<%-- 
    Document   : produtoUsuario
    Created on : 02/11/2015, 18:49:26
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="p" items="${produtos}" varStatus="j">
    <div class="panel-body">
        <div class="row">
            <div class="col-xs-12 text-right">
                <c:if test="${p.imagem != ''}">
                    <img src="${contexto}/imgs/${p.imagem}" class="img-circle pull-left" style="margin-top: 0px; border-radius: 0px;" alt="">
                </c:if>
                <span class="preco">R$ ${p.preco}</span>
                <a href="javascript:;" class="btn btn-small btn-success" style="padding: 1px 4px" onclick="addItemCarrinho(${p.codigo});">
                    <i class="glyphicon glyphicon-plus"></i>										
                </a>
            </div>
            <div class="col-xs-12">
                <h5><b>${p.nome}</b></h5>
                <p style="font-size: 12px;">${p.descricao}</p>
            </div>
        </div>
    </div>
</c:forEach>
