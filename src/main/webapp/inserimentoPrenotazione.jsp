<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente" %>
<%@ page import="models.Recensione" %>
<%@ page import="java.util.List" %>
<%@ page import="context.UtenteQuery" %>
<%
    Auto auto = (Auto) request.getAttribute("auto");
    String dataRitiro = (String) request.getAttribute("dataRitiro");
    String oraRitiro = (String) request.getAttribute("oraRitiro");
    String dataRiconsegna = (String) request.getAttribute("dataRiconsegna");
    String oraRiconsegna = (String) request.getAttribute("oraRiconsegna");
    List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inserimento Prenotazione - Drive Easy</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Eventuale CSS personalizzato -->
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <!-- Navbar di esempio -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
      <a class="navbar-brand" href="#">Drive Easy</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
              aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="HomeController?method=get">Home</a></li>
          <!-- Altri link se necessari -->
        </ul>
      </div>
    </div>
  </nav>

  <div class="container mt-4">
    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("errorMessage") %>
      </div>
    <% } %>

    <!-- Prima riga: Dettagli Auto (sinistra) e Form Prenotazione con date (destra) -->
    <div class="row">
      <!-- Colonna sinistra: Dettagli Auto -->
      <div class="col-md-6 mb-4">
        <div class="card">
          <img src="placeholder.jpg" class="card-img-top" alt="Immagine Auto">
          <div class="card-body">
            <h2 class="card-title">Dettagli Auto</h2>
            <p class="card-text"><strong>ID:</strong> <%= auto.getId() %></p>
            <p class="card-text"><strong>Modello:</strong> <%= auto.getModello() %></p>
            <p class="card-text"><strong>Targa:</strong> <%= auto.getTarga() %></p>
            <p class="card-text"><strong>Carburante:</strong> <%= auto.getCarburante() %></p>
            <p class="card-text"><strong>Livello Carburante:</strong> <%= auto.getLivello() %>%</p>
            <p class="card-text"><strong>Numero Posti:</strong> <%= auto.getNumeroPosti() %></p>
            <p class="card-text"><strong>Cambio:</strong> <%= auto.getCambio() %></p>
            <p class="card-text"><strong>Posizione:</strong> <%= auto.getPosizione() %></p>
            <p class="card-text"><strong>Città:</strong> <%= auto.getCitta() %></p>
            <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno</p>
          </div>
        </div>
      </div>
      <!-- Colonna destra: Form Prenotazione (date) -->
      		<%
		String errorMessage = (String) request.getAttribute("errorMessage");
		%>
			<%
		if (errorMessage != null) {
		%>
			<p class="error"><%=errorMessage%></p>
			<%
		}
		%>
      <div class="col-md-6 mb-4">
        <div class="card p-4">
          <h2 class="mb-3">Inserisci le Date</h2>
          <form method="get" action="NoleggioController">
            <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
            <div class="mb-3">
              <label for="data-ritiro" class="form-label">📅 Data di ritiro</label>
              <input type="date" name="dataRitiro" id="data-ritiro" class="form-control" 
                     value="<%= dataRitiro != null ? dataRitiro : "" %>">
            </div>
            <div class="mb-3">
              <label for="ora-ritiro" class="form-label">🕒 Ora di ritiro</label>
              <input type="time" name="oraRitiro" id="ora-ritiro" class="form-control" 
                     value="<%= oraRitiro != null ? oraRitiro : "" %>">
            </div>
            <div class="mb-3">
              <label for="data-riconsegna" class="form-label">📅 Data di riconsegna</label>
              <input type="date" name="dataRiconsegna" id="data-riconsegna" class="form-control" 
                     value="<%= dataRiconsegna != null ? dataRiconsegna : "" %>">
            </div>
            <div class="mb-3">
              <label for="ora-riconsegna" class="form-label">🕒 Ora di riconsegna</label>
              <input type="time" name="oraRiconsegna" id="ora-riconsegna" class="form-control" 
                     value="<%= oraRiconsegna != null ? oraRiconsegna : "" %>">
            </div>
            <input type="hidden" name="tipoOperazione" value="preparaPagamento">
            <button type="submit" class="btn btn-primary w-100">Vai al pagamento</button>
          </form>
        </div>
      </div>
    </div>

    <!-- Seconda riga: Recensioni centrate -->
    <div class="row">
      <div class="col-md-8 mx-auto">
        <h3 class="text-center mb-3">Recensioni</h3>
        <%
          UtenteQuery utenteQuery = new UtenteQuery();
          if (recensioni != null && !recensioni.isEmpty()) {
              double somma = 0;
              int count = 0;
              for (Recensione recensione : recensioni) {
                  Utente utente = utenteQuery.getUtenteById(recensione.getIdUtente());
        %>
                  <div class="card mb-3">
                    <div class="card-body">
                      <h5 class="card-title">Utente: <%= utente.getNome() + " " + utente.getCognome() %></h5>
                      <p class="card-text">Valutazione: <%= recensione.getValuatzione() %>/5</p>
                      <p class="card-text"><%= recensione.getDescrizione() %></p>
                    </div>
                  </div>
        <%
                  somma += recensione.getValuatzione();
                  count++;
              }
              double media = somma / count;
              String mediaFormatted = String.format("%.1f", media);
        %>
              <div class="alert alert-info text-center">
                <strong>Valutazione media:</strong> <%= mediaFormatted %>/5
              </div>
        <%
          } else {
        %>
              <div class="alert alert-secondary text-center">
                Non ci sono ancora recensioni per questa auto.
              </div>
        <%
          }
        %>
      </div>
    </div>
  </div>
  
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
