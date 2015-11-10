/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
 * @author brd03-pc
 */
public class RemoveItemCarrinho implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(true);

        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
        carrinho.remove(Integer.parseInt(request.getParameter("indice")));

        session.setAttribute("carrinho", carrinho);

        return "pages/carrinho.jsp";

    }

}
