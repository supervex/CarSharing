<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Auto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Recupero la lista delle prenotazioni e delle auto
    List<Noleggio> noleggi = (List<Noleggio>) request.getAttribute("noleggi");
    List<Auto> autos = (List<Auto>) request.getAttribute("autos");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    // Recupero la data attuale
    LocalDateTime now = LocalDateTime.now();

    // Separazione delle prenotazioni attuali e storiche
    List<Noleggio> prenotazioniAttuali = new ArrayList<>();
    List<Noleggio> storicoPrenotazioni = new ArrayList<>();

    for (int i = 0; i < noleggi.size(); i++) {
        Noleggio noleggio = noleggi.get(i);
        if (noleggio.getData_fine().isAfter(now)) {
            prenotazioniAttuali.add(noleggio);
        } else {
            storicoPrenotazioni.add(noleggio);
        }
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Le tue Prenotazioni</title>
    <link rel="stylesheet" href="styles.css"> <!-- Collegamento a un file CSS -->
</head>
<body>
    <h1>Le tue Prenotazioni</h1>

    <!-- Prenotazioni Attuali -->
    <h2>Prenotazioni Attuali</h2>
    <% if (prenotazioniAttuali.isEmpty()) { %>
        <p>Non hai prenotazioni attive.</p>
    <% } else { %>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Noleggio</th>
                    <th>Modello Auto</th>
                    <th>Targa</th>
                    <th>Data Inizio</th>
                    <th>Data Fine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% for (int i = 0; i < prenotazioniAttuali.size(); i++) { 
                    Noleggio noleggio = prenotazioniAttuali.get(i);
                    Auto auto = autos.get(i);
                %>
                    <tr>
                        <td><%= noleggio.getId() %></td>
                        <td><%= auto.getModello() %></td>
                        <td><%= auto.getTarga() %></td>
                        <td><%= noleggio.getData_inizio().format(formatter) %></td>
                        <td><%= noleggio.getData_fine().format(formatter) %></td>
                        <td>
                            <!-- Pulsante per visualizzare i dettagli -->
                            <form action="NoleggioController" method="GET" style="display:inline;">
                                <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                <input type="hidden" name="tipoOperazione" value="dettagli">
                                <button type="submit">Dettagli</button>
                            </form>

                            <!-- Pulsante per cancellare -->
                            <form action="NoleggioController" method="POST" style="display:inline;">
                                <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                <input type="hidden" name="tipoOperazione" value="elimina">
                                <button type="submit" onclick="return confirm('Sei sicuro di voler cancellare questa prenotazione?')">Cancella</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <!-- Storico Prenotazioni -->
    <h2>Storico Prenotazioni</h2>
    <% if (storicoPrenotazioni.isEmpty()) { %>
        <p>Non hai prenotazioni passate.</p>
    <% } else { %>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Noleggio</th>
                    <th>Modello Auto</th>
                    <th>Targa</th>
                    <th>Data Inizio</th>
                    <th>Data Fine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% for (int i = 0; i < storicoPrenotazioni.size(); i++) { 
                    Noleggio noleggio = storicoPrenotazioni.get(i);
                    Auto auto = autos.get(i);
                %>
                    <tr>
                        <td><%= noleggio.getId() %></td>
                        <td><%= auto.getModello() %></td>
                        <td><%= auto.getTarga() %></td>
                        <td><%= noleggio.getData_inizio().format(formatter) %></td>
                        <td><%= noleggio.getData_fine().format(formatter) %></td>
                        <td>
                            <!-- Pulsante per visualizzare i dettagli -->
                            <form action="NoleggioController" method="GET" style="display:inline;">
                                <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                <input type="hidden" name="tipoOperazione" value="dettagli">
                                <button type="submit">Dettagli</button>
                            </form>

                            <!-- Pulsante per lasciare una recensione -->
                            <form action="RecensioneController" method="GET" style="display:inline;">
                                <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                <input type="hidden" name="tipoOperazione" value="lasciaRecensione">
                                <button type="submit">Lascia una recensione</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <a href="home.jsp">Torna alla Home</a>
</body>
</html>
