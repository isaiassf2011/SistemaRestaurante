package br.com.apprestaurante.helper;

import br.com.apprestaurante.constante.AcaoConstante;
import java.util.HashSet;
import java.util.Set;

public class AcaoFilterHelper {

    private Set<String> acoes;

    public AcaoFilterHelper() {
        acoes = new HashSet<String>();
        acoes.add(AcaoConstante.BUSCAR_MESA);
        acoes.add(AcaoConstante.BUSCAR_PRODUTO);
        acoes.add(AcaoConstante.BUSCAR_RESTAURANTE);
        acoes.add(AcaoConstante.EXCLUIR_MESA);
        acoes.add(AcaoConstante.EXCLUIR_PRODUTO);
        acoes.add(AcaoConstante.LISTAR_CARDAPIO);
        acoes.add(AcaoConstante.LISTAR_CARDAPIO_USUARIO);
        acoes.add(AcaoConstante.LISTAR_CATEGORIAS);
        acoes.add(AcaoConstante.LISTAR_PRODUTOS);
        acoes.add(AcaoConstante.LISTAR_PRODUTOS_USUARIO);
        acoes.add(AcaoConstante.REMOVER_IMAGEM);
        acoes.add(AcaoConstante.SALVAR_MESA);
        acoes.add(AcaoConstante.SALVAR_PRODUTO);
    }

    public boolean getAcaoFilter(String acaoFilter) {
        return acoes.contains(acaoFilter);
    }

}
