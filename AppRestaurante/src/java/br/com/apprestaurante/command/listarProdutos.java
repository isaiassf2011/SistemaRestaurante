package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class listarProdutos implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<Produto> produtos = new ArrayList<Produto>();

        produtos = new ProdutoDao().buscarPorCategoria(Integer.parseInt(request.getParameter("codigoCategoria")), 1);

        request.setAttribute("produtos", produtos);

        return "pages/produto.jsp";

    }

}
