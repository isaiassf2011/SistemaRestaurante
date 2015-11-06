package br.com.apprestaurante.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tb_estado")
public class Estado implements Serializable {

    @Id
    @Column(name = "estado_codigo", nullable = false, unique = true)
    private Integer codigo;

    @Column(name = "estado_descricao", nullable = false, length = 100)
    private String descricao;

    @Column(name = "estado_uf", nullable = false, length = 2)
    private String uf;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

}
