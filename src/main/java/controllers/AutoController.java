package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Auto;

import java.io.IOException;
import java.util.ArrayList;

import context.AutoQuery;

/**
 * Servlet implementation class AutoController
 */
@WebServlet("/AutoController")
public class AutoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AutoQuery autoQuery= new AutoQuery();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		ArrayList<Auto> autos = (ArrayList<Auto>) autoQuery.stampaAuto();
		request.setAttribute("listaAuto", autos);
		RequestDispatcher dispatcher = request.getRequestDispatcher("mostraAuto.jsp");
        dispatcher.forward(request, response);
		
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String targa = request.getParameter("targa");
	    String modello = request.getParameter("modello");
	    String carburante = request.getParameter("carburante");
	    String livelloStr = request.getParameter("livello");
	    String numeroPostiStr = request.getParameter("numeroPosti");
	    String prezzoStr = request.getParameter("prezzo");

	    // Validazione dei dati
	    if (targa.isEmpty() || modello.isEmpty() || carburante.isEmpty()) {
	        request.setAttribute("error", "Campi obbligatori mancanti!");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("aggiungiAuto.jsp");
	        dispatcher.forward(request, response);
	        return;
	    }
	    
	    try {
	        double livello = Double.parseDouble(livelloStr);
	        int numeroPosti = Integer.parseInt(numeroPostiStr);
	        double prezzo = Double.parseDouble(prezzoStr);
	        
	        Auto auto = new Auto(0, targa, modello, carburante, livello, numeroPosti, "Manuale", "Posizione", prezzo);
	        autoQuery.aggiungiAuto(auto);
	        
	        // Successo
	        response.sendRedirect("AutoController");
	    } catch (NumberFormatException e) {
	        request.setAttribute("error", "Valori numerici invalidi!");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("inserisciVeicolo.jsp");
	        dispatcher.forward(request, response);
	    }
	}


}
