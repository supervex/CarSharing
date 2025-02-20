<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dettagli Utente - Drive Easy</title>
    <!-- Bootstrap CSS per un layout gradevole -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center">Dettagli Utente</h1>
        <%
            Utente utente = (Utente) session.getAttribute("user");
            if(utente != null) {
        %>
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body">
                <h5 class="card-title"><%= utente.getNome() %> <%= utente.getCognome() %></h5>
                <p class="card-text"><strong>ID:</strong> <%= utente.getId() %></p>
                <p class="card-text"><strong>Username:</strong> <%= utente.getUsername() %></p>
                <p class="card-text"><strong>Data di Nascita:</strong> <%= utente.getDataNascita() %></p>
                <p class="card-text"><strong>Password:</strong> <%= utente.getPasswordUtente() %></p>
                <p class="card-text"><strong>Città:</strong> <%= utente.getCitta() %></p>
                <p class="card-text"><strong>Telefono:</strong> <%= utente.getTelefono() %></p>
                <p class="card-text"><strong>Email:</strong> <%= utente.getEmail() %></p>
                <p class="card-text"><strong>Ruolo:</strong> <%= utente.isAmministratore() ? "Amministratore" : "Utente" %></p>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-warning text-center" role="alert">
            Nessun utente loggato.
        </div>
        <%
            }
        %>
        <div class="text-center mt-4">
            <a href="HomeController?method=get" class="btn btn-primary">Torna alla Home</a>
             <a href="javascript:history.back()">Torna alla pagina precedente</a>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
