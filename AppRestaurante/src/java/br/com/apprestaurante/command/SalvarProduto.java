/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Produto;
import br.com.apprestaurante.entity.Restaurante;
import java.math.BigDecimal;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class SalvarProduto implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        try {

            ProdutoDao dao = new ProdutoDao();
            Produto produto = new Produto();
            produto.setNome(request.getParameter("nomeProduto"));
            produto.setDescricao(request.getParameter("descricao"));
            produto.setImagem(request.getParameter("imagem"));
            produto.setPreco(new BigDecimal(request.getParameter("preco")));
            Restaurante restaurante = new RestauranteDao().getById(1);
            produto.setRestaurante(restaurante);
            
            dao.salvar(produto);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
