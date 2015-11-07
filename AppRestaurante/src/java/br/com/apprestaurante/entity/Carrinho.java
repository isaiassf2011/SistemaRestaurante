package br.com.apprestaurante.entity;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author isaias
 */
public class Carrinho {

    private List<CarrinhoItem> itens = new ArrayList<CarrinhoItem>();
    private Double total = 0.0;

    public List<CarrinhoItem> getItens() {
        return itens;
    }

    public void setItens(List<CarrinhoItem> itens) {
        this.itens = itens;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

}
