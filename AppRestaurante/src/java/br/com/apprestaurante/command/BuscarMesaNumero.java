package br.com.apprestaurante.command;

import br.com.apprestaurante.dao.MesaDao;
import br.com.apprestaurante.entity.Mesa;
import br.com.apprestaurante.entity.Restaurante;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author isaias_sergio
 */
public class BuscarMesaNumero implements CommandInterface {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        JsonObject json = new JsonObject();
        PrintWriter out = null;
        try {

            response.setContentType("application/json");
            out = response.getWriter();

            HttpSession session = request.getSession(false);
            Restaurante restaurante = (Restaurante) session.getAttribute("restaurante");

            Mesa mesa = new MesaDao().buscarMesaPorNumero(Integer.parseInt(request.getParameter("numeroMesa")),restaurante.getCodigo());

            String codigoMesa = request.getParameter("codigoMesa");
            
            if(mesa == null){
                json.addProperty("ok", "S");
            }else{
                if(!mesa.getCodigo().toString().equals(codigoMesa)){
                    json.addProperty("ok", "N");
                }else{
                    json.addProperty("ok", "S");
                }
            }

        } catch (IOException ex) {
            Logger.getLogger(BuscarProduto.class.getName()).log(Level.SEVERE, null, ex);
        }

        out.print(json);
        out.flush();
        return null;

    }

}
