package br.com.apprestaurante.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author isaias_sergio
 */
@Entity
@Table(name = "tb_restaurante")
public class Restaurante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "res_codigo", nullable = false, unique = true)
    private Integer codigo;

    @Column(name = "res_nome", nullable = false, length = 200)
    private String nome;

    @Column(name = "res_logo", nullable = false, length = 250)
    private String logo;

    @Column(name = "res_telefone", nullable = false, length = 20)
    private String telefone;

    @Column(name = "res_email", nullable = false, length = 200)
    private String email;

    @Column(name = "res_cep", nullable = false, length = 10)
    private String cep;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
