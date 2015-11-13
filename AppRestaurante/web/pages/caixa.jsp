<%-- 
    Document   : caixa
    Created on : 13/11/2015, 17:35:21
    Author     : brd03-pc
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="p" items="${pedidos}" varStatus="i">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" href="#mesa${p.mesa.codigo}" onclick="buscarPedido(${p.codigo});">
                    Mesa ${p.mesa.numero}
                </a>
            </h4>
        </div>
        <div id="mesa${p.mesa.codigo}" class="panel-collapse collapse in" >
        </div>
    </div>
</c:forEach>
