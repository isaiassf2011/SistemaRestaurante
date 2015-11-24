package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Produto;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class BuscarProduto implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        JsonObject json = new JsonObject();
        PrintWriter out = null;
        try {

            response.setContentType("application/json");
            out = response.getWriter();

            if (session == null) {
                json.addProperty("ok", "400");
            } else {
                Produto produto = new ProdutoDao().getById(Integer.parseInt(request.getParameter("codigoProduto")));

                json.addProperty("nome", produto.getNome());
                json.addProperty("imagem", produto.getImagem());
                json.addProperty("descricao", produto.getDescricao());
                json.addProperty("preco", String.format("%.2f", produto.getPreco()));
                json.addProperty("categoria", produto.getCategoriaProduto().getCodigo());
            }

        } catch (IOException ex) {
            Logger.getLogger(BuscarProduto.class.getName()).log(Level.SEVERE, null, ex);
        }

        out.print(json);
        out.flush();
        return null;

    }

}
