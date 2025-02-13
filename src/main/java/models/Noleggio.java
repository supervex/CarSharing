package models;

import java.time.LocalDateTime;
import java.util.Objects;

public class Noleggio {
	private int id;
	private int idUtente;
	private int idAuto;
	private LocalDateTime data_inizio;
	private LocalDateTime data_fine;

	public Noleggio() {
		super();
	}

	public Noleggio(int id, int idUtente, int idAuto, LocalDateTime data_inizio, LocalDateTime data_fine) {
		super();
		this.id = id;
		this.idUtente = idUtente;
		this.idAuto = idAuto;
		this.data_inizio = data_inizio;
		this.data_fine = data_fine;
	}

	public int getId() {
		return id;
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

	public LocalDateTime getData_inizio() {
		return data_inizio;
	}

	public LocalDateTime getData_fine() {
		return data_fine;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setData_inizio(LocalDateTime data_inizio) {
		this.data_inizio = data_inizio;
	}

	public void setData_fine(LocalDateTime data_fine) {
		this.data_fine = data_fine;
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
		Noleggio other = (Noleggio) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Noleggio [id=" + id + ", data_inizio=" + data_inizio + ", data_fine=" + data_fine + "]";
	}

}
