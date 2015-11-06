/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class SalvarProduto implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        HttpSession session = request.getSession(false);
        
        try {

            Produto produto;
            ProdutoDao dao = new ProdutoDao();
            if (!request.getParameter("codigoProduto").equals("") && request.getParameter("codigoProduto") != null) {
                produto = dao.getById(Integer.parseInt(request.getParameter("codigoProduto")));
                if (!produto.getImagem().equals("")) {
                    File f = new File(request.getSession().getServletContext().getRealPath("/imgs/"+produto.getImagem()).replace("build", ""));
                    f.delete();
                }
            } else {
                produto = new Produto();
            }
            produto.setNome(request.getParameter("nomeProduto"));
            produto.setDescricao(request.getParameter("descricao"));
            // diretorio de origem
            File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("imagem"));
            // diretorio de destino
            File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/").replace("build", ""));
            // move o arquivo para o novo diretorio
            boolean ok = arquivo.renameTo(new File(dir, arquivo.getName()));
            if (ok) {
                System.out.println("Arquivo foi movido com sucesso");
            } else {
                System.out.println("Nao foi possivel mover o arquivo");
            }

            produto.setImagem(request.getParameter("imagem"));
            produto.setPreco(new BigDecimal(request.getParameter("preco")));
            
            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
            produto.setRestaurante(restaurante);
            CategoriaProduto categoriaProduto = new CategoriaProduto();
            categoriaProduto.setCodigo(Integer.parseInt(request.getParameter("cmbCategoria")));
            produto.setCategoriaProduto(categoriaProduto);

            dao.salvar(produto);

            List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
            categorias = new CategoriaProdutoDao().buscarPorRestaurante(restaurante.getCodigo());
            request.setAttribute("categorias", categorias);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "pages/categoria.jsp";

    }

}
