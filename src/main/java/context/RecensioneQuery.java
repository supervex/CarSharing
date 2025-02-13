package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class RecensioneQuery {
	
	public void inserisciRecensione(int idRecensione, int idUtente, int idAuto, String descrizione, int valutazione) {
	    String query = "INSERT INTO noleggio(ID_noleggio, ID_utente, ID_auto, data_inizio, data_fine) VALUES (?,?,?,?,?)";
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        
	        connection = DataBaseConnection.getConnection();
	        preparedStatement = connection.prepareStatement(query);

	        
	        preparedStatement.setInt(1, idRecensione);
	        preparedStatement.setInt(2, idUtente);
	        preparedStatement.setInt(3, idAuto);
	        preparedStatement.setString(4, descrizione);
	        preparedStatement.setInt(5, valutazione);
	       
	        int rowsAffected = preparedStatement.executeUpdate();
	        System.out.println("Inserimento completato con successo. Righe interessate: " + rowsAffected);

	    } catch (SQLException e) {
	        
	        System.err.println("Errore durante l'inserimento nella tabella prenotazioni_pizze: " + e.getMessage());
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
