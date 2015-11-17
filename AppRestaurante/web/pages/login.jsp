<%-- 
    Document   : login
    Created on : 05/11/2015, 10:48:59
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

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <script src="${contexto}/js/validaCampos.js" type="text/javascript"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#cnpj").mask("99.999.999/9999-99");

                $.validator.addMethod("cnpj", function (cnpj, element) {

                    return validarCNPJ(cnpj);

                }, "Informe um CNPJ válido."); // Mensagem padrão

                $("#formLogin").validate({
                    ignore: ":hidden",
                    rules: {
                        cnpj: {
                            required: true,
                            cnpj: true
                        },
                        senha: {
                            required: true
                        }
                    },
                    messages: {
                        cnpj: {
                            required: "Digite o CNPJ do restaurante",
                            cnpj: "CNPJ inválido"
                        },
                        senha: {
                            required: "Digite sua senha"
                        }
                    },
                    submitHandler: function (form) {
                        efetuarLogin();
                        return false;
                    }
                });

            });
            
            function validarFormulario() {
                $('#erroLogin').html("");
            }

            function efetuarLogin() {
                var valores = $('#formLogin').serialize();
                console.log(valores);
                //iniciamos o ajax
                $.ajax({
                    //definimos a url
                    url: '../ControllerServlet?acao=autenticaRestaurante',
                    //definimos o tipo de requisição
                    type: 'post',
                    //colocamos os valores a serem enviados
                    data: valores,
                    //antes de enviar ele alerta para esperar
                    beforeSend: function () {

                    },
                    //colocamos o retorno na tela
                    success: function (json) {
                        if (json.ok === "S") {
                            location.href = "../ControllerServlet?acao=listarCardapio";
                        } else {
                            $('#erroLogin').html("Usuario/Senha incorretos!");
                        }
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
                            <strong> Já sou cadastrado!</strong>
                        </div>
                        <div class="panel-body">
                            <form role="form" action="#" method="POST" id="formLogin" onsubmit="validarFormulario(); return false;">
                                <fieldset>
                                    <div class="row">
                                        <div class="center-block">
                                            <img class="profile-img"
                                                 src="https://amanditaamorim.files.wordpress.com/2012/03/logo-rgb-300-dpis.jpg" alt="">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <input id="cnpj" class="form-control" placeholder="CNPJ" name="cnpj" type="text" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Senha" name="senha" type="password" value="">
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" class="btn btn-lg btn-primary btn-block" value="Entrar" >
                                                <button id="login_lost_btn" type="button" class="btn btn-link" style="margin-left: -10px;">Esqueceu sua senha?</button>
                                                <h5 id="erroLogin" for="cnpj" style="color: red;" class="text-center"></h5>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                        <div class="panel-footer ">
                            Ainda não está cadastrado? <a href="../ControllerServlet?acao=cadastrarRestaurante" > Cadastre-se </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
