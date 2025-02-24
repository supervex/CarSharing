<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Auto - Drive Easy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="my-navbar">
        <div class="logo-container">
            <img src="images/Logo.png" class="logo_immagine" alt="Logo">
        </div>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <li><a href="areaUtente.jsp">Area utente</a></li>
            <li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
            <li><a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a></li>
            <li>
                <form action="UtenteController" method="post" style="display: inline;">
                    <input type="hidden" name="tipoOperazione" value="logout">
                    <button class="register-btn">Logout</button>
                </form>
            </li>
        </ul>
    </nav>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="areaUtente.jsp">Profilo Utente</a>
        <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Le tue Prenotazioni</a>
        <a class="active" href="AutoController?tipoOperazione=autoUtente">Le tue Auto</a>
        <a href="RecensioneController?tipoOperazione=mostraRecensioni">Le tue Recensioni</a>
        <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
    </div>

    <!-- Contenuto principale -->
    <div class="content">
        <div class="container mt-4">
            <h2 class="text-center">Modifica Auto</h2>
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { 
            %>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage %>
                </div>
            <% } %>

            <% Auto auto = (Auto) request.getAttribute("auto"); %>
            <form action="AutoController" method="post">
                <input type="hidden" name="tipoOperazione" value="aggiorna">
                <input type="hidden" name="id" value="<%= auto.getId() %>">
                
                <div class="card mx-auto shadow-sm" style="width: 60%;">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">MODIFICA AUTO</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Modello:</label>
                            <input type="text" class="form-control" name="modello" value="<%= auto.getModello() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Targa:</label>
                            <input type="text" class="form-control" name="targa" value="<%= auto.getTarga() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Carburante:</label>
                            <input type="text" class="form-control" name="carburante" value="<%= auto.getCarburante() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Livello Carburante (%):</label>
                            <input type="number" class="form-control" name="livello" value="<%= auto.getLivello() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Numero posti:</label>
                            <input type="number" class="form-control" name="numeroPosti" value="<%= auto.getNumeroPosti() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cambio:</label>
                            <input type="text" class="form-control" name="cambio" value="<%= auto.getCambio() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Posizione:</label>
                            <input type="text" class="form-control" name="posizione" value="<%= auto.getPosizione() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Città:</label>
                            <input type="text" class="form-control" name="citta" value="<%= auto.getCitta() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Prezzo al giorno (€):</label>
                            <input type="number" step="0.01" class="form-control" name="prezzo" value="<%= auto.getPrezzo() %>" required>
                        </div>
                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-success">Salva Modifiche</button>
                            <a href="AutoController?tipoOperazione=autoUtente" class="btn btn-secondary">Annulla</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
