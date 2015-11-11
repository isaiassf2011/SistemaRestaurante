package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.PedidoDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Carrinho;
import br.com.apprestaurante.entity.CarrinhoItem;
import br.com.apprestaurante.entity.CategoriaProduto;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Pedido;
import br.com.apprestaurante.entity.PedidoItem;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RealizarPedido implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
        Pedido pedido = new Pedido();
        pedido.setFinalizado(false);
        Mesa mesa = new Mesa();
        mesa.setCodigo(3);
        pedido.setMesa(mesa);
        pedido.setTotal(carrinho.getTotal());

        List<PedidoItem> items = new ArrayList<PedidoItem>();
        
        for (CarrinhoItem carrinhoItem : carrinho.getItens()) {
            PedidoItem pedidoItem = new PedidoItem();
            pedidoItem.setProduto(carrinhoItem.getProduto());
            pedidoItem.setQuantidade(carrinhoItem.getQuantidade());
            pedidoItem.setPedido(pedido);
            items.add(pedidoItem);
        }
        pedido.setItens(items);
        
        new PedidoDao().salvar(pedido);
        
        return null;

    }

}
