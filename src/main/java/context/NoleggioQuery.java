package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import models.Auto;
import models.Noleggio;

public class NoleggioQuery {
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	
	public void inserisciNoleggio(Noleggio noleggio) {
        String query = "INSERT INTO noleggio (ID_utente, ID_auto, data_inizio, data_fine) VALUES (?, ?, ?, ?)";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, noleggio.getIdUtente());
            preparedStatement.setInt(2, noleggio.getIdAuto());
            preparedStatement.setTimestamp(3, Timestamp.valueOf(noleggio.getData_inizio()));
            preparedStatement.setTimestamp(4, Timestamp.valueOf(noleggio.getData_fine()));

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println("Inserimento completato con successo. Righe interessate: " + rowsAffected);

        } catch (SQLException e) {
            System.err.println("Errore durante l'inserimento nella tabella noleggio: " + e.getMessage());
            e.printStackTrace();
        }
    }
	
	public List<Auto> trovaAutoDisponibiliPerNoleggio(String luogo, LocalDateTime dataInizio, LocalDateTime dataFine) {
	    List<Auto> autoDisponibili = new ArrayList<>();
	    String query = 
	        "SELECT a.ID_auto, a.targa, a.modello, a.carburante, a.livello, a.numero_posti, a.cambio, a.posizione, a.citta, a.prezzo " +
	        "FROM auto AS a " +
	        "WHERE a.citta = ? " +
	        "AND a.ID_auto NOT IN (" +
	        "    SELECT n.ID_auto " +
	        "    FROM noleggio AS n " +
	        "    WHERE (? BETWEEN n.data_inizio AND n.data_fine " +
	        "           OR ? BETWEEN n.data_inizio AND n.data_fine " +
	        "           OR (n.data_inizio BETWEEN ? AND ?) " +
	        "           OR (n.data_fine BETWEEN ? AND ?))" +
	        ")";

	    try (Connection connection = DataBaseConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        // Impostiamo i parametri per il PreparedStatement
	        preparedStatement.setString(1, luogo);  // Imposta il luogo (ad esempio, "Milano")
	        preparedStatement.setTimestamp(2, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(3, Timestamp.valueOf(dataFine));
	        preparedStatement.setTimestamp(4, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(5, Timestamp.valueOf(dataFine));
	        preparedStatement.setTimestamp(6, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(7, Timestamp.valueOf(dataFine));

	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            while (resultSet.next()) {
	                // Crea un oggetto Auto per ogni riga e aggiungilo alla lista
	                Auto auto = new Auto(
	                    resultSet.getInt("ID_auto"),
	                    resultSet.getString("targa"),
	                    resultSet.getString("modello"),
	                    resultSet.getString("carburante"),
	                    resultSet.getDouble("livello"),
	                    resultSet.getInt("numero_posti"),
	                    resultSet.getString("cambio"),
	                    resultSet.getString("posizione"),
	                    resultSet.getString("citta"),
	                    resultSet.getDouble("prezzo")
	                );
	                autoDisponibili.add(auto);
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Errore SQL: " + e.getMessage());
	    }

	    return autoDisponibili;
	}

	
}
