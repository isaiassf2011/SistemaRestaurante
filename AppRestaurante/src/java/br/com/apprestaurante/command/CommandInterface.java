package br.com.apprestaurante.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandInterface {

    public abstract String execute(HttpServletRequest request, HttpServletResponse response);

}
