<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<%@ page import="models.Auto" %>
<%@ page import="java.util.List" %>

<% 
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null || !utenteLoggato.isAmministratore()) {
        response.sendRedirect("HomeController?method=get"); // Reindirizza se non è admin
        return;
    }

    List<Utente> listaUtenti = (List<Utente>) session.getAttribute("listaUtenti");
    List<Auto> listaAuto = (List<Auto>) session.getAttribute("listaAuto");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione - Drive Easy</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">
        <i class="fas fa-car"></i> Drive Easy - Gestione
    </div>
    <ul class="nav-links">
        <li><a href="HomeController?method=get">Home</a></li>
        <li><a href="gestione.jsp">Gestione</a></li>
        <li>
            <form action="UtenteController" method="post" style="display:inline;">
                <input type="hidden" name="tipoOperazione" value="logout">
                <button class="register-btn">Logout</button>
            </form>
        </li>
    </ul>
</nav>

<div class="container">
    <h2 class="text-center">Gestione Utenti</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
            <th>Ruolo</th>
            <th>Azioni</th>
        </tr>
        <% if (listaUtenti != null && !listaUtenti.isEmpty()) {
            for (Utente utente : listaUtenti) { %>
        <tr>
            <td><%= utente.getId() %></td>
            <td><%= utente.getUsername() %></td>
            <td><%= utente.getNome() %></td>
            <td><%= utente.getCognome() %></td>
            <td><%= utente.getEmail() %></td>
            <td><%= utente.isAmministratore() ? "Admin" : "Utente" %></td>
            <td>
                <form action="UtenteController" method="post" style="display:inline;">
                    <input type="hidden" name="tipoOperazione" value="eliminaUtente">
                    <input type="hidden" name="idUtente" value="<%= utente.getId() %>">
                    <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questo utente?')">
                        Elimina
                    </button>
                </form>
            </td>
        </tr>
        <% } 
        } else { %>
        <tr>
            <td colspan="7" class="text-center">Nessun utente registrato.</td>
        </tr>
        <% } %>
    </table>
</div>

<div class="container">
    <h2 class="text-center">Gestione Auto</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Modello</th>
            <th>Targa</th>
            <th>Carburante</th>
            <th>Prezzo</th>
            <th>Azioni</th>
        </tr>
        <% if (listaAuto != null && !listaAuto.isEmpty()) {
            for (Auto auto : listaAuto) { %>
        <tr>
            <td><%= auto.getId() %></td>
            <td><%= auto.getModello() %></td>
            <td><%= auto.getTarga() %></td>
            <td><%= auto.getCarburante() %></td>
            <td>€<%= auto.getPrezzo() %> al giorno</td>
            <td>
                <form action="AutoController" method="post" style="display:inline;">
                    <input type="hidden" name="tipoOperazione" value="eliminaAuto">
                    <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                    <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questa auto?')">
                        Elimina
                    </button>
                </form>
            </td>
        </tr>
        <% } 
        } else { %>
        <tr>
            <td colspan="6" class="text-center">Nessuna auto disponibile.</td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>