package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import models.Utente;



public class UtenteQuery {

	
	public void aggiungiUtente(Utente utente) {
		String query = "insert into utente(username, nome, cognome, dataNascita, passwordUtente, città, telefono, email) values(?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection connection = DataBaseConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, utente.getUsername());
			preparedStatement.setString(2, utente.getNome());
			preparedStatement.setString(3, utente.getCognome());
			preparedStatement.setDate(4, utente.getDataNascita());
			preparedStatement.setString(5, utente.getPasswordUtente());
			preparedStatement.setString(6, utente.getCitta());
			preparedStatement.setString(7, utente.getTelefono());
			preparedStatement.setString(8, utente.getEmail());

			int righeModificate = preparedStatement.executeUpdate();
			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga inserita");
			}
		} catch (SQLException e) {
			System.err.println("Errore SQL: " + e.getMessage());
		}
	}
	
	public void modificaUtente(Utente utente) {
		String query = "update utente set username = ?, nome = ?, cognome = ?, dataNascita = ?, passwordUtente = ?, città = ?, telefono = ?, email = ? where ID_utente = ?";
		try (Connection connection = DataBaseConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, utente.getUsername());
			preparedStatement.setString(2, utente.getNome());
			preparedStatement.setString(3, utente.getCognome());
			preparedStatement.setDate(4, utente.getDataNascita());
			preparedStatement.setString(5, utente.getPasswordUtente());
			preparedStatement.setString(6, utente.getCitta());
			preparedStatement.setString(7, utente.getTelefono());
			preparedStatement.setString(8, utente.getEmail());
			preparedStatement.setInt(9, utente.getId());

			int righeModificate = preparedStatement.executeUpdate();
			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga modificata");
			}

		} catch (SQLException e) {
			System.err.println("Errore SQL: " + e.getMessage());
		}

	}
	
	public void eliminaUtente(int id) {
		String query = "delete from utente where ID_utente = ?";
		try (Connection connection = DataBaseConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setInt(1, id);

			int righeModificate = preparedStatement.executeUpdate();

			if (righeModificate == 0) {
				System.out.println("Operazione non riuscita, nessuna riga modificata");
			}

		} catch (SQLException e) {

			System.err.println("Errore SQL: " + e.getMessage());
		}
	}
	 public boolean getUtenteByUsername(String username) {
	      
	        String query = "SELECT * FROM utente WHERE username = ?";

	        try (Connection connection = DataBaseConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

	            preparedStatement.setString(1, username);
	            try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                if (resultSet.next()) {
	                   return false;
	                } else {
	                   return true;
	                }
	            }
	        } catch (SQLException e) {
	            System.err.println("Errore SQL: " + e.getMessage());
	            throw new RuntimeException("Errore");
	        }
	      
	    }
}
