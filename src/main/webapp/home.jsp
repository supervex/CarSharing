<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.Utente"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Auto"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home - Drive Easy</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="style.css">

</head>
<body>
	<nav class="my-navbar">
		<div class="logo-container">
			<img src="images/logo.png" class="logo_immagine" alt="Logo">
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

	<!-- Hero Section -->
	<div class="hero">
		<%
		if (utenteLoggatoHome != null) {
		%>
		<h1 class="titolo_home">
			Benvenuto,
			<%=utenteLoggatoHome.getNome()%>!
		</h1>
		<p>Drive Easy offre un'esperienza di noleggio auto senza intoppi.
			Scegli tra la nostra ampia selezione di auto e parti per la strada
			con stile.</p>
		<%
		} else {
		%>
		<br>
		<h1 class="titolo_home">Esperienza di Noleggio Auto Premium</h1>
		<p>Drive Easy offre un'esperienza di noleggio auto senza intoppi.
			Scegli tra la nostra ampia selezione di auto e parti per la strada
			con stile.</p>
		<%
		}
		%>
		<form class="search-bar" method="get" action="NoleggioController">
			<div class="search-item">
				<input type="text" name="luogo" placeholder="🔍 Luogo di ritiro"
					class="input-field"
					value="<%=request.getAttribute("luogo") != null ? request.getAttribute("luogo") : ""%>">
			</div>

			<div class="date-time">
				<label for="data-ritiro">📅 Data di ritiro</label> <input
					type="date" name="dataRitiro" id="data-ritiro" class="input-field"
					value="<%=request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : ""%>">
			</div>

			<div class="date-time">
				<label for="ora-ritiro">🕒 Ora</label> <input type="time"
					id="ora-ritiro" name="oraRitiro" class="input-field"
					value="<%=request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : ""%>">
			</div>

			<div class="date-time">
				<label for="data-riconsegna">📅 Data di consegna</label> <input
					type="date" id="data-riconsegna" name="dataRiconsegna"
					class="input-field"
					value="<%=request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : ""%>">
			</div>

			<div class="date-time">
				<label for="ora-riconsegna">🕒 Ora</label> <input type="time"
					id="ora-riconsegna" name="oraRiconsegna" class="input-field"
					value="<%=request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : ""%>">
			</div>

			<input type="hidden" name="tipoOperazione" value="mostra">
			<button type="submit" class="btn btn-primary">Cerca</button>
		</form>
	</div>
		
		



<!-- Available Cars -->
	<section class="cars">
  <div class="container-fluid mt-4 px-0">
    <h2 class="text-center">Auto Disponibili</h2>
    
    <div id="autoCarousel" class="carousel slide w-100" data-bs-ride="carousel">
      <div class="carousel-inner">
        <%
          List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAuto");
          if (listaAuto != null && !listaAuto.isEmpty()) {
              int count = listaAuto.size();
              // Raggruppa le auto a gruppi di 3
              for (int i = 0; i < count; i += 3) {
        %>
        <div class="carousel-item <%= i == 0 ? "active" : "" %>">
          <div class="row">
            <%
              for (int j = i; j < i + 3 && j < count; j++) {
                  Auto auto = listaAuto.get(j);
            %>
            <div class="col-md-4">
              <div class="card mb-3">
                <img src="<%= auto.getImmagine() %>" class="card-img-top" alt="Immagine auto">
                <div class="card-body">
                  <h5 class="card-title"><%= auto.getModello() %></h5>
                  <p class="card-text"><strong>Targa:</strong> <%= auto.getTarga() %></p>
                  <p class="card-text"><strong>Carburante:</strong> <%= auto.getCarburante() %></p>
                  <p class="card-text"><strong>Livello carburante:</strong> <%= auto.getLivello() %>%</p>
                  <p class="card-text"><strong>Numero posti:</strong> <%= auto.getNumeroPosti() %></p>
                  <p class="card-text"><strong>Cambio:</strong> <%= auto.getCambio() %></p>
                  <p class="card-text"><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
                  <p class="card-text"><strong>Città:</strong> <%= auto.getCitta() %></p>
                  <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
                  <% if (utenteLoggatoHome != null) { %>
                    <form action="NoleggioController" method="get">
                      <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                      <input type="hidden" name="dataRitiro" value="<%= request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : "" %>">
                      <input type="hidden" name="oraRitiro" value="<%= request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : "" %>">
                      <input type="hidden" name="dataRiconsegna" value="<%= request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : "" %>">
                      <input type="hidden" name="oraRiconsegna" value="<%= request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : "" %>">
                      <input type="hidden" name="tipoOperazione" value="inserisci">
                      <button type="submit" class="btn btn-success">Prenota</button>
                    </form>
                  <% } else { %>
                    <button type="button" class="btn btn-danger" onclick="avvisaUtente()">Prenota</button>
                  <% } %>
                </div>
              </div>
            </div>
            <%
              } // Fine for gruppo di 3
            %>
          </div>
        </div>
        <%
              } // Fine for lista auto
          } else {
        %>
          <p class="text-center">Nessuna auto disponibile.</p>
        <%
          }
        %>
      </div>
      
      <button class="carousel-control-prev" type="button" data-bs-target="#autoCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#autoCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>
</section>

<script>
    function avvisaUtente() {
        alert("Devi effettuare il login per poter prenotare un'auto.");
        window.location.href = "Register.jsp";
    }
</script>

	<!-- Bootstrap JS (Popper.js incluso) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>