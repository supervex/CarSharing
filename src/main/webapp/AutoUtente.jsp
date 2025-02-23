<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ciao</title>
    
    <link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="areaUtente.css">
<style>
button{
padding: 7px 20px;
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
  <a class="active" href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
  <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
</div>
<!-- Page content -->
<div class="content">
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
                    <img src="imageController?name=<%=auto.getImmagine() %>" class="card-img-top" alt="Immagine auto">
                    <div class="card-body">
                        <h5 class="card-title"><%= auto.getModello() %></h5>
                        <p class="card-text"><strong>Targa:</strong> <%= auto.getTarga() %></p>
                        <p class="card-text"><strong>Carburante:</strong> <%= auto.getCarburante() %></p>
                        <p class="card-text"><strong>Livello carburante:</strong> <%= auto.getLivello() %>%</p>
                        <p class="card-text"><strong>Numero posti:</strong> <%= auto.getNumeroPosti() %></p>
                        <p class="card-text"><strong>Cambio:</strong> <%= auto.getCambio() %></p>
                        <p class="card-text"><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
                        <p class="card-text"><strong>Citta:</strong> <%= auto.getCitta() %></p>
                        <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
                        
                        <!-- Bottone Modifica -->
                        <a href="AutoController?tipoOperazione=aggiorna&id=<%= auto.getId() %>" class="btn btn-primary">Modifica</a>

                      <form action="AutoController" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questa auto?');">
    <input type="hidden" name="tipoOperazione" value="elimina">
    <input type="hidden" name="id" value="<%= auto.getId() %>">
    <button type="submit" class="btn btn-danger">Elimina</button>
</form>

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
    
    </div>
</body>
</html>
