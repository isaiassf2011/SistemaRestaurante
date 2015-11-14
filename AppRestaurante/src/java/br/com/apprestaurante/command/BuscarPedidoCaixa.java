package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Pedido;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class BuscarPedidoCaixa implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        Pedido pedido = new PedidoDao().getByIdItens(Integer.parseInt(request.getParameter("codigoPedido")));
        
        request.setAttribute("pedido", pedido);
        
        return "pages/pedidoMesa.jsp";

    }
    
}
