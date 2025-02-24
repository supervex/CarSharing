<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Noleggio, models.Auto, models.Utente" %>

<html>
<head>
    <title>Dettagli Prenotazione</title>
</head>
 <link rel="stylesheet" href="areaUtente.css">
  <link rel="stylesheet" href="style.css">
<style>

body {
    font-family: Arial, sans-serif;
    background-color: #dbe6f1; /* Colore di sfondo chiaro */
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
    margin: 50px auto;
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

h1 {
    text-align: center;
    color: #002244;
}

h2 {
    background-color: #007bff;
    color: white;
    padding: 10px;
    border-radius: 5px;
}

p {
    font-size: 16px;
    color: #333;
    padding: 5px 0;
}

strong {
    color: #000;
}

/* Layout per i dettagli auto */
.auto-container {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
}

.auto-info {
    flex: 1;
}

.auto-image {
    flex-shrink: 0;
}

img {
    border-radius: 5px;
    max-width: 300px;
    height: auto;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}


.edit-button {
    background-color: #007bff;
    color: white;
}

.edit-button:hover {
    background-color: #0056b3;
}

.delete-button {
    background-color: red;
    color: white;
}

.delete-button:hover {
    background-color: darkred;
}

.back-button {
    display: block;
    text-align: center;
    margin-top: 20px;
    font-size: 16px;
    text-decoration: none;
    color: white;
    background: #007bff;
    padding: 10px;
    border-radius: 5px;
}

.back-button:hover {
    background: #0056b3;
}
</style>
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
  
  <h1 style="
    font-size: 40px;
">DETTAGLI PRENOTAZIONE</h1>
    <div class="container">
        
        <%
            Noleggio noleggio = (Noleggio) request.getAttribute("noleggio");
            Auto auto = (Auto) request.getAttribute("auto");
        
            if (noleggio != null && auto != null) {
        %>
            <h2>Dettagli Noleggio</h2>
            <p><strong>Data inizio:</strong> <%= noleggio.getData_inizio() %></p>
            <p><strong>Data fine:</strong> <%= noleggio.getData_fine() %></p>
            <p><strong>Pagamento:</strong> €<%= noleggio.getPagamento() %></p>
            
            <h2>Dettagli Auto</h2>
            <div class="auto-container">
                <div class="auto-info">
                    <p><strong>Targa:</strong> <%= auto.getTarga() %></p>
                    <p><strong>Modello:</strong> <%= auto.getModello() %></p>
                    <p><strong>Città:</strong> <%= auto.getCitta() %></p>
                    <p><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
                </div>
                <div class="auto-image">
                    <img src="imageController?name=<%=auto.getImmagine() %>" alt="Immagine Auto">
                </div>
            </div>
           
        <%
            } else {
        %>
            <p>Errore: i dettagli della prenotazione non sono disponibili.</p>
        <%
            }
        %>
        <a href="javascript:history.back()" class="back-button">Torna alla pagina precedente</a>
    </div>
</body>
</html>
