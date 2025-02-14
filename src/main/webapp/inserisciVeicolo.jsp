<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<li><a href="inserisciVeicolo.jsp">Area Utente</a></li>
			<li><a href="login.jsp">Accedi</a></li>
			<li><a href="Register.jsp">
					<button class="register-btn">Registrati</button>
			</a></li>
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

    <nav class="navbar">
        <!-- Contenuto del navbar -->
    </nav>

    <div class="container">
        <h1>Area Utente</h1>
        <section>
            <h2>Inserisci il tuo veicolo</h2>
            <form id="carForm" action="AutoController" method="post">
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
                <input type="number" name="prezzo" step="0.01" placeholder="Prezzo" required>
                
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