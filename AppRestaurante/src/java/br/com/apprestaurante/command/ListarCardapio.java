package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class ListarCardapio implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Produto> produtos = new ArrayList<Produto>();

        produtos = new ProdutoDao().buscarPorCategoria(Integer.parseInt(request.getParameter("codigoCategoria")),1);
        categorias = new CategoriaProdutoDao().buscarPorRestaurante(1);

        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "pages/principal.jsp";

    }

    public static void main(String[] args) {

        List<CategoriaProduto> categoriaProdutos = new ArrayList<CategoriaProduto>();
        categoriaProdutos = new CategoriaProdutoDao().buscarPorRestaurante(1);

        for (CategoriaProduto categoriaProduto : categoriaProdutos) {
            System.out.println(categoriaProduto);
        }

    }
}
