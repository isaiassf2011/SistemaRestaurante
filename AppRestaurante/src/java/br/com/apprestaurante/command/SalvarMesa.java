/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.Mesa;
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
public class SalvarMesa implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //String codigoPergunta = request.getParameter("perguntaCodigo");

        HttpSession session = request.getSession(false);

        if (session != null) {
            try {

                Mesa mesa;
                MesaDao dao = new MesaDao();
                if (!request.getParameter("codigoMesa").equals("") && request.getParameter("codigoMesa") != null) {
                    mesa = dao.getById(Integer.parseInt(request.getParameter("codigoMesa")));
                } else {
                    mesa = new Mesa();
                }
                mesa.setNumero(Integer.parseInt(request.getParameter("numeroMesa")));
                Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
                mesa.setRestaurante(restaurante);
                mesa.setCancelado(false);

                dao.salvar(mesa);

                List<Mesa> mesas = new ArrayList<Mesa>();
                mesas = new MesaDao().listarPorRestaurante(restaurante.getCodigo());
                request.setAttribute("mesas", mesas);

            } catch (Exception e) {
                e.printStackTrace();
            }

            return "pages/mesa.jsp";

        } else {
            return null;
        }

    }

}
