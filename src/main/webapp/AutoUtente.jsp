<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Auto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ciao</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Auto per utente</h2>
        <div class="row">
            <% //cambiare lista con lista auto dell'utente
                List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAutoUtente");
                if (listaAuto != null && !listaAuto.isEmpty()) {
                    for (Auto auto : listaAuto) {
            %>
            <div class="col-md-4">
                <div class="card mb-3">
                    <img src="img/auto_default.jpg" class="card-img-top" alt="Immagine auto">
                    <div class="card-body">
                        <h5 class="card-title"><%= auto.getModello() %></h5>
                        <p class="card-text"><strong>Targa:</strong> <%= auto.getTarga() %></p>
                        <p class="card-text"><strong>Carburante:</strong> <%= auto.getCarburante() %></p>
                        <p class="card-text"><strong>Livello carburante:</strong> <%= auto.getLivello() %>%</p>
                        <p class="card-text"><strong>Numero posti:</strong> <%= auto.getNumeroPosti() %></p>
                        <p class="card-text"><strong>Cambio:</strong> <%= auto.getCambio() %></p>
                        <p class="card-text"><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
                        <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
                        <a href="AutoController?tipoOperazione=aggiorna&id=<%= auto.getId() %>" class="btn btn-primary">Modifica</a>



                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p class="text-center">Nessuna auto disponibile.</p>
            <%
                }
            %>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
