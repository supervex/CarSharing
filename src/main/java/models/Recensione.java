package models;

import java.util.Objects;

public class Recensione {
	private int id;
	private int idUtente;
	private int idAuto;
	private String descrizione;
	private int valuatzione;
	
	public Recensione() {
		super();
		
	}
	
	
	public Recensione(int id, int idUtente, int idAuto, String descrizione, int valuatzione) {
		super();
		this.id = id;
		this.idUtente = idUtente;
		this.idAuto = idAuto;
		this.descrizione = descrizione;
		this.valuatzione = valuatzione;
	}
	

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getIdUtente() {
		return idUtente;
	}


	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}


	public int getIdAuto() {
		return idAuto;
	}


	public void setIdAuto(int idAuto) {
		this.idAuto = idAuto;
	}


	public String getDescrizione() {
		return descrizione;
	}


	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}


	public int getValuatzione() {
		return valuatzione;
	}


	public void setValuatzione(int valuatzione) {
		this.valuatzione = valuatzione;
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
		Recensione other = (Recensione) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "Recensione [id=" + id + ", descrizione=" + descrizione + ", valuatzione=" + valuatzione + "]";
	}
}