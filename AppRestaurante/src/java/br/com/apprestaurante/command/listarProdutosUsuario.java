package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class listarProdutosUsuario implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        if (session != null) {
            List<Produto> produtos = new ArrayList<Produto>();

            Mesa mesa = (Mesa) session.getAttribute("mesa");
            produtos = new ProdutoDao().buscarPorCategoria(Integer.parseInt(request.getParameter("codigoCategoria")), mesa.getRestaurante().getCodigo());

            request.setAttribute("produtos", produtos);

            return "pages/produtoUsuario.jsp";

        } else {
            return null;
        }

    }

}
