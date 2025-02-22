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
      <link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="areaUtente.css">
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
				<form action="UtenteController" method="post"
					style="display: inline;">
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

	
	
<!-- The sidebar -->
<div class="sidebar">
  <a href="areaUtente.jsp">Profilo Utente</a>
  <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Le tue Prenotazioni</a>
  <a href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a class="active" href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
  <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
</div>

<!-- Page content -->
<div class="content">
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
    </div>
</body>
</html>
