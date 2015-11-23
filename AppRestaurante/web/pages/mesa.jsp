<%-- 
    Document   : mesa
    Created on : 30/10/2015, 10:41:09
    Author     : isaias
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:if test="${!empty mesas}">
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
                        <c:if test="${m.cancelado == false}"> 
                            <a href="javascript:;" style="padding: 5px 5px" title="Excluir" class="btn btn-danger" onclick="excluirMesaModal(${m.codigo});">
                                <i class="glyphicon glyphicon-trash"></i>										
                            </a>
                        </c:if>
                        <c:if test="${m.cancelado == true}"> 
                            <a href="javascript:;" style="padding: 5px 5px" title="Reativar" class="btn btn-success" onclick="reativarMesa(${m.codigo});">
                                <i class="glyphicon glyphicon-repeat"></i>										
                            </a>
                        </c:if>

                            <a href="javascript:;" style="padding: 5px 5px" title="Imprimir QR Code" class="btn btn-default" onclick="gerarRelatorio(${m.codigo},${m.numero});">
                            <i class="glyphicon glyphicon-qrcode"></i>										
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty mesas}">
    <div class="text-center">
        <h4>Nenhuma mesa cadastrada</h4>
    </div>
</c:if>
