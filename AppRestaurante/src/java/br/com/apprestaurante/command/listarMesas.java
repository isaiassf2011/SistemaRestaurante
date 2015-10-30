/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.dao.ProdutoDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Produto;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class listarMesas implements CommandInterface {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<Mesa> mesas = new ArrayList<Mesa>();

        mesas = new MesaDao().buscarPorRestaurante(1);

        request.setAttribute("mesas", mesas);

        return "pages/mesa.jsp";

    }

}
