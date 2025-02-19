<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Auto Disponibili</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar">
		<div class="logo">
			<i class="fas fa-car"></i> Drive Easy
		</div>
		<%
		Utente utenteLoggatoHome = (Utente) session.getAttribute("user");
		%>
		<ul class="nav-links">
			<li><a href="HomeController?method=get">Home</a></li>
			<%
			if (utenteLoggatoHome != null) {
			%>
			<li><a href="areaUtente.jsp">Area Utente</a></li>
			<%
			if (utenteLoggatoHome.isAmministratore()) {
			%>
			<li><a href="gestione.jsp">Gestione</a></li>
			<%
			}
			%>
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
			<li><a href="login.jsp">Accedi</a></li>
			<li><a href="Register.jsp"><button class="register-btn">Registrati</button></a></li>
			<%
			}
			%>
		</ul>
	</nav>
    <div class="container mt-4">
        <h2 class="text-center">Auto Disponibili</h2>
        <div class="row">
            <%
                List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAuto");
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
                        <p class="card-text"><strong>citta:</strong> <%= auto.getCitta() %></p>
                        <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
                        <a href="prenotaAuto?id=<%= auto.getId() %>" class="btn btn-primary">Prenota</a>
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
