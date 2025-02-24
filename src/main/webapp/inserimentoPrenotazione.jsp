<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Auto"%>
<%@ page import="models.Utente"%>
<%@ page import="models.Recensione"%>
<%@ page import="java.util.List"%>
<%@ page import="context.UtenteQuery"%>
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
    <!-- CSS personalizzato aggiunto -->
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .card-text {
            margin-bottom: 0.5rem;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card img {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        
        .alert {
            border-radius: 10px;
        }
        .alert-info {
            background-color: #e7f3fe;
            color: #31708f;
        }
        .alert-danger {
            background-color: #f2dede;
            color: #a94442;
        }
        .alert-secondary {
            background-color: #f7f7f9;
            color: #464a4c;
        }
        h2, h3 {
            text-align: center;
        }
        
button{
padding: 7px 20px;
}
</style>
    
</head>
<body>
    <!-- Navbar di esempio -->
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

    <div class="container mt-4">
        <%
            if (request.getAttribute("errorMessage") != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <%
            }
        %>

        <!-- Prima riga: Dettagli Auto e Form Prenotazione -->
        <div class="row">
            <!-- Colonna sinistra: Dettagli Auto -->
            <div class="col-md-6 mb-4">
                <div class="card text-center">
                    <img src="imageController?name=<%= auto.getImmagine() %>" class="card-img-top" alt="Immagine Auto">
                    <div class="card-body">
                        <h2 class="card-title">Dettagli Auto</h2>
                        <%
                            int utenteID = auto.getIdUtente();
                            UtenteQuery utenteQuery1 = new UtenteQuery();
                            Utente utente1 = utenteQuery1.getUtenteById(utenteID);
                        %>
                        <p class="card-text">
                            <strong>Proprietario:</strong> <%= utente1.getNome() + " " + utente1.getCognome() %>
                        </p>
                        <p class="card-text">
                            <strong>Modello:</strong> <%= auto.getModello() %>
                        </p>
                        <p class="card-text">
                            <strong>Targa:</strong> <%= auto.getTarga() %>
                        </p>
                        <p class="card-text">
                            <strong>Carburante:</strong> <%= auto.getCarburante() %>
                        </p>
                        <p class="card-text">
                            <strong>Livello Carburante:</strong> <%= auto.getLivello() %>%
                        </p>
                        <p class="card-text">
                            <strong>Numero Posti:</strong> <%= auto.getNumeroPosti() %>
                        </p>
                        <p class="card-text">
                            <strong>Cambio:</strong> <%= auto.getCambio() %>
                        </p>
                        <p class="card-text">
                            <strong>Posizione:</strong> <%= auto.getPosizione() %>
                        </p>
                        <p class="card-text">
                            <strong>Città:</strong> <%= auto.getCitta() %>
                        </p>
                        <p class="card-text">
                            <strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al giorno
                        </p>
                    </div>
                </div>
            </div>
            <!-- Colonna destra: Form Prenotazione -->
            <div class="col-md-6 mb-4 d-flex justify-content-center">
                <div class="card p-4" style="width: 100%; max-width: 500px;">
                    <h2 class="text-center mb-3">Inserisci le Date</h2>
                    <form method="get" action="NoleggioController" class="mx-auto" style="max-width: 300px;">
                        <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                        <div class="mb-3">
                            <label for="data-ritiro" class="form-label">📅 Data di ritiro</label>
                            <input type="date" name="dataRitiro" id="data-ritiro" class="form-control" value="<%= (dataRitiro != null) ? dataRitiro : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="ora-ritiro" class="form-label">🕒 Ora di ritiro</label>
                            <input type="time" name="oraRitiro" id="ora-ritiro" class="form-control" value="<%= (oraRitiro != null) ? oraRitiro : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="data-riconsegna" class="form-label">📅 Data di riconsegna</label>
                            <input type="date" name="dataRiconsegna" id="data-riconsegna" class="form-control" value="<%= (dataRiconsegna != null) ? dataRiconsegna : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="ora-riconsegna" class="form-label">🕒 Ora di riconsegna</label>
                            <input type="time" name="oraRiconsegna" id="ora-riconsegna" class="form-control" value="<%= (oraRiconsegna != null) ? oraRiconsegna : "" %>">
                        </div>
                        <input type="hidden" name="tipoOperazione" value="preparaPagamento">
                        <button type="submit" class="btn btn-primary w-100">Vai al pagamento</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- End Prima riga -->

        <!-- Seconda riga: Recensioni -->
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
                    <div class="card-body text-center">
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
        <!-- End Seconda riga -->
    </div>
    <!-- End Container -->

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>