package br.com.apprestaurante.command;

import br.com.apprestaurante.entity.Carrinho;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author brd03-pc
 */
public class RemoveItemCarrinho implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
        carrinho.remove(Integer.parseInt(request.getParameter("indice")));

        session.setAttribute("carrinho", carrinho);

        return "pages/carrinho.jsp";

    }

}
