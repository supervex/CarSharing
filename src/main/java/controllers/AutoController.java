package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import models.Auto;
import models.Utente;
import context.AutoQuery;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;

@WebServlet("/AutoController")
@MultipartConfig
public class AutoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final AutoQuery autoQuery = new AutoQuery();
    private static final String UPLOAD_DIR = "C:\\Users\\Alberto\\CarSharingImages";

    public AutoController() {
        super();
    }

    // Metodo doGet per visualizzare le auto
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");

        switch (tipoOperazione != null ? tipoOperazione : "") {
            case "tutteLeAuto":
                mostraTutteLeAuto(request, response);
                break;
            case "autoUtente":
                mostraAutoUtente(request, response);
                break;
            case "aggiorna":
            	String idAutoStr = request.getParameter("id");
            	int idAuto = Integer.parseInt(idAutoStr);               
                Auto autoDaAggiornare = autoQuery.trovaAutoPerId(idAuto);
                request.setAttribute("auto", autoDaAggiornare);
                RequestDispatcher dispatcher = request.getRequestDispatcher("modificaAuto.jsp");
                dispatcher.forward(request, response);
                break;
            case "dettagli":
                mostraDettagli(request, response);
                break;
            default:
                mostraTutteLeAuto(request, response); // Comportamento predefinito
                break;
        }
    }


    // Metodo doPost per gestire le operazioni sull'auto (inserimento, aggiornamento, eliminazione, ecc.)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");
       
        
        switch (tipoOperazione) {
            case "inserisci":
                gestisciInserimentoAuto(request, response);
                break;
            case "aggiorna":
                gestisciAggiornamentoAuto(request, response);
                break;
            case "elimina":
                gestisciEliminazioneAuto(request, response);
                break;
            case "autoUtente":
                mostraAutoUtente(request, response);
                break;
            default:
                // Gestione di operazioni non riconosciute
                request.setAttribute("errorMessage", "Operazione non valida!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
                dispatcher.forward(request, response);
                break;
        }
    }

    // Metodo per gestire l'inserimento di un'auto
    private void gestisciInserimentoAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String targa = request.getParameter("targa");
        String modello = request.getParameter("modello");
        String carburante = request.getParameter("carburante");
        String livelloStr = request.getParameter("livello");
        String numeroPostiStr = request.getParameter("numeroPosti");
        String prezzoStr = request.getParameter("prezzo");
        String idUtenteStr = request.getParameter("utente");
        String citta = request.getParameter("citta");
        String posizione = request.getParameter("posizione");
        String cambio = request.getParameter("cambio");

        // Caricamento dell'immagine
        Part immaginePart = request.getPart("immagine");
        String immaginePath = null;

        if (immaginePart != null && immaginePart.getSize() > 0) {
            String fileName = Path.of(immaginePart.getSubmittedFileName()).getFileName().toString();
            File uploadDirFile = new File(UPLOAD_DIR);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            File file = new File(UPLOAD_DIR, fileName);
            immaginePart.write(file.getAbsolutePath());
            immaginePath = fileName; // Salviamo solo il nome del file
        }

        try {
            double livello = Double.parseDouble(livelloStr);
            int numeroPosti = Integer.parseInt(numeroPostiStr);
            double prezzo = Double.parseDouble(prezzoStr);

            Auto auto;
            if (idUtenteStr != null && !idUtenteStr.isEmpty()) {
                int idUtente = Integer.parseInt(idUtenteStr);
                auto = new Auto(0, idUtente, targa, modello, carburante, livello, numeroPosti, cambio, posizione, citta, prezzo, immaginePath);
            } else {
                auto = new Auto(0, targa, modello, carburante, livello, numeroPosti, cambio, posizione, citta, prezzo, immaginePath);
            }

            autoQuery.aggiungiAuto(auto);
            response.sendRedirect("AutoController");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Valori numerici invalidi!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("inserisciVeicolo.jsp");
            dispatcher.forward(request, response);
        }
    }

  
    // Metodo per gestire l'aggiornamento di un'auto 
    private void gestisciAggiornamentoAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera l'ID dell'auto che si vuole aggiornare
        String idAutoStr = request.getParameter("id");

        if (idAutoStr != null && !idAutoStr.isEmpty()) {
            try {
                int idAuto = Integer.parseInt(idAutoStr);
                // Recupera i dettagli dell'auto da aggiornare
                Auto autoDaAggiornare = autoQuery.trovaAutoPerId(idAuto);

                if (autoDaAggiornare != null) {
                    // Recupera i nuovi valori da aggiornare
                    String targa = request.getParameter("targa");
                    String modello = request.getParameter("modello");
                    String carburante = request.getParameter("carburante");
                    String livelloStr = request.getParameter("livello");
                    String numeroPostiStr = request.getParameter("numeroPosti");
                    String prezzoStr = request.getParameter("prezzo");

                    // Controlla che i campi obbligatori non siano vuoti
                    if (targa.isEmpty() || modello.isEmpty() || carburante.isEmpty()) {
                        request.setAttribute("errorMessage", "Campi obbligatori mancanti!");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("modificaAuto.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }

                    try {
                        double livello = Double.parseDouble(livelloStr);
                        int numeroPosti = Integer.parseInt(numeroPostiStr);
                        double prezzo = Double.parseDouble(prezzoStr);

                        // Aggiorna l'auto con i nuovi valori
                        autoDaAggiornare.setTarga(targa);
                        autoDaAggiornare.setModello(modello);
                        autoDaAggiornare.setCarburante(carburante);
                        autoDaAggiornare.setLivello(livello);
                        autoDaAggiornare.setNumeroPosti(numeroPosti);
                        autoDaAggiornare.setPrezzo(prezzo);

                        // Salva l'auto aggiornata nel database (o nel sistema di gestione dati)
                        autoQuery.modificaAuto(autoDaAggiornare);

                        // Successo, redirect alla pagina delle auto
                        response.sendRedirect("AutoController?tipoOperazione=autoUtente");

                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "Valori numerici invalidi!");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
                        dispatcher.forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Auto non trovata!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID auto non valido!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "ID auto mancante!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
            dispatcher.forward(request, response);
        }
    }


    // Metodo per gestire l'eliminazione di un'auto (da implementare)
    private void gestisciEliminazioneAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAutoStr = request.getParameter("id");

        if (idAutoStr != null && !idAutoStr.isEmpty()) {
            try {
                int idAuto = Integer.parseInt(idAutoStr);
                autoQuery.eliminaAuto(idAuto);  // Esegui l'eliminazione dell'auto

                response.sendRedirect("AutoController?tipoOperazione=autoUtente");  
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID auto non valido!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "ID auto mancante!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
            dispatcher.forward(request, response);
        }
    }
    private void mostraAutoUtente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	Utente utenteLoggato = (Utente) request.getSession().getAttribute("user");
    String username =utenteLoggato.getUsername();
    	ArrayList<Auto> listaAutoUtente = (ArrayList<Auto>) autoQuery.cercaAutoByUsername(username);
    	request.setAttribute("listaAutoUtente", listaAutoUtente);
    	RequestDispatcher dispatcher = request.getRequestDispatcher("AutoUtente.jsp");
        dispatcher.forward(request, response);
    }
    
    private void mostraTutteLeAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 ArrayList<Auto> autos = (ArrayList<Auto>) autoQuery.stampaAuto();  
         request.setAttribute("listaAuto", autos);
         
         RequestDispatcher dispatcher = request.getRequestDispatcher("mostraAuto.jsp");
         dispatcher.forward(request, response);
    }
    
    private void mostraDettagli(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String idAutoStr = request.getParameter("id");
    	int idAuto = Integer.parseInt(idAutoStr);               
        Auto autoDettagli = autoQuery.trovaAutoPerId(idAuto);
        request.setAttribute("auto", autoDettagli);
        RequestDispatcher dispatcher = request.getRequestDispatcher("dettagliAuto.jsp");
        dispatcher.forward(request, response);   
        
    }
}
