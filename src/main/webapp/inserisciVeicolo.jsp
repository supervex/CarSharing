<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inserisci Veicolo - Drive Easy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
    <style>
        .card-body {
            flex: auto;
            padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
            color: var(--bs-card-color);
            display: flex;
            flex-direction: column;
            width: 700px;
        }
        .btn-primary {
            background-color: #0d6efd;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <nav class="my-navbar">
        <div class="logo-container">
            <img src="images/Logo.png" class="logo_immagine" alt="Logo">
        </div>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <li><a href="areaUtente.jsp">Area utente</a></li>
            <li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
            <li><a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a></li>
            <li>
                <form action="UtenteController" method="post" style="display: inline;">
                    <input type="hidden" name="tipoOperazione" value="logout">
                    <button class="register-btn">Logout</button>
                </form>
            </li>
        </ul>
    </nav>

    <div class="sidebar">
        <a href="areaUtente.jsp">Profilo Utente</a>
        <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
        <a href="AutoController?tipoOperazione=autoUtente">Le tue Auto</a>
        <a href="RecensioneController?tipoOperazione=mostraRecensioni">Le tue Recensioni</a>
        <a class="active" href="inserisciVeicolo.jsp">Aggiungi Auto</a>
    </div>

    <div class="content">
        <div class="container mt-4">
            <h1 class="text-center mb-4">INSERISCI IL TUO VEICOLO</h1>
            <form action="AutoController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="tipoOperazione" value="inserisci">
                <input type="hidden" name="utente" value="<%= utenteLoggato.getId() %>">
                <div class="card mx-auto shadow-sm" style="max-width: 700px;">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Dettagli Veicolo</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Targa</label>
                            <input type="text" name="targa" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Modello</label>
                            <input type="text" name="modello" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Carburante</label>
                            <input type="text" name="carburante" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Livello carburante</label>
                            <input type="number" name="livello" class="form-control" step="0.1" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Numero Posti</label>
                            <input type="number" name="numeroPosti" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cambio</label>
                            <select name="cambio" class="form-control" required>
                                <option value="" disabled selected>Seleziona</option>
                                <option value="manuale">Manuale</option>
                                <option value="automatico">Automatico</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Posizione</label>
                            <input type="text" name="posizione" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Città</label>
                            <input type="text" name="citta" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Prezzo</label>
                            <input type="number" name="prezzo" class="form-control" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Immagine</label>
                            <input type="file" name="immagine" class="form-control" accept="image/*" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Aggiungi Veicolo</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
