package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.CategoriaProdutoDao;
import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Mesa;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class listarCategorias implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();

        categorias = new CategoriaProdutoDao().buscarPorRestaurante(Integer.parseInt(request.getParameter("codigoRestaurante")));

        request.setAttribute("categorias", categorias);

        return "pages/categoria.jsp";

    }

}
