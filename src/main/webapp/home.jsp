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
<link rel="stylesheet" href="style.css">
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
			<li><a href="home.jsp">Home</a></li>
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

	<!-- Hero Section -->
	<div class="hero">
		<%
		if (utenteLoggatoHome != null) {
		%>
		<h2 class="text-center">
			Benvenuto,
			<%=utenteLoggatoHome.getNome()%>!
		</h2>
		<%
		} else {
		%>
		<h1>Esperienza di Noleggio Auto Premium</h1>
		<p>Drive Easy offre un'esperienza di noleggio auto senza intoppi.
			Scegli tra la nostra ampia selezione di auto e parti per la strada
			con stile.</p>
		<%
		}
		%>
	</div>


<form class="search-bar" method="get" action="NoleggioController">
    <div class="search-item">
        <input type="text" name="luogo" placeholder="🔍 Luogo di ritiro" class="input-field" 
               value="<%= request.getAttribute("luogo") != null ? request.getAttribute("luogo") : "" %>">
    </div>
    
    <div class="date-time">
        <label for="data-ritiro">📅 Data di ritiro</label>
        <input type="date" name="dataRitiro" id="data-ritiro" class="input-field" 
               value="<%= request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : "" %>">
    </div>
    
    <div class="date-time">
        <label for="ora-ritiro">🕒 Ora</label>
        <input type="time" id="ora-ritiro" name="oraRitiro" class="input-field" 
               value="<%= request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : "" %>">
    </div>
    
    <div class="date-time">
        <label for="data-riconsegna">📅 Data di riconsegna</label>
        <input type="date" id="data-riconsegna" name="dataRiconsegna" class="input-field" 
               value="<%= request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : "" %>">
    </div>
    
    <div class="date-time">
        <label for="ora-riconsegna">🕒 Ora</label>
        <input type="time" id="ora-riconsegna" name="oraRiconsegna" class="input-field" 
               value="<%= request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : "" %>">
    </div>
    
    <input type="hidden" name="tipoOperazione" value="mostra">
    <button type="submit" class="btn btn-primary">Cerca</button>
</form>





	<!-- Available Cars -->
	<section class="cars">
		<div class="container mt-4">
			<h2 class="text-center">Auto Disponibili</h2>
			<div class="row">
				<%
				List<Auto> listaAuto = (List<Auto>) session.getAttribute("listaAuto");
				if (listaAuto != null && !listaAuto.isEmpty()) {
					for (Auto auto : listaAuto) {
				%>
				<div class="col-md-4">
					<div class="card mb-3">
						<img src="img/auto_default.jpg" class="card-img-top"
							alt="Immagine auto">
						<div class="card-body">
							<h5 class="card-title"><%=auto.getModello()%></h5>
							<p class="card-text">
								<strong>Targa:</strong>
								<%=auto.getTarga()%></p>
							<p class="card-text">
								<strong>Carburante:</strong>
								<%=auto.getCarburante()%></p>
							<p class="card-text">
								<strong>Livello carburante:</strong>
								<%=auto.getLivello()%>%
							</p>
							<p class="card-text">
								<strong>Numero posti:</strong>
								<%=auto.getNumeroPosti()%></p>
							<p class="card-text">
								<strong>Cambio:</strong>
								<%=auto.getCambio()%></p>
							<p class="card-text">
								<strong>Posizione:</strong>
								<%=auto.getPosizione()%></p>
								<p class="card-text">
								<strong>città:</strong>
								<%=auto.getCitta()%></p>
							<p class="card-text">
								<strong>Prezzo:</strong> €<%=auto.getPrezzo()%>
								al giorno
							</p>
							<form action="NoleggioController" method="get">
                            <input type="hidden" name="idAuto" value="<%=auto.getId()%>">
                                <input type="hidden" name="dataRitiro" value="<%= request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : "" %>">
                               <input type="hidden" name="oraRitiro" value="<%= request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : "" %>">
                              <input type="hidden" name="dataRiconsegna" value="<%= request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : "" %>">
                             <input type="hidden" name="oraRiconsegna" value="<%= request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : "" %>">     
                             <input type="hidden" name="tipoOperazione" value="inserisci">                       
                            <button type="submit" class="btn btn-success">Prenota</button>
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
	</section>

</body>
</html>
