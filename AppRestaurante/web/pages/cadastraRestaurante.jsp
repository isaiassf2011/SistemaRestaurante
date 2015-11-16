<%-- 
    Document   : cadastraRestaurante
    Created on : 06/11/2015, 14:28:44
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
        <link rel="stylesheet" href="${contexto}/bootstrap/css/bootstrap.min.css" type="text/css"/>
        <link href="${contexto}/css/estiloLogin.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>

        <style>
            .msgmodal-container {
                padding: 5px;
                max-width: 350px;
                width: 100% !important;
                background-color: #F7F7F7;
                margin: 0 auto;
                border-radius: 2px;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
                overflow: hidden;
                font-family: roboto;
            }
        </style>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#telefone").mask("(99) 9999-9999");
                $("#cnpj").mask("99.999.999/9999-99");
                $("#cep").mask("99.999-999");
            });
            function salvar() {
                var valores = $('#form').serialize();
                console.log(valores);
                //iniciamos o ajax
                $.ajax({
                    //definimos a url
                    url: 'ControllerServlet?acao=salvarRestaurante',
                    //definimos o tipo de requisição
                    type: 'post',
                    //colocamos os valores a serem enviados
                    data: valores + '&lista=json',
                    //antes de enviar ele alerta para esperar
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    //colocamos o retorno na tela
                    success: function (pre) {
                        $("#processing-modal").modal('hide');
                        $("#msgTexto").html("Cadastro Concluido com Sucesso! Encaminhamos um e-mail com sua senha para: " + $("#email").val());
                        $("#msg-modal").modal('show');
                    }
                });
            }
        </script>

    </head>
    <body>
        <div class="container" style="margin-top:40px">
            <div class="row">
                <div class="col-sm-6 col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-heading panel-heading-login">
                            <strong> Cadastre-se!</strong>
                        </div>
                        <div class="panel-body">
                            <form role="form" action="#" method="POST" id="form">
                                <fieldset>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <input id="nome" class="form-control" placeholder="Nome do Restaurante" name="nomeRestaurante" type="text" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input id="cnpj" class="form-control" placeholder="CNPJ do Restaurante" name="cnpjRestaurante" type="text" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input id="telefone" class="form-control" placeholder="Telefone" name="telefone" type="tel" value="">
                                            </div>
                                            <div class="form-group">
                                                <input id="cep" class="form-control" placeholder="CEP" name="cep" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" id="estado" name="estado">
                                                    <c:forEach var="e" varStatus="j" items="${estados}" >
                                                        <option value="${e.codigo}">${e.descricao}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control">
                                                    <option value="none">Cidade</option>
                                                    <option value="1">Florianópoliz</option>
                                                    <option value="2">Santo Amaro da Imperatriz</option>
                                                    <option value="3">Palhoça</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="glyphicon glyphicon-envelope"></i>
                                                    </span>
                                                    <input id="email" class="form-control" placeholder="E-mail" name="email" type="email" value="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <input type="button" class="btn btn-lg btn-primary btn-block" onclick="salvar();" value="Concluir">
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                        <div class="panel-footer text-center">
                            <a href="${contexto}/pages/login.jsp" > Já está cadastrado? </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="msg-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; top: 50% !important; margin-top: -100px;">
                <div class="modal-dialog">
                    <div class="msgmodal-container">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center">
                                <h5 id="msgTexto"></h5>
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
    </body>
</html>
