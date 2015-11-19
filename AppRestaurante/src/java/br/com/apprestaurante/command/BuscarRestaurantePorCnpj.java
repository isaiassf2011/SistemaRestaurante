package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Restaurante;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias_sergio
 */
public class BuscarRestaurantePorCnpj implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        JsonObject json = new JsonObject();
        PrintWriter out = null;
        try {

            response.setContentType("application/json");
            out = response.getWriter();

            Restaurante restaurante = new RestauranteDao().buscaPorCnpj(request.getParameter("cnpj"));

            if (restaurante == null) {
                json.addProperty("ok", "N");
            } else {
                json.addProperty("ok", "S");
            }

        } catch (IOException ex) {
            Logger.getLogger(BuscarProduto.class.getName()).log(Level.SEVERE, null, ex);
        }

        out.print(json);
        out.flush();
        return null;

    }

}
