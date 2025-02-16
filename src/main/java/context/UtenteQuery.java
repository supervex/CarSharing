package context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Utente;

public class UtenteQuery {

    public boolean aggiungiUtente(Utente utente) {
        String query = "INSERT INTO utente(username, nome, cognome, dataNascita, passwordUtente, città, telefono, email) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
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

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (aggiunta utente): " + e.getMessage());
            return false;
        }
    }

    public boolean aggiornaUtente(Utente utente) {
        String query = "UPDATE utente SET nome = ?, cognome = ?, dataNascita = ?, città = ?, telefono = ?, email = ? WHERE ID_utente = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, utente.getNome());
            preparedStatement.setString(2, utente.getCognome());
            preparedStatement.setDate(3, utente.getDataNascita());
            preparedStatement.setString(4, utente.getCitta());
            preparedStatement.setString(5, utente.getTelefono());
            preparedStatement.setString(6, utente.getEmail());
            preparedStatement.setInt(7, utente.getId());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (aggiornamento utente): " + e.getMessage());
            return false;
        }
    }

    public boolean modificaUtente(Utente utente) {
        String query = "UPDATE utente SET username = ?, nome = ?, cognome = ?, dataNascita = ?, passwordUtente = ?, città = ?, telefono = ?, email = ? WHERE ID_utente = ?";
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

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (modifica utente): " + e.getMessage());
            return false;
        }
    }

    public boolean eliminaUtente(int id) {
        String query = "DELETE FROM utente WHERE ID_utente = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (eliminazione utente): " + e.getMessage());
            return false;
        }
    }

    public Utente getUtenteByUsername(String username) {
        String query = "SELECT * FROM utente WHERE username = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return creaUtenteDaResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            System.err.println("Errore SQL (getUtenteByUsername): " + e.getMessage());
        }
        return null;
    }

    public Utente getUtenteById(int id) {
        String query = "SELECT * FROM utente WHERE ID_utente = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return creaUtenteDaResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            System.err.println("Errore SQL (getUtenteById): " + e.getMessage());
        }
        return null;
    }

    public List<Utente> getAllUtenti() {
        String query = "SELECT * FROM utente";
        List<Utente> utenti = new ArrayList<>();
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                utenti.add(creaUtenteDaResultSet(resultSet));
            }
        } catch (SQLException e) {
            System.err.println("Errore SQL (getAllUtenti): " + e.getMessage());
        }
        return utenti;
    }

    private Utente creaUtenteDaResultSet(ResultSet resultSet) throws SQLException {
        return new Utente(
            resultSet.getInt("ID_utente"),
            resultSet.getString("username"),
            resultSet.getString("nome"),
            resultSet.getString("cognome"),
            resultSet.getDate("dataNascita"),
            resultSet.getString("passwordUtente"),
            resultSet.getString("città"),
            resultSet.getString("telefono"),
            resultSet.getString("email")
        );
    }
}
