package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Pedido;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class FinalizarPedido implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        if (session != null) {

            List<Pedido> pedidos = new ArrayList<Pedido>();

            PedidoDao dao = new PedidoDao();

            Pedido pedido = dao.getByIdItens(Integer.parseInt(request.getParameter("codigoPedido")));
            pedido.setFinalizado(true);
            dao.salvar(pedido);

            pedidos = new PedidoDao().listarPorPedido(pedido.getMesa().getRestaurante().getCodigo());

            request.setAttribute("pedidos", pedidos);

            return "pages/caixa.jsp";

        } else {
            return null;
        }

    }

}
