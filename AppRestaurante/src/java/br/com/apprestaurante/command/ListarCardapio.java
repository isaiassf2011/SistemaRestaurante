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
public class ListarCardapio implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<CategoriaProduto> categorias = new ArrayList<CategoriaProduto>();
        List<Mesa> mesas = new ArrayList<Mesa>();

        categorias = new CategoriaProdutoDao().buscarPorRestaurante(1);
        mesas = new MesaDao().buscarPorRestaurante(1);

        request.setAttribute("mesas", mesas);
        request.setAttribute("categorias", categorias);

        return "pages/principal.jsp";

    }

    public static void main(String[] args) {

        List<CategoriaProduto> categoriaProdutos = new ArrayList<CategoriaProduto>();
        categoriaProdutos = new CategoriaProdutoDao().buscarPorRestaurante(1);

        for (CategoriaProduto categoriaProduto : categoriaProdutos) {
            System.out.println(categoriaProduto);
        }

    }
}
