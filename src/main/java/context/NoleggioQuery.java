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
        String query = "INSERT INTO noleggio (ID_utente, ID_auto, data_inizio, data_fine, pagamento) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, noleggio.getIdUtente());
            preparedStatement.setInt(2, noleggio.getIdAuto());
            preparedStatement.setTimestamp(3, Timestamp.valueOf(noleggio.getData_inizio()));
            preparedStatement.setTimestamp(4, Timestamp.valueOf(noleggio.getData_fine()));
            preparedStatement.setDouble(5, noleggio.getPagamento());

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
	        "SELECT a.ID_auto, a.targa, a.modello, a.carburante, a.livello, a.numero_posti, a.cambio, a.posizione, a.citta, a.prezzo, a.immagine " +
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
	                    resultSet.getDouble("prezzo"),
	                    resultSet.getString("immagine")  // Recupera il percorso dell'immagine
	                );
	                autoDisponibili.add(auto);
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Errore SQL: " + e.getMessage());
	    }

	    return autoDisponibili;
	}

	
	   public List<Noleggio> trovaNoleggiPerUtente(int idUtente) {
	        List<Noleggio> listaNoleggi = new ArrayList<>();
	        String query = "SELECT * FROM noleggio WHERE ID_utente = ?";

	        try (Connection connection = DataBaseConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	            preparedStatement.setInt(1, idUtente);

	            try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                while (resultSet.next()) {
	                    Noleggio noleggio = new Noleggio(
	                        resultSet.getInt("ID_noleggio"),
	                        resultSet.getInt("ID_utente"),
	                        resultSet.getInt("ID_auto"),
	                        resultSet.getTimestamp("data_inizio").toLocalDateTime(),
	                        resultSet.getTimestamp("data_fine").toLocalDateTime(),
	                        resultSet.getDouble("pagamento")
	                    );
	                    listaNoleggi.add(noleggio);
	                }
	            }
	        } catch (SQLException e) {
	            System.err.println("Errore SQL durante il recupero dei noleggi: " + e.getMessage());
	            e.printStackTrace();
	        }

	        return listaNoleggi;
	    }

	public boolean eliminaNoleggio(int idNoleggio) {
	    String sql = "DELETE FROM noleggio WHERE ID_noleggio = ?";
	    try (Connection connection = DataBaseConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {
	        stmt.setInt(1, idNoleggio);
	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public Noleggio trovaNoleggioPerId(int idNoleggio) {
        String sql = "SELECT * FROM noleggio WHERE ID_noleggio = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idNoleggio);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Noleggio(
                        rs.getInt("ID_noleggio"),
                        rs.getInt("ID_utente"),
                        rs.getInt("ID_auto"),
                        rs.getTimestamp("data_inizio").toLocalDateTime(),
                        rs.getTimestamp("data_fine").toLocalDateTime(),
                        rs.getDouble("pagamento")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public boolean verificaDisponibilitaAuto(int idAuto, LocalDateTime dataInizio, LocalDateTime dataFine) {
	    String query = 
	        "SELECT COUNT(*) FROM noleggio " +
	        "WHERE ID_auto = ? " +
	        "AND (? BETWEEN data_inizio AND data_fine " +
	        "     OR ? BETWEEN data_inizio AND data_fine " +
	        "     OR (data_inizio BETWEEN ? AND ?) " +
	        "     OR (data_fine BETWEEN ? AND ?))";

	    try (Connection connection = DataBaseConnection.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	        preparedStatement.setInt(1, idAuto);
	        preparedStatement.setTimestamp(2, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(3, Timestamp.valueOf(dataFine));
	        preparedStatement.setTimestamp(4, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(5, Timestamp.valueOf(dataFine));
	        preparedStatement.setTimestamp(6, Timestamp.valueOf(dataInizio));
	        preparedStatement.setTimestamp(7, Timestamp.valueOf(dataFine));

	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next() && resultSet.getInt(1) == 0) {
	                return true; // L'auto è disponibile
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Errore SQL: " + e.getMessage());
	    }

	    return false; // L'auto non è disponibile
	}
	
	public List<Noleggio> stampaTuttiNoleggi() {
	    List<Noleggio> listaNoleggi = new ArrayList<>();
	    String sql = "SELECT * FROM noleggio";

	    try (Connection connection = DataBaseConnection.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            Noleggio noleggio = new Noleggio(
	                rs.getInt("ID_noleggio"),
	                rs.getInt("ID_utente"),
	                rs.getInt("ID_auto"),
	                rs.getTimestamp("data_inizio").toLocalDateTime(),
	                rs.getTimestamp("data_fine").toLocalDateTime(),
	                rs.getDouble("pagamento")
	            );
	            listaNoleggi.add(noleggio);
	        }

	        // Stampa ogni noleggio in console
	        for (Noleggio n : listaNoleggi) {
	            System.out.println(n);
	        }

	    } catch (SQLException e) {
	        System.err.println("Errore durante il recupero di tutti i noleggi: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return listaNoleggi;
	}

}
