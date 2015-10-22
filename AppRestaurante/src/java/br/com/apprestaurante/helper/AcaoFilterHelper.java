package br.com.apprestaurante.helper;

import br.com.apprestaurante.constante.AcaoConstante;
import java.util.HashSet;
import java.util.Set;

public class AcaoFilterHelper {

    private Set<String> acoes;

    public AcaoFilterHelper() {
        acoes = new HashSet<String>();
    }

    public boolean getAcaoFilter(String acaoFilter) {
        return acoes.contains(acaoFilter);
    }

}
