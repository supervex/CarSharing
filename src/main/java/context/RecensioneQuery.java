package context;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Recensione;


public class RecensioneQuery {
	
	public void inserisciRecensione(Recensione recensione) {
	    String query = "INSERT INTO recensione (ID_utente, ID_auto, descrizione, valutazione) VALUES (?,?,?,?)";
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        // Connessione al database
	        connection = DataBaseConnection.getConnection();
	        preparedStatement = connection.prepareStatement(query);

	        // Impostazione dei parametri per la query
	        preparedStatement.setInt(1, recensione.getIdUtente()); // ID dell'utente
	        preparedStatement.setInt(2, recensione.getIdAuto()); // ID dell'auto
	        preparedStatement.setString(3, recensione.getDescrizione()); // Descrizione della recensione
	        preparedStatement.setInt(4, recensione.getValuatzione()); // Valutazione (1-5)

	        // Esecuzione della query
	        int rowsAffected = preparedStatement.executeUpdate();
	        System.out.println("Inserimento completato con successo. Righe interessate: " + rowsAffected);

	    } catch (SQLException e) {
	        System.err.println("Errore durante l'inserimento nella tabella recensione: " + e.getMessage());
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
	public List<Recensione> stampaTutteRecensioni() {
        List<Recensione> listaRecensioni = new ArrayList<>();
        String sql = "SELECT * FROM recensione";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Assumiamo che la tabella contenga una colonna ID_recensione come chiave primaria
                Recensione recensione = new Recensione(
                    rs.getInt("ID_recensione"),
                    rs.getInt("ID_utente"),
                    rs.getInt("ID_auto"),
                    rs.getString("descrizione"),
                    rs.getInt("valutazione")
                );
                listaRecensioni.add(recensione);
            }

            // Stampa ogni recensione in console
            for (Recensione r : listaRecensioni) {
                System.out.println(r);
            }

        } catch (SQLException e) {
            System.err.println("Errore durante il recupero delle recensioni: " + e.getMessage());
            e.printStackTrace();
        }

        return listaRecensioni;
    }

    // Metodo per eliminare una recensione dato il suo ID
    public boolean eliminaRecensione(int idRecensione) {
        String sql = "DELETE FROM recensione WHERE ID_recensione = ?";
        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idRecensione);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Eliminazione recensione con ID " + idRecensione + " avvenuta con successo.");
                return true;
            } else {
                System.out.println("Nessuna recensione trovata con ID " + idRecensione);
            }

        } catch (SQLException e) {
            System.err.println("Errore durante l'eliminazione della recensione: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public Recensione cercaRecensionePerId(int idRecensione) {
        String sql = "SELECT * FROM recensione WHERE ID_recensione = ?";
        Recensione recensione = null;

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idRecensione);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    recensione = new Recensione(
                        rs.getInt("ID_recensione"),
                        rs.getInt("ID_utente"),
                        rs.getInt("ID_auto"),
                        rs.getString("descrizione"),
                        rs.getInt("valutazione")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore durante la ricerca della recensione: " + e.getMessage());
            e.printStackTrace();
        }

        return recensione;
    }
    
    public List<Recensione> cercaRecensioniPerIdUtente(int idUtente) {
        List<Recensione> listaRecensioni = new ArrayList<>();
        String sql = "SELECT * FROM recensione WHERE ID_utente = ?";

        try (Connection connection = DataBaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idUtente);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Recensione recensione = new Recensione(
                        rs.getInt("ID_recensione"),
                        rs.getInt("ID_utente"),
                        rs.getInt("ID_auto"),
                        rs.getString("descrizione"),
                        rs.getInt("valutazione")
                    );
                    listaRecensioni.add(recensione);
                }
            }

        } catch (SQLException e) {
            System.err.println("Errore durante la ricerca delle recensioni per ID utente: " + e.getMessage());
            e.printStackTrace();
        }

        return listaRecensioni;
    }

}	



