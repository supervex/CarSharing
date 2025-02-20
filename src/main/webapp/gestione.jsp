<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Recensione" %>
<%@ page import="java.util.List" %>
<%
    // Controllo se l'utente loggato è amministratore
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null || !utenteLoggato.isAmministratore()) {
        response.sendRedirect("HomeController?method=get");
        return;
    }
    
    // Recupera le liste impostate dal servlet
    List<Utente> listaUtenti = (List<Utente>) request.getAttribute("listaUtenti");
    List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAuto");
    List<Noleggio> listaNoleggi = (List<Noleggio>) request.getAttribute("listaNoleggi");
    List<Recensione> listaRecensioni = (List<Recensione>) request.getAttribute("listaRecensioni");
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
    <!-- Navbar di Gestione -->
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
    <% 
            // Verifica se esiste un messaggio di errore
            String successo = (String) request.getAttribute("successo");
            if (successo != null) { 
        %>
            <div class="alert alert-danger" role="alert">
                <%= successo %>
            </div>
        <% } %>
        
    <!-- Gestione Utenti -->
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
                        <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questo utente?')">Elimina</button>
                    </form>
                    <a href="UtenteController?tipoOperazione=dettagli&idUtente=<%= utente.getId() %>">
                        <button type="button">Dettagli</button>
                    </a>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="7" class="text-center">Nessun utente registrato.</td>
            </tr>
            <% } %>
        </table>
    </div>
    
    <!-- Gestione Auto -->
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
                        <input type="hidden" name="tipoOperazione" value="elimina">
                        <input type="hidden" name="id" value="<%= auto.getId() %>">
                        <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questa auto?')">Elimina</button>
                    </form>
                    <a href="AutoController?tipoOperazione=dettagli&idAuto=<%= auto.getId() %>">
                        <button type="button">Dettagli</button>
                    </a>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="6" class="text-center">Nessuna auto disponibile.</td>
            </tr>
            <% } %>
        </table>
    </div>
    
    <!-- Gestione Noleggi -->
    <div class="container">
        <h2 class="text-center">Gestione Noleggi</h2>
        <table border="1">
            <tr>
                <th>ID Noleggio</th>
                <th>ID Utente</th>
                <th>ID Auto</th>
                <th>Data Inizio</th>
                <th>Data Fine</th>
                <th>Pagamento</th>
                <th>Azioni</th>
            </tr>
            <% if (listaNoleggi != null && !listaNoleggi.isEmpty()) {
                for (Noleggio noleggio : listaNoleggi) { %>
            <tr>
                <td><%= noleggio.getId() %></td>
                <td><%= noleggio.getIdUtente() %></td>
                <td><%= noleggio.getIdAuto() %></td>
                <td><%= noleggio.getData_inizio() %></td>
                <td><%= noleggio.getData_fine() %></td>
                <td>€<%= noleggio.getPagamento() %></td>
                <td>
                    <form action="NoleggioController" method="post" style="display:inline;">
                        <input type="hidden" name="tipoOperazione" value="elimina">
                        <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                        <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questo noleggio?')">Elimina</button>
                    </form>
                     <form action="NoleggioController" method="GET" style="display:inline;">
                                <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                                <input type="hidden" name="tipoOperazione" value="dettagli">
                                <button type="submit">Dettagli</button>
                            </form>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="7" class="text-center">Nessun noleggio presente.</td>
            </tr>
            <% } %>
        </table>
    </div>
    
    <!-- Gestione Recensioni -->
    <div class="container">
        <h2 class="text-center">Gestione Recensioni</h2>
        <table border="1">
            <tr>
                <th>ID Recensione</th>
                <th>ID Utente</th>
                <th>ID Auto</th>
                <th>Descrizione</th>
                <th>Valutazione</th>
                <th>Azioni</th>
            </tr>
            <% if (listaRecensioni != null && !listaRecensioni.isEmpty()) {
                for (Recensione recensione : listaRecensioni) { %>
            <tr>
                <td><%= recensione.getId() %></td>
                <td><%= recensione.getIdUtente() %></td>
                <td><%= recensione.getIdAuto() %></td>
                <td><%= recensione.getDescrizione() %></td>
                <td><%= recensione.getValuatzione() %></td>
                <td>
                    <form action="RecensioneController" method="post" style="display:inline;">
                        <input type="hidden" name="tipoOperazione" value="eliminaRecensione">
                        <input type="hidden" name="idRecensione" value="<%= recensione.getId() %>">
                        <button type="submit" onclick="return confirm('Sei sicuro di voler eliminare questa recensione?')">Elimina</button>
                    </form>
                    <a href="RecensioneController?tipoOperazione=dettagli&idRecensione=<%= recensione.getId() %>">
                        <button type="button">Dettagli</button>
                    </a>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="6" class="text-center">Nessuna recensione presente.</td>
            </tr>
            <% } %>
        </table>
    </div>
    
</body>
</html>
