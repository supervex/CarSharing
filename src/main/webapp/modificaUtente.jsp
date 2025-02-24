<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<%
    Utente utenteLoggato = (Utente) session.getAttribute("user");
    if (utenteLoggato == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Profilo - Drive Easy</title>
    <!-- Bootstrap CDN per coerenza con il layout -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- I tuoi file CSS personalizzati -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="areaUtente.css">
    <style>
      /* Eventuali stili extra */
      button {
          padding: 7px 20px;
      }
      .card-body {
    flex: auto;
    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
    color: var(--bs-card-color);
    display: flex;
    flex-direction: column;
    width: 700px;
}
.btn-primary {
    background-color: #0d6efd;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 15px;
    cursor: pointer;
    font-size: 16px;
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
    <!-- Navbar -->
    <nav class="my-navbar">
        <div class="logo-container">
            <img src="images/Logo.png" class="logo_immagine" alt="Logo">
        </div>
        <ul class="nav-links">
            <li><a href="HomeController?method=get">Home</a></li>
            <%
                if (utenteLoggato != null) {
            %>
                <li><a href="areaUtente.jsp">Area utente</a></li>
                <%
                    if (utenteLoggato.isAmministratore()) {
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

    <!-- Contenuto principale -->
  <div class="content">
  <div class="container mt-4">
    <h1 class="text-center mb-4">MODIFICA PROFILO</h1>
    <form action="UtenteController" method="post">
      <!-- Se necessario, includi l'id dell'utente -->
      <input type="hidden" name="idUtente" value="<%= utenteLoggato.getId() %>">
      <div class="card mx-auto shadow-sm" style="max-width: 700px;">
        <div class="card-header bg-primary text-white">
          <h5 class="mb-0">Modifica Profilo</h5>
        </div>
        <div class="card-body">
          <!-- Riga: Username (readonly) -->
          <div class="mb-3 row">
            <label for="username" class="col-sm-3 col-form-label">Username:</label>
            <div class="col-sm-9">
              <input type="text" id="username" name="username" value="<%= utenteLoggato.getUsername() %>" class="form-control" readonly>
            </div>
          </div>
          <!-- Riga: Nome -->
          <div class="mb-3 row">
            <label for="nome" class="col-sm-3 col-form-label">Nome:</label>
            <div class="col-sm-9">
              <input type="text" id="nome" name="nome" value="<%= utenteLoggato.getNome() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Cognome -->
          <div class="mb-3 row">
            <label for="cognome" class="col-sm-3 col-form-label">Cognome:</label>
            <div class="col-sm-9">
              <input type="text" id="cognome" name="cognome" value="<%= utenteLoggato.getCognome() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Data di Nascita -->
          <div class="mb-3 row">
            <label for="dataNascita" class="col-sm-3 col-form-label">Data di Nascita:</label>
            <div class="col-sm-9">
              <input type="date" id="dataNascita" name="dataNascita" value="<%= utenteLoggato.getDataNascita() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Email -->
          <div class="mb-3 row">
            <label for="email" class="col-sm-3 col-form-label">Email:</label>
            <div class="col-sm-9">
              <input type="email" id="email" name="email" value="<%= utenteLoggato.getEmail() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Telefono -->
          <div class="mb-3 row">
            <label for="telefono" class="col-sm-3 col-form-label">Telefono:</label>
            <div class="col-sm-9">
              <input type="tel" id="telefono" name="telefono" value="<%= utenteLoggato.getTelefono() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Città -->
          <div class="mb-3 row">
            <label for="citta" class="col-sm-3 col-form-label">Città:</label>
            <div class="col-sm-9">
              <input type="text" id="citta" name="citta" value="<%= utenteLoggato.getCitta() %>" class="form-control" required>
            </div>
          </div>
          <!-- Riga: Nuova Password (opzionale) -->
          <div class="mb-3 row">
            <label for="passwordUtente" class="col-sm-3 col-form-label">Nuova Password:</label>
            <div class="col-sm-9">
              <input type="password" id="passwordUtente" name="passwordUtente" placeholder="Lascia vuoto per non modificare" class="form-control">
            </div>
          </div>
          <!-- Pulsanti per le operazioni -->
          <div class="text-center mt-4">
            <!-- Pulsante per aggiornare il profilo -->
            <button type="submit" name="tipoOperazione" value="modificaUtente" class="btn btn-primary">
              Salva Modifiche
            </button>
            <!-- Pulsante per eliminare l'account con conferma -->
            <button type="submit" name="tipoOperazione" value="eliminaUtente" class="btn btn-danger" style= color: 
              onclick="return confirm('Sei sicuro di voler eliminare il tuo account? L\'operazione è irreversibile!');">
              Elimina Account
            </button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>




    

    <!-- Bootstrap JS (opzionale) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
