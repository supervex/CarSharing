package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Recensione;
import models.Utente;
import models.Noleggio;
import models.Auto;
import java.io.IOException;

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
         default:
              // Comportamento predefinito
             break;
    	 }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupero i parametri inviati dal form
        String descrizione = request.getParameter("descrizione");
        String punteggioStr = request.getParameter("punteggio");
        
        // Recupero gli altri parametri necessari ( idAuto, idUtente)
       
        int idAuto = Integer.parseInt(request.getParameter("idAuto"));
        int idUtente = Integer.parseInt(request.getParameter("idUtente"));

        // Controllo se il punteggio è valido (compreso tra 1 e 5)
        int punteggio = 0;
        try {
            punteggio = Integer.parseInt(punteggioStr);
            if (punteggio < 1 || punteggio > 5) {
                // Se il punteggio non è valido, possiamo reindirizzare alla pagina di errore o fare un altro tipo di gestione
                request.setAttribute("errore", "Il punteggio deve essere compreso tra 1 e 5.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
                dispatcher.forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            // Se il punteggio non è un numero valido, possiamo inviare un errore
            request.setAttribute("errore", "Punteggio non valido.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Crea una nuova recensione con i dati ricevuti
        Recensione recensione = new Recensione();
        recensione.setDescrizione(descrizione);
        recensione.setValuatzione(punteggio);        
        recensione.setIdAuto(idAuto);
        recensione.setIdUtente(idUtente);

        // Inserisci la recensione nel database (implementa il metodo 'inserisciRecensione' nel tuo model)
        try {
        	receQuery.inserisciRecensione(recensione);
            // Se l'inserimento è andato a buon fine, redirigi alla pagina di successo o storico prenotazioni
            response.sendRedirect("HomeController?method=get");
        } catch (Exception e) {
            // Gestione errore durante l'inserimento
            request.setAttribute("errore", "Errore durante l'inserimento della recensione.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("recensione.jsp");
            dispatcher.forward(request, response);
        }
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
}
