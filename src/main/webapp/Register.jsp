<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link rel="stylesheet" href="registrazione.css">
    
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
				<form action="UtenteController" method="post"
					style="display: inline;">
					<input type="hidden" name="tipoOperazione" value="logout">
					<button class="register-btn">Logout</button>
				</form>
			</li>
			<%
			} else {
			
			}
			%>
		</ul>
	</nav>
    <br><br>
    <div class="container mt-4">
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger" role="alert" style=" font-weight: bold; text-align: center; padding: 10px; border-radius: 10px; background-color: #ffc08c; color: #df0400;">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="UtenteController" method="post">
                    <h1>Registrazione</h1>
                    <label class="label">Username</label> 
                    <input type="text" id="username" name="username" required
                        value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                    <label class="label">Nome</label>
                    <input type="text" id="nome" name="nome" required
                        value="<%= request.getAttribute("nome") != null ? request.getAttribute("nome") : "" %>">
                    <label class="label">Cognome</label>
                    <input type="text" id="cognome" name="cognome" required
                        value="<%= request.getAttribute("cognome") != null ? request.getAttribute("cognome") : "" %>">
                    <label class="label">Data di nascita</label>
                    <input type="date" id="dataNascita" name="dataNascita" required
                        value="<%= request.getAttribute("dataNascita") != null ? request.getAttribute("dataNascita") : "" %>">
                    <label class="label">CittÃ </label>
                    <input type="text" id="citta" name="citta" required
                        value="<%= request.getAttribute("citta") != null ? request.getAttribute("citta") : "" %>">
                    <label class="label">Numero di cellulare</label>
                    <input type="tel" id="telefono" name="telefono" required
                        value="<%= request.getAttribute("telefono") != null ? request.getAttribute("telefono") : "" %>">
                    <label class="label">E-mail</label>
                    <input type="email" id="email" name="email" required
                        value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    <label class="label">Password</label>
                    <input type="password" id="password" name="password" required>
                    <input type="hidden" name="tipoOperazione" value="register">
                    <button class="register_tasto" type="submit">Registrati</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <%
                    Utente utenteLoggato = (Utente) session.getAttribute("user");
                    if (utenteLoggato != null) {
                %>
                    <p class="text-center">Benvenuto, <%= utenteLoggato.getNome() %>!</p>
                    <form action="UtenteController" method="post">
                        <input type="hidden" name="tipoOperazione" value="logout">
                        <button type="submit">Logout</button>
                    </form>
                <%
                    } else {
                %>
                    <form action="UtenteController" method="post">
                        <h1>Accedi</h1>
                        <br> 
                        <label class="label">Username</label>
                        <input type="text" name="username" placeholder="Username" required>
                        <label class="label">Password</label>
                        <input type="password" name="password" placeholder="Password" required>
                        <input type="hidden" name="tipoOperazione" value="login">
                        <button type="submit">Accedi</button>
                    </form>
                <%
                    }
                %>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Bentornato!</h1>
                        <p>Per connetterti, effettua l'accesso con i tuoi dati personali</p>
                        <button class="ghost" id="signIn">Accedi</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Ciao!</h1>
                        <p>Inserisci i tuoi dati personali e inizia il viaggio con noi</p>
                        <button class="ghost" id="signUp">Registrati</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="registrazione.js"></script>
</body>
</html>
