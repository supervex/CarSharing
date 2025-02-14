package utils;

public class CriptaPassword {
    private static final String ALFABETO = "abcdefghijklmnopqrstuvwxyz";
    private static final String NUMERI = "0123456789";
    
    public static String cripta(int shift, String frase) {
        StringBuilder parolaCifrata = new StringBuilder();
        
        for (char lettera : frase.toCharArray()) {
            if (Character.isLowerCase(lettera)) {
                parolaCifrata.append(shiftChar(lettera, shift, ALFABETO));
            } else if (Character.isUpperCase(lettera)) {
                parolaCifrata.append(Character.toUpperCase(shiftChar(Character.toLowerCase(lettera), shift, ALFABETO)));
            } else if (Character.isDigit(lettera)) {
                parolaCifrata.append(shiftChar(lettera, shift, NUMERI));
            } else {
                parolaCifrata.append(lettera);
            }
        }
        return parolaCifrata.toString();
    }

    public static String decripta(int shift, String frase) {
        return cripta(-shift, frase);
    }
    
    private static char shiftChar(char lettera, int shift, String alfabeto) {
        int index = alfabeto.indexOf(lettera);
        if (index != -1) {
            return alfabeto.charAt((index + shift + alfabeto.length()) % alfabeto.length());
        }
        return lettera;
    }
}