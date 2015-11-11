package br.com.apprestaurante.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tb_pedido_item")
public class PedidoItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "pedido_item_codigo", nullable = false, unique = true)
    private Integer codigo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "produto_codigo", referencedColumnName = "produto_codigo", nullable = false)
    private Produto produto;

    @Column(name = "pedido_item_quantidade", nullable = false)
    private Integer quantidade;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "pedido_codigo", referencedColumnName = "pedido_codigo", nullable = false)
    private Pedido pedido;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public Integer getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

}
