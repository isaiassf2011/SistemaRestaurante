package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Mesa;
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

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
        categorias = new CategoriaProdutoDao().buscarPorRestaurante(restaurante.getCodigo());

        request.setAttribute("categorias", categorias);

        return "pages/categoria.jsp";

    }

}
