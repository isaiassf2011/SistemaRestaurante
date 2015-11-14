package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.CategoriaProduto;
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
public class listarCategorias implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Produto> produtos = new ArrayList<Produto>();

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
        categorias = new CategoriaProdutoDao().buscarPorRestaurante(restaurante.getCodigo());
        produtos = new ProdutoDao().buscarPorRestaurante(restaurante.getCodigo());

        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "pages/categoria.jsp";

    }

}
