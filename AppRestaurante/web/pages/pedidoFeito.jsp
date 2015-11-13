<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<table class="table table-hover" id="dev-table">
    <thead>
        <tr>
            <th class="text-center" width="70%">Produto</th>
            <th class="text-center" width="25%">Ações</th>
            <th class="text-center" width="5%">Mesa</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="p" items="${pedidos}" varStatus="i">
            <tr class="text-center">
                <td><span style="margin-left: 5px;">${p.produto.nome}</span></td>
                <td>
                    <span class="button-checkbox">
                        <button type="button" class="btn btn-success active" data-color="success" style="padding: 4px 12px" onclick="">
                            <i class="state-icon glyphicon glyphicon-check"></i>
                            Feito</button>
                        <input type="checkbox" class="hidden" />
                    </span>
                </td>
                <td>
                    <span style="margin-right: 15px; margin-left: 15px;">${p.pedido.mesa.codigo}</span>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
