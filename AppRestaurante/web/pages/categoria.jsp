<%-- 
    Document   : produto
    Created on : 25/10/2015, 16:32:22
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<c:forEach var="c" items="${categorias}" varStatus="i">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="" data-toggle="collapse" href="#categoria${c.codigo}" onclick="buscarProdutos(${c.codigo});" aria-expanded="true">
                    ${c.descricao}
                </a>
            </h4>
        </div>
        <div id="categoria${c.codigo}" class="panel-collapse collapse in" aria-expanded="true">
            <c:forEach var="p" items="${produtos}" varStatus="j">
                <c:if test="${p.categoriaProduto.codigo == c.codigo}">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-12 text-right">
                                <c:if test="${p.imagem != ''}">
                                    <img src="${contexto}/imgs/${p.imagem}" class="img-circle pull-left" style="
                                         margin-top: 0px;" alt="">
                                </c:if>
                                <span class="preco"><fmt:formatNumber type="currency" value="${p.preco}"/></span>
                                <button style="padding: 5px 5px" title="Editar produto" class="btn btn-primary" data-toggle="modal" data-target="#login-modal" onclick="buscarProduto(${p.codigo});">
                                    <i class="glyphicon glyphicon-pencil"></i>										
                                </button>
                                <a href="javascript:;" style="padding: 5px 5px" title="Excluir produto" class="btn btn-danger" onclick="excluirProduto(${p.codigo}, ${p.categoriaProduto.codigo});">
                                    <i class="glyphicon glyphicon-trash"></i>										
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

