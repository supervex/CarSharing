<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Profilo - Drive Easy</title>
    <link rel="stylesheet" href="style.css"> <!-- Collegamento al file CSS -->
</head>
<body>

    <% 
        Utente utenteLoggato = (Utente) session.getAttribute("user"); 
        if (utenteLoggato == null) {
            response.sendRedirect("login.jsp"); // Reindirizza se non loggato
        }
    %>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-car"></i> Drive Easy
        </div>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <li><a href="areaUtente.jsp">Area Utente</a></li>
            <li><a href="logout.jsp" class="logout-btn">Logout</a></li>
        </ul>
    </nav>

    <header>
        <h1>Modifica Profilo</h1>
    </header>

    <main>
        <section class="form-container">
            <form action="UtenteController" method="post">
                <input type="hidden" name="tipoOperazione" value="modificaUtente">
                
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= utenteLoggato.getUsername() %>" readonly>

                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= utenteLoggato.getNome() %>" required>

                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" value="<%= utenteLoggato.getCognome() %>" required>

                <label for="dataNascita">Data di Nascita:</label>
                <input type="date" id="dataNascita" name="dataNascita" value="<%= utenteLoggato.getDataNascita() %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= utenteLoggato.getEmail() %>" required>

                <label for="telefono">Telefono:</label>
                <input type="tel" id="telefono" name="telefono" value="<%= utenteLoggato.getTelefono() %>" required>

                <label for="citta">Città:</label>
                <input type="text" id="citta" name="citta" value="<%= utenteLoggato.getCitta() %>" required>

                <label for="passwordUtente">Nuova Password (opzionale):</label>
                <input type="password" id="passwordUtente" name="passwordUtente" placeholder="Lascia vuoto per non modificare">

                <button type="submit" class="btn">Salva Modifiche</button>
            </form>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Drive Easy - Tutti i diritti riservati</p>
    </footer>

</body>
</html>
