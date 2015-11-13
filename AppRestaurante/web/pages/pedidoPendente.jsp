<%-- 
    Document   : pedidoPendente
    Created on : 12/11/2015, 20:44:28
    Author     : isaias_sergio
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="p" items="${pedidos}" varStatus="i">
    <c:forEach var="pi" items="${p.itens}" varStatus="j">
        <c:if test="${pi.pedido.codigo == p.codigo}">
            <div class="panel-body" style="padding: 6px;">
                <div class="row">
                    <div class="col-xs-12 text-right">
                        <span class="button-checkbox">
                            <button type="button" class="btn" data-color="success" style="padding: 4px 12px">Feito</button>
                            <input type="checkbox" class="hidden" />
                        </span>
                        <a href="javascript:;" style="padding: 4px 6px" title="Excluir" class="btn btn-danger">
                            <i class="glyphicon glyphicon-trash"></i>										
                        </a>
                        <span style="margin-right: 15px; margin-left: 15px;">${p.mesa.codigo}</span>
                    </div>
                    <div class="col-xs-12">
                        <span style="margin-left: 5px;">${pi.produto.nome}</span>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>    
</c:forEach>
