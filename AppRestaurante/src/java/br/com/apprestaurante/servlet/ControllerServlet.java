package br.com.apprestaurante.servlet;

import br.com.apprestaurante.command.CommandInterface;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.apprestaurante.helper.ControllerHelper;

@WebServlet(name = "ControllerServlet", urlPatterns = "/ControllerServlet")
public class ControllerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ControllerHelper controllerHelper = new ControllerHelper();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.processaRequisicao(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.processaRequisicao(request, response);
    }

    private void processaRequisicao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        controllerHelper.setRequest(request);

        CommandInterface comando = controllerHelper.getComando();

        String pagina = null;

        try {
            pagina = comando.execute(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (pagina != null) {
            request.getRequestDispatcher(pagina).forward(request, response);
        }

    }

}
