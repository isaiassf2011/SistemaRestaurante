package br.com.apprestaurante.helper;

import br.com.apprestaurante.command.CommandInterface;
import br.com.apprestaurante.command.SalvarProduto;
import br.com.apprestaurante.command.SalvarRestaurante;
import br.com.apprestaurante.constante.AcaoConstante;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class ControllerHelper {

    private HashMap<String, CommandInterface> comandos;
    private HttpServletRequest request;

    public ControllerHelper() {

        comandos = new HashMap<String, CommandInterface>();
        comandos.put(AcaoConstante.SALVAR_RESTAURANTE, new SalvarRestaurante());
        comandos.put(AcaoConstante.SALVAR_PRODUTO, new SalvarProduto());

    }

    public CommandInterface getComando() {
        String comando = getRequest().getParameter("acao");
        return comandos.get(comando);
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

}
