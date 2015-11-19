package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.email.Email;
import br.com.apprestaurante.email.Velocity;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.Util;
import com.google.gson.JsonObject;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class RecuperarSenha implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        JsonObject json = new JsonObject();
        PrintWriter out = null;

        try {

            RestauranteDao dao = new RestauranteDao();
            Restaurante restaurante = dao.buscaPorCnpj(request.getParameter("cnpj"));

            if (restaurante != null) {

                if (restaurante.getEmail().equalsIgnoreCase(request.getParameter("email"))) {
                    ArrayList<String> dest = new ArrayList<String>();
                    dest.add(restaurante.getEmail());

                    dao.salvar(restaurante);

                    StringWriter texto = new Velocity().formataEmailSenha(request.getParameter("cnpjRestaurante"), restaurante.getSenha());
                    new Email().enviaEmail(dest, null, "Senha - Sistema Chegou Pediu!", texto.toString());

                    json.addProperty("ok", "S");
                } else {
                    json.addProperty("ok", "N");
                    System.out.println("Email incorreto!");
                }

            } else {
                json.addProperty("ok", "N");
                System.out.println("Usuario incorreto!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
