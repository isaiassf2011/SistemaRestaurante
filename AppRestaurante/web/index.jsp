<%-- 
    Document   : index
    Created on : 06/11/2015, 14:06:27
    Author     : brd03-pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <title>Bootstrap Case</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${contexto}/css/estilo.css" rel="stylesheet">
        <link rel="stylesheet" href="${contexto}/bootstrap/css/bootstrap.min.css" type="text/css"/>
        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

    </head>
    <body>

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
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="ControllerServlet?acao=cadastrarRestaurante">Cadastre-se</a></li>
                        <li><a href="pages/login.jsp">Entrar</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container" style="margin-top:40px">
            <div class="card hovercard">
                <div class="useravatar">
                    <img alt="" src="http://www.manentti.com.br/slir/w300-h226/img/servicosLogoFiora.png">
                    <p class="card-title btn-breadcrumb">Restaurante</p>
                </div>
            </div>
            <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <a id="stars" class="btn btn-primary" href="#tab1" data-toggle="tab"><span class="glyphicon glyphicon-cutlery" aria-hidden="true"></span>
                        <div class="hidden-xs">Cardapio</div>
                    </a>
                </div>
                <div class="btn-group" role="group">
                    <a id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
                        <span class="badge" style="background-color: rgb(4, 115, 18); color: white; padding: 2px 4px;"
                              title="Número de produtos que você pediu">0</span>
                        <div class="hidden-xs" style="margin-right: 25px;">Pedido</div>
                    </a>
                </div>
                <div class="btn-group" role="group">
                    <a id="following" class="btn btn-default" href="#tab3" data-toggle="tab"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        <div class="hidden-xs">Sobre</div>
                    </a>
                </div>
            </div>

            <div class="well" style="padding: 3px;">
                <div class="tab-content">
                    <div class="tab-pane fade in active" id="tab1">
                        <div class="panel-group" id="accordion">

                            <div id="custom-search-input">
                                <div class="input-group col-md-12">
                                    <input type="text" class="form-control" placeholder="Buscar produto" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-info" type="button">
                                            <i class="glyphicon glyphicon-search"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#collapseOne">
                                            Bebidas
                                        </a>
                                    </h4>
                                </div><!--/.panel-heading -->
                                <div id="collapseOne" class="panel-collapse collapse in" onclick="location.href = '#';" style="cursor: pointer;">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12 text-right">
                                                <img src="http://pizzarialacapanna.com.br/wp-content/uploads/2014/10/coca_cola_2l.png" class="img-circle pull-left" style="
                                                     margin-top: 0px; border-radius: 0px;" alt="">
                                                <span class="preco"><b>R$ 10,00</b></span>
                                                <a href="javascript:;" class="btn btn-small btn-success" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-plus"></i>										
                                                </a>
                                            </div>
                                            <div class="col-xs-12">
                                                <h5><b>Coca-Cola</b></h5>
                                                <p style="font-size: 12px;">Arroz, Feijão, Macarrão, Fritas e Salada. Escolha a carne.</p>
                                            </div>
                                        </div>
                                    </div><!--/.panel-body -->
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseTwo">
                                            Porções
                                        </a>
                                    </h4>
                                </div><!--/.panel-heading -->
                                <div id="collapseTwo" class="panel-collapse collapse" onclick="location.href = '#';" style="cursor: pointer;">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12 text-right">
                                                <span class="preco">R$ 10,00</span>
                                                <a href="javascript:;" class="btn btn-small btn-primary" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-plus"></i>										
                                                </a>
                                            </div>
                                            <div class="col-xs-12">
                                                <h4>6ª Feira</h4>
                                                <p>Arroz, Feijão, Macarrão, Fritas e Salada. Escolha a carne.</p>
                                            </div>
                                        </div>
                                    </div><!--/.panel-body -->
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseThree">
                                            Lanches
                                        </a>
                                    </h4>
                                </div><!--/.panel-heading -->
                                <div id="collapseThree" class="panel-collapse collapse" onclick="location.href = '#';" style="cursor: pointer;">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12 text-right">
                                                <span class="preco">R$ 10,00</span>
                                                <a href="javascript:;" class="btn btn-small btn-primary" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-plus"></i>										
                                                </a>
                                            </div>
                                            <div class="col-xs-12">
                                                <h4>6ª Feira</h4>
                                                <p>Arroz, Feijão, Macarrão, Fritas e Salada. Escolha a carne.</p>
                                            </div>
                                        </div>
                                    </div><!--/.panel-body -->
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->
                        </div><!-- /.panel-group -->

                    </div>
                    <div class="tab-pane fade in" id="tab2">
                        <div class="panel-car-head">
                            <i class="glyphicon glyphicon-shopping-cart"></i>
                            <span>Seu Pedido</span>
                        </div>
                        <div class="panel-car">
                            <div class="row">
                                <div class="col-md-8 col-xs-8 btn-breadcrumb">
                                    <a href="javascript:;" class="btn btn-small btn-danger" style="padding: 1px 4px">
                                        <i class="glyphicon glyphicon-minus"></i>										
                                    </a>
                                    <span>10</span>
                                    <a href="javascript:;" class="btn btn-small btn-success" style="padding: 1px 4px">
                                        <i class="glyphicon glyphicon-plus"></i>										
                                    </a>
                                    <span title="6ª Feira 6ª Feira6ª Feira6ª">Lanche Especial da Casa</span>
                                </div>
                                <div class="col-md-4 col-xs-4 preco">
                                    <span>R$ 10,00</span>
                                </div>
                            </div>
                        </div>
                        <div class="panel-car">
                            <div class="row">
                                <div class="col-md-8 col-xs-8 btn-breadcrumb">
                                    <a href="javascript:;" class="btn btn-small btn-danger" style="padding: 1px 4px">
                                        <i class="glyphicon glyphicon-minus"></i>										
                                    </a>
                                    <span>10</span>
                                    <a href="javascript:;" class="btn btn-small btn-success" style="padding: 1px 4px">
                                        <i class="glyphicon glyphicon-plus"></i>										
                                    </a>
                                    <span title="6ª Feira 6ª Feira6ª Feira6ª">Lanche da Casa com Fritas</span>
                                </div>
                                <div class="col-md-4 col-xs-4 preco">
                                    <span>R$ 15,00</span>
                                </div>
                            </div>
                        </div>
                        <div class="panel-car-total">
                            <span>Sub-Total do Pedido</span>
                            <strong class="subTotal">R$ 25,00</strong>
                        </div>
                        <div class="panel-car-footer">
                            <button class="btn btn-lg btn-primary btn-block"  name="Submit" value="Login" type="Submit">Realizar Pedido</button> 
                        </div>
                    </div>
                    <div class="tab-pane fade in" id="tab3">
                        <h3>Horários</h3>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <div>Segunda</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Terça</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Quarta</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Quinta</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Sexta</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Sabado</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                            <li class="list-group-item">
                                <div>Domingo</div>
                                <span>11:00</span> - <span>16:00</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="divRodape">
            <jsp:include page="/rodape.jsp"></jsp:include>
        </div>

    </body>
</html>
