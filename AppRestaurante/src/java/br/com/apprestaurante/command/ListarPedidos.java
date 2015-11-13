package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarPedidos implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<PedidoItem> itens = new ArrayList<PedidoItem>();

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

        //criar PedidoItemDao
        itens = new PedidoDao().listarPedidosPendentes2(restaurante);
        
        for (PedidoItem item : itens) {
            System.out.println(item.getPedido().getCodigo());
        }
        
        request.setAttribute("pedidos", itens);

        return "pages/pedidoRestaurante.jsp";

    }

}
