package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.email.Email;
import br.com.apprestaurante.email.Velocity;
import br.com.apprestaurante.entity.Restaurante;
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

            response.setContentType("application/json");
            out = response.getWriter();
            
            RestauranteDao dao = new RestauranteDao();
            Restaurante restaurante = dao.buscaPorCnpj(request.getParameter("cnpj"));

            if (restaurante != null) {

                if (restaurante.getEmail().equalsIgnoreCase(request.getParameter("email"))) {
                    ArrayList<String> dest = new ArrayList<String>();
                    dest.add(restaurante.getEmail());

                    dao.salvar(restaurante);

                    StringWriter texto = new Velocity().formataEmailSenhaRecuperada(restaurante.getCnpj(), restaurante.getSenha());
                    new Email().enviaEmail(dest, null, "Senha - Sistema Chegou Pediu!", texto.toString());

                    json.addProperty("ok", "S");
                    json.addProperty("msg", "Senha Recuperada com Sucesso. Encaminhamos um e-mail com sua senha para: "+request.getParameter("email"));
                } else {
                    json.addProperty("ok", "N");
                    json.addProperty("msg", "O e-mail digitado não confere com o e-mail cadastrado para esse usuário!");
                }

            } else {
                json.addProperty("ok", "N");
                json.addProperty("msg", "Não existe usuário cadastrado com este CNPJ!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        out.print(json);
        out.flush();
        return null;

    }

}
