package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoItemDao;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FinalizarItemPedido implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        if (session != null) {

            PedidoItemDao dao = new PedidoItemDao();
            PedidoItem pedidoItem = dao.getById(Integer.parseInt(request.getParameter("codigoItem")));
            pedidoItem.setFeito(true);
            dao.salvar(pedidoItem);

            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
            List<PedidoItem> itens = new ArrayList<PedidoItem>();
            itens = dao.listarPedidosPendentes(restaurante);
            request.setAttribute("pedidos", itens);

            return "pages/pedidoPendente.jsp";

        } else {
            return null;
        }

    }

}
