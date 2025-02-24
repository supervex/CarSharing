<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Auto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Utente" %>
<%@ page import="context.AutoQuery" %>

<%
    // Recupero la lista delle prenotazioni
    List<Noleggio> noleggi = (List<Noleggio>) request.getAttribute("noleggi");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    // Recupero la data attuale
    LocalDateTime now = LocalDateTime.now();

    // Separazione delle prenotazioni attuali e storiche
    List<Noleggio> prenotazioniAttuali = new ArrayList<>();
    List<Noleggio> storicoPrenotazioni = new ArrayList<>();

    for (Noleggio noleggio : noleggi) {
        if (noleggio.getData_fine().isAfter(now)) {
            prenotazioniAttuali.add(noleggio);
        } else {
            storicoPrenotazioni.add(noleggio);
        }
    }

    // Creo un'istanza di AutoQuery per recuperare le auto tramite id
    AutoQuery autoQuery = new AutoQuery();
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Le tue Prenotazioni</title>
    
    <!-- Collegamento a Bootstrap (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- I tuoi file CSS personalizzati -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
    <style>
button{
padding: 7px 20px;
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
.btn-primary:hover { /* Stile per btn-primary al passaggio del mouse */
    background-color: #064196; /* Mantiene il colore di sfondo arancione al passaggio del mouse */
}    

.btn-danger {
    background-color: #fd0d0d;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 15px;
    cursor: pointer;
    font-size: 16px;
}
.btn-warning {
    background-color: #fdb40d;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 15px;
    cursor: pointer;
    font-size: 16px;
    --bs-btn-hover-color: #fff;
    --bs-btn-hover-bg: #db9901;
}
</style>
</head>
<body>
    <%
        Utente utenteLoggato = (Utente) session.getAttribute("user");
        if (utenteLoggato == null) {
            response.sendRedirect("HomeController?method=get");
            return;
        }
    %>

    <!-- Navbar -->
    <nav class="my-navbar">
        <div class="logo-container">
            <img src="images/Logo.png" class="logo_immagine" alt="Logo">
        </div>
        <%
            Utente utenteLoggatoHome = (Utente) session.getAttribute("user");
        %>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <%
            if (utenteLoggatoHome != null) {
            %>
                <li><a href="areaUtente.jsp">Area utente</a></li>
                <%
                if (utenteLoggatoHome.isAmministratore()) {
                %>
                    <li><a href="AdminController?method=get">Gestione</a></li>
                <%
                }
                %>
                <li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
                <li><a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a></li>
                <li>
                    <form action="UtenteController" method="post" style="display: inline;">
                        <input type="hidden" name="tipoOperazione" value="logout">
                        <button class="register-btn">Logout</button>
                    </form>
                </li>
            <%
            } else {
            %>
                <li><a href="Register.jsp"><button class="login-btn">Accedi</button></a></li>
            <%
            }
            %>
        </ul>
    </nav>

    <!-- Sidebar -->
    <div class="sidebar">
      <a href="areaUtente.jsp">Profilo Utente</a>
      <a class="active" href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
      <a href="AutoController?tipoOperazione=autoUtente">Le tue Auto</a>
      <a href="RecensioneController?tipoOperazione=mostraRecensioni">Le tue Recensioni</a>
      <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
    </div>

    <!-- Contenuto principale -->
    <div class="content">
        <div class="container mt-4">
            <h1 class="text-center mb-4">LE TUE PRENOTAZIONI</h1>

            <!-- Card Prenotazioni Attuali -->
            <div class="card mx-auto shadow-sm mb-4" style="max-width: 1000px;">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Prenotazioni Attuali</h5>
                </div>
                <div class="card-body">
                    <% if (prenotazioniAttuali.isEmpty()) { %>
                        <p>Non hai prenotazioni attive.</p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover align-middle">
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
                                    <% 
                                    for (Noleggio noleggio : prenotazioniAttuali) { 
                                    	Auto auto = autoQuery.trovaAutoPerId(noleggio.getIdAuto());
                                    %>
                                        <tr>
                                            <td><%= noleggio.getId() %></td>
                                            <td><%= auto.getModello() %></td>
                                            <td><%= auto.getTarga() %></td>
                                            <td><%= noleggio.getData_inizio().format(formatter) %></td>
                                            <td><%= noleggio.getData_fine().format(formatter) %></td>
                                            <td>
                                                <!-- Pulsante per visualizzare i dettagli -->
                                                <form action="NoleggioController" method="GET" class="d-inline">
                                                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                                    <input type="hidden" name="tipoOperazione" value="dettagli">
                                                    <button type="submit" class="btn btn-primary btn-sm">Dettagli</button>
                                                </form>

                                                <!-- Pulsante per cancellare -->
                                                <form action="NoleggioController" method="POST" class="d-inline">
                                                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                                    <input type="hidden" name="tipoOperazione" value="elimina">
                                                    <button type="submit" class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Sei sicuro di voler cancellare questa prenotazione?')">
                                                        Cancella
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Card Storico Prenotazioni -->
            <div class="card mx-auto shadow-sm mb-4" style="max-width: 1000px;">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Storico Prenotazioni</h5>
                </div>
                <div class="card-body">
                    <% if (storicoPrenotazioni.isEmpty()) { %>
                        <p>Non hai prenotazioni passate.</p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover align-middle">
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
                                    <% 
                                    for (Noleggio noleggio : storicoPrenotazioni) { 
                                        Auto auto = autoQuery.trovaAutoPerId(noleggio.getIdAuto());
                                    %>
                                        <tr>
                                            <td><%= noleggio.getId() %></td>
                                            <td><%= auto.getModello() %></td>
                                            <td><%= auto.getTarga() %></td>
                                            <td><%= noleggio.getData_inizio().format(formatter) %></td>
                                            <td><%= noleggio.getData_fine().format(formatter) %></td>
                                            <td>
                                                <!-- Pulsante per visualizzare i dettagli -->
                                                <form action="NoleggioController" method="GET" class="d-inline">
                                                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                                    <input type="hidden" name="tipoOperazione" value="dettagli">
                                                    <button type="submit" class="btn btn-primary btn-sm">Dettagli</button>
                                                </form>

                                                <!-- Pulsante per lasciare una recensione -->
                                                <form action="RecensioneController" method="GET" class="d-inline">
                                                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                                    <input type="hidden" name="tipoOperazione" value="lasciaRecensione">
                                                    <button type="submit" class="btn btn-warning btn-sm">Recensisci</button>
                                                </form>
                                                <form action="NoleggioController" method="POST" class="d-inline">
                                                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                                    <input type="hidden" name="tipoOperazione" value="elimina">
                                                    <button type="submit" class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Sei sicuro di voler cancellare questa prenotazione?')">
                                                        Cancella
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Link di ritorno -->
           
        </div>
    </div>

    <!-- Footer (opzionale) -->
   

    <!-- Bootstrap JS (opzionale, per eventuali componenti interattivi) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>