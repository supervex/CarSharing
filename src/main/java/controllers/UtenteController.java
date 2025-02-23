package controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Optional;

import context.UtenteQuery;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Utente;
import utils.CriptaPassword;

@WebServlet("/UtenteController")
public class UtenteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final UtenteQuery utenteQuery = new UtenteQuery();
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String tipoOperazione = Optional.ofNullable(request.getParameter("tipoOperazione")).orElse("");
    	switch (tipoOperazione) {
    	 case "dettagli":
             dettagliUtente(request, response);
             break;  
    	}
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipoOperazione = Optional.ofNullable(request.getParameter("tipoOperazione")).orElse("");

        switch (tipoOperazione) {
            case "login":
                gestisciLogin(request, response);
                break;
            case "register":
                gestisciRegistrazione(request, response);
                break;
            case "logout":
                gestisciLogout(request, response);
                break;
            case "modificaUtente":
                gestisciModificaUtente(request, response);
                break;
            case "eliminaUtente":
                gestisciEliminaUtente(request, response);
                break;
             
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Operazione non valida");
        }
    }
    private void dettagliUtente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	int idUtente =Integer.parseInt(request.getParameter("idUtente"));
    	System.out.println(idUtente);
    	Utente utente = utenteQuery.getUtenteById(idUtente);
    	System.out.println(idUtente);
    	request.setAttribute("utente", utente);
    	
        RequestDispatcher dispatcher = request.getRequestDispatcher("dettagliUtente.jsp");
        dispatcher.forward(request, response);  
    	
    }
    private void gestisciLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            inviaErrore(request, response, "Compila tutti i campi.", "/Register.jsp");
            return;
        }

        Utente utente = utenteQuery.getUtenteByUsername(username);
        

        if (utente == null || !utente.getPasswordUtente().equals(CriptaPassword.cripta(14,password))) {
            inviaErrore(request, response, "Username o password errati.", "/Register.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("user", utente);
            response.sendRedirect("HomeController?method=get");
        }
    }

    private void gestisciRegistrazione(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String dataNascitaStr = request.getParameter("dataNascita");
        String password = request.getParameter("password");
        String citta = request.getParameter("citta");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");

        // Controllo se tutti i campi sono compilati
        if (username == null || username.isEmpty() || nome == null || nome.isEmpty() || cognome == null || cognome.isEmpty() ||
            dataNascitaStr == null || dataNascitaStr.isEmpty() || password == null || password.isEmpty() || citta == null || citta.isEmpty() ||
            telefono == null || telefono.isEmpty() || email == null || email.isEmpty()) {
            inviaErrore(request, response, "Tutti i campi devono essere compilati!", "/Register.jsp");
            return;
        }

        // Controllo formato email
        String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        if (!email.matches(emailPattern)) {
            inviaErrore(request, response, "Inserisci un'email valida!", "/Register.jsp");
            return;
        }

        // Controllo se l'username esiste già
        if (utenteQuery.getUtenteByUsername(username) != null) {
            inviaErrore(request, response, "Username già in uso. Scegli un altro username.", "/Register.jsp");
            return;
        }

        // Controllo se l'email esiste già
        if (utenteQuery.getUtenteByEmail(email) != null) { 
            inviaErrore(request, response, "Email già registrata. Usa un'altra email.", "/Register.jsp");
            return;
        }

        java.sql.Date dataNascitaSQL;
        try {
            dataNascitaSQL = java.sql.Date.valueOf(LocalDate.parse(dataNascitaStr));
        } catch (DateTimeParseException e) {
            inviaErrore(request, response, "Formato della data non valido. Usa 'yyyy-MM-dd'.", "/Register.jsp");
            return;
        }

        String passwordCriptata = CriptaPassword.cripta(14, password);
        Utente nuovoUtente = new Utente(0, username, nome, cognome, dataNascitaSQL, passwordCriptata, citta, telefono, email, false);
        
        utenteQuery.aggiungiUtente(nuovoUtente);

        // Crea una sessione e imposta l'utente registrato come loggato
        HttpSession session = request.getSession();
        session.setAttribute("user", nuovoUtente);

        // Reindirizza alla home o all'area utente
        response.sendRedirect("HomeController?method=get");
    }


    private void gestisciLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("user");
        }
        
        response.sendRedirect("HomeController?method=get");
    }

    private void gestisciModificaUtente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("user");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        utente.setNome(request.getParameter("nome"));
        utente.setCognome(request.getParameter("cognome"));
        utente.setEmail(request.getParameter("email"));
        utente.setTelefono(request.getParameter("telefono"));
        utente.setCitta(request.getParameter("citta"));
        
        String dataNascitaStr = request.getParameter("dataNascita");
        try {
            utente.setDataNascita(java.sql.Date.valueOf(LocalDate.parse(dataNascitaStr)));
        } catch (DateTimeParseException e) {
            inviaErrore(request, response, "Formato della data non valido.", "/modificaUtente.jsp");
            return;
        }
        
        String nuovaPassword = request.getParameter("passwordUtente");
        if (nuovaPassword != null && !nuovaPassword.isEmpty()) {
            utente.setPasswordUtente(CriptaPassword.cripta(14,nuovaPassword));
        }
        
        boolean success = utenteQuery.aggiornaUtente(utente);
        if (success) {
            session.setAttribute("user", utente);
            response.sendRedirect("areaUtente.jsp?success=1");
        } else {
            inviaErrore(request, response, "Errore durante l'aggiornamento.", "/modificaUtente.jsp");
        }
    }

    private void gestisciEliminaUtente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idUtente = Integer.parseInt(request.getParameter("idUtente"));
        utenteQuery.eliminaUtente(idUtente);
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("user");
        if(utente.isAmministratore()) {
        	request.setAttribute("successMessage", "utente eliminato con successo.");
        	response.sendRedirect("AdminController?method=get");
        	if(utente.getId() == idUtente) {
        		gestisciLogout(request, response);   
        	}
        }else {        	
        	gestisciLogout(request, response);        	
        }       
    }

    private void inviaErrore(HttpServletRequest request, HttpServletResponse response, String messaggio, String pagina)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
        dispatcher.forward(request, response);
    }
}
