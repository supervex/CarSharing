package models;

import java.util.Objects;

public class Auto {

    
    private int id;
    private String targa;
    private String modello;
    private String carburante;
    private double livello; 
    private int numeroPosti;
    private String cambio; // Manuale o Automatico
    private String posizione; // Posizione corrente dell'auto
    private double prezzo; // Prezzo per noleggio o acquisto

    
    public Auto(int id, String targa, String modello, String carburante, double livello, 
    		int numeroPosti, String cambio, String posizione, double prezzo) {
        this.id = id;
        this.targa = targa;
        this.modello = modello;
        this.carburante = carburante;
        this.livello = livello;
        this.numeroPosti = numeroPosti;
        this.cambio = cambio;
        this.posizione = posizione;
        this.prezzo = prezzo;
        
    }

    // Getter e Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTarga() {
        return targa;
    }

    public void setTarga(String targa) {
        this.targa = targa;
    }

    public String getModello() {
        return modello;
    }

    public void setModello(String modello) {
        this.modello = modello;
    }

    public String getCarburante() {
        return carburante;
    }

    public void setCarburante(String carburante) {
        this.carburante = carburante;
    }

    public double getLivello() {
        return livello;
    }

    public void setLivello(double livello) {
        this.livello = livello;
    }

    public int getNumeroPosti() {
        return numeroPosti;
    }

    public void setNumeroPosti(int numeroPosti) {
        this.numeroPosti = numeroPosti;
    }

    public String getCambio() {
        return cambio;
    }

    public void setCambio(String cambio) {
        this.cambio = cambio;
    }

    public String getPosizione() {
        return posizione;
    }

    public void setPosizione(String posizione) {
        this.posizione = posizione;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

   

	@Override
	public String toString() {
		return "Auto [id=" + id + ", targa=" + targa + ", modello=" + modello + ", carburante=" + carburante
				+ ", livello=" + livello + ", numeroPosti=" + numeroPosti + ", cambio=" + cambio + ", posizione="
				+ posizione + ", prezzo=" + prezzo + ", citta=" + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, targa);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Auto other = (Auto) obj;
		return id == other.id && Objects.equals(targa, other.targa);
	}


    
}