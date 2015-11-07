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
public class ListarCardapioUsuario implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Produto> produtos = new ArrayList<Produto>();

        categorias = new CategoriaProdutoDao().buscarPorRestaurante(1);
        produtos = new ProdutoDao().buscarPorRestaurante(1);

        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "usuario.jsp";

    }

}
