<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Auto" %>
<%
    Auto auto = (Auto) request.getAttribute("auto");
    String dataRitiro = (String) request.getAttribute("dataRitiro");
    String oraRitiro = (String) request.getAttribute("oraRitiro");
    String dataRiconsegna = (String) request.getAttribute("dataRiconsegna");
    String oraRiconsegna = (String) request.getAttribute("oraRiconsegna");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Inserimento Prenotazione</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; flex-direction: column; align-items: center; background-color: #f4f4f4; padding: 20px; }
        .card { width: 50%; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); text-align: center; margin-bottom: 20px; }
        .card img { width: 100%; max-height: 200px; object-fit: cover; border-radius: 5px; margin-bottom: 15px; }
        .detail { margin-bottom: 10px; font-size: 16px; }
        .search-bar { width: 50%; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        .input-field { width: 100%; padding: 8px; margin-top: 5px; }
        .btn-primary { background-color: #007bff; color: white; padding: 10px; border: none; cursor: pointer; margin-top: 10px; width: 100%; }
    </style>
</head>
<body>
    <div class="card">
        <img src="placeholder.jpg" alt="Immagine Auto">
        <h2>Dettagli Auto</h2>
        <div class="detail"><strong>ID:</strong> <%= auto.getId() %></div>
        <div class="detail"><strong>Modello:</strong> <%= auto.getModello() %></div>
        <div class="detail"><strong>Targa:</strong> <%= auto.getTarga() %></div>
        <div class="detail"><strong>Carburante:</strong> <%= auto.getCarburante() %></div>
        <div class="detail"><strong>Livello Carburante:</strong> <%= auto.getLivello() %>%</div>
        <div class="detail"><strong>Numero Posti:</strong> <%= auto.getNumeroPosti() %></div>
        <div class="detail"><strong>Cambio:</strong> <%= auto.getCambio() %></div>
        <div class="detail"><strong>Posizione:</strong> <%= auto.getPosizione() %></div>
        <div class="detail"><strong>Città:</strong> <%= auto.getCitta() %></div>
        <div class="detail"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</div>
    </div>

    <form class="search-bar" method="post" action="NoleggioController">
        <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
        
        <div class="date-time">
            <label for="data-ritiro">📅 Data di ritiro</label>
            <input type="date" name="dataRitiro" id="data-ritiro" class="input-field" 
                   value="<%= dataRitiro != null ? dataRitiro : "" %>">
        </div>

        <div class="date-time">
            <label for="ora-ritiro">🕒 Ora di ritiro</label>
            <input type="time" id="ora-ritiro" name="oraRitiro" class="input-field" 
                   value="<%= oraRitiro != null ? oraRitiro : "" %>">
        </div>

        <div class="date-time">
            <label for="data-riconsegna">📅 Data di riconsegna</label>
            <input type="date" id="data-riconsegna" name="dataRiconsegna" class="input-field" 
                   value="<%= dataRiconsegna != null ? dataRiconsegna : "" %>">
        </div>

        <div class="date-time">
            <label for="ora-riconsegna">🕒 Ora di riconsegna</label>
            <input type="time" id="ora-riconsegna" name="oraRiconsegna" class="input-field" 
                   value="<%= oraRiconsegna != null ? oraRiconsegna : "" %>">
        </div>

        <input type="hidden" name="tipoOperazione" value="confermaPrenotazione">
        <button type="submit" class="btn-primary">Conferma Prenotazione</button>
    </form>
</body>
</html>
