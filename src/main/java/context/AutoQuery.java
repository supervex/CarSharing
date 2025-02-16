package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Auto;
import models.Utente;

public class AutoQuery {

	public void aggiungiAuto(Auto auto) {
		String query = "insert into auto(targa, modello, carburante, livello, numero_posti, cambio, posizione, prezzo) values(?, ?, ?, ?, ?, ?, ?, ?)";
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

			int righeModificate = preparedStatement.executeUpdate();
			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga inserita");
			}
		} catch (SQLException e) {
			System.err.println("Errore SQL: " + e.getMessage());
		}
	}

	public void modificaAuto(Auto auto) {
		String query = "update auto set targa = ?, modello = ?, carburante = ?, livello = ?, numeroPosti = ?, cambio = ?, posizione = ?, prezzo= ? where ID_auto = ?";
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
			preparedStatement.setDouble(9, auto.getId());

			int righeModificate = preparedStatement.executeUpdate();
			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga modificata");
			}

		} catch (SQLException e) {
			System.err.println("Errore SQL: " + e.getMessage());
		}

	}

	public void eliminaAuto(int id) {
		String query = "delete from auto where ID_auto = ?";
		try (Connection connection = DataBaseConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setInt(1, id);

			int righeModificate = preparedStatement.executeUpdate();

			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga eliminata");
			}

		} catch (SQLException e) {

			System.err.println("Errore SQL: " + e.getMessage());
		}
	}

	public List<Auto> stampaAuto() {
		List<Auto> autos = new ArrayList<>();
		String query = "SELECT * FROM Auto";

		try (Connection connection = DataBaseConnection.getConnection();
				Statement statement = connection.createStatement();
				ResultSet resultSet = statement.executeQuery(query)) {

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
				System.out.println("Nessuna auto trovata.");
			}

		} catch (SQLException e) {
			System.err.println("Errore SQL: " + e.getMessage());
			throw new RuntimeException("Errore nel recupero delle auto.");
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
