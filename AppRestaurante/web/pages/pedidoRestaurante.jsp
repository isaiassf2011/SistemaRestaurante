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
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">
            $(document).ready(function () {
                $(".btn-pref .btn").click(function () {
                    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below 
                    $(this).removeClass("btn-default").addClass("btn-primary");
                });

                $('#pendenteMenu').click(function (evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#pendenteMenu').addClass('active');
                    $('#pronto').hide();
                    $('#cancelado').hide();
                    $('#pendente').show();
                });

                $('#prontoMenu').click(function (evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#prontoMenu').addClass('active');
                    $('#pendente').hide();
                    $('#cancelado').hide();
                    $('#pronto').show();
                });

                $('#canceladoMenu').click(function (evt) {
                    $('#custom_carousel .controls li.active').removeClass('active');
                    $('#canceladoMenu').addClass('active');
                    $('#pendente').hide();
                    $('#pronto').hide();
                    $('#cancelado').show();
                });

                $('.button-checkbox').each(function () {

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
                    $button.on('click', function () {
                        $checkbox.prop('checked', !$checkbox.is(':checked'));
                        $checkbox.triggerHandler('change');
                        updateDisplay();
                    });
                    $checkbox.on('change', function () {
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

            function finalizarItem(codigoItem) {

                $.ajax({
                    url: 'ControllerServlet?acao=finalizarItemPedido',
                    type: 'POST',
                    data: '&codigoItem=' + codigoItem,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divPendentes").html(data);
                    }
                });

            }

            function listarItensProntos() {

                $.ajax({
                    url: 'ControllerServlet?acao=listarItensProntos',
                    type: 'POST',
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divProntos").html(data);
                    }
                });

            }

            function listarItensPendentes() {

                $.ajax({
                    url: 'ControllerServlet?acao=listarItensPendentes',
                    type: 'POST',
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divPendentes").html(data);
                    }
                });

            }


            function listarPedidosCaixa() {

                $.ajax({
                    url: 'ControllerServlet?acao=listarPedidosCaixa',
                    type: 'POST',
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divCaixa").html(data);
                    }
                });

            }
        </script>

    </head>
    <body>

        <div id="divCabecalho">
            <jsp:include page="/cabecalho.jsp" flush="true"></jsp:include>
            </div>

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
                                                    <li id="pendenteMenu" data-target="#custom_carousel" data-slide-to="0" class="active" onclick="listarItensPendentes();"><a href="#"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span><small>Pendentes</small></a></li>
                                                    <li id="prontoMenu"  data-target="#custom_carousel" data-slide-to="1" onclick="listarItensProntos();"><a href="#" ><span class="glyphicon glyphicon-ok" aria-hidden="true"></span><small>Feitos</small></a></li>
                                                    <li id="canceladoMenu"  data-target="#custom_carousel" data-slide-to="2" onclick="listarPedidosCaixa();"><a href="#"><img src="${contexto}/imgs/caixa.png" alt=""><small>Caixa</small></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div id="pendente">
                                        <div id="divPendentes">
                                            <jsp:include page="/pages/pedidoPendente.jsp"></jsp:include>
                                            </div>
                                        </div>

                                        <div id="pronto" style="display: none;">
                                            <div id="divProntos">
                                            <jsp:include page="/pages/pedidoFeito.jsp"></jsp:include>
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
                                                <div id="divCaixa">
                                                <jsp:include page="/pages/pedidoMesa.jsp"></jsp:include>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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

