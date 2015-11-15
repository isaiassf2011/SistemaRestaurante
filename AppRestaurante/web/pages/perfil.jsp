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

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${contexto}/js/bootstrap-filestyle.min.js"></script>
        <script src="${contexto}/js/jquery.form.js" type="text/javascript"></script>
        <script src="${contexto}/js/upload.js" type="text/javascript"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
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
                    $('#arquivo').closest("form").submit();
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

            function salvar() {
                var valores = $('#form').serialize();
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

                    },
                    //colocamos o retorno na tela
                    success: function (pre) {
                        //$('#divCabecalho').load("cabecalho.jsp");
                        alert("Cadastrado");
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
                                <form role="form" action="MeuServlet" method="POST" id="form">
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
                                                    <input class="form-control" placeholder="E-mail" name="email" type="email" value="${restaurante.email}">
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
                    </div>
                </div>
            </div>
        </div>

        <div id="divRodape">
            <jsp:include page="/rodape.jsp"></jsp:include>
        </div>

    </body>
</html>
