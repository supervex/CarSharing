package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Utente;
import models.Auto;
import models.Noleggio;
import context.AutoQuery;
import context.NoleggioQuery;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/NoleggioController")
public class NoleggioController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final NoleggioQuery noleggioQuery = new NoleggioQuery();
    private static final AutoQuery autoQuery = new AutoQuery();
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");

        if (tipoOperazione == null) {
            mostraErrore(request, response, "Operazione non valida!");
            return;
        }
        switch (tipoOperazione) {
            case "mostra":
                mostraAutoDisponibili(request, response);
                break;
            case "inserisci":
                preparaInserimentoPrenotazione(request, response);
                break;
            case "prenotazioniUtente":
                mostraPrenotazioniUtente(request, response);
                break;
            case "dettagli":
                mostraAutoDisponibili(request, response);
                break;
            case "preparaPagamento":
            	preparaPagamento(request, response);
                break;
            default:
                mostraErrore(request, response, "Operazione non valida!");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");

        if (tipoOperazione == null) {
            mostraErrore(request, response, "Operazione non valida!");
            return;
        }

        switch (tipoOperazione) {
            case "confermaPrenotazione":
                gestisciInserimentoPrenotazione(request, response);
                break;
            case "elimina":
                eliminaPrenotazione(request, response);
                break;
            default:
                mostraErrore(request, response, "Operazione non valida!");
                break;
        }
    }
    private void eliminaPrenotazione(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idNoleggioStr = request.getParameter("idNoleggio");

        if (idNoleggioStr == null || idNoleggioStr.isEmpty()) {
            mostraErrore(request, response, "ID noleggio non valido!");
            return;
        }

        int idNoleggio = -1;
        try {
            idNoleggio = Integer.parseInt(idNoleggioStr);
        } catch (NumberFormatException e) {
            mostraErrore(request, response, "ID noleggio non valido!");
            return;
        }

        // Recupero il noleggio da eliminare
        Noleggio noleggio = noleggioQuery.trovaNoleggioPerId(idNoleggio);
        if (noleggio == null) {
            mostraErrore(request, response, "Noleggio non trovato!");
            return;
        }

        // Elimina il noleggio
        boolean eliminato = noleggioQuery.eliminaNoleggio(idNoleggio);

        if (eliminato) {
            // Successo nell'eliminazione
            request.setAttribute("successMessage", "Prenotazione eliminata con successo.");
            mostraPrenotazioniUtente(request, response);
        } else {
            // Errore nell'eliminazione
            mostraErrore(request, response, "Errore durante l'eliminazione della prenotazione.");
        }
    }
    private void preparaPagamento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAutoStr = request.getParameter("idAuto");
        if (idAutoStr == null || idAutoStr.isEmpty()) {
            mostraErrore(request, response, "ID auto mancante!");
            return;
        }

        int idAuto = Integer.parseInt(idAutoStr);
        Auto auto = autoQuery.trovaAutoPerId(idAuto);
        if (auto == null) {
            mostraErrore(request, response, "Auto non trovata!");
            return;
        }

//        request.setAttribute("auto", auto);
//        request.setAttribute("dataRitiro", request.getParameter("dataRitiro"));
//        request.setAttribute("oraRitiro", request.getParameter("oraRitiro"));
//        request.setAttribute("dataRiconsegna", request.getParameter("dataRiconsegna"));
//        request.setAttribute("oraRiconsegna", request.getParameter("oraRiconsegna"));
        
        LocalDateTime ritiro = parseDateTime(request.getParameter("dataRitiro"), request.getParameter("oraRitiro"), request, response);
        if (ritiro == null) return;

        LocalDateTime riconsegna = parseDateTime(request.getParameter("dataRiconsegna"), request.getParameter("oraRiconsegna"), request, response);
        if (riconsegna == null) return;

        if (riconsegna.isBefore(ritiro)) {
            request.setAttribute("auto", auto);
            inviaErrore(request, response, "La data di riconsegna non può essere precedente alla data di ritiro.", "/inserimentoPrenotazione.jsp");
            return;
        }

     // Verifica la disponibilità dell'auto
        if (noleggioQuery.verificaDisponibilitaAuto(idAuto, ritiro, riconsegna)) {
            request.setAttribute("auto", auto);
            request.setAttribute("ritiro", ritiro);
            request.setAttribute("riconsegna", riconsegna);
            
            request.setAttribute("dataRitiro", request.getParameter("dataRitiro"));
            request.setAttribute("oraRitiro", request.getParameter("oraRitiro"));
            request.setAttribute("dataRiconsegna", request.getParameter("dataRiconsegna"));
            request.setAttribute("oraRiconsegna", request.getParameter("oraRiconsegna"));
            // Calcola la durata in minuti
            long durataInMinuti = java.time.Duration.between(ritiro, riconsegna).toMinutes();
            
            // Converte la durata in ore (incluso il frazionamento dei minuti)
            double durataInOre = durataInMinuti / 60.0;

            // Calcola il prezzo totale (moltiplicato per la durata in ore frazionate)
            double prezzoPerOra = auto.getPrezzo(); // Supponiamo che questo restituisca il prezzo per ora
            double prezzoTotale = prezzoPerOra * durataInOre;

            // Calcola il 2% del prezzo totale
            double percentuale = 0.02;
            double incremento2Percento = prezzoTotale * percentuale;

            // Aggiungi il 2% al prezzo totale
            double prezzoTotaleConSconto = prezzoTotale + incremento2Percento;

            // Format the total price (2 decimal places)
            String prezzoTotaleFormattato = String.format("%.2f", prezzoTotaleConSconto);
            String prezzoTotaleFormattato2 = String.format("%.2f", prezzoTotale);
            

            // Imposta gli attributi per il JSP
            request.setAttribute("prezzoTotaleSenzaIncremento", prezzoTotaleFormattato2);
            request.setAttribute("prezzoTotale", prezzoTotaleFormattato);
            request.setAttribute("durataInOre", durataInOre);
            request.setAttribute("incremento2Percento", String.format("%.2f", incremento2Percento));

            // Invia la richiesta al JSP di pagamento
            RequestDispatcher dispatcher = request.getRequestDispatcher("pagamento.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("auto", auto);
            inviaErrore(request, response, "L'auto non è disponibile", "/inserimentoPrenotazione.jsp");
        }


        
    }
    private void mostraPrenotazioniUtente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("user");
        if (utenteLoggato == null) {
            mostraErrore(request, response, "Devi effettuare il login per visualizzare le prenotazioni.");
            return;
        }

        int idUtente = utenteLoggato.getId();
        List<Noleggio> noleggi = noleggioQuery.trovaNoleggiPerUtente(idUtente);

        List<Auto> autos = new ArrayList<>();
        for (Noleggio noleggio : noleggi) {
            Auto auto = autoQuery.trovaAutoPerId(noleggio.getIdAuto());
            if (auto != null) {
                autos.add(auto);
            }
        }

        request.setAttribute("noleggi", noleggi);
        request.setAttribute("autos", autos);
        forward(request, response, "prenotazioniUtente.jsp");
    }

    private void preparaInserimentoPrenotazione(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idAutoStr = request.getParameter("idAuto");
        if (idAutoStr == null || idAutoStr.isEmpty()) {
            mostraErrore(request, response, "ID auto mancante!");
            return;
        }

        int idAuto = Integer.parseInt(idAutoStr);
        Auto auto = autoQuery.trovaAutoPerId(idAuto);
        if (auto == null) {
            mostraErrore(request, response, "Auto non trovata!");
            return;
        }

        request.setAttribute("auto", auto);
        request.setAttribute("dataRitiro", request.getParameter("dataRitiro"));
        request.setAttribute("oraRitiro", request.getParameter("oraRitiro"));
        request.setAttribute("dataRiconsegna", request.getParameter("dataRiconsegna"));
        request.setAttribute("oraRiconsegna", request.getParameter("oraRiconsegna"));

        forward(request, response, "inserimentoPrenotazione.jsp");
    }

    private void gestisciInserimentoPrenotazione(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente utenteLoggato = (Utente) request.getSession().getAttribute("user");
        if (utenteLoggato == null) {
            mostraErrore(request, response, "Devi essere loggato per prenotare un'auto.");
            return;
        }

        int idUtente = utenteLoggato.getId();
        int idAuto = parseInteger(request.getParameter("idAuto"), request, response);
        if (idAuto == -1) return;

        LocalDateTime ritiro = parseDateTime(request.getParameter("dataRitiro"), request.getParameter("oraRitiro"), request, response);
        if (ritiro == null) return;

        LocalDateTime riconsegna = parseDateTime(request.getParameter("dataRiconsegna"), request.getParameter("oraRiconsegna"), request, response);
        if (riconsegna == null) return;

        if (riconsegna.isBefore(ritiro)) {
            mostraErrore(request, response, "La data di riconsegna non può essere precedente alla data di ritiro.");
            return;
        }

        Noleggio noleggio = new Noleggio(0, idUtente, idAuto, ritiro, riconsegna);
        noleggioQuery.inserisciNoleggio(noleggio);

        forward(request, response, "prenotazioneSuccesso.jsp");
    }

    private void mostraAutoDisponibili(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String luogo = request.getParameter("luogo");

        LocalDateTime ritiro = parseDateTime(request.getParameter("dataRitiro"), request.getParameter("oraRitiro"), request, response);
        if (ritiro == null) return;

        LocalDateTime riconsegna = parseDateTime(request.getParameter("dataRiconsegna"), request.getParameter("oraRiconsegna"), request, response);
        if (riconsegna == null) return;

        if (riconsegna.isBefore(ritiro)) {
            mostraErrore(request, response, "La data di riconsegna non può essere precedente alla data di ritiro.");
            return;
        }

        List<Auto> autos = noleggioQuery.trovaAutoDisponibiliPerNoleggio(luogo, ritiro, riconsegna);

        request.getSession().setAttribute("listaAuto", autos);
        request.setAttribute("luogo", luogo);
        request.setAttribute("dataRitiro", request.getParameter("dataRitiro"));
        request.setAttribute("oraRitiro", request.getParameter("oraRitiro"));
        request.setAttribute("dataRiconsegna", request.getParameter("dataRiconsegna"));
        request.setAttribute("oraRiconsegna", request.getParameter("oraRiconsegna"));

        forward(request, response, "home.jsp");
    }

    private void mostraErrore(HttpServletRequest request, HttpServletResponse response, String messaggio) throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        forward(request, response, "errore.jsp");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String pagina) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
        dispatcher.forward(request, response);
    }

    private LocalDateTime parseDateTime(String data, String ora, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (data == null || ora == null) {
            mostraErrore(request, response, "Data o ora mancanti!");
            return null;
        }
        return LocalDateTime.parse(data + " " + ora, FORMATTER);
    }
    private int parseInteger(String value, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (value == null || value.isEmpty()) {
            mostraErrore(request, response, "ID auto mancante!");
            return -1;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            mostraErrore(request, response, "ID auto non valido!");
            return -1;
        }
    }
    private void inviaErrore(HttpServletRequest request, HttpServletResponse response, String messaggio, String pagina)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
        dispatcher.forward(request, response);
    }
}
