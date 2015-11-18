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

/**
 *
 * @author isaias_sergio
 */
@Entity
@Table(name = "tb_mesa")
public class Mesa implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "mesa_codigo", nullable = false, unique = true)
    private Integer codigo;

    @Column(name = "mesa_numero", nullable = false)
    private Integer numero;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "restaurante_codigo", referencedColumnName = "res_codigo", nullable = false)
    private Restaurante restaurante;

    @Column(name = "mesa_cancelado")
    private Boolean cancelado;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public Restaurante getRestaurante() {
        return restaurante;
    }

    public void setRestaurante(Restaurante restaurante) {
        this.restaurante = restaurante;
    }

    public Boolean getCancelado() {
        return cancelado;
    }

    public void setCancelado(Boolean cancelado) {
        this.cancelado = cancelado;
    }

}
