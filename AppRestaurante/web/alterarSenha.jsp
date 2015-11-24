
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
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">
            $(document).ready(function () {

                $("#formAlterarSenha").validate({
                    ignore: ":hidden",
                    rules: {
                        senhaAtual: {
                            required: true,
                            minlength: 6
                        },
                        novaSenha: {
                            required: true,
                            minlength: 6
                        },
                        confirmarNovaSenha: {
                            required: true,
                            minlength: 6
                        }
                    },
                    messages: {
                        senhaAtual: {
                            required: "Digite sua Senha Atual",
                            minlength: "A Senha Atual deve conter no mínimo 6 caracteres"
                        },
                        novaSenha: {
                            required: "Digite a Nova Senha",
                            minlength: "A Nova Senha deve conter no mínimo 6 caracteres"
                        }
                        ,
                        confirmarNovaSenha: {
                            required: "Digite a Nova Senha novamente",
                            minlength: "A Nova Senha deve conter no mínimo 6 caracteres"
                        }
                    },
                    submitHandler: function (form) {
                        salvarNovaSenha();
                        return false;
                    }
                });

            });

            function validarFormulario() {
                $("#msgSenha").html("");
            }

            function salvarNovaSenha() {
                var valores = $('#formAlterarSenha').serialize();
                console.log(valores);
                $.ajax({
                    url: 'ControllerServlet?acao=alterarSenha',
                    type: 'post',
                    data: valores,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (json) {
                        $("#processing-modal").modal('hide');
                        if (json.ok === '400') {
                            window.location.reload();
                        } else if (json.ok === 'S') {
                            $("#formAlterarSenha")[0].reset();
                            $("#msgSenha").css('color', 'green');
                            $("#msgSenha").html(json.msg);
                        } else {
                            $("#msgSenha").css('color', 'red');
                            $('#msgSenha').html(json.msg);
                        }
                    }
                });
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
                                <strong> Alterar Senha!</strong>
                            </div>
                            <div style="padding: 15px;">
                                <form role="form" action="#" method="POST" id="formAlterarSenha" onsubmit="validarFormulario();
                                        return false;">
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                                <div class="form-group">
                                                    <label for="senhaAtual">Senha Atual:</label>
                                                    <input class="form-control" placeholder="Senha Atual" name="senhaAtual" id="senhaAtual" type="password" autofocus>
                                                </div>
                                                <div class="form-group">
                                                    <label for="novaSenha">Nova Senha:</label>
                                                    <input class="form-control" placeholder="Nova Senha" name="novaSenha" id="novaSenha" type="password">
                                                </div>
                                                <div class="form-group">
                                                    <label for="confirmarNovaSenha">Confirmar Nova Senha:</label>
                                                    <input class="form-control" placeholder="Confirmar Nova Senha" name="confirmarNovaSenha" id="confirmarNovaSenha" type="password">
                                                </div>
                                                <div class="form-group">
                                                    <input type="submit" class="btn btn-lg btn-primary btn-block" value="Salvar">
                                                    <h5 id="msgSenha" style="color: red;" class="text-center"></h5>
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
