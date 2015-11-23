<%-- 
    Document   : relatorioPedido
    Created on : 21/11/2015, 12:54:57
    Author     : isaias
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
        <link href="${contexto}/css/estiloMsgErro.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${contexto}/js/bootstrap-filestyle.min.js"></script>
        <script src="${contexto}/js/jquery.form.js" type="text/javascript"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">

            $(document).ready(function () {

                $("#formRelatorio").validate({
                    ignore: ":hidden",
                    rules: {
                        dataInicial: {
                            required: true
                        },
                        dataFinal: {
                            required: true
                        }
                    },
                    messages: {
                        dataInicial: {
                            required: "Digite a data Inicial"
                        },
                        dataFinal: {
                            required: "Digite a data Final"
                        }
                    },
                    submitHandler: function (form) {
                        gerarRelatorio($('#dataInicial').val(), $('#dataFinal').val());
                        return false;
                    }
                });

            });

            function gerarRelatorio(dataInicial, dataFinal) {

                location.href = "ControllerServlet?acao=relatorioPedidoPeriodo&dt_inicial="+dataInicial+"&dt_final="+dataFinal;

            }
        </script>

    </head>
    <body>

        <div id="divCabecalho">
            <jsp:include page="/cabecalho.jsp"></jsp:include>
            </div>

            <div class="container" style="margin-top:65px">
                <div class="row">
                    <div class="col-sm-6 col-md-4 col-md-offset-4">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-login">
                                <strong> Relatório de Pedidos por Periodo!</strong>
                            </div>
                            <div style="padding: 15px;">
                                <form role="form" action="#" method="POST" id="formRelatorio">
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                                <div class="form-group">
                                                    <label for="dataInicial">Data Inicial:</label>
                                                    <input class="form-control" placeholder="Data Inicial" name="dataInicial" id="dataInicial" type="date" autofocus>
                                                </div>
                                                <div class="form-group">
                                                    <label for="dataFinal">Data Final:</label>
                                                    <input class="form-control" placeholder="Data Final" name="dataFinal" id="dataFinal" type="date" autofocus>
                                                </div>
                                                <div class="form-group">
                                                    <h5 id="msgSucessoPerfil" style="color: green; font-weight: bold;"></h5>
                                                </div>
                                                <div class="form-group">
                                                    <input type="submit" class="btn btn-lg btn-primary btn-block" value="Gerar">
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
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
