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
import javax.servlet.http.HttpSession;

public class AutenticaRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        JsonObject json = new JsonObject();
        PrintWriter out = null;
        try {

            response.setContentType("application/json");
            out = response.getWriter();

            RestauranteDao dao = new RestauranteDao();
            Restaurante restaurante = dao.buscaPorCnpjSenha(request.getParameter("cnpj"), request.getParameter("senha"));

            if (restaurante != null) {
                session.setAttribute("restaurante", restaurante);
            } else {
                System.out.println("Usuario/Senha incorreto!");
            }

        } catch (IOException ex) {
            Logger.getLogger(AutenticaRestaurante.class.getName()).log(Level.SEVERE, null, ex);
        }

        out.print(json);
        out.flush();
        return null;

    }

}
