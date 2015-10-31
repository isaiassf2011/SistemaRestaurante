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
                <img src="${contexto}/imgs/${p.imagem}" class="img-circle pull-left" style="
                     margin-top: 0px;" alt="">
                <span class="preco">R$ ${p.preco}</span>
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
</c:forEach>

