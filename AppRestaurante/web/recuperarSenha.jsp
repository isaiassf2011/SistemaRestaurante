<%-- 
    Document   : recuperarSenha
    Created on : 19/11/2015, 00:37:49
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
        <link href="${contexto}/css/estiloMsgErro.css" rel="stylesheet">
        <link href="${contexto}/css/estiloInicial.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <script src="${contexto}/js/validaCampos.js" type="text/javascript"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">
            $(document).ready(function () {
                $("#cnpj").mask("99.999.999/9999-99");

                $.validator.addMethod("cnpj", function (cnpj, element) {

                    if (cnpj !== "") {
                        return validarCNPJ(cnpj);
                    }

                }, "Informe um CNPJ válido.");

                $("#formRecuperarSenha").validate({
                    ignore: ":hidden",
                    rules: {
                        cnpj: {
                            required: true,
                            cnpj: true
                        },
                        email: {
                            required: true,
                            email: true
                        }
                    },
                    messages: {
                        cnpj: {
                            required: "Digite o CNPJ do restaurante",
                            cnpj: "CNPJ inválido"
                        },
                        email: {
                            required: "Digite o E-mail",
                            email: "Digite um e-mail válido"
                        }
                    },
                    submitHandler: function (form) {
                        recuperarSenha();
                        return false;
                    }
                });

            });

            function validarFormulario() {
                $('#erroLogin').html("");
            }

            function recuperarSenha() {

                var valores = $('#formRecuperarSenha').serialize();
                console.log(valores);
                $.ajax({
                    url: 'ControllerServlet?acao=recuperarSenha',
                    type: 'post',
                    data: valores,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (json) {
                        $("#processing-modal").modal('hide');
                        if (json.ok === "S") {
                            $("#formRecuperarSenha")[0].reset();
                            $("#erroLogin").css('color', 'green');
                            $("#erroLogin").html(json.msg);
                        } else {
                            $("#erroLogin").css('color', 'red');
                            $('#erroLogin').html(json.msg);
                        }
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
                                <strong> Recuperar senha!</strong>
                            </div>
                            <div class="panel-body">
                                <form role="form" action="#" method="POST" id="formRecuperarSenha" onsubmit="validarFormulario();
                                        return false;">
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                                <div class="form-group">
                                                    <input id="cnpj" class="form-control" placeholder="CNPJ" name="cnpj" type="text" autofocus>
                                                </div>
                                                <div class="form-group">
                                                    <input id="email" class="form-control" placeholder="E-mail" name="email" type="email" value="">
                                                </div>
                                                <div class="form-group">
                                                    <input type="submit" class="btn btn-lg btn-primary btn-block" value="Recuperar" >
                                                    <h5 id="erroLogin" for="cnpj" style="color: red;" class="text-center"></h5>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="panel-footer ">
                                Lembrou sua senha? <a href="${contexto}" > Entrar </a>
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
                                <img src="${contexto}/imgs/imgsSistema/loading.gif" class="icon" />
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
