package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.MesaDao;
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
public class ListarCardapioUsuario implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(true);
        
        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Produto> produtos = new ArrayList<Produto>();

        Mesa mesa = new MesaDao().getById(10);
        categorias = new CategoriaProdutoDao().buscarPorRestaurante(1);
        produtos = new ProdutoDao().buscarPorRestaurante(1);

        session.setAttribute("mesa", mesa);
        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "usuario.jsp";

    }

}
