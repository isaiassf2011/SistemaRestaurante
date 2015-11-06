package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.EstadoDao;
import br.com.apprestaurante.entity.Estado;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastraRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        
        List<Estado> estados = new EstadoDao().getAll();
        request.setAttribute("estados", estados);
        
        return "pages/cadastraRestaurante.jsp";
        
    }
    
}
