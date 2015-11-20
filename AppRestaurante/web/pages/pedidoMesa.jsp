<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />
<c:set var="bloqueiaFinalizar" value="0" />

<c:forEach var="pi" items="${pedido.itens}" varStatus="j">
    <div class="panel-body" style="padding: 6px;">
        <div class="row">
            <div class="col-md-8 col-xs-8" style="font-size: 13px;">
                <c:if test="${pi.feito == false}">
                    <c:set var="bloqueiaFinalizar" value="1" />
                    <span class="button-checkbox">
                        <button type="button" class="btn btn-default" data-color="success" style="padding: 4px 12px" onclick="finalizarItem(${pi.codigo});">
                            <i class="state-icon glyphicon glyphicon-unchecked"></i>
                            Feito</button>
                        <input type="checkbox" class="hidden" />
                    </span>
                </c:if>
                <c:if test="${pi.feito == true}">
                    <span class="button-checkbox">
                        <button type="button" class="btn btn-success active" data-color="success" style="padding: 4px 12px" onclick="">
                            <i class="state-icon glyphicon glyphicon-check"></i>
                            Feito</button>
                        <input type="checkbox" class="hidden" />
                    </span>
                </c:if>
                <span>${pi.quantidade}</span>
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
    <strong class="subTotal"><fmt:formatNumber type="currency" value="${pedido.total}"/></strong>
</div>
<div class="panel-car-footer">
    <button class="btn btn-lg btn-primary btn-block"  type="button" onclick="finalizarPedido(${pedido.codigo}, ${bloqueiaFinalizar}, ${pedido.mesa.codigo});">Finalizar Pedido</button> 
</div>