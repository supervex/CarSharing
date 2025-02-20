package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Recensione;
import models.Utente;
import models.Noleggio;
import models.Auto;
import java.io.IOException;
import java.util.ArrayList;

import context.AutoQuery;
import context.NoleggioQuery;
import context.RecensioneQuery;
import context.UtenteQuery;

@WebServlet("/RecensioneController")
public class RecensioneController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final NoleggioQuery noleggioQuery = new NoleggioQuery();
    private static final AutoQuery autoQuery = new AutoQuery();
    private static final UtenteQuery utenteQuery = new UtenteQuery();
    private static final RecensioneQuery receQuery = new RecensioneQuery();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecensioneController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ottieni l'ID della prenotazione dalla richiesta
    	String tipoOperazione = request.getParameter("tipoOperazione");
    	
    	 switch (tipoOperazione != null ? tipoOperazione : "") {
         case "lasciaRecensione":
             preparaFormRecensione(request, response);
             break;
         case "dettagli":
             mostraDettagli(request, response);
             break;
         case "mostraRecensioni":
            mostraRecensioni(request, response);
             break;
         default:
              // Comportamento predefinito
             break;
    	 }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");
        
        if ("eliminaRecensione".equals(tipoOperazione)) {
            try {
                int idRecensione = Integer.parseInt(request.getParameter("idRecensione"));
                boolean success = receQuery.eliminaRecensione(idRecensione);
                
                if (success) {
                	HttpSession session = request.getSession();
                    Utente utente = (Utente) session.getAttribute("user");
                    if(utente.isAmministratore()) {
                    	request.setAttribute("successMessage", "auto eliminata con successo.");
                    	response.sendRedirect("AdminController?method=get");
                    	
                    }else {
                    // Reindirizza alla pagina di gestione, dove verranno aggiornate le liste
                    response.sendRedirect("tutteLeMieRecensioni.jsp");
                    }
                } else {
                    request.setAttribute("errore", "Eliminazione recensione non riuscita.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("gestione.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errore", "Errore nell'eliminazione della recensione: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("gestione.jsp");
                dispatcher.forward(request, response);
            }
        } else if ("inserisciRecensione".equals(tipoOperazione)) {
            // Inserisci recensione (già implementato)
            String descrizione = request.getParameter("descrizione");
            String punteggioStr = request.getParameter("punteggio");
            int idAuto = Integer.parseInt(request.getParameter("idAuto"));
            int idUtente = Integer.parseInt(request.getParameter("idUtente"));

            int punteggio = 0;
            try {
                punteggio = Integer.parseInt(punteggioStr);
                if (punteggio < 1 || punteggio > 5) {
                    request.setAttribute("errore", "Il punteggio deve essere compreso tra 1 e 5.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errore", "Punteggio non valido.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
                dispatcher.forward(request, response);
                return;
            }

            Recensione recensione = new Recensione();
            recensione.setDescrizione(descrizione);
            recensione.setValuatzione(punteggio);        
            recensione.setIdAuto(idAuto);
            recensione.setIdUtente(idUtente);

            try {
                receQuery.inserisciRecensione(recensione);
                response.sendRedirect("HomeController?method=get");
            } catch (Exception e) {
                request.setAttribute("errore", "Errore durante l'inserimento della recensione.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            // Altri tipi di operazione o comportamento di default
            response.sendRedirect("gestione.jsp");
        }
    }
    protected void mostraRecensioni(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("user");
        
      ArrayList<Recensione> recensioni = (ArrayList<Recensione>) receQuery.cercaRecensioniPerIdUtente(utente.getId());
      request.setAttribute("recensioni", recensioni);
      RequestDispatcher dispatcher = request.getRequestDispatcher("recensioniUtente.jsp");
      dispatcher.forward(request, response);
    	
    }
    protected void preparaFormRecensione(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int idNoleggio = Integer.parseInt(request.getParameter("idNoleggio"));
    	Noleggio noleggio = noleggioQuery.trovaNoleggioPerId(idNoleggio);
    	noleggio.getIdAuto();
    	noleggio.getIdUtente();
    	
    	Auto auto = autoQuery.trovaAutoPerId(noleggio.getIdAuto());
    	Utente utente = utenteQuery.getUtenteById(noleggio.getIdUtente());
    	
    	request.setAttribute("auto", auto);
    	request.setAttribute("utente", utente);
    	request.setAttribute("noleggio", noleggio);
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
        dispatcher.forward(request, response);
    	
    }
    
    protected void mostraDettagli(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idRecensione = Integer.parseInt(request.getParameter("idRecensione"));
            Recensione recensione = receQuery.cercaRecensionePerId(idRecensione);

            if (recensione != null) {
                request.setAttribute("recensione", recensione);
                RequestDispatcher dispatcher = request.getRequestDispatcher("dettagliRecensione.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errore", "Recensione non trovata.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errore", "ID recensione non valido.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
            dispatcher.forward(request, response);
        }
    }

}
