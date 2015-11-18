package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReativarProduto implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        Integer codigoCategoria;
        Integer codigoRestaurante;
        ProdutoDao dao = new ProdutoDao();
        Produto p = dao.getById(Integer.parseInt(request.getParameter("codigoProduto")));
        codigoCategoria = p.getCategoriaProduto().getCodigo();
        codigoRestaurante = p.getRestaurante().getCodigo();
        p.setCancelado(false);
        dao.salvar(p);

        List<Produto> produtos = new ArrayList<Produto>();
        produtos = new ProdutoDao().buscarPorCategoria(codigoCategoria, codigoRestaurante);
        request.setAttribute("produtos", produtos);

        return "pages/produto.jsp";

    }

}
