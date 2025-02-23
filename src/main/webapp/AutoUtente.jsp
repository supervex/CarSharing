<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ciao</title>
    
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Stili personalizzati -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
    <style>
.btn-orange {
    background-color: #FFA500; /* Arancione */
    border-color: #FFA500;
}

.btn-orange:hover {
    background-color: #ff8c00; /* Un arancione più scuro per l'hover */
    border-color: #ff8c00;
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
<!-- Contenitore principale -->
<div class="content">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Le Tue Auto</h2>

        <% List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAutoUtente"); %>
        
        <% if (listaAuto != null && !listaAuto.isEmpty()) { %>
            <table class="table table-striped table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Immagine</th>
                        <th>Modello</th>
                        <th>Targa</th>
                        <th>Carburante</th>
                        <th>Livello Carburante</th>
                        <th>Numero Posti</th>
                        <th>Cambio</th>
                        <th>Posizione</th>
                        <th>Città</th>
                        <th>Prezzo</th>
                        <th class="text-end pe-3" style="width: 150px;">Azioni</th> <!-- Larghezza fissa per uniformità -->
                    </tr>
                </thead>
                <tbody>
                    <% for (Auto auto : listaAuto) { %>
                        <tr>
                            <td><%= auto.getId() %></td>
                            <td>
                                <img src="imageController?name=<%= auto.getImmagine() %>" alt="Auto" style="width: 100px; height: auto;">
                            </td>
                            <td><%= auto.getModello() %></td>
                            <td><%= auto.getTarga() %></td>
                            <td><%= auto.getCarburante() %></td>
                            <td><%= auto.getLivello() %>%</td>
                            <td><%= auto.getNumeroPosti() %></td>
                            <td><%= auto.getCambio() %></td>
                            <td><%= auto.getPosizione() %></td>
                            <td><%= auto.getCitta() %></td>
                            <td>€<%= auto.getPrezzo() %> al giorno</td>
                            <td class="text-end pe-3">
    <form action="AutoController" method="get" class="d-inline">
        <input type="hidden" name="tipoOperazione" value="aggiorna">
        <input type="hidden" name="id" value="<%= auto.getId() %>">
        <button type="submit" class="btn btn-orange btn-sm">Modifica</button>

    </form>
    <form action="AutoController" method="post" class="d-inline" onsubmit="return confirm('Sei sicuro di voler eliminare questa auto?');">
        <input type="hidden" name="tipoOperazione" value="elimina">
        <input type="hidden" name="id" value="<%= auto.getId() %>">
        <button type="submit" class="btn btn-danger btn-sm">Elimina</button>
    </form>
</td>

                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p class="text-center">Nessuna auto disponibile.</p>
        <% } %>
    </div>
</div>

</body>
</html>
