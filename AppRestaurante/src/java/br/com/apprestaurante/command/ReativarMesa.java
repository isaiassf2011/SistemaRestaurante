package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReativarMesa implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

        Mesa m = new Mesa();

        m.setCodigo(Integer.parseInt(request.getParameter("codigoMesa")));
        m.setCancelado(false);
        new MesaDao().salvar(m);

        List<Mesa> mesas = new ArrayList<Mesa>();
        mesas = new MesaDao().listarPorRestaurante(restaurante.getCodigo());
        request.setAttribute("mesas", mesas);

        return "pages/mesa.jsp";

    }

}
