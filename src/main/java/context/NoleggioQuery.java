package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class NoleggioQuery {
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY-MM-DD HH:mm:ss");
	
	public void inserisciNoleggio(int idNoleggio, int idUtente, int idAuto, LocalDateTime data_inizio, LocalDateTime data_fine) {
	    String query = "INSERT INTO noleggio(ID_noleggio, ID_utente, ID_auto, data_inizio, data_fine) VALUES (?,?,?,?,?)";
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        
	        connection = DataBaseConnection.getConnection();
	        preparedStatement = connection.prepareStatement(query);

	        
	        preparedStatement.setInt(1, idNoleggio);
	        preparedStatement.setInt(2, idUtente);
	        preparedStatement.setInt(3, idAuto);
	        preparedStatement.setTimestamp(4, Timestamp.valueOf(data_inizio));
	        preparedStatement.setTimestamp(5, Timestamp.valueOf(data_fine));
	       
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
