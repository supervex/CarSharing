<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Recensione" %>
<%@ page import="models.Noleggio" %>
<%@ page import="models.Auto" %>
<%@ page import="models.Utente" %>

<%
    // Recupero gli oggetti passati dal controller
    Auto auto = (Auto) request.getAttribute("auto");
    Utente utente = (Utente) request.getAttribute("utente");

    // Recupero la prenotazione associata
    Noleggio noleggio = (Noleggio) request.getAttribute("noleggio");

    if (noleggio == null) {
        out.println("<p>La prenotazione non è stata trovata.</p>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lascia una Recensione - Drive Easy</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
    
    body { /* Definisce lo stile di base per il body della pagina */
    font-family: 'Montserrat', sans-serif; /* Imposta il font principale a Montserrat con fallback a sans-serif */
    margin: 0; /* Rimuove i margini predefiniti */
    padding: 0; /* Rimuove il padding predefinito */
    background: rgb(210 225 239);;     /* Imposta il colore di sfondo con trasparenza (45%) */
    
}
       /* Navbar personalizzata */
.my-navbar { /* Seleziona l'elemento con classe my-navbar */
    display: flex; /* Usa il flexbox per il layout */
    height: 60px; /* Imposta l'altezza a 60px */
    justify-content: space-between; /* Distribuisce lo spazio tra gli elementi in modo uniforme */
    background-color: #0c2241; /* Imposta il colore di sfondo a un blu scuro */
    padding: 5px; /* Applica un padding di 5px su tutti i lati */
    color: white; /* Imposta il colore del testo a bianco */
    align-items: center; /* Allinea verticalmente gli elementi al centro */
}

.nav-links { /* Seleziona l'elemento con classe nav-links */
    list-style: none; /* Rimuove i bullet point dalla lista */
    display: flex; /* Usa il flexbox per disporre gli elementi in riga */
    gap: 12px; /* Aggiunge uno spazio di 12px tra gli elementi */
    align-items: center; /* Allinea verticalmente gli elementi al centro */
    margin-right: 15px; /* Aggiunge un margine destro di 15px */
}

.nav-links a { /* Seleziona i link all'interno di nav-links */
    color: white; /* Imposta il colore del testo a bianco */
    text-decoration: none; /* Rimuove la sottolineatura dai link */
    font-weight: bold; /* Rende il testo in grassetto */
    margin-top: 10px;
}

/* Stile liste */
ul { /* Seleziona tutti gli elementi ul */
    list-style-type: none; /* Rimuove i bullet point dalle liste */
    padding: 0; /* Rimuove il padding predefinito */
}
button{ 
    font-weight: bold;
    display: block; 
    margin: 5px auto; 
    width: auto; 
    max-width: 250px; 
    padding: 10px 20px; 
    font-size: 16px; 
    border: none; 
    background-color: #ff5600; 
    color: white; 
    cursor: pointer; 
    border-radius: 15px; 
    transition: background 0.3s; 
    text-align: center;
}

button:hover { 
    background-color: rgb(0, 0, 0, 0.001); 
}

.logo_immagine {
    margin-top: 5px;
    width: 220px;
    height: 80px;
    background-image: url(images/Logo.png);
}
        
        .container {
            max-width: 900px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
        }
        h1, h2 {
        	color: #ff5600;
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .due {
            font-weight: bold;
            text-align: center;
            display: block;
        }
        .form-control {
            border-radius: 5px;
            width: 90%;
            margin: 0 auto;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 0.75rem;
            font-size: 1rem;
            border-radius: 5px;
            transition: background-color 0.3s;
            width: 100%;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 0.75rem;
            font-size: 1rem;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .rating-container {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 10px;
            outline: none;
        }
        .rating-container input {
            display: none;
        }
        .rating-container label {
            font-size: 1.5rem;
            cursor: pointer;
            color: #ccc;
        }
        .rating-container input:checked ~ label,
        .rating-container label:hover,
        .rating-container label:hover ~ label {
            color: #f5c518;
        }
        
        .recensione{
        justify-content: space-between;
        overflow: hidden;
        display: flex; /* Usa il flexbox per il layout */
    	align-items: center;
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

   <div class="container mt-5">
    <h1 class="text-center">Lascia una Recensione</h1>
    <div class="row d-flex align-items-center justify-content-center g-4">
        <!-- Contenitore Recensione -->
        <div class="col-md-6">
            <div class="card">
                <h2 class="text-center">La tua Recensione</h2>
                <form action="RecensioneController" method="POST">
                    <input type="hidden" name="idNoleggio" value="<%= noleggio.getId() %>">
                    <input type="hidden" name="idAuto" value="<%= auto.getId() %>">
                    <input type="hidden" name="idUtente" value="<%= utente.getId() %>">
                    <input type="hidden" name="tipoOperazione" value="inserisciRecensione">
                    <div class="mb-3">
                        <label for="descrizione" class="d-block text-center fw-bold">Descrizione Recensione:</label>
                        <textarea name="descrizione" id="descrizione" rows="4" class="form-control" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="d-block text-center fw-bold">Punteggio:</label>
                        <div class="rating-container text-center">
                            <input type="radio" id="stelle1" name="punteggio" value="1">
                            <label for="stelle1">★</label>
                            <input type="radio" id="stelle2" name="punteggio" value="2">
                            <label for="stelle2">★</label>
                            <input type="radio" id="stelle3" name="punteggio" value="3">
                            <label for="stelle3">★</label>
                            <input type="radio" id="stelle4" name="punteggio" value="4">
                            <label for="stelle4">★</label>
                            <input type="radio" id="stelle5" name="punteggio" value="5">
                            <label for="stelle5">★</label>
                      
                        </div>
                    
                    </div>
                   <button type="submit" class="d-block mx-auto">Invia Recensione</button>

                </form>
                  
            </div>
           
        </div>
        
        <!-- Contenitore Dettagli Prenotazione -->
        <div class="col-md-6">
            <div class="card text-center">
                <h2>Dettagli Prenotazione</h2>
                <p><strong>Modello Auto:</strong> <%= auto.getModello() %></p>
                <p><strong>Targa:</strong> <%= auto.getTarga() %></p>
                <p><strong>Data di Inizio:</strong> <%= noleggio.getData_inizio() %></p>
                <p><strong>Data di Fine:</strong> <%= noleggio.getData_fine() %></p>
            </div>
        </div>
    </div>
    <div class="text-center mt-3">
        <a href="javascript:history.back()" class="btn btn-secondary">Torna alla pagina precedente</a>
    </div>
</div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>