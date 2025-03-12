# Car Sharing Portal 🚗💨

## Descrizione

Car Sharing Portal è una web app che permette agli utenti di offrire e noleggiare auto private per brevi periodi. Il sistema offre un'interfaccia intuitiva per la ricerca e la gestione dei veicoli disponibili per il noleggio.

## Funzionalità principali

- **Home Page**: Ricerca auto disponibili per noleggio, con filtri per località, modello e fascia di prezzo.
- **Area Utente**:
  - Registrazione/Login.
  - Inserimento del proprio veicolo nel sistema con dettagli (modello, prezzo, disponibilità).
  - Prenotazione di un'auto disponibile.
  - Storico dei noleggi effettuati e ricevuti.
  - Recensioni su auto e utenti.
- **Pannello di Amministrazione**:
  - Gestione utenti, veicoli e prenotazioni.

## Tecnologie utilizzate

- **Frontend**: HTML, CSS
- **Backend**: Java EE
- **Database**: MySQL/MariaDB

## Requisiti di sistema

- Java Development Kit (JDK) 11+
- Apache Tomcat v10.1 o un altro server compatibile con Java EE
- MySQL/MariaDB
- IDE consigliato: Spring Tool Suite (STS) o Eclipse con plugin Java EE

## Struttura del progetto

```
CarSharing/
│-- src/main/java/
│   │-- context/        # Contesto dell'applicazione
│   │-- controllers/    # Controller per la gestione delle richieste
│   │-- models/         # Modelli dei dati
│   │-- utils/          # Utility e helper
│-- src/main/webapp/    # File della web application
│-- build/              # File di build generati
│-- Web App Libraries/  # Librerie web necessarie
│-- Server Runtime/     # Apache Tomcat v10.1
│-- README.md
```


