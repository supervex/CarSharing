package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import models.Auto;

public class AutoQuery {

	public void aggiungiAuto(Auto auto) {
		String query = "insert into auto(targa, modello, carburante, livello, numeroPosti, cambio, posizione, prezzo) values(?, ?, ?, ?, ?, ?, ?, ?)";
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

}
