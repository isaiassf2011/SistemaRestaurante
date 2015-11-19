<%-- 
    Document   : municipio
    Created on : 19/11/2015, 14:45:09
    Author     : brd03-pc
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />

<select class="form-control" id="municipio" name="municipio">
    <option value="0">Selecione o Municipio</option>
    <c:forEach var="m" items="${municipios}" varStatus="i">
        <option value="${m.codigo}">${m.descricao}</option>
    </c:forEach>
</select>
