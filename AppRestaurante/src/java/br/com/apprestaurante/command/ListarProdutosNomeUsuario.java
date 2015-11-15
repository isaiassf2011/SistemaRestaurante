package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.CategoriaProduto;
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
public class ListarProdutosNomeUsuario implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        List<Produto> produtos = new ArrayList<Produto>();
        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();

        Mesa mesa = (Mesa) session.getAttribute("mesa");
        categorias = new CategoriaProdutoDao().buscarPorProdutoNome(request.getParameter("nome"), mesa.getRestaurante().getCodigo());
        produtos = new ProdutoDao().buscarPorNome(request.getParameter("nome"), mesa.getRestaurante().getCodigo());

        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "pages/categoriaUsuario.jsp";

    }

}
