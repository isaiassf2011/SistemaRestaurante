package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Produto;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class listarProdutos implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        if (session != null) {
            List<Produto> produtos = new ArrayList<Produto>();
            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

            produtos = new ProdutoDao().buscarPorCategoria(Integer.parseInt(request.getParameter("codigoCategoria")), restaurante.getCodigo());

            request.setAttribute("produtos", produtos);

            return "pages/produto.jsp";

        } else {
            return null;
        }

    }

}
