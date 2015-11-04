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

        <script type="text/javascript">
            $(document).ready(function () {

                $('#arquivo').change(function () {
                    var reader = new FileReader();
                    $(reader).load(function (event) {
                        $("#imgProduto").attr("src", event.target.result);
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
                    data: valores,
                    //antes de enviar ele alerta para esperar
                    beforeSend: function () {

                    },
                    //colocamos o retorno na tela
                    success: function (pre) {
                        alert("Cadastrado");
                    }
                });
            }

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

        <div class="container" style="margin-top:65px">
            <div class="row">
                <div class="col-sm-6 col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-heading panel-heading-login">
                            <strong> Meu Perfil!</strong>
                        </div>
                        <div style="padding: 15px;">
                            <form role="form" action="../MeuServlet" method="POST" id="form">
                                <input type="hidden" id="caminho" name="logo" value=""/>
                                <fieldset>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <img src="" class="img-circle pull-left" style="
                                                     margin-top: 0px;margin-left: 35%;" alt="" id="imgProduto">
                                                <a href="javascript:;" style="padding: 1px 4px" title="Remover Imagem">
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
                                                <input class="form-control" placeholder="Telefone" name="telefone" type="tel" value="${restaurante.telefone}">
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="CEP" name="cep" type="text" value="${restaurante.cep}">
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control">
                                                    <option value="none" >Estado</option>
                                                    <option value="1" selected="">SC</option>
                                                    <option value="2">SP</option>
                                                    <option value="3">RS</option>
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
    </body>
</html>
