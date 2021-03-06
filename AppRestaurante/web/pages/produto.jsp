<%-- 
    Document   : produto
    Created on : 25/10/2015, 16:32:35
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
                    <img src="${contexto}/imgs/imgsRestaurante/${p.imagem}" class="img-circle pull-left" style="
                         margin-top: 0px;" alt="">
                </c:if>
                <span class="preco"><fmt:formatNumber type="currency" value="${p.preco}"/></span>
                <button style="padding: 5px 5px" title="Editar produto" class="btn btn-primary" data-toggle="modal" data-target="#login-modal" onclick="buscarProduto(${p.codigo});">
                    <i class="glyphicon glyphicon-pencil"></i>										
                </button>
                <c:if test="${p.cancelado == false}">    
                    <a href="javascript:;" style="padding: 5px 5px" title="Excluir produto" class="btn btn-danger" onclick="excluirProdutoModal(${p.codigo}, ${p.categoriaProduto.codigo});">
                        <i class="glyphicon glyphicon-trash"></i>										
                    </a>
                </c:if>
                <c:if test="${p.cancelado == true}">    
                    <a href="javascript:;" style="padding: 5px 5px" title="Reativar produto" class="btn btn-success" onclick="reativarProduto(${p.codigo}, ${p.categoriaProduto.codigo});">
                        <i class="glyphicon glyphicon-repeat"></i>										
                    </a>
                </c:if>  
            </div>
            <div class="col-xs-12">
                <h5><b>${p.nome}</b></h5>
                <p style="font-size: 12px;">${p.descricao}</p>
            </div>
        </div>
    </div>
</c:forEach>

