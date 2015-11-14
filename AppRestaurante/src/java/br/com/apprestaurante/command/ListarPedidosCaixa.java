package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarPedidosCaixa implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<Pedido> pedidos = new ArrayList<Pedido>();

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

        pedidos = new PedidoDao().listarPorPedido(restaurante.getCodigo());

        request.setAttribute("pedidos", pedidos);

        return "pages/caixa.jsp";

    }
    
}
