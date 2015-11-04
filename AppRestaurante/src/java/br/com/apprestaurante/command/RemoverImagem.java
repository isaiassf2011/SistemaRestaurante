package br.com.apprestaurante.command;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class RemoverImagem implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        /*String nome = request.getParameter("imagem");
        String caminho = request.getSession().getServletContext().getRealPath("/imgs/"+nome).replace("build", "");
        if(caminho != null){
            File f = new File(caminho);
            f.delete();
        }*/
        return null;

    }

}
