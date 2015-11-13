<%-- 
    Document   : pedidoRestaurante
    Created on : 12/11/2015, 19:59:24
    Author     : isaias_sergio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contexto" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${contexto}/bootstrap/css/bootstrap.min.css" type="text/css"/>
        <link href="${contexto}/css/estiloLogin.css" rel="stylesheet">
        <link href="${contexto}/css/estilo.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${contexto}/js/bootstrap-filestyle.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {
                $(".btn-pref .btn").click(function() {
                    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below 
                    $(this).removeClass("btn-default").addClass("btn-primary");
                });

                $('#pendenteMenu').click(function(evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#pendenteMenu').addClass('active');
                    $('#pronto').hide();
                    $('#cancelado').hide();
                    $('#pendente').show();
                });

                $('#prontoMenu').click(function(evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#prontoMenu').addClass('active');
                    $('#pendente').hide();
                    $('#cancelado').hide();
                    $('#pronto').show();
                });

                $('#canceladoMenu').click(function(evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#canceladoMenu').addClass('active');
                    $('#pendente').hide();
                    $('#pronto').hide();
                    $('#cancelado').show();
                });

                $('.button-checkbox').each(function() {

                    // Settings
                    var $widget = $(this),
                            $button = $widget.find('button'),
                            $checkbox = $widget.find('input:checkbox'),
                            color = $button.data('color'),
                            settings = {
                                on: {
                                    icon: 'glyphicon glyphicon-check'
                                },
                                off: {
                                    icon: 'glyphicon glyphicon-unchecked'
                                }
                            };

                    // Event Handlers
                    $button.on('click', function() {
                        $checkbox.prop('checked', !$checkbox.is(':checked'));
                        $checkbox.triggerHandler('change');
                        updateDisplay();
                    });
                    $checkbox.on('change', function() {
                        updateDisplay();
                    });

                    // Actions
                    function updateDisplay() {
                        var isChecked = $checkbox.is(':checked');

                        // Set the button's state
                        $button.data('state', (isChecked) ? "on" : "off");

                        // Set the button's icon
                        $button.find('.state-icon')
                                .removeClass()
                                .addClass('state-icon ' + settings[$button.data('state')].icon);

                        // Update the button's color
                        if (isChecked) {
                            $button
                                    .removeClass('btn-default')
                                    .addClass('btn-' + color + ' active');
                        }
                        else {
                            $button
                                    .removeClass('btn-' + color + ' active')
                                    .addClass('btn-default');
                        }
                    }

                    // Initialization
                    function init() {

                        updateDisplay();

                        // Inject the icon if applicable
                        if ($button.find('.state-icon').length == 0) {
                            $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
                        }
                    }
                    init();
                });

            });

        </script>

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
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="pedido.html">Pedidos</a></li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="Logado como: Lanchonete do Zé">
                                <span class="glyphicon glyphicon-cog"></span>
                                Configurações
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="principal.html">Cardapio</a></li>
                                <li><a href="principal.html">Mesas</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="Logado como: Lanchonete do Zé">
                                <img alt="" src="http://www.manentti.com.br/slir/w300-h226/img/servicosLogoFiora.png" style="width: 25px;"> Perfil    
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="perfil.html">Ver Perfil</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><span class="glyphicon glyphicon-log-in"></span> Sair</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container"  style="margin-top:65px">
            <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <a id="following" class="btn btn-primary" data-toggle="tab"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                        <div class="hidden-xs">Pedidos</div>
                    </a>
                </div>
            </div>

            <div class="well" style="padding: 5px;">
                <div class="tab-content">

                    <div class="tab-pane fade in active" id="tab3">
                        <div class="panel-group" id="accordionPedido">

                            <div class="panel panel-default">
                                <div id="collapseOnePedido" class="panel-collapse collapse in" >
                                    <div id="custom_carousel" class="carousel" data-ride="carousel">
                                        <div class="controls">
                                            <ul class="nav">
                                                <li id="pendenteMenu" data-target="#custom_carousel" data-slide-to="0" class="active"><a href="#"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><small>Pendentes</small></a></li>
                                                <li id="prontoMenu"  data-target="#custom_carousel" data-slide-to="1"><a href="#" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span><small>Feitos</small></a></li>
                                                <li id="canceladoMenu"  data-target="#custom_carousel" data-slide-to="2"><a href="#"><img src="../imgs/caixa.png" alt=""><small>Caixa</small></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div id="pendente">
                                        <div class="panel-pedido-head" style="text-align: right;">
                                            <h5 style="margin-right: 5px;">Mesa</h5>
                                        </div>
                                        <div id="divPendentes">
                                            <jsp:include page="/pages/pedidoPendente.jsp"></jsp:include>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success" style="padding: 4px 12px">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <a href="javascript:;" style="padding: 6px 6px" title="Excluir" class="btn btn-danger">
                                                        <i class="glyphicon glyphicon-trash"></i>										
                                                    </a>
                                                    <span style="margin-right: 15px; margin-left: 15px;">3</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">Coca-Lata</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success" style="padding: 4px 12px">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <a href="javascript:;" style="padding: 6px 6px" title="Excluir" class="btn btn-danger">
                                                        <i class="glyphicon glyphicon-trash"></i>										
                                                    </a>
                                                    <span style="margin-right: 15px; margin-left: 15px;">3</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">Coca-Lata</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="pronto" style="display: none;">
                                        <div class="panel-pedido-head" style="text-align: right;">
                                            <h5 style="margin-right: 5px;">Mesa</h5>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <span style="margin-right: 15px; margin-left: 15px;">1</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">X-Salada</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <span style="margin-right: 15px; margin-left: 15px;">1</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">X-Burguer</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <span style="margin-right: 15px; margin-left: 15px;">3</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">Coca-Lata</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="padding: 6px;">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <span class="button-checkbox">
                                                        <button type="button" class="btn" data-color="success">Feito</button>
                                                        <input type="checkbox" class="hidden" />
                                                    </span>
                                                    <span style="margin-right: 15px; margin-left: 15px;">5</span>
                                                </div>
                                                <div class="col-xs-12">
                                                    <span style="margin-left: 5px;">X-Salada</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="cancelado" style="display: none;">
                                        <div class="panel-group" id="accordionCardapio">
                                            <div id="custom-search-input">
                                                <div class="input-group col-md-12">
                                                    <input type="text" class="form-control" placeholder="Buscar mesa" />
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
                                                            Mesa 1
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseOne" class="panel-collapse collapse in" >
                                                    <div class="panel-body" style="padding: 6px;">
                                                        <div class="row">
                                                            <div class="col-md-8 col-xs-8" style="font-size: 13px;">
                                                                <a href="javascript:;" class="btn btn-small btn-danger" style="padding: 4px 4px;">
                                                                    <i class="glyphicon glyphicon-minus" style="position: initial;"></i>										
                                                                </a>
                                                                <span>10</span>
                                                                <a href="javascript:;" class="btn btn-small btn-success" style="padding: 4px 4px;">
                                                                    <i class="glyphicon glyphicon-plus" style="position: initial;"></i>										
                                                                </a>
                                                                <span title="6ª Feira 6ª Feira6ª Feira6ª">Lanche Especial da Casa</span>
                                                            </div>
                                                            <div class="col-md-4 col-xs-4 preco">
                                                                <span>R$ 10,00</span>
                                                            </div>
                                                        </div>
                                                    </div><!--/.panel-body -->
                                                    <div class="panel-car-total">
                                                        <span>Total à pagar:</span>
                                                        <strong class="subTotal">R$ 25,00</strong>
                                                    </div>
                                                    <div class="panel-car-footer">
                                                        <button class="btn btn-lg btn-primary btn-block"  name="Submit" value="Login" type="Submit">Finalizar Pedido</button> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->

                        </div><!-- /.panel-group -->
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
