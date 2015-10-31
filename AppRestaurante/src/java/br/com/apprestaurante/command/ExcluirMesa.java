package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.Mesa;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class ExcluirMesa implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        Mesa m = new Mesa();
        m.setCodigo(Integer.parseInt(request.getParameter("codigoMesa")));
        new MesaDao().excluir(m);

        List<Mesa> mesas = new ArrayList<Mesa>();
        mesas = new MesaDao().buscarPorRestaurante(1);
        request.setAttribute("mesas", mesas);

        return "pages/mesa.jsp";

    }

}
