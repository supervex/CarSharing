package context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Auto;

public class AutoQuery {

    // Aggiungere un'auto
	   public boolean aggiungiAuto(Auto auto) {
	        String query = "INSERT INTO auto (ID_utente, targa, modello, carburante, livello, numero_posti, cambio, posizione, citta, prezzo, immagine) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        try (Connection connection = DataBaseConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	            preparedStatement.setInt(1, auto.getIdUtente());
	            preparedStatement.setString(2, auto.getTarga());
	            preparedStatement.setString(3, auto.getModello());
	            preparedStatement.setString(4, auto.getCarburante());
	            preparedStatement.setDouble(5, auto.getLivello());
	            preparedStatement.setInt(6, auto.getNumeroPosti());
	            preparedStatement.setString(7, auto.getCambio());
	            preparedStatement.setString(8, auto.getPosizione());
	            preparedStatement.setString(9, auto.getCitta());
	            preparedStatement.setDouble(10, auto.getPrezzo());
	            preparedStatement.setString(11, auto.getImmagine());  // Gestisci immagine

	            int righeModificate = preparedStatement.executeUpdate();
	            return righeModificate > 0;

	        } catch (SQLException e) {
	            System.err.println("Errore SQL: " + e.getMessage());
	            return false;
	        }
	    }

	    // Modificare un'auto
	    public boolean modificaAuto(Auto auto) {
	        String query = "UPDATE auto SET targa = ?, modello = ?, carburante = ?, livello = ?, numero_posti = ?, cambio = ?, posizione = ?, citta = ?, prezzo = ?, immagine = ? WHERE ID_auto = ?";
	        try (Connection connection = DataBaseConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	            preparedStatement.setString(1, auto.getTarga());
	            preparedStatement.setString(2, auto.getModello());
	            preparedStatement.setString(3, auto.getCarburante());
	            preparedStatement.setDouble(4, auto.getLivello());
	            preparedStatement.setInt(5, auto.getNumeroPosti());
	            preparedStatement.setString(6, auto.getCambio());
	            preparedStatement.setString(7, auto.getPosizione());
	            preparedStatement.setString(8, auto.getCitta());
	            preparedStatement.setDouble(9, auto.getPrezzo());
	            preparedStatement.setString(10, auto.getImmagine());  // Gestisci immagine
	            preparedStatement.setInt(11, auto.getId());

	            int righeModificate = preparedStatement.executeUpdate();
	            return righeModificate > 0;

	        } catch (SQLException e) {
	            System.err.println("Errore SQL: " + e.getMessage());
	            return false;
	        }
	    }

	    // Metodo per creare un'istanza di Auto da un ResultSet (con immagine)
	    private Auto creaAutoDaResultSet(ResultSet resultSet) throws SQLException {
	        return new Auto(
	            resultSet.getInt("ID_auto"),
	            resultSet.getInt("ID_utente"),
	            resultSet.getString("targa"),
	            resultSet.getString("modello"),
	            resultSet.getString("carburante"),
	            resultSet.getDouble("livello"),
	            resultSet.getInt("numero_posti"),
	            resultSet.getString("cambio"),
	            resultSet.getString("posizione"),
	            resultSet.getString("citta"),
	            resultSet.getDouble("prezzo"),
	            resultSet.getString("immagine")  // Recupera immagine
	        );
	    }

	    // Recuperare tutte le auto
	    public List<Auto> stampaAuto() {
	        List<Auto> autos = new ArrayList<>();
	        String query = "SELECT * FROM auto";

	        try (Connection connection = DataBaseConnection.getConnection();
	             Statement statement = connection.createStatement();
	             ResultSet resultSet = statement.executeQuery(query)) {

	            while (resultSet.next()) {
	                autos.add(creaAutoDaResultSet(resultSet));
	            }

	        } catch (SQLException e) {
	            System.err.println("Errore SQL: " + e.getMessage());
	        }

	        return autos;
	    }

    // Recuperare auto per ID utente
    public List<Auto> trovaAutoPerUtente(int idUtente) {
        List<Auto> autos = new ArrayList<>();
        String query = "SELECT * FROM auto WHERE ID_utente = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idUtente);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    autos.add(creaAutoDaResultSet(resultSet));
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
        }

        return autos;
    }

    // Recuperare auto per username
    public List<Auto> cercaAutoByUsername(String username) {
        List<Auto> autos = new ArrayList<>();
        String query = "SELECT a.* FROM auto a JOIN utente u ON a.ID_utente = u.ID_utente WHERE u.username = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    autos.add(creaAutoDaResultSet(resultSet));
                }
            }

            if (autos.isEmpty()) {
                System.out.println("Nessuna auto trovata per l'utente: " + username);
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
            throw new RuntimeException("Errore nel recupero delle auto per l'utente.");
        }

        return autos;
    }
 // Recuperare un'auto per ID
    public Auto trovaAutoPerId(int idAuto) {
        String query = "SELECT * FROM auto WHERE ID_auto = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idAuto);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return creaAutoDaResultSet(resultSet);
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
        }

        return null; // Ritorna null se l'auto non viene trovata
    }
    public boolean eliminaAuto(int idAuto) {
        String query = "DELETE FROM auto WHERE ID_auto = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idAuto);
            int righeEliminate = preparedStatement.executeUpdate();
            return righeEliminate > 0;

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
            return false;
        }
    }
}
