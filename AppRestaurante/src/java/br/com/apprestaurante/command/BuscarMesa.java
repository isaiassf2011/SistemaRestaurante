/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.Mesa;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaias
 */
public class BuscarMesa implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        JsonObject json = new JsonObject();
        PrintWriter out = null;
        try {

            response.setContentType("application/json");
            out = response.getWriter();

            Mesa mesa = new MesaDao().getById(Integer.parseInt(request.getParameter("codigoMesa")));

            json.addProperty("numero", mesa.getNumero());

        } catch (IOException ex) {
            Logger.getLogger(BuscarProduto.class.getName()).log(Level.SEVERE, null, ex);
        }

        out.print(json);
        out.flush();
        return null;

    }

}
