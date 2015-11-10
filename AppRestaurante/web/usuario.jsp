<%-- 
    Document   : usuario
    Created on : 02/11/2015, 18:36:55
    Author     : isaias
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


        <script type="text/javascript">
            $(document).ready(function () {
                $(".btn-pref .btn").click(function () {
                    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below 
                    $(this).removeClass("btn-default").addClass("btn-primary");
                });
            });

            function buscarProdutos(codigoCategoria) {
                var classe = $("#categoria" + codigoCategoria).attr("class");

                if (classe === "panel-collapse collapse") {
                    $.ajax({
                        url: 'ControllerServlet?acao=listarProdutosUsuario',
                        type: 'POST',
                        data: '&codigoCategoria=' + codigoCategoria,
                        beforeSend: function () {
                            $("#processing-modal").modal('show');
                        },
                        success: function (data) {
                            $("#processing-modal").modal('hide');
                            jQuery("#categoria" + codigoCategoria).html(data);
                        }
                    });
                }

            }

            function addItemCarrinho(codigoProduto) {

                $.ajax({
                    url: 'ControllerServlet?acao=addItemCarrinho',
                    type: 'POST',
                    data: '&codigoProduto=' + codigoProduto,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divCarrinho").html(data);
                        $(".badge").html($("#totalDeItens").val());
                    }
                });

            }

        </script>
    </head>
    <body>

        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">ChegouPediu</a>
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
                            <div class="panel-group" id="accordionCardapio">
                                <jsp:include page="/pages/categoriaUsuario.jsp"></jsp:include>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade in" id="tab2">
                            <div class="panel-car-head">
                                <i class="glyphicon glyphicon-shopping-cart"></i>
                                <span>Seu Pedido</span>
                            </div>
                            <div id="divCarrinho">
                                <jsp:include page="/pages/carrinho.jsp"></jsp:include>
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

                <div class="modal modal-static fade" style="position: fixed; top: 50% !important; 
                     left: 50% !important; margin-top: -100px;  
                     margin-left: -100px; 
                     overflow: visible !important;" id="processing-modal" role="dialog" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-body">
                                <div class="text-center">
                                    <img src="http://www.travislayne.com/images/loading.gif" class="icon" />
                                    <h4>Carregando...</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                
            </div>

            <div id="divRodape">
            <jsp:include page="/rodape.jsp"></jsp:include>
        </div>

    </body>
</html>
