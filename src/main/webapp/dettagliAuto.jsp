<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Auto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dettagli Auto - Drive Easy</title>
    <!-- Bootstrap CSS (opzionale, per un layout più gradevole) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center">Dettagli Auto</h1>
        <%
            Auto auto = (Auto) request.getAttribute("auto");
            if(auto != null) {
        %>
        <div class="card mb-3" style="max-width: 800px; margin: 0 auto;">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="<%= auto.getImmagine() %>" class="img-fluid rounded-start" alt="Immagine auto">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= auto.getModello() %> - <%= auto.getTarga() %></h5>
                        <p class="card-text"><strong>Carburante:</strong> <%= auto.getCarburante() %></p>
                        <p class="card-text"><strong>Livello Carburante:</strong> <%= auto.getLivello() %>%</p>
                        <p class="card-text"><strong>Numero Posti:</strong> <%= auto.getNumeroPosti() %></p>
                        <p class="card-text"><strong>Cambio:</strong> <%= auto.getCambio() %></p>
                        <p class="card-text"><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
                        <p class="card-text"><strong>Città:</strong> <%= auto.getCitta() %></p>
                        <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
                        <p class="card-text"><strong>ID Auto:</strong> <%= auto.getId() %></p>
                        <p class="card-text"><strong>ID Utente:</strong> <%= auto.getIdUtente() %></p>
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <p class="text-center">Nessun dettaglio disponibile per questa auto.</p>
        <%
            }
        %>
        <div class="text-center">
            <a href="HomeController?method=get" class="btn btn-primary">Torna alla Home</a>
             <a href="javascript:history.back()">Torna alla pagina precedente</a>
        </div>
    </div>
    
    <!-- Bootstrap JS (opzionale) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
