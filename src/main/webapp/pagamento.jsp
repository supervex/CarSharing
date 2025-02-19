<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="models.Auto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modulo di Pagamento</title>
   <% 
    // Recupera l'auto
    Auto auto = (Auto) request.getAttribute("auto");

    // Recupera i valori delle date e orari di ritiro e riconsegna
    String dataRitiro = (String) request.getAttribute("dataRitiro");
    String oraRitiro = (String) request.getAttribute("oraRitiro");
    String dataRiconsegna = (String) request.getAttribute("dataRiconsegna");
    String oraRiconsegna = (String) request.getAttribute("oraRiconsegna");
%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            display: flex;
            justify-content: space-between;
        }
        .form-container {
            width: 45%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .details-container {
            width: 45%;
            padding: 20px;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .benefits ul {
            list-style: none;
            padding: 0;
        }
        .benefits ul li {
            margin-bottom: 10px;
        }
        .cancel-note {
            text-align: center;
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Come vuoi pagare?</h2>
        <form id="carForm" action="NoleggioController" method="post">
            <div class="form-group">
                <label for="cardholder">Titolare della carta</label>
                <input type="text" id="cardholder" name="cardholder" required>
            </div>
            <div class="form-group">
                <label for="cardnumber">Numero della carta</label>
                <input type="text" id="cardnumber" name="cardnumber" required>
            </div>
            <div class="form-group">
                <label for="expiration">Scadenza</label>
                <input type="text" id="expiration" name="expiration" placeholder="MM/AA" required>
            </div>
            <div class="form-group">
                <label for="cvc">CVC</label>
                <input type="text" id="cvc" name="cvc" required>
            </div>
            <input type="hidden" name="tipoOperazione" value="confermaPrenotazione">
            <input type="hidden" name="idAuto" value=<%= auto.getId() %>>
            <input type="hidden" name="dataRitiro" value="<%= dataRitiro != null ? dataRitiro : "" %>">
<input type="hidden" name="oraRitiro" value="<%= oraRitiro != null ? oraRitiro : "" %>">
<input type="hidden" name="dataRiconsegna" value="<%= dataRiconsegna != null ? dataRiconsegna : "" %>">
<input type="hidden" name="oraRiconsegna" value="<%= oraRiconsegna != null ? oraRiconsegna : "" %>">
            
            <button type="submit">Paga</button>
        </form>
    </div>
    <div class="details-container">
        <div class="price-details">
            <h3>Dettaglio prezzi dell'auto</h3>
            <% 
                // Recupera gli attributi dalla request
                
                LocalDateTime ritiro = (LocalDateTime) request.getAttribute("ritiro");
                LocalDateTime riconsegna = (LocalDateTime) request.getAttribute("riconsegna");
                String prezzoTotaleStr = (String) request.getAttribute("prezzoTotale"); // Recupera come String
                String incremento2Percento = (String) request.getAttribute("incremento2Percento");
                String prezzoTotSenz = (String) request.getAttribute("prezzoTotaleSenzaIncremento");
               

                // Formattazione delle date per la visualizzazione
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                String ritiroFormatted = ritiro != null ? ritiro.format(formatter) : "N/A";
                String riconsegnaFormatted = riconsegna != null ? riconsegna.format(formatter) : "N/A";
            %>
            <p><strong>Modello Auto:</strong> <%= auto != null ? auto.getModello() : "N/A" %></p>
            <p><strong>Targa:</strong> <%= auto != null ? auto.getTarga() : "N/A" %></p>
            <p><strong>Data di Ritiro:</strong> <%= ritiroFormatted %></p>
            <p><strong>Data di Riconsegna:</strong> <%= riconsegnaFormatted %></p>
            <p><strong>prezzo:</strong> <%= prezzoTotSenz %> €</p>
            <p><strong>+ tassa servizio:</strong> <%= incremento2Percento %> €</p>
            <p><strong>Costo totale:</strong> <%= prezzoTotaleStr %> €</p>
        </div>
        <div class="benefits">
            <h3>Ottima scelta!</h3>
            <ul>
                <li>Valutazione clienti: 8.0 / 10</li>
                <li>Politica carburante più diffusa</li>
                <li>Code più brevi al banco</li>
                <li>Banco facile da individuare</li>
                <li>Il personale al banco si è rivelato utile</li>
                <li>Cancellazione gratuita</li>
            </ul>
        </div>
        <div class="cancel-note">
            <p>Cancellazione gratuita fino a 48 ore prima del ritiro</p>
        </div>
    </div>
</body>
</html>
