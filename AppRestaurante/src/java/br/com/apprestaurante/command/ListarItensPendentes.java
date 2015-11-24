package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoItemDao;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarItensPendentes implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        if (session != null) {
            List<PedidoItem> itens = new ArrayList<PedidoItem>();

            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

            itens = new PedidoItemDao().listarPedidosPendentes(restaurante);

            request.setAttribute("pedidos", itens);

            return "pages/pedidoPendente.jsp";

        } else {
            return null;
        }

    }

}
