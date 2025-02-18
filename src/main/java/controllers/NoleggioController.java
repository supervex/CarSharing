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

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import context.AutoQuery;
import context.NoleggioQuery;

/**
 * Servlet implementation class NoleggioController
 */
@WebServlet("/NoleggioController")
public class NoleggioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static NoleggioQuery noleggioQuery = new NoleggioQuery();
	private static AutoQuery autoQuery = new AutoQuery();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoleggioController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String tipoOperazione = request.getParameter("tipoOperazione");
		
		switch (tipoOperazione) {
         case "mostra":
             mostraAutoDisponibili(request, response);
             break;
         case "inserisci":
        	 int idAuto = Integer.parseInt(request.getParameter("idAuto"));
        	 Auto auto = autoQuery.trovaAutoPerId(idAuto);
     		 String dataRitiro = request.getParameter("dataRitiro");
    		 String oraRitiro = request.getParameter("oraRitiro");
    		 String dataRiconsegna = request.getParameter("dataRiconsegna");
    		 String oraRiconsegna = request.getParameter("oraRiconsegna");
    	
    		 request.setAttribute("auto", auto);
    			request.setAttribute("dataRitiro", dataRitiro);
    			request.setAttribute("oraRitiro", oraRitiro);
    			request.setAttribute("dataRiconsegna", dataRiconsegna);
    			request.setAttribute("oraRiconsegna", oraRiconsegna);
    			
    			 RequestDispatcher dispatcher1 = request.getRequestDispatcher("inserimentoPrenotazione.jsp");
                 dispatcher1.forward(request, response);
        	 
           //  gestisciEliminazioneAuto(request, response);
             break;
//         case "autoUtente":
//             mostraAutoUtente(request, response);
//             break;
         default:
             // Gestione di operazioni non riconosciute
             request.setAttribute("errorMessage", "Operazione non valida!");
             RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
             dispatcher.forward(request, response);
             break;
     }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
         String tipoOperazione = request.getParameter("tipoOperazione");
		
		switch (tipoOperazione) {
		 case "confermaPrenotazione":
             gestisciInserimentoPrenotazione(request, response);
             break;
		 default:
             // Gestione di operazioni non riconosciute
             request.setAttribute("errorMessage", "Operazione non valida!");
             RequestDispatcher dispatcher = request.getRequestDispatcher("errore.jsp");
             dispatcher.forward(request, response);
             break;
		}
	}
	protected void gestisciInserimentoPrenotazione(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Utente utenteLoggato = (Utente) request.getSession().getAttribute("user");
	    //String username =utenteLoggato.getUsername();
		int idUtente = utenteLoggato.getId();
		
		int idAuto = Integer.parseInt(request.getParameter("idAuto"));
		String dataRitiro = request.getParameter("dataRitiro");
		String oraRitiro = request.getParameter("oraRitiro");
		String dataRiconsegna = request.getParameter("dataRiconsegna");
		String oraRiconsegna = request.getParameter("oraRiconsegna");
		

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

		LocalDateTime ritiro = LocalDateTime.parse(dataRitiro + " " + oraRitiro, formatter);
		LocalDateTime riconsegna = LocalDateTime.parse(dataRiconsegna + " " + oraRiconsegna, formatter);
		
		Noleggio noleggio = new Noleggio(0,idUtente,idAuto,ritiro,riconsegna);
		
		noleggioQuery.inserisciNoleggio(noleggio);
				
		
	}
	protected void mostraAutoDisponibili(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String luogo = request.getParameter("luogo");
		
		String dataRitiro = request.getParameter("dataRitiro");
		String oraRitiro = request.getParameter("oraRitiro");
		String dataRiconsegna = request.getParameter("dataRiconsegna");
		String oraRiconsegna = request.getParameter("oraRiconsegna");
	
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

		LocalDateTime ritiro = LocalDateTime.parse(dataRitiro + " " + oraRitiro, formatter);
		LocalDateTime riconsegna = LocalDateTime.parse(dataRiconsegna + " " + oraRiconsegna, formatter);
		
		List<Auto> autos = noleggioQuery.trovaAutoDisponibiliPerNoleggio(luogo, ritiro, riconsegna);
		
		request.getSession().setAttribute("listaAuto", autos);
		request.setAttribute("luogo", luogo);
		request.setAttribute("dataRitiro", dataRitiro);
		request.setAttribute("oraRitiro", oraRitiro);
		request.setAttribute("dataRiconsegna", dataRiconsegna);
		request.setAttribute("oraRiconsegna", oraRiconsegna);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
		
		
	//LocalDateTime orario1 =LocalDateTime.of(Integer.parseInt(dataRitiro.substring(0,4)),Integer.parseInt( dataRitiro.substring(5,7)),Integer.parseInt (dataRitiro.substring(8,9)),Integer.parseInt (oraRitiro.substring(0,3)), Integer.parseInt(oraRitiro.substring(4,6)));
	
	}
}
