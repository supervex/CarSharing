package controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

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
    private static UtenteQuery utenteQuery = new UtenteQuery();

    public UtenteController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipoOperazione = request.getParameter("tipoOperazione");

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
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Operazione non valida");
        }
    }

    private void gestisciLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            inviaErrore(request, response, "Compila tutti i campi.", "/login.jsp");
            return;
        }

        String passwordCriptata = CriptaPassword.stampaCriptato(14, password);
        Utente utente = utenteQuery.getUtenteByUsername(username);

        if (utente == null || !utente.getPasswordUtente().equals(passwordCriptata)) {
            inviaErrore(request, response, "Username o password errati.", "/login.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("user", utente);
            response.sendRedirect("home.jsp");
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

        if (utenteQuery.getUtenteByUsername(username) != null) {
            inviaErrore(request, response, "Username già in uso. Scegli un altro username.", "/Register.jsp");
            return;
        }

        java.sql.Date dataNascitaSQL;
        try {
            LocalDate dataNascita = LocalDate.parse(dataNascitaStr);
            dataNascitaSQL = java.sql.Date.valueOf(dataNascita);
        } catch (DateTimeParseException e) {
            inviaErrore(request, response, "Formato della data non valido. Usa 'yyyy-MM-dd'.", "/Register.jsp");
            return;
        }

        String passwordCriptata = CriptaPassword.stampaCriptato(14, password);
        Utente nuovoUtente = new Utente(0, username, nome, cognome, dataNascitaSQL, passwordCriptata, citta, telefono, email);
        utenteQuery.aggiungiUtente(nuovoUtente);
        response.sendRedirect("successo.jsp");
    }

    private void gestisciLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }

    private void inviaErrore(HttpServletRequest request, HttpServletResponse response, String messaggio, String pagina)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", messaggio);
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagina);
        dispatcher.forward(request, response);
    }
}
