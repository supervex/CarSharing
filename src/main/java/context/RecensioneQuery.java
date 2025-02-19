package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import models.Recensione;


public class RecensioneQuery {
	
	public void inserisciRecensione(Recensione recensione) {
	    String query = "INSERT INTO recensione (ID_utente, ID_auto, descrizione, valutazione) VALUES (?,?,?,?)";
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        // Connessione al database
	        connection = DataBaseConnection.getConnection();
	        preparedStatement = connection.prepareStatement(query);

	        // Impostazione dei parametri per la query
	        preparedStatement.setInt(1, recensione.getIdUtente()); // ID dell'utente
	        preparedStatement.setInt(2, recensione.getIdAuto()); // ID dell'auto
	        preparedStatement.setString(3, recensione.getDescrizione()); // Descrizione della recensione
	        preparedStatement.setInt(4, recensione.getValuatzione()); // Valutazione (1-5)

	        // Esecuzione della query
	        int rowsAffected = preparedStatement.executeUpdate();
	        System.out.println("Inserimento completato con successo. Righe interessate: " + rowsAffected);

	    } catch (SQLException e) {
	        System.err.println("Errore durante l'inserimento nella tabella recensione: " + e.getMessage());
	        e.printStackTrace();

	    } finally {
	        
	        try {
	            if (preparedStatement != null) {
	                preparedStatement.close();
	            }
	            if (connection != null) {
	                connection.close();
	            }
	        } catch (SQLException e) {
	            System.err.println("Errore durante la chiusura delle risorse: " + e.getMessage());
	        }
	    }
	}

}	



