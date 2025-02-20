package context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Utente;

public class UtenteQuery {

    public boolean aggiungiUtente(Utente utente) {
        String query = "INSERT INTO utente(username, nome, cognome, dataNascita, passwordUtente, citta, telefono, email, amministratore) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, utente.getUsername());
            preparedStatement.setString(2, utente.getNome());
            preparedStatement.setString(3, utente.getCognome());
            preparedStatement.setDate(4, utente.getDataNascita());
            preparedStatement.setString(5, utente.getPasswordUtente());  // Inserisci la password in chiaro
            preparedStatement.setString(6, utente.getCitta());
            preparedStatement.setString(7, utente.getTelefono());
            preparedStatement.setString(8, utente.getEmail());
            preparedStatement.setBoolean(9, utente.isAmministratore()); 

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (aggiunta utente): " + e.getMessage());
            return false;
        }
    }

    public boolean aggiornaUtente(Utente utente) {
        String query = "UPDATE utente SET username = ?, nome = ?, cognome = ?, dataNascita = ?, citta = ?, telefono = ?, email = ?, amministratore = ?, passwordUtente = ? WHERE ID_utente = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, utente.getUsername());
            preparedStatement.setString(2, utente.getNome());
            preparedStatement.setString(3, utente.getCognome());
            preparedStatement.setDate(4, utente.getDataNascita());
            preparedStatement.setString(5, utente.getCitta());
            preparedStatement.setString(6, utente.getTelefono());
            preparedStatement.setString(7, utente.getEmail());
            preparedStatement.setBoolean(8, utente.isAmministratore());
            preparedStatement.setString(9, utente.getPasswordUtente());  // Aggiungi la password in chiaro
            preparedStatement.setInt(10, utente.getId());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Errore SQL (aggiornamento utente): " + e.getMessage());
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
        String query = "SELECT ID_utente, username, nome, cognome, dataNascita, citta, telefono, email, passwordUtente, amministratore FROM utente WHERE username = ?";
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
        String query = "SELECT ID_utente, username, nome, cognome, dataNascita, citta, telefono, email, passwordUtente, amministratore FROM utente WHERE ID_utente = ?";
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
        String query = "SELECT ID_utente, username, nome, cognome, dataNascita, citta, telefono, email, passwordUtente, amministratore FROM utente";
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
            resultSet.getString("citta"),
            resultSet.getString("telefono"),
            resultSet.getString("email"),
            resultSet.getBoolean("amministratore")
        );
    }
    
    public Utente getUtenteByEmail(String email) {
        String sql = "SELECT * FROM utente WHERE email = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Utente(
                        rs.getInt("ID_utente"),
                        rs.getString("username"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getDate("dataNascita"),
                        rs.getString("passwordUtente"),
                        rs.getString("citta"),
                        rs.getString("telefono"),
                        rs.getString("email"),
                        rs.getBoolean("amministratore")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Se non trova l'utente, ritorna null
    }

}
