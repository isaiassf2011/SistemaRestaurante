/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Restaurante;
import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author brd03-pc
 */
public class AlterarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        try {

            HttpSession session = request.getSession(false);
            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");;
            RestauranteDao dao = new RestauranteDao();
            restaurante = dao.getById(restaurante.getCodigo());
            if (!restaurante.getLogo().equals("") && !restaurante.getLogo().equals(request.getParameter("logo"))) {
                File f = new File(request.getSession().getServletContext().getRealPath("/imgs/" + restaurante.getLogo()).replace("build", ""));
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

            if (!restaurante.getLogo().equals(request.getParameter("logo"))) {
                File arquivo = new File(System.getProperty("java.io.tmpdir") + File.separator + request.getParameter("logo"));
                File dir = new File(request.getSession().getServletContext().getRealPath("/imgs/").replace("build", ""));
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
