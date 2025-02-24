<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Recensione" %>
<%@ page import="models.Utente" %>
<%@ page import="models.Auto" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="context.AutoQuery" %>
<%
    // Recupera la lista di recensioni passata dal controller
    ArrayList<Recensione> recensioni = (ArrayList<Recensione>) request.getAttribute("recensioni");
    HttpSession sessione = request.getSession();
    Utente utente = (Utente) sessione.getAttribute("user");
    AutoQuery autoQuery = new AutoQuery();
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Le Mie Recensioni</title>
    <!-- Bootstrap CDN per garantire coerenza con il layout -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- I tuoi file CSS personalizzati -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
    <style>
button{
padding: 7px 20px;
}
</style>
    <style>
      /* Consenti il wrapping del testo nelle celle */
      .table td, .table th {
          white-space: normal;
          word-wrap: break-word;
          
      }
      .btn-danger {
    background-color: #fd0d0d;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 15px;
    cursor: pointer;
    font-size: 16px;
    margin-right: 5px;
    display: flex;
}
    </style>
</head>
<body>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null) {
        response.sendRedirect("HomeController?method=get");
        return;
    }
%>

<!-- Navbar -->
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

<!-- Sidebar -->
<div class="sidebar">
    <a href="areaUtente.jsp">Profilo Utente</a>
    <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
    <a href="AutoController?tipoOperazione=autoUtente">Le tue Auto</a>
    <a class="active" href="RecensioneController?tipoOperazione=mostraRecensioni">Le tue Recensioni</a>
    <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
</div>

<!-- Contenuto principale -->
<div class="content">
    <div class="container mt-4">
        <h1 class="text-center mb-4">Le Mie Recensioni</h1>
        
        <!-- Card per le Recensioni -->
        <div class="card mx-auto shadow-sm mb-4" style="max-width: 60%;">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Recensioni</h5>
            </div>
            <div class="card-body">
                <% if (recensioni != null && !recensioni.isEmpty()) { %>
                  <table class="table table-striped table-hover align-middle">
    <thead>
        <tr>
            
            <th>Modello Auto</th>
            <th>Descrizione</th>
            <th>Valutazione</th>
            <th class="text-end pe-3" style="width: 150px;">Azioni</th>
        </tr>
    </thead>
    <tbody>
        <% for (Recensione recensione : recensioni) { 
            Auto auto = autoQuery.trovaAutoPerId(recensione.getIdAuto());
        %>
            <tr>
                
                <td><%= auto.getModello() %></td>
                <td class="text-start"><%= recensione.getDescrizione() %></td>
                <td><%= recensione.getValuatzione() %> / 5</td>
                <td>
                    <form action="RecensioneController" method="post" class="d-inline">
                        <input type="hidden" name="tipoOperazione" value="eliminaRecensione">
                        <input type="hidden" name="idRecensione" value="<%= recensione.getId() %>">
                        <button type="submit" class="btn btn-danger"
                                onclick="return confirm('Sei sicuro di voler eliminare questa recensione?');">
                            Elimina
                        </button>
                    </form>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>



                <% } else { %>
                    <p>Non hai ancora scritto recensioni.</p>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->


<!-- Bootstrap JS (opzionale) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
