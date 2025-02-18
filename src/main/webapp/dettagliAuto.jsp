<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Auto" %>
<%
    Auto auto = (Auto) request.getAttribute("auto");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Auto</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #f4f4f4; }
        .card { width: 50%; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); text-align: center; }
        .card img { width: 100%; max-height: 200px; object-fit: cover; border-radius: 5px; margin-bottom: 15px; }
        .detail { margin-bottom: 10px; font-size: 16px; }
    </style>
</head>
<body>
    <div class="card">
        <img src="placeholder.jpg" alt="Immagine Auto">
        <h2>Dettagli Auto</h2>
        <div class="detail"><strong>ID:</strong> <%= auto.getId() %></div>
        <div class="detail"><strong>ID Utente:</strong> <%= auto.getIdUtente() %></div>
        <div class="detail"><strong>Targa:</strong> <%= auto.getTarga() %></div>
        <div class="detail"><strong>Modello:</strong> <%= auto.getModello() %></div>
        <div class="detail"><strong>Carburante:</strong> <%= auto.getCarburante() %></div>
        <div class="detail"><strong>Livello Carburante:</strong> <%= auto.getLivello() %></div>
        <div class="detail"><strong>Numero Posti:</strong> <%= auto.getNumeroPosti() %></div>
        <div class="detail"><strong>Cambio:</strong> <%= auto.getCambio() %></div>
        <div class="detail"><strong>Posizione:</strong> <%= auto.getPosizione() %></div>
        <div class="detail"><strong>Citta:</strong> <%= auto.getCitta() %></div>
        <div class="detail"><strong>Prezzo:</strong> <%= auto.getPrezzo() %> €</div>
        <a href="NoleggioController?tipoOperazione=prenota&id=<%=auto.getId()%>"class="btn btn-primary">Prenota</a>
    </div>
</body>
</html>

