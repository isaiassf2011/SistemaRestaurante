package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Pedido;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias_sergio
 */
public class BuscarPedido implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        
        Mesa mesa = (Mesa) session.getAttribute("mesa");
        Pedido pedido = new PedidoDao().buscarPedidoPorMesa(mesa.getCodigo());
        
        request.setAttribute("pedido", pedido);
        
        return "pages/pedido.jsp";

    }

}
