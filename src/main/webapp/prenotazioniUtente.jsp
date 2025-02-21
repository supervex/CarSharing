<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Auto" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.ArrayList" %>
<<<<<<< HEAD
<%@ page import="models.Recensione" %>
<%@ page import="models.Utente" %>
=======
<%@ page import="models.Utente"%>
>>>>>>> main

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
    <link rel="stylesheet" href="style.css">

   <style>
   .bookings-table{
   align-items: row;
   }
   </style>
</head>
<body>
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
                    <li>
                        <form action="UtenteController" method="post" style="display:inline;">
                            <input type="hidden" name="tipoOperazione" value="logout">
                            <button class="register-btn">Logout</button>
                        </form>
                    </li>
            <%
                } else {
            %>
                    <li>
                        <a href="Register.jsp">
                            <button class="login-btn">Accedi</button>
                        </a>
                    </li>
            <%
                }
            %>
        </ul>
    </nav>
    
    <main class="container">
      
            <h1>Le tue Prenotazioni</h1>
      
        
        <!-- Sezione Prenotazioni Attuali -->
        <section class="current-bookings">
            <h2>Prenotazioni Attuali</h2>
            <% if (prenotazioniAttuali.isEmpty()) { %>
                <p>Non hai prenotazioni attive.</p>
            <% } else { %>
                <table class="bookings-table">
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
                                    <form action="NoleggioController" method="GET" style="display:inline;">
                                        <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                        <input type="hidden" name="tipoOperazione" value="dettagli">
                                        <button type="submit" class="details-btn">Dettagli</button>
                                    </form>
                                    <form action="NoleggioController" method="POST" style="display:inline;">
                                        <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                        <input type="hidden" name="tipoOperazione" value="elimina">
                                        <button type="submit" class="delete-btn" onclick="return confirm('Sei sicuro di voler cancellare questa prenotazione?')">Cancella</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>
        
        <!-- Sezione Storico Prenotazioni -->
        <section class="past-bookings">
            <h2>Storico Prenotazioni</h2>
            <% if (storicoPrenotazioni.isEmpty()) { %>
                <p>Non hai prenotazioni passate.</p>
            <% } else { %>
                <table class="bookings-table">
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
                                    <form action="NoleggioController" method="GET" style="display:inline;">
                                        <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                        <input type="hidden" name="tipoOperazione" value="dettagli">
                                        <button type="submit" class="details-btn">Dettagli</button>
                                    </form>
                                    <form action="RecensioneController" method="GET" style="display:inline;">
                                        <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                        <input type="hidden" name="tipoOperazione" value="lasciaRecensione">
                                        <button type="submit" class="review-btn">Lascia una recensione</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>
        
         <div class="text-center mt-3">
        <a href="javascript:history.back()" class="btn btn-secondary">Torna alla pagina precedente</a>
    </div>
    </main>

<link rel="stylesheet" href="areaUtente.css">
</head>
<body>	<%
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
		<ul class="nav-links">
			<li><a href="HomeController?method=get">Home</a></li>
			<li><a href="#assistenza">Assistenza</a></li>
			<li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
			<li><a href="#impostazioni">Impostazioni</a></li>
			<li><a href="#pagamenti">Pagamenti</a></li>
			<li><a href="#prenotazioni">Prenotazioni</a></li>

			<li class="user-info">Benvenuto, <%=utenteLoggato.getNome()%>!
			</li>
			<li>
				<form action="UtenteController" method="post">
					<input type="hidden" name="tipoOperazione" value="logout">
					<button class="logout-btn">Logout</button>
				</form>
			</li>
		</ul>
	</nav>
	
<div class="sidebar">
  <a href="areaUtente.jsp">Profilo Utente</a>
  <a class="active" href="NoleggioController?tipoOperazione=prenotazioniUtente">Le tue Prenotazioni</a>
  <a href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
</div>	
	<div class="content">
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

    <a href="HomeController?method=get">Torna alla Home</a>
    </div>

</body>
</html>
