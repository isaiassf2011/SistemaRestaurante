package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoItemDao;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarItensProntos implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<PedidoItem> itens = new ArrayList<PedidoItem>();

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

        itens = new PedidoItemDao().listarPedidosProntos(restaurante);

        request.setAttribute("pedidos", itens);

        return "pages/pedidoFeito.jsp";

    }
    
}
