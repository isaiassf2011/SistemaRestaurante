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
import javax.servlet.http.HttpSession;

/**
 *
 * @author brd03-pc
 */
public class AlterarSenha implements CommandInterface {

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

                RestauranteDao dao = new RestauranteDao();
                Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
                restaurante = dao.getById(restaurante.getCodigo());

                if (!restaurante.getSenha().equals(request.getParameter("senhaAtual"))) {
                    json.addProperty("ok", "N");
                    json.addProperty("msg", "Senha Atual incorreta!");
                } else if (!request.getParameter("confirmarNovaSenha").equals(request.getParameter("novaSenha"))) {
                    json.addProperty("ok", "N");
                    json.addProperty("msg", "O campo Nova Senha e Confirmar Nova Senha são diferentes, favor informar novamente!");
                } else {
                    ArrayList<String> dest = new ArrayList<String>();
                    dest.add(restaurante.getEmail());
                    restaurante.setSenha(request.getParameter("novaSenha"));
                    dao.salvar(restaurante);

                    StringWriter texto = new Velocity().formataEmailSenhaRecuperada(restaurante.getCnpj(), restaurante.getSenha());
                    new Email().enviaEmail(dest, null, "Senha - Sistema Chegou Pediu!", texto.toString());

                    json.addProperty("ok", "S");
                    json.addProperty("msg", "Senha alterada com Sucesso. Encaminhamos um e-mail com sua senha para: " + restaurante.getEmail());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        out.print(json);
        out.flush();
        return null;

    }

}
