package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.entity.Carrinho;
import br.com.apprestaurante.entity.CarrinhoItem;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.PedidoItem;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RealizarPedido implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
        Mesa mesa = (Mesa) session.getAttribute("mesa");
        PedidoDao pedidoDao = new PedidoDao();
        Pedido pedido = pedidoDao.buscarPedidoPorMesa(mesa.getCodigo());
        if(pedido == null){
            pedido = new Pedido();
            pedido.setTotal(carrinho.getTotal());
            pedido.setData(new Date());
        }else{
            pedido.setTotal(pedido.getTotal().add(carrinho.getTotal()));
        }
        pedido.setFinalizado(false);
        pedido.setMesa(mesa);

        List<PedidoItem> items = new ArrayList<PedidoItem>();
        
        for (CarrinhoItem carrinhoItem : carrinho.getItens()) {
            PedidoItem pedidoItem = new PedidoItem();
            pedidoItem.setProduto(carrinhoItem.getProduto());
            pedidoItem.setQuantidade(carrinhoItem.getQuantidade());
            pedidoItem.setPedido(pedido);
            pedidoItem.setFeito(false);
            items.add(pedidoItem);
        }
        pedido.setItens(items);
        
        pedidoDao.salvar(pedido);
        
        carrinho = new Carrinho();
        session.setAttribute("carrinho", carrinho);
        request.setAttribute("pedido", pedido);
        
        return "pages/carrinho.jsp";

    }

}
