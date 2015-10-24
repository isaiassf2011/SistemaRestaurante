<%-- 
    Document   : principal
    Created on : 23/10/2015, 22:30:57
    Author     : isaias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" type="text/css"/>
        <link href="../css/estiloLogin.css" rel="stylesheet">
        <link href="../css/estilo.css" rel="stylesheet">

        <script src="../js/jquery-1.11.3.min.js"></script>
        <script src="../bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../js/bootstrap-filestyle.min.js"></script>
        <script src="../js/jquery.form.js" type="text/javascript"></script>
        <script src="../js/upload.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(".btn-pref .btn").click(function () {
                    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below 
                    $(this).removeClass("btn-default").addClass("btn-primary");
                });

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

            function salvar() {
                var valores = $('#form').serialize();
                console.log(valores);
                //iniciamos o ajax
                $.ajax({
                    //definimos a url
                    url: '../ControllerServlet?acao=salvarProduto',
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

            function buscarProdutos() {



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
                                <li><a href="#">Ver Perfil</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><span class="glyphicon glyphicon-log-in"></span> Sair</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container"  style="margin-top:65px">
            <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <a id="stars" class="btn btn-primary" href="#tab1" data-toggle="tab"><span class="glyphicon glyphicon-cutlery" aria-hidden="true"></span>
                        <div class="hidden-xs">Cardapio</div>
                    </a>
                </div>
                <div class="btn-group" role="group">
                    <a id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab"><span class="glyphicon glyphicon-th-large" aria-hidden="true"></span>
                        <div class="hidden-xs">Mesas</div>
                    </a>
                </div>
            </div>

            <div class="well" style="padding: 5px;">
                <div class="tab-content">

                    <div class="tab-pane fade in active" id="tab1">
                        <div style="padding: 5px 0px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#login-modal"><i class="glyphicon glyphicon-plus-sign"></i> Adicionar Produto</button> 
                        </div>
                        <div class="panel-group" id="accordionCardapio">

                            <c:forEach var="c" items="${categorias}" varStatus="i">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" href="#collapseOne" onclick="buscarProdutos();">
                                                Bebidas
                                            </a>
                                        </h4>
                                    </div><!--/.panel-heading -->
                                    <div id="collapseOne" class="panel-collapse collapse in" >
                                        <c:forEach var="p" items="${produtos}" varStatus="j">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12 text-right">
                                                        <img src="http://www.bragaburgerq.com.br/wp-content/uploads/2015/01/x-salada1.jpg" class="img-circle pull-left" style="
                                                             margin-top: 0px;" alt="">
                                                        <span class="preco">R$ 10,00</span>
                                                        <a href="javascript:;" style="padding: 5px 5px" data-toggle="modal" data-target="#login-modal" title="Editar produto" class="btn btn-primary">
                                                            <i class="glyphicon glyphicon-pencil"></i>										
                                                        </a>
                                                        <a href="javascript:;" style="padding: 5px 5px" title="Excluir produto" class="btn btn-danger">
                                                            <i class="glyphicon glyphicon-trash"></i>										
                                                        </a>
                                                    </div>
                                                    <div class="col-xs-12">
                                                        <h5><b>X-Salada</b></h5>
                                                        <p style="font-size: 12px;">Pão, amburguer, presunto, queijo, alface e tomate</p>
                                                    </div>
                                                </div>
                                            </div><!--/.panel-body -->
                                        </c:forEach>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-xs-12 text-right">
                                                    <img src="http://www.bigxpicanha.com.br/Content/Produto/Imagem/Big-X-Calabresa-Acebolada-27.png" class="img-circle pull-left" style="
                                                         margin-top: 0px;" alt="">
                                                    <span class="preco">R$ 10,00</span>
                                                    <a href="javascript:;" style="padding: 5px 5px" data-toggle="modal" data-target="#login-modal" title="Editar produto" class="btn btn-primary">
                                                        <i class="glyphicon glyphicon-pencil"></i>										
                                                    </a>
                                                    <a href="javascript:;" style="padding: 5px 5px" title="Excluir produto" class="btn btn-danger">
                                                        <i class="glyphicon glyphicon-trash"></i>										
                                                    </a>
                                                </div>
                                                <div class="col-xs-12">
                                                    <h4>X-Calabresa</h4>
                                                    <p>Pão, amburguer, presunto, queijo e calabresa</p>
                                                </div>
                                            </div>
                                        </div><!--/.panel-body -->
                                    </div><!--/.panel-collapse -->
                                </div><!-- /.panel -->
                            </c:forEach>

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseTwo">
                                            Porções
                                        </a>
                                    </h4>
                                </div><!--/.panel-heading -->
                                <div id="collapseTwo" class="panel-collapse collapse" >
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12 text-right">
                                                <span class="preco">R$ 10,00</span>
                                                <a href="javascript:;" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-pencil"></i>										
                                                </a>
                                                <a href="javascript:;" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-trash"></i>										
                                                </a>
                                            </div>
                                            <div class="col-xs-12">
                                                <h4>6ª Feira</h4>
                                                <p>Arroz, Feijão, Macarrão, Fritas e Salada. Escolha a carne.</p>
                                            </div>
                                        </div>
                                    </div><!--/.panel-body -->
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->

                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseThree">
                                            Lanches
                                        </a>
                                    </h4>
                                </div><!--/.panel-heading -->
                                <div id="collapseThree" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12 text-right">
                                                <span class="preco">R$ 10,00</span>
                                                <a href="javascript:;" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-pencil"></i>										
                                                </a>
                                                <a href="javascript:;" style="padding: 1px 4px">
                                                    <i class="glyphicon glyphicon-trash"></i>										
                                                </a>
                                            </div>
                                            <div class="col-xs-12">
                                                <h4>6ª Feira</h4>
                                                <p>Arroz, Feijão, Macarrão, Fritas e Salada. Escolha a carne.</p>
                                            </div>
                                        </div>
                                    </div><!--/.panel-body -->
                                </div><!--/.panel-collapse -->
                            </div><!-- /.panel -->
                        </div><!-- /.panel-group -->
                    </div>

                    <div class="tab-pane fade in" id="tab2">
                        <div style="padding: 5px 0px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#mesa-modal"><i class="glyphicon glyphicon-plus-sign"></i> Adicionar Mesa</button> 
                        </div>
                        <table class="table table-hover" id="dev-table">
                            <thead>
                                <tr>
                                    <th class="text-center">Nº</th>
                                    <th class="text-center">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-center">
                                    <td>1</td>
                                    <td>
                                        <a href="javascript:;" style="padding: 5px 5px" data-toggle="modal" data-target="#mesa-modal" title="Editar" class="btn btn-primary">
                                            <i class="glyphicon glyphicon-pencil"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 5px 5px" title="Excluir" class="btn btn-danger">
                                            <i class="glyphicon glyphicon-trash"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 5px 5px" title="Imprimir QR Code" class="btn btn-default">
                                            <i class="glyphicon glyphicon-qrcode"></i>										
                                        </a>
                                    </td>
                                </tr>
                                <tr class="text-center">
                                    <td>2</td>
                                    <td><a href="javascript:;" style="padding: 1px 4px" data-toggle="modal" data-target="#mesa-modal" title="Editar">
                                            <i class="glyphicon glyphicon-pencil"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 1px 4px" title="Excluir">
                                            <i class="glyphicon glyphicon-trash"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 1px 4px" title="Imprimir QR Code">
                                            <i class="glyphicon glyphicon-qrcode"></i>										
                                        </a>
                                    </td>
                                </tr>
                                <tr class="text-center">
                                    <td>3</td>
                                    <td><a href="javascript:;" style="padding: 1px 4px" data-toggle="modal" data-target="#mesa-modal" title="Editar">
                                            <i class="glyphicon glyphicon-pencil"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 1px 4px" title="Excluir">
                                            <i class="glyphicon glyphicon-trash"></i>										
                                        </a>
                                        <a href="javascript:;" style="padding: 1px 4px" title="Imprimir QR Code">
                                            <i class="glyphicon glyphicon-qrcode"></i>										
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="loginmodal-container">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                            </button>
                            <h1> Cadastre seus produtos!</h1>
                        </div>
                        <div class="modal-body">
                            <form role="form" action="../MeuServlet" method="POST" id="form">
                                <input type="hidden" id="caminho" name="imagem" value=""/>
                                <fieldset>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <img src="http://localhost:8080/AppRestaurante/imgs/x-salada1.jpg" class="img-circle pull-left" style="
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
                                                <input class="form-control" placeholder="Nome do Produto" name="nomeProduto" type="text" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Descrição" name="descricao" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Preço" name="preco" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" name="cmbCategoria">
                                                    <option value="none">Selecione a Categoria</option>
                                                    <option value="1">Bebida</option>
                                                    <option value="2">Porção</option>
                                                    <option value="3">Massas</option>
                                                    <option value="4">Lanche</option>
                                                </select>
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

            <!-- Mesa -->
            <div class="modal fade" id="mesa-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="loginmodal-container">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                            </button>
                            <h1> Adicione suas mesas!</h1>
                        </div>
                        <div class="modal-body">
                            <form role="form" action="#" method="POST">
                                <fieldset>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Número" name="numero" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" class="btn btn-lg btn-primary btn-block" value="Adicionar">
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
