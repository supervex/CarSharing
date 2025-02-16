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
    private static AutoQuery autoQuery = new AutoQuery();
    //private static UtenteQuery utenteQuery = new UtenteQuery(); 

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera la lista delle auto
        ArrayList<Auto> autos = (ArrayList<Auto>) autoQuery.stampaAuto();
        request.setAttribute("listaAuto", autos);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("mostraAuto.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String idUtenteStr = request.getParameter("utente");
        String targa = request.getParameter("targa");
        String modello = request.getParameter("modello");
        String carburante = request.getParameter("carburante");
        String livelloStr = request.getParameter("livello");
        String numeroPostiStr = request.getParameter("numeroPosti");
        String prezzoStr = request.getParameter("prezzo");

        
        if (targa.isEmpty() || modello.isEmpty() || carburante.isEmpty()) {
            request.setAttribute("error", "Campi obbligatori mancanti!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("aggiungiAuto.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Parsing dei valori numerici
        try {
            double livello = Double.parseDouble(livelloStr);
            int numeroPosti = Integer.parseInt(numeroPostiStr);
            double prezzo = Double.parseDouble(prezzoStr);

            // Controlla se idUtente è presente, altrimenti crea l'auto senza utente
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
            request.setAttribute("error", "Valori numerici invalidi!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("inserisciVeicolo.jsp");
            dispatcher.forward(request, response);
        }
    }
}
