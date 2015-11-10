package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Carrinho;
import br.com.apprestaurante.entity.CarrinhoItem;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class AddItemCarrinho implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(true);

        Produto produto = new ProdutoDao().getById(Integer.parseInt(request.getParameter("codigoProduto")));

        CarrinhoItem carrinhoItem = new CarrinhoItem();
        carrinhoItem.setProduto(produto);
        carrinhoItem.setQuantidade(1);
        List<CarrinhoItem> itemsCarrinho;
        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
        if (carrinho == null) {
            carrinho = new Carrinho();
            itemsCarrinho = new ArrayList<CarrinhoItem>();
        }else{
            itemsCarrinho = carrinho.getItens();
        }
        itemsCarrinho.add(carrinhoItem);
        carrinho.adiciona(carrinhoItem);

        carrinho.setItens(itemsCarrinho);

        session.setAttribute("carrinho", carrinho);

        for (CarrinhoItem i : itemsCarrinho) {
            System.out.println("Item: " + i.getProduto().getNome());
            System.out.println("Item: " + i.getProduto().getDescricao());
            System.out.println("Item: " + i.getProduto().getCodigo());
            System.out.println("Item: " + i.getProduto().getPreco());
        }

        return "pages/carrinho.jsp";

    }

}
