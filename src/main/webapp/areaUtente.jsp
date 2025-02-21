<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Area Utente - Drive Easy</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="areaUtente.css">
<!-- Collegamento al file CSS -->
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

	
	
<!-- The sidebar -->
<div class="sidebar">
  <a class="active" href="areaUtente.jsp">Profilo Utente</a>
  <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Le tue Prenotazioni</a>
  <a href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
</div>

<!-- Page content -->
<div class="content">
   <div class="container mt-4">
        <h1 class="text-center">Dettagli Utente</h1>
        <%
            Utente utente = (Utente) session.getAttribute("user");
            if(utente != null) {
        %>
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body">
                <h5 class="card-title"><%= utente.getNome() %> <%= utente.getCognome() %></h5>
                <p class="card-text"><strong>ID:</strong> <%= utente.getId() %></p>
                <p class="card-text"><strong>Username:</strong> <%= utente.getUsername() %></p>
                <p class="card-text"><strong>Data di Nascita:</strong> <%= utente.getDataNascita() %></p>
                
                <p class="card-text"><strong>Città:</strong> <%= utente.getCitta() %></p>
                <p class="card-text"><strong>Telefono:</strong> <%= utente.getTelefono() %></p>
                <p class="card-text"><strong>Email:</strong> <%= utente.getEmail() %></p>
                <p class="card-text"><strong>Ruolo:</strong> <%= utente.isAmministratore() ? "Amministratore" : "Utente" %></p>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-warning text-center" role="alert">
            Nessun utente loggato.
        </div>
        <%
            }
        %>
        <div class="text-center mt-4">
            <a href="modificaUtente.jsp" class="btn btn-primary">modifica</a>
             <form action="UtenteController" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare il tuo account? L\'operazione è irreversibile!')">
                <input type="hidden" name="tipoOperazione" value="eliminaUtente">
                <input type="hidden" name="idUtente" value="<%= utenteLoggato.getId() %>">
                <button type="submit" class="btn btn-danger">Elimina Account</button>
            </form>
        </div>
    </div>
</div>
	

	<!-- Footer -->
	<footer>
		<p>&copy; 2025 Drive Easy - Tutti i diritti riservati</p>
	</footer>

</body>
</html>
