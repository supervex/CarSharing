<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Recensione" %>
<%@ page import="models.Utente" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Recupera la lista di recensioni passata dal controller
    ArrayList<Recensione> recensioni = (ArrayList<Recensione>) request.getAttribute("recensioni");
    HttpSession sessione = request.getSession();
    Utente utente = (Utente) sessione.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Le Mie Recensioni</title>
    <link rel="stylesheet" href="styles.css"> <!-- Aggiungi il tuo file CSS se necessario -->
</head>
<body>
    <h2>Le Mie Recensioni</h2>

    <% if (recensioni != null && !recensioni.isEmpty()) { %>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Recensione</th>
                    <th>ID Auto</th>
                    <th>Descrizione</th>
                    <th>Valutazione</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% for (Recensione recensione : recensioni) { %>
                    <tr>
                        <td><%= recensione.getId() %></td>
                        <td><%= recensione.getIdAuto() %></td>
                        <td><%= recensione.getDescrizione() %></td>
                        <td><%= recensione.getValuatzione() %> / 5</td>
                        <td>
                            <form action="RecensioneController" method="post">
                                <input type="hidden" name="tipoOperazione" value="eliminaRecensione">
                                <input type="hidden" name="idRecensione" value="<%= recensione.getId() %>">
                                <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questa recensione?');">
                                    Elimina
                                </button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>Non hai ancora scritto recensioni.</p>
    <% } %>

    <br>
    <a href="HomeController?method=get">Torna alla home</a>
</body>
</html>
