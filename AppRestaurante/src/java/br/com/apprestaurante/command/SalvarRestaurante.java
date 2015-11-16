package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.email.Email;
import br.com.apprestaurante.email.Velocity;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Restaurante;
import br.com.apprestaurante.util.Util;
import java.io.StringWriter;
import java.util.ArrayList;
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
            restaurante.setSenha(Util.geraSenha(6));

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

            ArrayList<String> dest = new ArrayList<String>();
            dest.add(request.getParameter("email"));

            dao.salvar(restaurante);

            StringWriter texto = new Velocity().formataEmailSenha(request.getParameter("cnpjRestaurante"), restaurante.getSenha());
            new Email().enviaEmail(dest, null, "Senha - Sistema Chegou Pediu!", texto.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
