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
        <link href="${contexto}/css/estiloMsgErro.css" rel="stylesheet">
        <link href="${contexto}/css/estiloInicial.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <script src="${contexto}/js/validaCampos.js" type="text/javascript"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

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

                $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                    return arg !== value;
                }, "Value must not equal arg.");

                $.validator.addMethod("cnpj", function (cnpj, element) {

                    return validarCNPJ(cnpj);

                }, "Informe um CNPJ válido."); // Mensagem padrão

                $("#formRestaurante").validate({
                    ignore: ":hidden",
                    rules: {
                        nomeRestaurante: {
                            required: true
                        },
                        cnpjRestaurante: {
                            required: true,
                            cnpj: true
                        },
                        cep: {
                            required: true
                        },
                        estado: {
                            valueNotEquals: "0"
                        },
                        municipio: {
                            valueNotEquals: "0"
                        },
                        email: {
                            required: true,
                            email: true
                        }
                    },
                    messages: {
                        nomeRestaurante: {
                            required: "Digite o nome do restaurante"
                        },
                        cnpjRestaurante: {
                            required: "Digite o CNPJ do restaurante",
                            cnpj: "CNPJ inválido"
                        },
                        cep: {
                            required: "Digite o CEP"
                        },
                        estado: {
                            valueNotEquals: "Selecione o Estado"
                        },
                        municipio: {
                            valueNotEquals: "Selecione o Municipio"
                        },
                        email: {
                            required: "Digite o E-mail",
                            email: "Digite um e-mail válido"
                        }
                    },
                    submitHandler: function (form) {
                        salvar();
                        return false;
                    }
                });

            });

            function montaComboMunicipio(codigoEstado) {

                $.ajax({
                    url: 'ControllerServlet?acao=montaComboMucicipio',
                    type: 'post',
                    data: '&codigoEstado=' + codigoEstado,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divMunicipio").html(data);
                    }
                });
            }

            function salvar() {
                var valores = $('#formRestaurante').serialize();
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

        <div id="divCabecalhoInicial">
            <jsp:include page="/cabecalhoInicial.jsp" flush="true"></jsp:include>
            </div>

            <div class="container" style="margin-top:60px">
                <div class="row">
                    <div class="col-sm-6 col-md-4 col-md-offset-4">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-login">
                                <strong> Cadastre-se!</strong>
                            </div>
                            <div class="panel-body">
                                <form role="form" action="" method="POST" id="formRestaurante">
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
                                                    <select class="form-control" id="estado" name="estado" onchange="montaComboMunicipio(this.value)">
                                                    <c:forEach var="e" varStatus="j" items="${estados}" >
                                                        <option value="${e.codigo}">${e.descricao}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <div id="divMunicipio">
                                                    <jsp:include page="/pages/municipio.jsp" flush="true"></jsp:include>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <input id="email" class="form-control" placeholder="E-mail" name="email" type="email" value="">
                                                </div>
                                                <div class="form-group">
                                                    <input type="submit" class="btn btn-lg btn-primary btn-block" value="Concluir">
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="panel-footer text-center">
                                <a href="${contexto}" > Já está cadastrado? </a>
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

        <div id="divRodape">
            <jsp:include page="/rodape.jsp"></jsp:include>
        </div>
    </body>
</html>
