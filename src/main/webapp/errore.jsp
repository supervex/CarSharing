<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Errore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center text-danger">Si è verificato un errore</h2>

        <% 
            // Recupera il messaggio di errore passato dal servlet
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <% } else { %>
            <div class="alert alert-danger" role="alert">
                Si è verificato un errore sconosciuto. Per favore riprova più tardi.
            </div>
        <% } %>

        <div class="text-center">
            <a href="AutoUtente.jsp" class="btn btn-primary">Torna alla lista auto</a>
            <a href="index.jsp" class="btn btn-secondary">Torna alla homepage</a>
        </div>
    </div>
</body>
</html>
