<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Utente - Drive Easy</title>
    <link rel="stylesheet" href="style.css"> <!-- Collegamento al file CSS -->
</head>
<body>

    <% Utente utenteLoggato = (Utente) session.getAttribute("user"); %>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-car"></i> Drive Easy
        </div>
        <ul class="nav-links">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="#assistenza">Assistenza</a></li>
            <li><a href="inserisciVeicolo.jsp">Aggiungi Auto</a></li>
            <li><a href="#impostazioni">Impostazioni</a></li>
            <li><a href="#pagamenti">Pagamenti</a></li>
            <li><a href="#prenotazioni">Prenotazioni</a></li>
            
            <% if (utenteLoggato != null) { %>
                <li class="user-info">Benvenuto, <%= utenteLoggato.getNome() %>!</li>
                <li>
                    <form action="UtenteController" method="post">
                        <input type="hidden" name="tipoOperazione" value="logout">
                        <button class="logout-btn">Logout</button>
                    </form>
                </li>
            <% } else { 
                response.sendRedirect("login.jsp"); // Redirect se non loggato
               } %>
        </ul>
    </nav>

    <header>
        <h1>Area Utente</h1>
    </header>

    <main>
        <!-- Sezione Profilo -->
        <section id="profilo" class="card">
            <h2>Profilo Utente</h2>
            <p><strong>Nome:</strong> <%= utenteLoggato.getNome() %> <%= utenteLoggato.getCognome() %></p>
            <p><strong>Email:</strong> <%= utenteLoggato.getEmail() %></p>
            <p><strong>Telefono:</strong> <%= utenteLoggato.getTelefono() %></p>
            <a href="modificaUtente.jsp" class="btn">Modifica Profilo</a>
        </section>

        <!-- Sezione Prenotazioni -->
        <section id="prenotazioni" class="card">
            <h2>Le Tue Prenotazioni</h2>
            <ul>
                <li>Tesla Model 3 - Dal 10/02/2025 al 15/02/2025</li>
                <li>BMW 3 Series - Dal 20/03/2025 al 25/03/2025</li>
            </ul>
            <button class="btn">Visualizza Tutte</button>
        </section>

        <!-- Sezione Pagamenti -->
        <section id="pagamenti" class="card">
            <h2>Fatture e Pagamenti</h2>
            <p><strong>Ultimo pagamento:</strong> 109€ per Mercedes GLC</p>
            <button class="btn">Visualizza Fatture</button>
        </section>

        <!-- Sezione Assistenza -->
        <section id="assistenza" class="card">
            <h2>Assistenza</h2>
            <p>Hai bisogno di aiuto? Contattaci!</p>
            <button class="btn">Chatta con un operatore</button>
        </section>

        <!-- Sezione Impostazioni -->
        <section id="impostazioni" class="card">
            <h2>Impostazioni</h2>
            <label><input type="checkbox"> Ricevi notifiche via email</label><br>
            <label><input type="checkbox"> Ricevi notifiche via SMS</label>
            <button class="btn">Salva Impostazioni</button>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Drive Easy - Tutti i diritti riservati</p>
    </footer>

</body>
</html>
