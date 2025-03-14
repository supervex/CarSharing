<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente" %>
<%@ page import="models.Recensione"%>
<%@ page import="java.util.List"%>
<%@ page import="context.RecensioneQuery"%>
<%
    // Recupera l'auto e i dati delle date/orari dalla request
    Auto auto = (Auto) request.getAttribute("auto");

    String dataRitiro = (String) request.getAttribute("dataRitiro");
    String oraRitiro = (String) request.getAttribute("oraRitiro");
    String dataRiconsegna = (String) request.getAttribute("dataRiconsegna");
    String oraRiconsegna = (String) request.getAttribute("oraRiconsegna");

    // Recupera altri attributi
    LocalDateTime ritiro = (LocalDateTime) request.getAttribute("ritiro");
    LocalDateTime riconsegna = (LocalDateTime) request.getAttribute("riconsegna");
    String prezzoTotaleStr = (String) request.getAttribute("prezzoTotale"); // Recuperato come String
    String incremento2Percento = (String) request.getAttribute("incremento2Percento");
    String prezzoTotSenz = (String) request.getAttribute("prezzoTotaleSenzaIncremento");

    // Formattazione delle date per la visualizzazione
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    String ritiroFormatted = ritiro != null ? ritiro.format(formatter) : "N/A";
    String riconsegnaFormatted = riconsegna != null ? riconsegna.format(formatter) : "N/A";
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modulo di Pagamento</title>
    
    <link rel="stylesheet" href="style.css">
    
    <style>
    form {
    display: flex;
    flex-direction: column;
    gap: 20px;
    width: auto;
    border-radius: 10px;
    margin: auto;
    align-items: center;
}
         body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom, #d2e1ef, #efe5a2, #fcc262);
            margin: 0;
            padding: 0;
            min-height: 100vh;
         }
         /* Wrapper per centrare il contenuto principale (esclusa la navbar) */
         .main-content {
             display: flex;
             align-items: center;
             justify-content: center;
             padding: 40px 0;
         }
         .container {
            background: white;
            width: 70%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            display: flex;
         }
         .left-container, .right-container {
            width: 50%;
            padding: 20px;
         }
         /* Riduci lo spazio tra il titolo e la form nella parte sinistra */
         .left-container h2 {
            margin-bottom: 10px;
         }
         .left-container form {
            margin-top: 0;
         }
         h2, h3 {
            text-align: center;
            color: #4B0082;
         }
         .form-group {
            margin-bottom: 15px;
         }
         .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #4B0082;
         }
         .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
         }
         button:hover {
            background: #E63900;
         }
         .price-details, .benefits {
            margin-top: 20px;
            padding: 15px;
            background: #F8F8FF;
            border-radius: 10px;
         }
         .price-details p, .benefits ul li {
            color: #333;
         }
         .benefits ul {
            list-style: none;
            padding: 0;
         }
         .cancel-note {
            text-align: center;
            margin-top: 20px;
            font-weight: bold;
         }
    </style>
</head>
<body>
    <!-- Navbar (non centrata) -->
    <nav class="my-navbar">
        <div class="logo-container">
            <img src="images/Logo.png" class="logo_immagine" alt="Logo">
        </div>
        <%
        Utente utenteLoggatoHome = (Utente) session.getAttribute("user");
        %>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <%
            if (utenteLoggatoHome != null) {
            %>
            <li><a href="areaUtente.jsp">Area utente</a></li>
            <%
            if (utenteLoggatoHome.isAmministratore()) {
            %>
            <li><a href="AdminController?method=get">Gestione</a></li>
            <%
            }
            %>
            <li>
                <form action="UtenteController" method="post" style="display: inline;">
                    <input type="hidden" name="tipoOperazione" value="logout">
                    <button class="register-btn">Logout</button>
                </form>
            </li>
            <%
            } else {
            %>
            <li><a href="Register.jsp"><button class="login-btn">Accedi</button></a></li>
            <%
            }
            %>
        </ul>
    </nav>

    <!-- Contenuto principale centrato -->
    <div class="main-content">
        <div class="container">
            <div class="left-container">
                <h2>Come vuoi pagare?</h2>
                <!-- La form è subito dopo il titolo, senza margine aggiuntivo -->
                <form id="carForm" action="NoleggioController" method="post">
                    <div class="form-group">
                        <label for="cardholder">Titolare della carta</label>
                        <input type="text" id="cardholder" name="cardholder" required>
                    </div>
                    <div class="form-group">
                        <label for="cardnumber">Numero della carta</label>
                        <input type="text" id="cardnumber" name="cardnumber" required>
                    </div>
                    <div class="form-group">
                        <label for="expiration">Scadenza</label>
                        <input type="text" id="expiration" name="expiration" placeholder="MM/AA" required>
                    </div>
                    <div class="form-group">
                        <label for="cvc">CVC</label>
                        <input type="text" id="cvc" name="cvc" required>
                    </div>
                    <input type="hidden" name="tipoOperazione" value="confermaPrenotazione">
                    <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                    <input type="hidden" name="dataRitiro" value="<%= dataRitiro != null ? dataRitiro : "" %>">
                    <input type="hidden" name="oraRitiro" value="<%= oraRitiro != null ? oraRitiro : "" %>">
                    <input type="hidden" name="dataRiconsegna" value="<%= dataRiconsegna != null ? dataRiconsegna : "" %>">
                    <input type="hidden" name="oraRiconsegna" value="<%= oraRiconsegna != null ? oraRiconsegna : "" %>">
                    <input type="hidden" name="pagametoTotale" value="<%= prezzoTotaleStr %>">
                    <button type="submit">Paga</button>
                </form>
            </div>
            <div class="right-container">
                <div class="price-details">
                    <h3>Dettaglio prezzi dell'auto</h3>
                    <p><strong>Modello Auto:</strong> <%= auto != null ? auto.getModello() : "N/A" %></p>
                    <p><strong>Targa:</strong> <%= auto != null ? auto.getTarga() : "N/A" %></p>
                    <p><strong>Data di Ritiro:</strong> <%= ritiroFormatted %></p>
                    <p><strong>Data di Riconsegna:</strong> <%= riconsegnaFormatted %></p>
                    <p><strong>Prezzo:</strong> <%= prezzoTotSenz %> €</p>
                    <p><strong>+ tassa servizio:</strong> <%= incremento2Percento %> €</p>
                    <p><strong>Costo totale:</strong> <%= prezzoTotaleStr %> €</p>
                </div>
                <div class="benefits">
                    <h3>Ottima scelta!</h3>
                    <%
                    RecensioneQuery recensioneQuery = new RecensioneQuery();
                    List<Recensione> recensioni = recensioneQuery.getAllRecensioniPerAuto(auto.getId());
                    double somma = 0;
                    double c = 0;
                    for(Recensione recensione : recensioni){
                        somma += recensione.getValuatzione();
                        c++;
                    }
                    double media = (c > 0) ? somma / c : 0;
                    String mediaFormatted = String.format("%.1f", media);
                    %>
                    <p class="card-text"><strong>Valutazione media:</strong> <%= mediaFormatted %> ⭐</p>
                </div>
                <div class="cancel-note">
                    <p>Cancellazione gratuita fino a 48 ore prima del ritiro</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
