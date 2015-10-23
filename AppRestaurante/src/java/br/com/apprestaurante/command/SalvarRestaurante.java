package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Restaurante;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

public class SalvarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        try {

            RestauranteDao dao = new RestauranteDao();
            Restaurante restaurante = new Restaurante();
            restaurante.setNome(request.getParameter("nomeRestaurante"));
            restaurante.setCep(request.getParameter("cep"));
            restaurante.setEmail(request.getParameter("email"));
            restaurante.setTelefone(request.getParameter("telefone"));
            restaurante.setLogo(request.getParameter("logo"));
            dao.salvar(restaurante);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
