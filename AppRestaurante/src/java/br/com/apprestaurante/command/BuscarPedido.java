package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.Produto;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
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
