<%-- 
    Document   : cabecalho
    Created on : 04/11/2015, 20:50:18
    Author     : isaias_sergio
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contexto" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>                        
            </button>
            <a class="navbar-brand" href="#">ChegouPediu</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="pedido.html">Pedidos</a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" >
                        <span class="glyphicon glyphicon-cog"></span>
                        Configurações
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="ControllerServlet?acao=listarCardapio">Cardapio</a></li>
                        <li><a href="ControllerServlet?acao=listarCardapio">Mesas</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="Logado como: ${sessionScope.restaurante.nome}">
                        <c:if test="${sessionScope.restaurante.logo != ''}">
                            <img alt="" src="${contexto}/imgs/${sessionScope.restaurante.logo}" id="menuLogo" style="width: 18px;"> Perfil
                        </c:if>
                        <c:if test="${sessionScope.restaurante.logo == ''}">
                            <img alt="" src="${contexto}/imgs/sem_imagem.jpg" id="menuLogo" style="width: 18px;"> Perfil
                        </c:if>
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="ControllerServlet?acao=buscarRestaurante">Ver Perfil</a></li>
                    </ul>
                </li>
                <li>
                    <a href="LogoffServlet"><span class="glyphicon glyphicon-log-in"></span> Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
