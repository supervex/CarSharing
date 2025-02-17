package models;

import java.sql.Date;
import java.util.Objects;

public class Utente {

    private int id;
    private String username;
    private String nome;
    private String cognome;
    private Date dataNascita;
    private String passwordUtente;
    private String citta;
    private String telefono;
    private String email;
    private boolean amministratore; // Aggiunto il campo amministratore

    // Costruttore vuoto
    public Utente() {}

    // Costruttore completo
    public Utente(int id, String username, String nome, String cognome, Date dataNascita, 
                  String passwordUtente, String citta, String telefono, String email, boolean amministratore) {
        this.id = id;
        this.username = username;
        this.nome = nome;
        this.cognome = cognome;
        this.dataNascita = dataNascita;
        this.passwordUtente = passwordUtente;
        this.citta = citta;
        this.telefono = telefono;
        this.email = email;
        this.amministratore = amministratore;
    }

    // Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getDataNascita() {
        return dataNascita;
    }

    public void setDataNascita(Date dataNascita) {
        this.dataNascita = dataNascita;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getPasswordUtente() {
        return passwordUtente;
    }

    public void setPasswordUtente(String passwordUtente) {
        this.passwordUtente = passwordUtente;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAmministratore() {
        return amministratore;
    }

    public void setAmministratore(boolean amministratore) {
        this.amministratore = amministratore;
    }

    @Override
    public String toString() {
        return "Utente [id=" + id + ", username=" + username + ", nome=" + nome + ", cognome=" + cognome
                + ", dataNascita=" + dataNascita + ", citta=" + citta
                + ", telefono=" + telefono + ", email=" + email + ", amministratore=" + amministratore + "]";
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, email);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Utente other = (Utente) obj;
        return id == other.id && Objects.equals(email, other.email);
    }
}
