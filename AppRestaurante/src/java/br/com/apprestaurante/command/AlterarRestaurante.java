package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Municipio;
import br.com.apprestaurante.entity.Restaurante;
import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AlterarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        try {

            HttpSession session = request.getSession(false);
            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
            RestauranteDao dao = new RestauranteDao();
            restaurante = dao.getById(restaurante.getCodigo());
            if (!restaurante.getLogo().equals("") && !restaurante.getLogo().equals(request.getParameter("logo"))) {
                File f = new File(request.getSession().getServletContext().getRealPath("/imgs/imgsRestaurante/" + restaurante.getLogo()).replace("build", ""));
                f.delete();
            }
            restaurante.setNome(request.getParameter("nomeRestaurante"));
            restaurante.setCnpj(request.getParameter("cnpjRestaurante"));
            restaurante.setCep(request.getParameter("cep"));
            restaurante.setEmail(request.getParameter("email"));
            restaurante.setTelefone(request.getParameter("telefone"));
            Estado estado = new Estado();
            estado.setCodigo(Integer.parseInt(request.getParameter("estado")));
            restaurante.setEstado(estado);
            Municipio municipio = new Municipio();
            municipio.setCodigo(Integer.parseInt(request.getParameter("municipio")));
            restaurante.setMunicipio(municipio);

            if (!restaurante.getLogo().equals(request.getParameter("logo"))) {
                File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("logo"));
                File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/imgsRestaurante/").replace("build", ""));
                boolean ok = arquivo.renameTo(new File(dir, arquivo.getName()));
                if (ok) {
                    System.out.println("Arquivo foi movido com sucesso");
                } else {
                    System.out.println("Nao foi possivel mover o arquivo");
                }
            }
            restaurante.setLogo(request.getParameter("logo"));
            dao.salvar(restaurante);
            session.setAttribute("restaurante", restaurante);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
