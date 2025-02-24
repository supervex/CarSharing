<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inserisci Veicolo - Drive Easy</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="areaUtente.css">
<link rel="stylesheet" href="style.css">
<style>
    .error-message {
        color: red;
        background-color: #ffd6d6;
        border: 1px solid red;
        padding: 10px;
        margin-bottom: 10px;
        text-align: center;
        font-weight: bold;
    }
    h1{
    color: #0c2241;
    font-weight: bold;
    text-align: center !important;
    }
    section{
    flex-direction: initial;
    }
    button{
padding: 7px 20px;
}
</style>
</head>
<body>
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
      <li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
      <li><a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a></li>
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

    <!-- Messaggio di errore se presente -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div class="error-message">
            <%= errorMessage %>
        </div>
    <%
        }
    %>
<div class="sidebar">
  <a href="areaUtente.jsp">Profilo Utente</a>
  <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
  <a href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
  <a class="active" href="inserisciVeicolo.jsp">Aggiungi Auto</a>
</div>

<!-- Page content -->

<div class="content">
    <div class="container">
        <h1>Inserisci il tuo veicolo</h1>
        <section>
        <form id="carForm" action="AutoController" method="post" enctype="multipart/form-data">
            <!-- Controllo se l'utente è loggato -->
            <% if (utenteLoggatoHome != null) { %>
                <input type="hidden" name="utente" value="<%= utenteLoggatoHome.getId() %>">
            <% } else { %>
                <input type="hidden" name="utente" value="">
            <% } %>

            <input type="hidden" name="tipoOperazione" value="inserisci">
            <input type="text" name="targa" placeholder="Targa" required>
            <input type="text" name="modello" placeholder="Modello" required>
            <input type="text" name="carburante" placeholder="Carburante" required>
            <input type="number" name="livello" placeholder="Livello" step="0.1" required>
            <input type="number" name="numeroPosti" placeholder="Numero posti" required>
            <select id="cambio" name="cambio" required>
                <option value="" disabled selected>Cambio</option>
                <option value="manuale">Manuale</option>
                <option value="automatico">Automatico</option>
            </select>
            <input type="text" name="posizione" placeholder="Indirizzo" required>
            <input type="text" name="citta" placeholder="Città" required>
            <input type="number" name="prezzo" step="0.01" placeholder="Prezzo" required>
            
            <!-- Campo per caricare l'immagine -->
            <input type="file" name="immagine" accept="image/*" required>
            
            <button type="submit">Invia</button>
        </form>
        </section>
    </div>
    </div>
     <!-- Bootstrap JS (opzionale, per eventuali interazioni) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>