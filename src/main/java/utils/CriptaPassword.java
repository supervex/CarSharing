package utils;

public class CriptaPassword {
	private static final char[] lettere = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
			'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

	public static String stampaCriptato(int numero, String frase) {

		String parolaCifrata = "";

		for (int i = 0; i < frase.length(); i++) {

			char lettera = frase.charAt(i);
			if (lettera == ' ') {
				parolaCifrata = parolaCifrata + " ";
			}
			for (int j = 0; j < lettere.length; j++) {

				if (lettere[j] == lettera) {

					parolaCifrata = parolaCifrata + lettere[(j + numero) % lettere.length];					
				}
			}

		}
		return parolaCifrata;
	}
	public static String decifraCriptato(int numero, String frase) {
		
		String parolaDecifrata = "";

		for (int i = 0; i < frase.length(); i++) {

			char lettera = frase.charAt(i);
			if (lettera == ' ') {
				parolaDecifrata = parolaDecifrata + " ";
			}
			for (int j = 0; j < lettere.length; j++) {

				if (lettere[j] == lettera) {

					parolaDecifrata = parolaDecifrata + lettere[(j - numero + lettere.length) % lettere.length];
				
				}
			}

		}
		return parolaDecifrata;		
	}
		
	
}
