<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Auto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica Auto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Modifica Auto</h2>

        <% Auto auto = (Auto) request.getAttribute("auto"); %>
        <form action="AutoController" method="post">
        <input type="hidden" name="tipoOperazione" value="aggiorna">
            <input type="hidden" name="id" value="<%= auto.getId() %>">

            <div class="mb-3">
                <label class="form-label">Modello:</label>
                <input type="text" class="form-control" name="modello" value="<%= auto.getModello() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Targa:</label>
                <input type="text" class="form-control" name="targa" value="<%= auto.getTarga() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Carburante:</label>
                <input type="text" class="form-control" name="carburante" value="<%= auto.getCarburante() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Livello Carburante (%):</label>
                <input type="number" class="form-control" name="livello" value="<%= auto.getLivello() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Numero posti:</label>
                <input type="number" class="form-control" name="numeroPosti" value="<%= auto.getNumeroPosti() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Cambio:</label>
                <input type="text" class="form-control" name="cambio" value="<%= auto.getCambio() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Posizione:</label>
                <input type="text" class="form-control" name="posizione" value="<%= auto.getPosizione() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">citta:</label>
                <input type="text" class="form-control" name="citta" value="<%= auto.getCitta() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Prezzo al giorno (€):</label>
                <input type="number" step="0.01" class="form-control" name="prezzo" value="<%= auto.getPrezzo() %>" required>
            </div>

            <button type="submit" class="btn btn-success">Salva Modifiche</button>
            <a href="AutoUtente.jsp" class="btn btn-secondary">Annulla</a>
        </form>
    </div>
</body>
</html>
