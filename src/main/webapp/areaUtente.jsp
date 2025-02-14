<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Utente - Drive Easy</title>
    <link rel="stylesheet" href="style.css"> <!-- Assicurati di avere un file CSS per lo stile -->
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-car"></i> Drive Easy
        </div>
        <ul class="nav-links">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="#assistenza">Assistenza</a></li>
            <li><a href="inserisciVeicolo.jsp">Aggiungi auto</a></li>
            <li><a href="#impostazioni">Impostazioni</a></li>
            <li><a href="#pagamenti">Pagamenti</a></li>
            <li><a href="#prenotazioni">Prenotazioni</a></li>
        </ul>
    </nav>
    <header>
        <h1>Area Utente</h1>
    </header>
    <main>
        <section id="profilo">
            <h2>Profilo Utente</h2>
            <p>Nome: Mario Rossi</p>
            <p>Email: mario.rossi@email.com</p>
            <p>Telefono: +39 123 456 7890</p>
            <button>Modifica Profilo</button>
        </section>
        
        <section id="prenotazioni">
            <h2>Le Tue Prenotazioni</h2>
            <ul>
                <li>Tesla Model 3 - Dal 10/02/2025 al 15/02/2025</li>
                <li>BMW 3 Series - Dal 20/03/2025 al 25/03/2025</li>
            </ul>
            <button>Visualizza Tutte</button>
        </section>
        
        <section id="pagamenti">
            <h2>Fatture e Pagamenti</h2>
            <p>Ultimo pagamento: 109€ per Mercedes GLC</p>
            <button>Visualizza Fatture</button>
        </section>
        
        <section id="assistenza">
            <h2>Assistenza</h2>
            <p>Hai bisogno di aiuto? Contattaci!</p>
            <button>Chatta con un operatore</button>
        </section>
    
            <section id="impostazioni">
                <h2>Impostazioni</h2>
                <label><input type="checkbox"> Ricevi notifiche via email</label><br>
                <label><input type="checkbox"> Ricevi notifiche via SMS</label>
                <button>Salva Impostazioni</button>
            </section>
    </main>
    <footer>
        <p>&copy; 2025 Drive Easy - Tutti i diritti riservati</p>
    </footer>
</body>
</html>
