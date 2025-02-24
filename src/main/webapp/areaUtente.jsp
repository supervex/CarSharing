<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Utente"%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Area Utente - Drive Easy</title>
  <!-- Collegamento a Bootstrap (CDN) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- I tuoi file CSS personalizzati -->
  <link rel="stylesheet" href="areaUtente.css">
  <link rel="stylesheet" href="style.css">
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
        <form action="UtenteController" method="post" style="display: inline;">
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

  <!-- Sidebar -->
  <div class="sidebar">
    <a class="active" href="areaUtente.jsp">Profilo Utente</a>
    <a href="NoleggioController?tipoOperazione=prenotazioniUtente">Prenotazioni</a>
    <a href="AutoController?tipoOperazione=autoUtente">Le tue Auto</a>
    <a href="RecensioneController?tipoOperazione=mostraRecensioni">Le tue Recensioni</a>
    <a href="inserisciVeicolo.jsp">Aggiungi Auto</a>
  </div>

  <!-- Contenuto della pagina -->
  <div class="content">
  <div class="container mt-4">
    <h1 class="text-center mb-4">Dettagli Utente</h1>
    <%
      Utente utente = (Utente) session.getAttribute("user");
      if (utente != null) {
    %>
    <form action="UtenteController" method="post" class="user-details-form">
      <input type="hidden" name="idUtente" value="<%= utente.getId() %>">
      <div class="card mx-auto shadow-sm" style="max-width: 700px;">
        <div class="card-header bg-primary text-white">
          <h5 class="mb-0">Profilo Utente</h5>
        </div>
        <div class="card-body">
          <!-- Riga: Nome -->
          <div class="mb-3 row">
            <label for="nome" class="col-sm-3 col-form-label">Nome:</label>
            <div class="col-sm-9">
              <input type="text" id="nome" name="nome" value="<%= utente.getNome() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Cognome -->
          <div class="mb-3 row">
            <label for="cognome" class="col-sm-3 col-form-label">Cognome:</label>
            <div class="col-sm-9">
              <input type="text" id="cognome" name="cognome" value="<%= utente.getCognome() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Username -->
          <div class="mb-3 row">
            <label for="username" class="col-sm-3 col-form-label">Username:</label>
            <div class="col-sm-9">
              <input type="text" id="username" name="username" value="<%= utente.getUsername() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Data di Nascita -->
          <div class="mb-3 row">
            <label for="dataNascita" class="col-sm-3 col-form-label">Data di Nascita:</label>
            <div class="col-sm-9">
              <input type="date" id="dataNascita" name="dataNascita" value="<%= utente.getDataNascita() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Città -->
          <div class="mb-3 row">
            <label for="citta" class="col-sm-3 col-form-label">Città:</label>
            <div class="col-sm-9">
              <input type="text" id="citta" name="citta" value="<%= utente.getCitta() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Telefono -->
          <div class="mb-3 row">
            <label for="telefono" class="col-sm-3 col-form-label">Telefono:</label>
            <div class="col-sm-9">
              <input type="text" id="telefono" name="telefono" value="<%= utente.getTelefono() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Email -->
          <div class="mb-3 row">
            <label for="email" class="col-sm-3 col-form-label">Email:</label>
            <div class="col-sm-9">
              <input type="email" id="email" name="email" value="<%= utente.getEmail() %>" class="form-control-plaintext" readonly>
            </div>
          </div>
          <!-- Riga: Ruolo -->
          <div class="mb-3 row">
            <label class="col-sm-3 col-form-label">Ruolo:</label>
            <div class="col-sm-9 pt-2">
              <strong><%= utente.isAmministratore() ? "Amministratore" : "Utente" %></strong>
            </div>
          </div>
        </div>
        <!-- Footer della Card con i pulsanti -->
        
          <!-- Pulsante per Modifica: utilizza "formaction" per reindirizzare alla pagina di modifica -->
          <button type="submit" formaction="modificaUtente.jsp" class="btn btn-primary">
            Modifica
          </button>
          <!-- Pulsante per Eliminare: invia al controller con tipoOperazione "eliminaUtente" -->
          <button type="submit" name="tipoOperazione" value="eliminaUtente" class="btn btn-danger"
            onclick="return confirm('Sei sicuro di voler eliminare il tuo account? L\'operazione è irreversibile!');">
            Elimina Account
          </button>
        
      </div>
    </form>
    <%
      } else {
    %>
    <div class="alert alert-warning text-center" role="alert">
      Nessun utente loggato.
    </div>
    <%
      }
    %>
  </div>
</div>




  <!-- Bootstrap JS (opzionale, per eventuali interazioni) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
