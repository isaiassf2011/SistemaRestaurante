package br.com.apprestaurante.util;

import java.util.UUID;

public class Util {

    public static String geraSenha(int qtdeDigitos) {
        UUID uuid = UUID.randomUUID();
        String myRandom = uuid.toString();

        return myRandom.substring(0, qtdeDigitos);
    }

}
