<%-- 
    Document   : produto
    Created on : 25/10/2015, 16:32:22
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:forEach var="c" items="${categorias}" varStatus="i">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="collapsed" data-toggle="collapse" href="#categoria${c.codigo}" onclick="buscarProdutos(${c.codigo});">
                    ${c.descricao}
                </a>
            </h4>
        </div>
        <div id="categoria${c.codigo}" class="panel-collapse collapse" >
            <jsp:include page="/pages/produto.jsp"></jsp:include>
        </div>
    </div>
</c:forEach>

