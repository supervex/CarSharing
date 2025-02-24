<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Le tue Auto</title>
    
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Stili personalizzati -->
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
    justify-content: center;
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
  <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
  <a class="active" href="AutoController?tipoOperazione=autoUtente">le tue Auto</a>
  <a href="RecensioneController?tipoOperazione=mostraRecensioni">le tue Recensioni</a>
  <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
</div>
<!-- Page content -->
<!-- Contenitore principale -->
<div class="content">
  <div class="container mt-4">
    <h1 class="text-center mb-4">LE TUE AUTO</h1>
    <% List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAutoUtente"); %>
    <div class="card mx-auto shadow-sm mb-4" style="max-width: 10000px;">
      <div class="card-header bg-primary text-white">
        <h5 class="mb-0">Le Tue Auto</h5>
      </div>
      <div class="card-body">
        <% if (listaAuto != null && !listaAuto.isEmpty()) { %>
          <div class="table-responsive">
            <table class="table table-striped table-hover align-middle">
              <thead>
                <tr>
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
                  <th class="text-end pe-3" style="width: 150px;">Azioni</th>
                </tr>
              </thead>
              <tbody>
                <% for (Auto auto : listaAuto) { %>
                  <tr>
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
                    <td>€<%= auto.getPrezzo() %> al ora</td>
                    <td class="text-end pe-3">
                      <form action="AutoController" method="get" class="d-inline">
                        <input type="hidden" name="tipoOperazione" value="aggiorna">
                        <input type="hidden" name="id" value="<%= auto.getId() %>">
                        <button type="submit" class="btn btn-primary btn-sm">Modifica</button>
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
          </div>
        <% } else { %>
          <p class="text-center">Nessuna auto disponibile.</p>
        <% } %>
      </div>
    </div>
  </div>
</div>


</body>
</html>
