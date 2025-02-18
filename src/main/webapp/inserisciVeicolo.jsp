<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Area Utente - Drive Easy</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<nav class="navbar">
		<div class="logo">
			<i class="fas fa-car"></i> Drive Easy
		</div>
		<ul class="nav-links">
			<li><a href="home.jsp">Home</a></li>
			<% Utente utenteLoggatoHome = (Utente) session.getAttribute("user");
               if (utenteLoggatoHome != null) { %>
            <li><a href="areaUtente.jsp">Area Utente</a></li>
            <li>
                <form action="UtenteController" method="post" style="display:inline;">
                    <input type="hidden" name="tipoOperazione" value="logout">
                    <button class="register-btn">Logout</button>
                </form>
            </li>
        <% } else { %>
            <li><a href="login.jsp">Accedi</a></li>
            <li><a href="Register.jsp"><button class="register-btn">Registrati</button></a></li>
        <% } %>
		</ul>
	</nav>

    <!-- Verifica se c'è un errore e lo mostra all'utente -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div class="error-message">
            <%= errorMessage %>
        </div>
    <%
        }
    %>

    <div class="container">
        <h1>Area Utente</h1>
        <section>
            <h2>Inserisci il tuo veicolo</h2>
            <form id="carForm" action="AutoController" method="post" enctype="multipart/form-data">
                <!-- Controllo se l'utente è loggato -->
                <%
                    if (utenteLoggatoHome != null) {
                %>
                    <!-- Se l'utente è loggato, passo l'idUtente -->
                    <input type="hidden" name="utente" value="<%= utenteLoggatoHome.getId() %>">
                <%
                    } else {
                %>
                    <!-- Se non è loggato, non passo idUtente -->
                    <input type="hidden" name="utente" value="">
                <%
                    }
                %>
                <input type="hidden" name="tipoOperazione" value="inserisci">
                <input type="text" name="targa" placeholder="Targa" required>
                <input type="text" name="modello" placeholder="Modello" required>
                <input type="text" name="carburante" placeholder="Carburante" required>
                <input type="number" name="livello" placeholder="Livello" step="0.1" required>
                <input type="number" name="numeroPosti" placeholder="Numero posti" required>
                <select id="cambio" name="cambio" required>
                    <option value="" disabled selected>Cambio</option>
                    <option value="manuale">Manuale</option>
                    <option value="automatico">Automatico</option>
                </select>
                <input type="text" name="posizione" placeholder="Indirizzo" required>
                <input type="text" name="citta" placeholder="Città" required>
                <input type="number" name="prezzo" step="0.01" placeholder="Prezzo" required>
                
                <!-- Aggiunta del campo per caricare l'immagine -->
                <input type="file" name="immagine" accept="image/*" required>
                
                
                <button type="submit">Invia</button>
            </form>
        </section>
    </div>		

	<section>
		<h2>Prenota un'auto</h2>
		<button class="register-btn">Prenota Ora</button>
	</section>

	<section>
		<h2>Storico Noleggi</h2>
		<p>Visualizza i tuoi noleggi effettuati e ricevuti.</p>
	</section>

	<section>
		<h2>Recensioni</h2>
		<textarea placeholder="Lascia una recensione"></textarea>
		<button class="register-btn">Invia Recensione</button>
	</section>

</body>
</html>
