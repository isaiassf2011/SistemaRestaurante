/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Produto;
import br.com.apprestaurante.entity.Restaurante;
import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
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

            Produto produto;
            ProdutoDao dao = new ProdutoDao();
            if (!request.getParameter("codigoProduto").equals("") && request.getParameter("codigoProduto") != null) {
                produto = dao.getById(Integer.parseInt(request.getParameter("codigoProduto")));
            } else {
                produto = new Produto();
            }
            produto.setNome(request.getParameter("nomeProduto"));
            produto.setDescricao(request.getParameter("descricao"));
            produto.setImagem(request.getParameter("imagem"));
            produto.setPreco(new BigDecimal(request.getParameter("preco")));
            Restaurante restaurante = new RestauranteDao().getById(1);
            produto.setRestaurante(restaurante);
            CategoriaProduto categoriaProduto = new CategoriaProduto();
            categoriaProduto.setCodigo(Integer.parseInt(request.getParameter("cmbCategoria")));
            produto.setCategoriaProduto(categoriaProduto);

            dao.salvar(produto);

            List<Produto> produtos = new ArrayList<Produto>();
            produtos = new ProdutoDao().buscarPorCategoria(Integer.parseInt(request.getParameter("cmbCategoria")), 1);
            request.setAttribute("produtos", produtos);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "pages/produto.jsp";

    }

}
