<%-- 
    Document   : carrinho
    Created on : 10/11/2015, 10:01:42
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />
<input type="hidden" id="totalDeItens" value="${carrinho.totalDeItens}"/>

<c:if test="${carrinho.totalDeItens != 0}">
    <c:forEach var="c" items="${carrinho.itens}" varStatus="i">
        <div class="panel-car">
            <div class="row">
                <div class="col-md-8 col-xs-8 btn-breadcrumb">
                    <a href="javascript:;" class="btn btn-small btn-danger" style="padding: 1px 4px" onclick="removeItemCarrinho(${i.count - 1});">
                        <i class="glyphicon glyphicon-minus"></i>										
                    </a>
                    <span>${c.quantidade}</span>
                    <a href="javascript:;" class="btn btn-small btn-success" style="padding: 1px 4px" onclick="addItemCarrinho(${c.produto.codigo});">
                        <i class="glyphicon glyphicon-plus"></i>										
                    </a>
                    <span title="${c.produto.nome}">${c.produto.nome}</span>
                </div>
                <div class="col-md-4 col-xs-4 preco">
                    <span><fmt:formatNumber type="currency" value="${c.quantidade * c.produto.preco}"/></span>
                </div>
            </div>
        </div>
    </c:forEach>
    <div class="panel-car-total">
        <span>Sub-Total do Pedido</span>
        <strong class="subTotal"><fmt:formatNumber type="currency" value="${carrinho.total}"/></strong>
    </div>
    <div class="panel-car-footer">
        <button class="btn btn-lg btn-primary btn-block" type="button" onclick="realizarPedido();">Realizar Pedido</button> 
    </div>
</c:if>
<c:if test="${carrinho.totalDeItens == 0}">
    <div class="text-center">
        <img alt="" src="${contexto}/imgs/prato_vazio.png" class="imagem-centro">
        <h4>Carrinho Vazio</h4>
        <p>Escolha algo no Cardapio para comer!</p>
    </div>
</c:if>