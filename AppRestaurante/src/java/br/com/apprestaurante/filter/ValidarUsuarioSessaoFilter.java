package br.com.apprestaurante.filter;

import br.com.apprestaurante.helper.AcaoFilterHelper;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/pages/*",
    "/index.html",
    "/teste.html",
    "/usuario.html",
    "/usuario.jsp"},
        servletNames = {"LogoffUsuarioServlet", "ControllerServlet"},
        filterName = "validarUsuarioSessaoFilter")
public class ValidarUsuarioSessaoFilter implements Filter {

    private AcaoFilterHelper acaoFilterHelper;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        acaoFilterHelper = new AcaoFilterHelper();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session == null && filtrarAcao(req)) {
            resp.sendRedirect(req.getContextPath());
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }

    private boolean filtrarAcao(HttpServletRequest req) {
        return acaoFilterHelper.getAcaoFilter(req.getParameter("acao"));
    }

}
