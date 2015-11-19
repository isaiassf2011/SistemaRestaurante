<%-- 
    Document   : categoriaUsuario
    Created on : 02/11/2015, 18:47:39
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:if test="${!empty categorias}">
    <c:forEach var="c" items="${categorias}" varStatus="i">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="" data-toggle="collapse" href="#categoria${c.codigo}" aria-expanded="true">
                        ${c.descricao}
                    </a>
                </h4>
            </div>
            <div id="categoria${c.codigo}" class="panel-collapse collapse in" aria-expanded="true" >
                <c:forEach var="p" items="${produtos}" varStatus="j">
                    <c:if test="${p.categoriaProduto.codigo == c.codigo}">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <c:if test="${p.imagem != ''}">
                                        <img src="${contexto}/imgs/imgsRestaurante/${p.imagem}" class="img-circle pull-left" style="margin-top: 0px; border-radius: 0px;" alt="">
                                    </c:if>
                                    <span class="preco"><fmt:formatNumber type="currency" value="${p.preco}"/></span>
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
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty categorias}">
    <div class="text-center">
        <h4>Nenhum produto encontrado</h4>
    </div>
</c:if>