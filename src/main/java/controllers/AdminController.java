package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Auto;
import models.Noleggio;
import models.Recensione;
import models.Utente;

import java.io.IOException;
import java.util.ArrayList;

import context.AutoQuery;
import context.NoleggioQuery;
import context.RecensioneQuery;
import context.UtenteQuery;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AutoQuery autoQuery = new AutoQuery();
	private static final UtenteQuery utenteQuery = new UtenteQuery();
	private static final RecensioneQuery receQuery = new RecensioneQuery();
	private static final NoleggioQuery noleggioQuery = new NoleggioQuery();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminController() {
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
		ArrayList<Utente> utenti = (ArrayList<Utente>) utenteQuery.getAllUtenti();
		ArrayList<Noleggio> noleggi = (ArrayList<Noleggio>) noleggioQuery.stampaTuttiNoleggi();
		ArrayList<Recensione> recensioni = (ArrayList<Recensione>) receQuery.stampaTutteRecensioni();
		
		request.setAttribute("listaAuto", autos);
		request.setAttribute("listaUtenti", utenti);
		request.setAttribute("listaNoleggi", noleggi);
		request.setAttribute("listaRecensioni", recensioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("gestione.jsp");
        dispatcher.forward(request, response);
        
		        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
