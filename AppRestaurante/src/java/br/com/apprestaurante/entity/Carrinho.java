package br.com.apprestaurante.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author isaias
 */
public class Carrinho {

    private List<CarrinhoItem> itens = new ArrayList<CarrinhoItem>();
    private BigDecimal total = new BigDecimal(0.0);

    public void remove(int indiceItem) {
        CarrinhoItem removido = itens.remove(indiceItem);
        total = total.subtract(removido.getProduto().getPreco().multiply(new BigDecimal(removido.getQuantidade())));
    }

    public void adiciona(CarrinhoItem item) {
        total = total.add(item.getProduto().getPreco().multiply(new BigDecimal(item.getQuantidade())));
    }

    public List<CarrinhoItem> getItens() {
        return itens;
    }

    public void setItens(List<CarrinhoItem> itens) {
        this.itens = itens;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public Integer getTotalDeItens() {
        return itens.size();
    }

}
