<%-- 
    Document   : pedidoPendente
    Created on : 12/11/2015, 20:44:28
    Author     : isaias_sergio
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<div>
    <h5 id="msgPedidoPendente" style="color: green; font-weight: bold;"></h5>
</div>
<c:if test="${!empty pedidos}">
    <table class="table table-hover" id="dev-table">
        <thead>
            <tr>
                <th class="text-center" width="70%">Produto</th>
                <th class="text-center" width="25%">A��es</th>
                <th class="text-center" width="5%">Mesa</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${pedidos}" varStatus="i">
                <tr class="text-center">
                    <td><span style="margin-left: 5px;">${p.produto.nome}</span></td>
                    <td>
                        <span class="button-checkbox">
                            <button type="button" class="btn btn-default" data-color="success" style="padding: 4px 12px" onclick="finalizarItem(${p.codigo});">
                                <i class="state-icon glyphicon glyphicon-unchecked"></i>
                                Feito</button>
                            <input type="checkbox" class="hidden" />
                        </span>
                    </td>
                    <td>
                        <span style="margin-right: 15px; margin-left: 15px;">${p.pedido.mesa.numero}</span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty pedidos}">
    <div class="text-center">
        <h4>Nenhum pedido pendente</h4>
    </div>
</c:if>
