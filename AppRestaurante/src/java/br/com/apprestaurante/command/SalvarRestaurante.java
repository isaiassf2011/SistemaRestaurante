package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Restaurante;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SalvarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        try {

            Restaurante restaurante = new Restaurante();
            RestauranteDao dao = new RestauranteDao();
            restaurante.setNome(request.getParameter("nomeRestaurante"));
            restaurante.setCnpj(request.getParameter("cnpjRestaurante"));
            restaurante.setCep(request.getParameter("cep"));
            restaurante.setEmail(request.getParameter("email"));
            restaurante.setTelefone(request.getParameter("telefone"));
            Estado estado = new Estado();
            estado.setCodigo(Integer.parseInt(request.getParameter("estado")));
            restaurante.setEstado(estado);
            restaurante.setSenha("123");

            /*
             File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("logo"));
             File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/").replace("build", ""));
             boolean ok = arquivo.renameTo(new File(dir, arquivo.getName()));
             if (ok) {
             System.out.println("Arquivo foi movido com sucesso");
             } else {
             System.out.println("Nao foi possivel mover o arquivo");
             }*/
            restaurante.setLogo("");
            dao.salvar(restaurante);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
