<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Noleggio, models.Auto" %>
<html>
<head>
    <title>Dettagli Prenotazione</title>
</head>
<body>
    <h1>Dettagli Prenotazione</h1>
    <%
        // Recupera gli oggetti Noleggio e Auto passati come attributi
        Noleggio noleggio = (Noleggio) request.getAttribute("noleggio");
        Auto auto = (Auto) request.getAttribute("auto");
        
        if (noleggio != null && auto != null) {
    %>
            <!-- Sezione dettagli noleggio -->
            <h2>Dettagli Noleggio</h2>
            <p><strong>Data inizio:</strong> <%= noleggio.getData_inizio() %></p>
            <p><strong>Data fine:</strong> <%= noleggio.getData_fine() %></p>
            <p><strong>Pagamento:</strong> €<%= noleggio.getPagamento() %></p>
            
            <!-- Sezione dettagli auto -->
            <h2>Dettagli Auto</h2>
            <p><strong>Targa:</strong> <%= auto.getTarga() %></p>
            <p><strong>Modello:</strong> <%= auto.getModello() %></p>
            <p><strong>Città:</strong> <%= auto.getCitta() %></p>
            <p><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
            <p><strong>Immagine:</strong></p>
            <img src="<%= auto.getImmagine() %>" alt="Immagine Auto" width="300">
    <%
        } else {
    %>
            <p>Errore: i dettagli della prenotazione non sono disponibili.</p>
    <%
        }
    %>
    <br>
    <a href="javascript:history.back()">Torna alla pagina precedente</a>
</body>
</html>
