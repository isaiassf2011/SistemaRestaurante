package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Mesa;
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
public class ListarCardapio implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        List<CategoriaProduto> listaCategorias = new ArrayList<CategoriaProduto>();
        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Mesa> mesas = new ArrayList<Mesa>();
        List<Produto> produtos = new ArrayList<Produto>();

        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

        CategoriaProdutoDao categoriaProdutoDao = new CategoriaProdutoDao();

        listaCategorias = categoriaProdutoDao.getAll();
        categorias = categoriaProdutoDao.buscarPorRestaurante(restaurante.getCodigo());
        mesas = new MesaDao().listarPorRestaurante(restaurante.getCodigo());
        produtos = new ProdutoDao().buscarPorRestaurante(restaurante.getCodigo());

        System.out.println(request.getParameter("divTab"));
        request.setAttribute("divTab", request.getParameter("divTab"));
        request.setAttribute("listaCategorias", listaCategorias);
        request.setAttribute("mesas", mesas);
        request.setAttribute("categorias", categorias);
        request.setAttribute("produtos", produtos);

        return "pages/principal.jsp";

    }

}
