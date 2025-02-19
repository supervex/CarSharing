<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Recensione" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente" %>

<%
    // Recupero l'ID della prenotazione passato tramite la request
  
    

    // Recupero gli oggetti auto e utente passati dal controller
    Auto auto = (Auto) request.getAttribute("auto");
    Utente utente = (Utente) request.getAttribute("utente");

    // Recupero la prenotazione associata a questo ID
    Noleggio noleggio = (Noleggio) request.getAttribute("noleggio");

    if (noleggio == null) {
        out.println("<p>La prenotazione non è stata trovata.</p>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lascia una Recensione</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <h1>Lascia una Recensione per la tua prenotazione</h1>

    <h2>Dettagli Prenotazione</h2>
    <p><strong>Modello Auto:</strong> <%= auto.getModello() %></p>
    <p><strong>Targa:</strong> <%= auto.getTarga() %></p>
    <p><strong>Data di Inizio:</strong> <%= noleggio.getData_inizio() %></p>
    <p><strong>Data di Fine:</strong> <%= noleggio.getData_fine() %></p>

    <form action="RecensioneController" method="POST">
       <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
        <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
        <input type="hidden" name="idUtente" value="<%= utente.getId() %>">

        <div class="form-group">
            <label for="descrizione">Descrizione Recensione:</label>
            <textarea name="descrizione" id="descrizione" rows="4" class="input-field" required></textarea>
        </div>

        <div class="form-group">
            <label for="punteggio">Punteggio:</label>
            <div>
                <label for="stelle1">
                    <input type="radio" id="stelle1" name="punteggio" value="1"> 1 stella
                </label>
                <label for="stelle2">
                    <input type="radio" id="stelle2" name="punteggio" value="2"> 2 stelle
                </label>
                <label for="stelle3">
                    <input type="radio" id="stelle3" name="punteggio" value="3"> 3 stelle
                </label>
                <label for="stelle4">
                    <input type="radio" id="stelle4" name="punteggio" value="4"> 4 stelle
                </label>
                <label for="stelle5">
                    <input type="radio" id="stelle5" name="punteggio" value="5"> 5 stelle
                </label>
            </div>
        </div>

        <div class="form-group">
            <button type="submit">Invia Recensione</button>
        </div>
    </form>

    <a href="storicoPrenotazioni.jsp">Torna allo storico delle prenotazioni</a>

</body>
</html>
