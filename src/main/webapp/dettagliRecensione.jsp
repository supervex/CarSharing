<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Recensione" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Recensione</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px gray;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
            padding: 10px;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        a {
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 20px;
            border-radius: 5px;
        }
        a:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Dettagli Recensione</h2>

        <%
            Recensione recensione = (Recensione) request.getAttribute("recensione");

            if (recensione != null) {
        %>

        <table>
            <tr>
                <th>ID Recensione</th>
                <td><%= recensione.getId() %></td>
            </tr>
            <tr>
                <th>ID Utente</th>
                <td><%= recensione.getIdUtente() %></td>
            </tr>
            <tr>
                <th>ID Auto</th>
                <td><%= recensione.getIdAuto() %></td>
            </tr>
            <tr>
                <th>Descrizione</th>
                <td><%= recensione.getDescrizione() %></td>
            </tr>
            <tr>
                <th>Valutazione</th>
                <td><%= recensione.getValuatzione() %> / 5</td>
            </tr>
        </table>

        <br>
        <a href="HomeController?method=get">Torna alla Home</a>

        <%
            } else {
        %>
        <p style="color: red;">Errore: Recensione non trovata.</p>
        <a href="HomeController?method=get">Torna alla Home</a>
        
        <%
            }
        %>

    </div>

</body>
</html>
