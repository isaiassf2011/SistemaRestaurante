/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.EstadoDao;
import br.com.apprestaurante.dao.MunicipioDao;
import br.com.apprestaurante.dao.RestauranteDao;
import br.com.apprestaurante.entity.Estado;
import br.com.apprestaurante.entity.Municipio;
import br.com.apprestaurante.entity.Restaurante;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias
 */
public class BuscarRestaurante implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);

        Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");
        restaurante = new RestauranteDao().getById(restaurante.getCodigo());

        List<Estado> estados = new EstadoDao().getAll();
        List<Municipio> municipios = new MunicipioDao().listarPorEstado(restaurante.getEstado().getCodigo());
        request.setAttribute("restaurante", restaurante);
        request.setAttribute("municipios", municipios);
        request.setAttribute("estados", estados);

        return "pages/perfil.jsp";

    }

}
