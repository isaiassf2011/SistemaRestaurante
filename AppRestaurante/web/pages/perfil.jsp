<%-- 
    Document   : perfil
    Created on : 03/11/2015, 10:28:26
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
        <script src="${contexto}/js/upload.js" type="text/javascript"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
        <script src="${contexto}/js/validaCampos.js" type="text/javascript"></script>
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">
            $(document).ready(function () {

                $('#arquivo').change(function () {
                    var reader = new FileReader();
                    $(reader).load(function (event) {
                        $("#imgRestaurante").attr("src", event.target.result);
                        $("#menuLogo").attr("src", event.target.result);
                    });
                    reader.readAsDataURL(event.target.files[0]);
                    $('#arquivo').closest("formPeril").submit();
                });

                $(":file").filestyle({
                    input: false,
                    buttonText: 'Adicionar Imagem',
                    badge: false,
                    size: "sm"
                });

                $("#telefone").mask("(99) 9999-9999");
                $("#cnpj").mask("99.999.999/9999-99");
                $("#cep").mask("99.999-999");

                $.validator.addMethod("valueNotEquals", function (value, element, arg) {
                    return arg !== value;
                }, "Value must not equal arg.");

                $.validator.addMethod("cnpj", function (cnpj, element) {

                    return validarCNPJ(cnpj);

                }, "Informe um CNPJ válido."); // Mensagem padrão

                $("#formPeril").validate({
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

            /*
             function deletarImg() {
             
             $.ajax({
             url: 'ControllerServlet?acao=removerImagem',
             type: 'POST',
             data: '&imagem=' + $('#caminho').val(),
             beforeSend: function () {
             },
             success: function (data) {
             }
             });
             
             }*/

            function removerImagem() {
                $(":file").filestyle('clear');
                $('#caminho').val("");
                $("#menuLogo").attr("src", "${contexto}/imgs/imgsSistema/sem_imagem.jpg");
                $('#imgRestaurante').attr('src', "${contexto}/imgs/imgsSistema/sem_imagem.jpg");
            }

            function validarFormulario() {
                $("#msgSucessoPerfil").html("");
            }

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
                var valores = $('#formPeril').serialize();
                console.log(valores);
                //iniciamos o ajax
                $.ajax({
                    //definimos a url
                    url: 'ControllerServlet?acao=alterarRestaurante',
                    //definimos o tipo de requisição
                    type: 'post',
                    //colocamos os valores a serem enviados
                    data: valores,
                    //antes de enviar ele alerta para esperar
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    //colocamos o retorno na tela
                    success: function (pre) {
                        $("#processing-modal").modal('hide');
                        $('#msgSucessoPerfil').html("Informações alteradas com Sucesso!");
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
                                <strong> Meu Perfil!</strong>
                            </div>
                            <div style="padding: 15px;">
                                <form role="form" action="MeuServlet" method="POST" id="formPeril" onsubmit="validarFormulario();
                                        return false;">
                                    <input type="hidden" id="caminho" name="logo" value="${restaurante.logo}"/>
                                <input type="hidden" id="codigoRestaurante" name="codigoRestaurante" value="1"/>
                                <fieldset>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <c:if test="${restaurante.logo != ''}">
                                                    <img src="${contexto}/imgs/imgsRestaurante/${restaurante.logo}" class="img-circle pull-left" style="
                                                         margin-top: 0px;margin-left: 35%;" alt="" id="imgRestaurante">
                                                </c:if>
                                                <c:if test="${restaurante.logo == ''}">
                                                    <img src="${contexto}/imgs/imgsSistema/sem_imagem.jpg" class="img-circle pull-left" style="
                                                         margin-top: 0px;margin-left: 35%;" alt="" id="imgRestaurante">
                                                </c:if>
                                                <a href="javascript:;" style="padding: 1px 4px" onclick="removerImagem();" title="Remover Imagem">
                                                    <i class="glyphicon glyphicon-trash" style="margin-top: 40px;"></i>
                                                </a>
                                            </div>
                                            <div class="form-group">
                                                <input type="file" class="form-control" id="arquivo" name="file" >
                                            </div>
                                            <div class="form-group" id="barraDeProgresso" style="display: none;">
                                                <progress value="0" max="100" style="width: 110px;"></progress><span id="porcentagem">0%</span>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Nome do Restaurante" name="nomeRestaurante" type="text" value="${restaurante.nome}" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input id="cnpj" class="form-control" placeholder="CNPJ do Restaurante" name="cnpjRestaurante" type="text" value="${restaurante.cnpj}" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input id="telefone" class="form-control" placeholder="Telefone" name="telefone" type="tel" value="${restaurante.telefone}">
                                            </div>
                                            <div class="form-group">
                                                <input id="cep" class="form-control" placeholder="CEP" name="cep" type="text" value="${restaurante.cep}">
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" id="estado" name="estado">
                                                    <c:forEach var="e" varStatus="j" items="${estados}" >
                                                        <option value="${e.codigo}" <c:if test="${e.codigo == restaurante.estado.codigo}">selected="selected"</c:if>>${e.descricao}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <div id="divMunicipio">
                                                    <select class="form-control" id="municipio" name="municipio">
                                                        <option value="0">Selecione o Municipio</option>
                                                        <c:forEach var="m" items="${municipios}" varStatus="i">
                                                            <option value="${m.codigo}" <c:if test="${m.codigo == restaurante.municipio.codigo}">selected="selected"</c:if>>${m.descricao}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="E-mail" name="email" type="email" value="${restaurante.email}">
                                            </div>
                                            <div class="form-group">
                                                <h5 id="msgSucessoPerfil" style="color: green; font-weight: bold;"></h5>
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" class="btn btn-lg btn-primary btn-block" value="Concluir">
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
