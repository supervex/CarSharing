package context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Auto;

public class AutoQuery {

    // Aggiungere un'auto
    public boolean aggiungiAuto(Auto auto) {
        String query = "INSERT INTO auto (ID_utente, targa, modello, carburante, livello, numero_posti, cambio, posizione, prezzo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            preparedStatement.setDouble(9, auto.getPrezzo());

            int righeModificate = preparedStatement.executeUpdate();
            return righeModificate > 0;

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
            return false;
        }
    }

    // Modificare un'auto
    public boolean modificaAuto(Auto auto) {
        String query = "UPDATE auto SET targa = ?, modello = ?, carburante = ?, livello = ?, numero_posti = ?, cambio = ?, posizione = ?, prezzo = ? WHERE ID_auto = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, auto.getTarga());
            preparedStatement.setString(2, auto.getModello());
            preparedStatement.setString(3, auto.getCarburante());
            preparedStatement.setDouble(4, auto.getLivello());
            preparedStatement.setInt(5, auto.getNumeroPosti());
            preparedStatement.setString(6, auto.getCambio());
            preparedStatement.setString(7, auto.getPosizione());
            preparedStatement.setDouble(8, auto.getPrezzo());
            preparedStatement.setInt(9, auto.getId());

            int righeModificate = preparedStatement.executeUpdate();
            return righeModificate > 0;

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
            return false;
        }
    }

    // Eliminare un'auto
    public boolean eliminaAuto(int id) {
        String query = "DELETE FROM auto WHERE ID_auto = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);

            int righeModificate = preparedStatement.executeUpdate();
            return righeModificate > 0;

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
            return false;
        }
    }

    // Recuperare tutte le auto
    public List<Auto> stampaAuto() {
        List<Auto> autos = new ArrayList<>();
        String query = "SELECT * FROM auto";

        try (Connection connection = DataBaseConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("ID_auto");
                int idUtente = resultSet.getInt("ID_utente");
                String targa = resultSet.getString("targa");
                String modello = resultSet.getString("modello");
                String carburante = resultSet.getString("carburante");
                double livello = resultSet.getDouble("livello");
                int numeroPosti = resultSet.getInt("numero_posti");
                String cambio = resultSet.getString("cambio");
                String posizione = resultSet.getString("posizione");
                double prezzo = resultSet.getDouble("prezzo");

                Auto auto = new Auto(id, idUtente, targa, modello, carburante, livello, numeroPosti, cambio, posizione, prezzo);
                autos.add(auto);
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
        }

        return autos;
    }

    // Recuperare un'auto per ID
    public Auto trovaAutoPerId(int id) {
        String query = "SELECT * FROM auto WHERE ID_auto = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int idAuto = resultSet.getInt("ID_auto");
                    int idUtente = resultSet.getInt("ID_utente");
                    String targa = resultSet.getString("targa");
                    String modello = resultSet.getString("modello");
                    String carburante = resultSet.getString("carburante");
                    double livello = resultSet.getDouble("livello");
                    int numeroPosti = resultSet.getInt("numero_posti");
                    String cambio = resultSet.getString("cambio");
                    String posizione = resultSet.getString("posizione");
                    double prezzo = resultSet.getDouble("prezzo");

                    return new Auto(idAuto, idUtente, targa, modello, carburante, livello, numeroPosti, cambio, posizione, prezzo);
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
        }

        return null;  // Auto non trovata
    }

    // Recuperare tutte le auto di un utente
    public List<Auto> trovaAutoPerUtente(int idUtente) {
        List<Auto> autos = new ArrayList<>();
        String query = "SELECT * FROM auto WHERE ID_utente = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, idUtente);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int id = resultSet.getInt("ID_auto");
                    String targa = resultSet.getString("targa");
                    String modello = resultSet.getString("modello");
                    String carburante = resultSet.getString("carburante");
                    double livello = resultSet.getDouble("livello");
                    int numeroPosti = resultSet.getInt("numero_posti");
                    String cambio = resultSet.getString("cambio");
                    String posizione = resultSet.getString("posizione");
                    double prezzo = resultSet.getDouble("prezzo");

                    Auto auto = new Auto(id, idUtente, targa, modello, carburante, livello, numeroPosti, cambio, posizione, prezzo);
                    autos.add(auto);
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore SQL: " + e.getMessage());
        }

        return autos;
    }
    
    public List<Auto> cercaAutoByUsername(String username) {
		String query = "SELECT a.* FROM auto a JOIN utente u ON a.ID_utente = u.ID_utente WHERE u.username = ?";
		List<Auto> autos = new ArrayList<>();

		try (Connection connection = DataBaseConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, username);
			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				int id = resultSet.getInt("ID_auto");
				String targa = resultSet.getString("targa");
				String modello = resultSet.getString("modello");
				String carburante = resultSet.getString("carburante");
				double livello = resultSet.getDouble("livello");
				int numeroPosti = resultSet.getInt("numero_posti");
				String cambio = resultSet.getString("cambio");
				String posizione = resultSet.getString("posizione");
				double prezzo = resultSet.getDouble("prezzo");

				Auto auto = new Auto(id, targa, modello, carburante, livello, numeroPosti, cambio, posizione, prezzo);
				autos.add(auto);
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
}