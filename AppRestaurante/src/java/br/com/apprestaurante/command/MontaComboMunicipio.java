package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MunicipioDao;
import br.com.apprestaurante.entity.Municipio;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author brd03-pc
 */
public class MontaComboMunicipio implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<Municipio> municipios = new ArrayList<Municipio>();

        municipios = new MunicipioDao().listarPorEstado(Integer.parseInt(request.getParameter("codigoEstado")));

        request.setAttribute("municipios", municipios);

        return "pages/municipio.jsp";

    }
    
}
