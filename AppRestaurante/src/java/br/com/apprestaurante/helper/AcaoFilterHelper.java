package br.com.apprestaurante.helper;

import br.com.apprestaurante.constante.AcaoConstante;
import java.util.HashSet;
import java.util.Set;

public class AcaoFilterHelper {

    private Set<String> acoes;

    public AcaoFilterHelper() {
        acoes = new HashSet<String>();
        
        acoes.add(AcaoConstante.RELATORIO);
        acoes.add(AcaoConstante.ADD_ITEM_CARRINHO);
        acoes.add(AcaoConstante.ALTERAR_RESTAURANTE);
        acoes.add(AcaoConstante.BUSCAR_MESA_POR_NUMERO);
        acoes.add(AcaoConstante.BUSCAR_PEDIDO_CAIXA);
        acoes.add(AcaoConstante.BUSCAR_MESA_NUMERO);
        acoes.add(AcaoConstante.BUSCAR_MESA);
        acoes.add(AcaoConstante.BUSCAR_PRODUTO);
        acoes.add(AcaoConstante.BUSCAR_RESTAURANTE);
        acoes.add(AcaoConstante.FINALIZAR_ITEM_PEDIDO);
        acoes.add(AcaoConstante.LISTAR_ITENS_PENDENTES);
        acoes.add(AcaoConstante.LISTAR_ITENS_PRONTOS);
        acoes.add(AcaoConstante.LISTAR_PRODUTOS_NOME_USUARIO);
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
        acoes.add(AcaoConstante.REATIVAR_PRODUTO);
        acoes.add(AcaoConstante.REATIVAR_MESA);
        acoes.add(AcaoConstante.REMOVE_ITEM_CARRINHO);
        acoes.add(AcaoConstante.LISTAR_PEDIDOS);
        
        
    }

    public boolean getAcaoFilter(String acaoFilter) {
        return acoes.contains(acaoFilter);
    }

}
