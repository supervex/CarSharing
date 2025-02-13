package models;

import java.sql.Date;
import java.util.Objects;

public class Utente {

	private int id;
	private String username;
	private String nome;
    private String cognome;
    private Date dataNascita; // Formato: "yyyy-MM-dd"
    private String passwordUtente;
    private String citta;
    private String telefono;
    private String email;
	
    

	public Utente() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Utente(int id, String username, String nome, String cognome, Date dataNascita, String passwordUtente,
			String citta, String telefono, String email) {
		super();
		this.id = id;
		this.username = username;
		this.nome = nome;
		this.cognome = cognome;
		this.dataNascita = dataNascita;
		this.passwordUtente = passwordUtente;
		this.citta = citta;
		this.telefono = telefono;
		this.email = email;
	}

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

	// Getter e Setter
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

	

	@Override
	public String toString() {
		return "Utente [id=" + id + ", username=" + username + ", nome=" + nome + ", cognome=" + cognome
				+ ", dataNascita=" + dataNascita + ", passwordUtente=" + passwordUtente + ", citta=" + citta
				+ ", telefono=" + telefono + ", email=" + email + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Utente other = (Utente) obj;
		return id == other.id;
	}
	
}
