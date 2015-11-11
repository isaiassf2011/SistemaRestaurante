<%-- 
    Document   : pedido
    Created on : 11/11/2015, 19:43:06
    Author     : isaias_sergio
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="p" items="${pedido.itens}" varStatus="i">
    <div class="panel-car">
        <div class="row">
            <div class="col-md-8 col-xs-8 btn-breadcrumb">
                <span>${p.quantidade}</span>
                <span title="${p.produto.nome}">${p.produto.nome}</span>
            </div>
            <div class="col-md-4 col-xs-4 preco">
                <span><fmt:formatNumber type="currency" value="${p.quantidade * p.produto.preco}"/></span>
            </div>
        </div>
    </div>
</c:forEach>
<div class="panel-car-total">
    <span>Sub-Total do Pedido</span>
    <strong class="subTotal"><fmt:formatNumber type="currency" value="${pedido.total}"/></strong>
</div>