<%-- 
    Document   : mesa
    Created on : 30/10/2015, 10:41:09
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<table class="table table-hover" id="dev-table">
    <thead>
        <tr>
            <th class="text-center">Nº</th>
            <th class="text-center">Ações</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="m" items="${mesas}" varStatus="i">
            <tr class="text-center">
                <td>${m.numero}</td>
                <td>
                    <a href="javascript:;" style="padding: 5px 5px" data-toggle="modal" data-target="#mesa-modal" 
                       title="Editar" class="btn btn-primary" onclick="buscarMesa(${m.codigo});">
                        <i class="glyphicon glyphicon-pencil"></i>										
                    </a>
                    <a href="javascript:;" style="padding: 5px 5px" title="Excluir" class="btn btn-danger" onclick="excluirMesa(${m.codigo});">
                        <i class="glyphicon glyphicon-trash"></i>										
                    </a>
                    <a href="javascript:;" style="padding: 5px 5px" title="Imprimir QR Code" class="btn btn-default">
                        <i class="glyphicon glyphicon-qrcode"></i>										
                    </a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>