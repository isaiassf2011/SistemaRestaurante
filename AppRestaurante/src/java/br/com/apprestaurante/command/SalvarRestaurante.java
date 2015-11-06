package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Restaurante;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import java.io.File;
import javax.servlet.http.HttpSession;

public class SalvarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        try {

            HttpSession session = request.getSession(false);
            Restaurante restaurante;
            RestauranteDao dao = new RestauranteDao();
            if (session != null) {
                restaurante = (Restaurante) session.getAttribute("restaurante");
                restaurante = dao.getById(restaurante.getCodigo());
                if (!restaurante.getLogo().equals("")) {
                    File f = new File(request.getSession().getServletContext().getRealPath("/imgs/" + restaurante.getLogo()).replace("build", ""));
                    f.delete();
                }
            } else {
                restaurante = new Restaurante();
            }
            restaurante.setNome(request.getParameter("nomeRestaurante"));
            restaurante.setCnpj(request.getParameter("cnpjRestaurante"));
            restaurante.setCep(request.getParameter("cep"));
            restaurante.setEmail(request.getParameter("email"));
            restaurante.setTelefone(request.getParameter("telefone"));

            File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("logo"));
            File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/").replace("build", ""));
            boolean ok = arquivo.renameTo(new File(dir, arquivo.getName()));
            if (ok) {
                System.out.println("Arquivo foi movido com sucesso");
            } else {
                System.out.println("Nao foi possivel mover o arquivo");
            }
            restaurante.setLogo(request.getParameter("logo"));
            dao.salvar(restaurante);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
