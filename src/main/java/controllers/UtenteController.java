package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Utente;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import context.UtenteQuery;

/**
 * Servlet implementation class UtenteController
 */
@WebServlet("/UtenteController")
public class UtenteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UtenteQuery utenteQuery = new UtenteQuery();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UtenteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Utente utente = utenteQuery.getUtenteByUsername(username);
		if(!utente.getPasswordUtente().equals(password) || utente == null) {
			request.setAttribute("errorMessage", "Username o password errate");
		
			//lo rimandiamo alla home con il login effettuato
		}else{
			System.out.println("benvenuto");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String username = request.getParameter("username");
	String nome = request.getParameter("nome");
	String cognome = request.getParameter("cognome");
	System.out.println("ciao");
	
	String dataNascitaStr = request.getParameter("dataNascita");
	
	
	System.out.println("Data ricevuta: " + dataNascitaStr);
	java.sql.Date dataNascitaSQL = null;
	LocalDate dataNascita = null;
	try {
		dataNascita = LocalDate.parse(dataNascitaStr); 
		System.out.println(dataNascita);
		dataNascitaSQL = java.sql.Date.valueOf(dataNascita);
		System.out.println(dataNascitaSQL);
	} catch (DateTimeParseException e) {
		
		e.printStackTrace();
		throw new ServletException("Formato della data non valido. Assicurati che sia nel formato 'yyyy-MM-dd'.",
				e);
	}	
	String password = request.getParameter("password");
	String città = request.getParameter("citta");
	String telefono= request.getParameter("telefono");
	String email = request.getParameter("email");
	
	
	//cercare se esiste lo stesso username
	if(utenteQuery.getUtenteByUsername(username) == null) {
		Utente utente = new Utente(0, username, nome, cognome, dataNascitaSQL, password, città, telefono, email);
	    utenteQuery.aggiungiUtente(utente);
	    response.sendRedirect("successo.jsp");
	    
	}else {
		
		    request.setAttribute("errorMessage", "Username già in uso. Scegli un altro username.");
		    //request.setAttribute("username", username);
		    request.setAttribute("nome", nome);
		    request.setAttribute("cognome", cognome);
		    request.setAttribute("dataNascita", dataNascitaStr);
		    request.setAttribute("password", password);
		    request.setAttribute("citta", città);
		    request.setAttribute("telefono", telefono);
		    request.setAttribute("email", email);
		    
		    RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
		    dispatcher.forward(request, response);
		}
		     
	}
	
	
		// metodo per criptare password
	
	//utenteQuery.aggiungiUtente(utente);
	//System.out.println(utente);
	
	}


