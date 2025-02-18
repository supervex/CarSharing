<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, models.Auto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista Auto Noleggio</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Auto Disponibili per Noleggio</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Targa</th>
                    <th>Modello</th>
                    <th>Carburante</th>
                    <th>Livello</th>
                    <th>Numero Posti</th>
                    <th>Cambio</th>
                    <th>Posizione</th>
                    <th>Città</th>
                    <th>Prezzo</th>
                    <th>Azioni</th> <!-- Nuova colonna per il tasto Prenota -->
                </tr>
            </thead>
            <tbody>
                <% 
                    // Recuperiamo la lista delle auto passata dalla servlet
                    List<Auto> autoList = (List<Auto>) request.getAttribute("listaAutoNoleggio");
                    if (autoList != null && !autoList.isEmpty()) {
                        // Iteriamo sulla lista e visualizziamo i dettagli di ciascuna auto
                        for (Auto auto : autoList) {
                %>
                    <tr>
                        <td><%= auto.getId() %></td>
                        <td><%= auto.getTarga() %></td>
                        <td><%= auto.getModello() %></td>
                        <td><%= auto.getCarburante() %></td>
                        <td><%= auto.getLivello() %></td>
                        <td><%= auto.getNumeroPosti() %></td>
                        <td><%= auto.getCambio() %></td>
                        <td><%= auto.getPosizione() %></td>
                        <td><%= auto.getCitta() %></td>
                        <td><%= auto.getPrezzo() %> €</td>
                        <td>
                            <form action="NoleggioController" method="get">
                                <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                                <input type="hidden" name="idUtente" value="<%= auto.getIdUtente() %>">
                                <input type="hidden" name="tipoOperazione" value="dettagli">
                                <button type="submit">Prenota</button>
                            </form>
                        </td>
                    </tr>
                <%  
                        }
                    } else {
                %> 
                    <tr>
                        <td colspan="11">Nessuna auto disponibile per il periodo selezionato.</td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
        </table>

        <button onclick="window.history.back()">Indietro</button>
    </div>
</body>
</html>
