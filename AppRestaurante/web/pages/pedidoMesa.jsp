<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="pi" items="${pedido.itens}" varStatus="j">
    <div class="panel-body" style="padding: 6px;">
        <div class="row">
            <div class="col-md-8 col-xs-8" style="font-size: 13px;">
                <a href="javascript:;" class="btn btn-small btn-danger" style="padding: 4px 4px;">
                    <i class="glyphicon glyphicon-minus" style="position: initial;"></i>										
                </a>
                <span>${pi.quantidade}</span>
                <a href="javascript:;" class="btn btn-small btn-success" style="padding: 4px 4px;">
                    <i class="glyphicon glyphicon-plus" style="position: initial;"></i>										
                </a>
                <span title="${pi.produto.nome}">${pi.produto.nome}</span>
            </div>
            <div class="col-md-4 col-xs-4 preco">
                <span><fmt:formatNumber type="currency" value="${pi.quantidade * pi.produto.preco}"/></span>
            </div>
        </div>
    </div>
</c:forEach>
<div class="panel-car-total">
    <span>Total à pagar:</span>
    <strong class="subTotal"><fmt:formatNumber type="currency" value="${p.total}"/></strong>
</div>
<div class="panel-car-footer">
    <button class="btn btn-lg btn-primary btn-block"  name="Submit" value="Login" type="Submit">Finalizar Pedido</button> 
</div>