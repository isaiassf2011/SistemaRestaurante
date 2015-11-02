package br.com.apprestaurante.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author isaias_sergio
 */
@Entity
@Table(name = "tb_produto")
public class Produto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "produto_codigo", nullable = false, unique = true)
    private Integer codigo;

    @Column(name = "produto_nome", nullable = false, length = 200)
    private String nome;

    @Column(name = "produto_descricao", length = 300)
    private String descricao;

    @Column(name = "produto_preco", nullable = false, precision = 7, scale = 2)
    private BigDecimal preco;

    @Column(name = "produto_imagem", length = 250)
    private String imagem;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "restaurante_codigo", referencedColumnName = "res_codigo", nullable = false)
    private Restaurante restaurante;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categoria_pro_codigo", referencedColumnName = "categoria_pro_codigo", nullable = false)
    private CategoriaProduto categoriaProduto;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public Restaurante getRestaurante() {
        return restaurante;
    }

    public void setRestaurante(Restaurante restaurante) {
        this.restaurante = restaurante;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public void setPreco(BigDecimal preco) {
        this.preco = preco;
    }

    public CategoriaProduto getCategoriaProduto() {
        return categoriaProduto;
    }

    public void setCategoriaProduto(CategoriaProduto categoriaProduto) {
        this.categoriaProduto = categoriaProduto;
    }

}
