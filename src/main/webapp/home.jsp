<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.Utente"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Auto"%>
<%@ page import= "context.RecensioneQuery" %>
<%@ page import="models.Recensione" %>
<%@ page import="utils.Utility" %>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home - Drive Easy</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="style.css">
<style>
button{
padding: 7px 20px;
}

section {
    background: rgb(240, 240, 240);
    padding: 20px;
    margin: 20px auto;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    max-width: 1150px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    }
@media (min-width: 992px) {
    .col-lg-5 {
        flex: 0 0 auto;
        width: 350px;
    }
}

@media (min-width: 992px) {
    .col-lg-7 {
        flex: 0 0 auto;
        width: 65%;
    }
}
h2 {
    color: #0c2241;
    margin-top: 20px;
}

</style>

</head>
<body>
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

	<!-- Hero Section -->
	<div class="hero">
		<%
		if (utenteLoggatoHome != null) {
		%>
		<h1 class="titolo_home">
			Benvenuto,
			<%=utenteLoggatoHome.getNome()%>!
		</h1>
		<p>Drive Easy offre un'esperienza di noleggio auto senza intoppi.
			Scegli tra la nostra ampia selezione di auto e parti per la strada
			con stile.</p>
		<%
		} else {
		%>
		<br>
		<h1 class="titolo_home">Esperienza di Noleggio Auto Premium</h1>
		<p>Drive Easy offre un'esperienza di noleggio auto senza intoppi.
			Scegli tra la nostra ampia selezione di auto e parti per la strada
			con stile.</p>
		<%
		}
		%>
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
		<form class="search-bar" method="get" action="NoleggioController">
			<div class="search-item">
				<input type="text" name="luogo" placeholder="🔍 Luogo di ritiro"
					class="input-field"
					value="<%=request.getAttribute("luogo") != null ? request.getAttribute("luogo") : ""%>">
			</div>

			<div class="date-time">
				<label for="data-ritiro">📅 Data di ritiro</label> <input
					type="date" name="dataRitiro" id="data-ritiro" class="input-field"
					value="<%=request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : ""%>">
			</div>

			<div class="date-time">
				<label for="ora-ritiro">🕒 Ora</label> <input type="time"
					id="ora-ritiro" name="oraRitiro" class="input-field"
					value="<%=request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : ""%>">
			</div>

			<div class="date-time">
				<label for="data-riconsegna">📅 Data di consegna</label> <input
					type="date" id="data-riconsegna" name="dataRiconsegna"
					class="input-field"
					value="<%=request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : ""%>">
			</div>

			<div class="date-time">
				<label for="ora-riconsegna">🕒 Ora</label> <input type="time"
					id="ora-riconsegna" name="oraRiconsegna" class="input-field"
					value="<%=request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : ""%>">
			</div>

			<input type="hidden" name="tipoOperazione" value="mostra">
			<button type="submit" class="btn btn-primary">Cerca</button>
		</form>
	</div>
		

<!-- Available Cars -->
	<section class="cars carousel-section">
  <div class="carousel-container mt-4">
    <h2 class="text-center">AUTO DISPONIBILI</h2>
    <div id="autoCarousel" class="carousel slide w-100" data-bs-ride="carousel">
      <div class="carousel-inner">
        <%
          List<Auto> listaAuto = (List<Auto>) request.getAttribute("listaAuto");
          if (listaAuto != null && !listaAuto.isEmpty()) {
              int count = listaAuto.size();
              // Raggruppa le auto a gruppi di 3
              for (int i = 0; i < count; i += 3) {
        %>
        <div class="carousel-item <%= i == 0 ? "active" : "" %>">
          <div class="row">
            <%
              for (int j = i; j < i + 3 && j < count; j++) {
                  Auto auto = listaAuto.get(j);
            %>
            <div class="col-md-4">
              <div class="card mb-3">
                <img src="imageController?name=<%=auto.getImmagine() %>" class="card-img-top" alt="Immagine auto">
                <div class="card-body">
                  <h5 class="card-title"><%= auto.getModello() %></h5>
                  
                  
                  
                  
                  <p class="card-text"><strong>Città:</strong> <%= auto.getCitta() + ", " +  auto.getPosizione() %> </p>
                  
                  <p class="card-text"><strong>Prezzo:</strong> €<%= auto.getPrezzo() %> al ora</p>
                  <%  
                  RecensioneQuery recensioneQuery = new RecensioneQuery();
                  List<Recensione> recensioni = recensioneQuery.getAllRecensioniPerAuto(auto.getId());
                  double somma = 0;
                  double c = 0;
                  for(Recensione recensione : recensioni){
                	somma = somma + recensione.getValuatzione();
                	c ++;
                  }
                  double media = somma /c;
                  String mediaFormatted = String.format("%.1f", media);
                  %>
                  <p class="card-text"><strong>Valutazione media:</strong> <%= mediaFormatted %> ⭐</p>
                  <% if (utenteLoggatoHome != null) { %>
    <form action="NoleggioController" method="get" class="prenota-form text-center">
        <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
        <input type="hidden" name="dataRitiro" value="<%= request.getAttribute("dataRitiro") != null ? request.getAttribute("dataRitiro") : "" %>">
        <input type="hidden" name="oraRitiro" value="<%= request.getAttribute("oraRitiro") != null ? request.getAttribute("oraRitiro") : "" %>">
        <input type="hidden" name="dataRiconsegna" value="<%= request.getAttribute("dataRiconsegna") != null ? request.getAttribute("dataRiconsegna") : "" %>">
        <input type="hidden" name="oraRiconsegna" value="<%= request.getAttribute("oraRiconsegna") != null ? request.getAttribute("oraRiconsegna") : "" %>">
        <input type="hidden" name="tipoOperazione" value="inserisci">
        <button type="submit" class="btn d-block mx-auto franco">Prenota</button>
    </form>
<% } else { %>
    <div class="text-center">
        <button type="button" class="franco" onclick="avvisaUtente()">Prenota</button>
    </div>
<% } %>

                </div>
              </div>
            </div>
            <%
              } // Fine for gruppo di 3
            %>
          </div>
        </div>
        <%
              } // Fine for lista auto
          } else {
        %>
          <p class="text-center">Nessuna auto disponibile.</p>
        <%
          }
        %>
      </div>
      
      <button class="carousel-control-prev" type="button" data-bs-target="#autoCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#autoCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
  </div>
</section>

<div style="padding-top: 80px;padding-bottom: 80px;background: linear-gradient(to bottom, #d2e1ef, #efe5a2, #fcc262);position:relative;color:#fff;&quot;>&quot;;">
<!-- Sezione About Us - Template Style -->
<!-- Sezione Informativa - Noleggio Auto -->
<section id="de_info_noleggio" style="padding-top:80px;padding-bottom:80px;background: linear-gradient(to bottom, #6bb2f4, #fdea66, #ffb335);position:relative;color:#fff;">
  <div id="de_container" style="position:relative; z-index:1; max-width:1150px; margin:0 auto;">
    <div id="de_row" style="display:flex; flex-wrap:wrap;">
      <!-- Colonna Sinistra: Descrizione e confronto prezzi -->
      <div id="de_col_left" style="flex:0 0 58%; max-width:58%; text-align:left;">
        <h2 style="font-weight:600; margin-bottom:20px;">Perché scegliere Drive Easy?</h2>
        <p style="font-size:1.125rem; line-height:1.6; margin-bottom:1rem;">Sicurezza e Affidabilità</p>
        <p style="font-size:1.125rem; line-height:1.6; margin-bottom:1rem;">
          La sicurezza è la nostra priorità. Ogni utente che utilizza la piattaforma è verificato attraverso un sistema di controllo avanzato per garantire un’esperienza affidabile.
          Inoltre, ogni auto disponibile su Drive Easy è assicurata, così puoi viaggiare senza pensieri.
        </p>
        <p style="font-size:1.125rem; line-height:1.6; margin-bottom:1rem;">Privacy Garantita</p>
        <p style="font-size:1.125rem; line-height:1.6; margin-bottom:1rem;">
          Proteggiamo i tuoi dati con tecnologie di crittografia avanzate, assicurandoci che tutte le informazioni personali e di pagamento siano sempre al sicuro.
          La nostra piattaforma rispetta le normative sulla privacy per offrirti un’esperienza protetta e senza rischi.
        </p>
      </div>
      <!-- Colonna Destra: Prenotazione e link ai migliori paesi -->
      <div id="de_col_right" style="flex:0 0 42%; max-width:42%; padding-left:20px;">
        <div id="de_card" style="background:#fff; color:#333; padding:30px; border-radius:15px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
          <h2 style="font-size:1.75rem; font-weight:600; color:#ff5600; margin-bottom:1rem;">Prenota con pochi CLICK</h2>
          <p style="font-size:1rem; line-height:1.5; margin-bottom:1rem;">
            Dopo aver confrontato le tariffe e trovato l’offerta migliore, prenota facilmente la tua auto compilando il modulo online in pochi minuti.
            Il nostro processo è semplice, veloce e sicuro, così puoi organizzare il tuo viaggio senza stress.
          </p>
          <p style="font-size:1rem; line-height:1.5;">
            Trova l'auto perfetta per ogni occasione, che si tratti di un breve soggiorno, di un viaggio di lavoro o di una lunga vacanza.
            Scegli tra una vasta gamma di veicoli, dalle city car alle auto di lusso, e parti con la massima comodità e tranquillità!
          </p>
        </div>
      </div>
    </div>
  </div>
  <!-- Overlay per aumentare il contrasto del testo -->
  <div style="position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.3); z-index:0;"></div>
</section>


</div>

<footer>
		Drive Easy | Via Italia, 24 - Roma ITALIA | C.F. ABC534845745 | P.Iva 854345764 <br>
		<a class="trans-color-text" href="#">DriveEasy@info.com</a> | <span itemprop="telephone"><a href="#">+39 347 58 30 387</a></span>
		  <br><a target="_blank" href="#"> privacy</a> | <a target="_blank" href="#"> cookie policy</a>

		<div class="social-cont">        
		<ul class="social-list">

		<li><a target="_blank" href="#"><img src="images/facebook-icon.png"  title="facebook" alt="Facebook icon"></a></li>
		<li><a target="_blank" href="#"><img src="images/instagram-icon.png" title="Instagram" alt="Instagram icon"></a></li>
		<li><a target="_blank" href="#"><img src="images/tiktok-icon.png" title="pinterest" alt="Instagram icon"></a></li>

		</ul>
    	<div class="floatstop"></div>
		</div><!--/fine social cont-->

        Designed by<br>
       <div class="credits">
       <a target="_blank" href="#"><img width="100" src="images/Logo.png" title="#" alt="#"></a>  
    	</div>
    	<br>
        <p>Copyright © 2025 DriveEasy, Srl.</p>
	</footer>
	
<script>
    function avvisaUtente() {
        alert("Devi effettuare il login per poter prenotare un'auto.");
        window.location.href = "Register.jsp";
    }
</script>

	<!-- Bootstrap JS (Popper.js incluso) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>