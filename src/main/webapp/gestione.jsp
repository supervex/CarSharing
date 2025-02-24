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
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Optional: FontAwesome per gli icone -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
  <link rel="stylesheet" href="style.css">
  <style>
button{
padding: 7px 20px;
}
</style>
</head>
<body>
  <!-- Navbar di Gestione -->
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
			%>
			<li><a href="Register.jsp"><button class="login-btn">Accedi</button></a></li>
			<%
			}
			%>
		</ul>
	</nav>
  
  <!-- Messaggi di errore/successo -->
  <div class="container mt-3">
    <% 
      String successo = (String) request.getAttribute("successo");
      if (successo != null) { 
    %>
      <div class="alert alert-danger" role="alert">
        <%= successo %>
      </div>
    <% } %>
  </div>
  
  <!-- Gestione Utenti -->
  <div class="container my-5">
    <h2 class="text-center mb-4">Gestione Utenti</h2>
    <!-- Barra di ricerca per Utenti -->
    <div class="mb-3">
      <input type="text" id="searchUtenti" class="form-control" placeholder="Cerca utente..." onkeyup="filterTable('searchUtenti','tableUtenti')">
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle" id="tableUtenti">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
            <th>Ruolo</th>
            <th>Azioni</th>
          </tr>
        </thead>
        <tbody>
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
                <form action="UtenteController" method="post" class="d-inline">
                  <input type="hidden" name="tipoOperazione" value="eliminaUtente">
                  <input type="hidden" name="idUtente" value="<%= utente.getId() %>">
                  <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Sei sicuro di voler eliminare questo utente?')">
                    Elimina
                  </button>
                </form>
                <form action="UtenteController" method="get" class="d-inline">
                  <input type="hidden" name="tipoOperazione" value="dettagli">
                  <input type="hidden" name="idUtente" value="<%= utente.getId() %>">
                  <button type="submit" class="btn btn-info btn-sm">Dettagli</button>
                </form>
              </td>
            </tr>
          <% } } else { %>
            <tr>
              <td colspan="7" class="text-center">Nessun utente registrato.</td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  
  <!-- Gestione Auto -->
  <div class="container my-5">
    <h2 class="text-center mb-4">Gestione Auto</h2>
    <!-- Barra di ricerca per Auto -->
    <div class="mb-3">
      <input type="text" id="searchAuto" class="form-control" placeholder="Cerca auto..." onkeyup="filterTable('searchAuto','tableAuto')">
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle" id="tableAuto">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Modello</th>
            <th>Targa</th>
            <th>Carburante</th>
            <th>Prezzo</th>
            <th>Azioni</th>
          </tr>
        </thead>
        <tbody>
          <% if (listaAuto != null && !listaAuto.isEmpty()) {
              for (Auto auto : listaAuto) { %>
            <tr>
              <td><%= auto.getId() %></td>
              <td><%= auto.getModello() %></td>
              <td><%= auto.getTarga() %></td>
              <td><%= auto.getCarburante() %></td>
              <td>€<%= auto.getPrezzo() %> al giorno</td>
              <td>
                <form action="AutoController" method="post" class="d-inline">
                  <input type="hidden" name="tipoOperazione" value="elimina">
                  <input type="hidden" name="id" value="<%= auto.getId() %>">
                  <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Sei sicuro di voler eliminare questa auto?')">
                    Elimina
                  </button>
                </form>
                <a href="AutoController?tipoOperazione=dettagli&id=<%= auto.getId() %>" class="btn btn-info btn-sm">
                  Dettagli
                </a>
              </td>
            </tr>
          <% } } else { %>
            <tr>
              <td colspan="6" class="text-center">Nessuna auto disponibile.</td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  
  <!-- Gestione Noleggi -->
  <div class="container my-5">
    <h2 class="text-center mb-4">Gestione Noleggi</h2>
    <!-- Barra di ricerca per Noleggi -->
    <div class="mb-3">
      <input type="text" id="searchNoleggi" class="form-control" placeholder="Cerca noleggio..." onkeyup="filterTable('searchNoleggi','tableNoleggi')">
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle" id="tableNoleggi">
        <thead class="table-dark">
          <tr>
            <th>ID Noleggio</th>
            <th>ID Utente</th>
            <th>ID Auto</th>
            <th>Data Inizio</th>
            <th>Data Fine</th>
            <th>Pagamento</th>
            <th>Azioni</th>
          </tr>
        </thead>
        <tbody>
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
                <form action="NoleggioController" method="post" class="d-inline">
                  <input type="hidden" name="tipoOperazione" value="elimina">
                  <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                  <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Sei sicuro di voler eliminare questo noleggio?')">
                    Elimina
                  </button>
                </form>
                <form action="NoleggioController" method="get" class="d-inline">
                  <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                  <input type="hidden" name="tipoOperazione" value="dettagli">
                  <button type="submit" class="btn btn-info btn-sm">Dettagli</button>
                </form>
              </td>
            </tr>
          <% } } else { %>
            <tr>
              <td colspan="7" class="text-center">Nessun noleggio presente.</td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  
  <!-- Gestione Recensioni -->
  <div class="container my-5">
    <h2 class="text-center mb-4">Gestione Recensioni</h2>
    <!-- Barra di ricerca per Recensioni -->
    <div class="mb-3">
      <input type="text" id="searchRecensioni" class="form-control" placeholder="Cerca recensione..." onkeyup="filterTable('searchRecensioni','tableRecensioni')">
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle" id="tableRecensioni">
        <thead class="table-dark">
          <tr>
            <th>ID Recensione</th>
            <th>ID Utente</th>
            <th>ID Auto</th>
            <th>Descrizione</th>
            <th>Valutazione</th>
            <th>Azioni</th>
          </tr>
        </thead>
        <tbody>
          <% if (listaRecensioni != null && !listaRecensioni.isEmpty()) {
              for (Recensione recensione : listaRecensioni) { %>
            <tr>
              <td><%= recensione.getId() %></td>
              <td><%= recensione.getIdUtente() %></td>
              <td><%= recensione.getIdAuto() %></td>
              <td><%= recensione.getDescrizione() %></td>
              <td><%= recensione.getValuatzione() %></td>
              <td>
                <form action="RecensioneController" method="post" class="d-inline">
                  <input type="hidden" name="tipoOperazione" value="eliminaRecensione">
                  <input type="hidden" name="idRecensione" value="<%= recensione.getId() %>">
                  <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Sei sicuro di voler eliminare questa recensione?')">
                    Elimina
                  </button>
                </form>
                <a href="RecensioneController?tipoOperazione=dettagli&idRecensione=<%= recensione.getId() %>" class="btn btn-info btn-sm">
                  Dettagli
                </a>
              </td>
            </tr>
          <% } } else { %>
            <tr>
              <td colspan="6" class="text-center">Nessuna recensione presente.</td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  
  <!-- Funzione JavaScript per il filtro delle tabelle -->
  <script>
    function filterTable(searchInputId, tableId) {
      var input = document.getElementById(searchInputId);
      var filter = input.value.toUpperCase();
      var table = document.getElementById(tableId);
      var tr = table.getElementsByTagName("tr");
      // Salta la prima riga (header) e filtra le righe
      for (var i = 1; i < tr.length; i++) {
        var tds = tr[i].getElementsByTagName("td");
        var found = false;
        for (var j = 0; j < tds.length; j++) {
          var cell = tds[j];
          if (cell) {
            var txtValue = cell.textContent || cell.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
              found = true;
              break;
            }
          }
        }
        tr[i].style.display = found ? "" : "none";
      }
    }
  </script>
  
  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>