package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.Restaurante;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class BuscarMesaPorNumero implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<Pedido> pedidos = new ArrayList<Pedido>();

        HttpSession session = request.getSession(false);
        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
        if (!request.getParameter("numero").equals("")) {
            Pedido pedido = new PedidoDao().buscarPedidoPorNMesa(Integer.parseInt(request.getParameter("numero")), restaurante.getCodigo());
            if (pedido != null) {
                pedidos.add(pedido);
            }
        }

        request.setAttribute("pedidos", pedidos);

        return "pages/caixa.jsp";

    }

}
