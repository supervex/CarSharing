package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Auto;
import context.AutoQuery;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AutoController")
public class AutoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final AutoQuery autoQuery = new AutoQuery();

    public AutoController() {
        super();
    }

    // Metodo doGet per visualizzare le auto
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Auto> autos = (ArrayList<Auto>) autoQuery.stampaAuto();  
        request.setAttribute("listaAuto", autos);

        
        RequestDispatcher dispatcher = request.getRequestDispatcher("mostraAuto.jsp");
        dispatcher.forward(request, response);
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

        
        if (targa.isEmpty() || modello.isEmpty() || carburante.isEmpty()) {
            request.setAttribute("errorMessage", "Campi obbligatori mancanti!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("inserisciVeicolo.jsp");
            dispatcher.forward(request, response);
            return;
        }

        
        try {
            double livello = Double.parseDouble(livelloStr);
            int numeroPosti = Integer.parseInt(numeroPostiStr);
            double prezzo = Double.parseDouble(prezzoStr);

            Auto auto;
            if (idUtenteStr != null && !idUtenteStr.isEmpty()) {
                int idUtente = Integer.parseInt(idUtenteStr);
                auto = new Auto(0, idUtente, targa, modello, carburante, livello, numeroPosti, "Manuale", "Posizione", prezzo);
            } else {
                auto = new Auto(0, targa, modello, carburante, livello, numeroPosti, "Manuale", "Posizione", prezzo);
            }

            autoQuery.aggiungiAuto(auto);

            // Successo, redirect alla lista delle auto
            response.sendRedirect("AutoController");

        } catch (NumberFormatException e) {
            // Gestione errori di parsing numerico
            request.setAttribute("errorMessage", "Valori numerici invalidi!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("inserisciVeicolo.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    

    // Metodo per gestire l'aggiornamento di un'auto (da implementare)
//    private void gestisciAggiornamentoAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Logica di aggiornamento
//        // Eseguiamo l'aggiornamento dell'auto in base ai dati ricevuti
//        request.setAttribute("message", "Funzionalità di aggiornamento non implementata ancora.");
//        RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
//        dispatcher.forward(request, response);
//    }

    private void gestisciAggiornamentoAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupero lo username dalla sessione
        String username = (String) request.getSession().getAttribute("username");

        // Recupero la lista delle auto associate all'username
        List<Auto> autos = autoQuery.cercaAutoByUsername(username);

        if (autos == null || autos.isEmpty()) {
            request.setAttribute("errorMessage", "Nessuna auto trovata per l'username fornito!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Recupero l'ID dell'auto dal form per identificare quale auto aggiornare
        String idAutoStr = request.getParameter("idAuto");

        if (idAutoStr == null || idAutoStr.isEmpty()) {
            request.setAttribute("errorMessage", "ID auto mancante!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int idAuto = Integer.parseInt(idAutoStr);
        Auto autoDaAggiornare = null;

        for (Auto auto : autos) {
            if (auto.getId() == idAuto) {
                autoDaAggiornare = auto;
                break;
            }
        }

        if (autoDaAggiornare == null) {
            request.setAttribute("errorMessage", "Auto non trovata per l'ID fornito!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Recupero i nuovi dati dell'auto dal form
        String modello = request.getParameter("modello");
        String carburante = request.getParameter("carburante");
        String livelloStr = request.getParameter("livello");
        String numeroPostiStr = request.getParameter("numeroPosti");
        String prezzoStr = request.getParameter("prezzo");

        try {
            double livello = Double.parseDouble(livelloStr);
            int numeroPosti = Integer.parseInt(numeroPostiStr);
            double prezzo = Double.parseDouble(prezzoStr);

            // Aggiornamento dei dati dell'auto
            autoDaAggiornare.setModello(modello);
            autoDaAggiornare.setCarburante(carburante);
            autoDaAggiornare.setLivello(livello);
            autoDaAggiornare.setNumeroPosti(numeroPosti);
            autoDaAggiornare.setPrezzo(prezzo);

            // Eseguiamo l'aggiornamento nel database
            autoQuery.modificaAuto(autoDaAggiornare);

            // Successo, redirect alla lista delle auto
            response.sendRedirect("AutoController");

        } catch (NumberFormatException e) {
            // Gestione errori di parsing numerico
            request.setAttribute("errorMessage", "Valori numerici invalidi!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("aggiornaAuto.jsp");
            dispatcher.forward(request, response);
        }
    }


    

    // Metodo per gestire l'eliminazione di un'auto (da implementare)
    private void gestisciEliminazioneAuto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAutoStr = request.getParameter("idAuto");

        // Verifica che l'ID auto sia presente e valido
        if (idAutoStr != null && !idAutoStr.isEmpty()) {
            try {
                int idAuto = Integer.parseInt(idAutoStr);
                autoQuery.eliminaAuto(idAuto);  // Esegui l'eliminazione dell'auto

                response.sendRedirect("AutoController");
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
}
