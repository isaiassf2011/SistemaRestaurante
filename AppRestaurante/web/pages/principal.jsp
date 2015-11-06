<%-- 
    Document   : principal
    Created on : 23/10/2015, 22:30:57
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
        <link href="${contexto}/bootstrap/css/full-width-pics.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

        <script type="text/javascript">
            $(document).ready(function() {
                $(".btn-pref .btn").click(function() {
                    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below 
                    $(this).removeClass("btn-default").addClass("btn-primary");
                });

                $('#arquivo').change(function() {
                    var reader = new FileReader();
                    $(reader).load(function(event) {
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

            function limparMesa() {
                $("#formMesa")[0].reset();
                $('#codigoMesa').val("");
            }

            function limparProduto() {
                $("#form")[0].reset();
                $('#codigoProduto').val("");
                $('#caminho').val("");
                $('#imgProduto').attr('src', "${contexto}/imgs/produto-sem-imagem.gif");
            }

            function removerImagem() {
                $(":file").filestyle('clear');
                $('#caminho').val("");
                $('#imgProduto').attr('src', "${contexto}/imgs/produto-sem-imagem.gif");
            }

            function salvar() {
                var valores = $('#form').serialize();
                console.log(valores);
                //iniciamos o ajax
                $.ajax({
                    //definimos a url
                    url: 'ControllerServlet?acao=salvarProduto',
                    //definimos o tipo de requisição
                    type: 'POST',
                    //colocamos os valores a serem enviados
                    data: valores,
                    //antes de enviar ele alerta para esperar
                    beforeSend: function() {
                        $("#processing-modal").modal('show');
                    },
                    //colocamos o retorno na tela
                    success: function(data) {
                        $("#form")[0].reset();
                        $('#codigoProduto').val("");
                        removerImagem();
                        $("#processing-modal").modal('hide');
                        jQuery("#accordionCardapio").html(data);
                        //alert("Cadastrado");
                    }
                });
            }

            function salvarMesa() {
                var valores = $('#formMesa').serialize();
                console.log(valores);

                $.ajax({
                    url: 'ControllerServlet?acao=salvarMesa',
                    type: 'POST',
                    data: valores,
                    beforeSend: function() {
                        $("#processing-modal").modal('show');
                    },
                    success: function(data) {
                        $("#formMesa")[0].reset();
                        $('#codigoMesa').val("");
                        $("#processing-modal").modal('hide');
                        jQuery("#divMesas").html(data);
                        //alert("Cadastrado");
                    }
                });
            }

            function buscarMesa(codigoMesa) {

                $.ajax({
                    url: 'ControllerServlet?acao=buscarMesa',
                    type: 'POST',
                    data: '&codigoMesa=' + codigoMesa,
                    beforeSend: function() {
                        //$("#processing-modal").modal('show');
                    },
                    success: function(json) {
                        $("#numeroMesa").val(json.numero);
                        $('#codigoMesa').val(codigoMesa);
                        //$("#processing-modal").modal('hide');
                    }
                });

            }

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

            function buscarProdutos(codigoCategoria) {
                var classe = $("#categoria" + codigoCategoria).attr("class");

                if (classe === "panel-collapse collapse") {
                    $.ajax({
                        url: 'ControllerServlet?acao=listarProdutos',
                        type: 'POST',
                        data: '&codigoCategoria=' + codigoCategoria,
                        beforeSend: function() {
                            $("#processing-modal").modal('show');
                        },
                        success: function(data) {
                            $("#processing-modal").modal('hide');
                            jQuery("#categoria" + codigoCategoria).html(data);
                        }
                    });
                }

            }

            function buscarCategorias(codigoRestaurante) {

                $.ajax({
                    url: 'ControllerServlet?acao=listarCategorias',
                    type: 'POST',
                    data: '&codigoRestaurante=' + codigoRestaurante,
                    beforeSend: function() {
                    },
                    success: function(data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#accordionCardapio").html(data);
                    }
                });

            }

            function buscarProduto(codigoProduto) {

                $.ajax({
                    url: 'ControllerServlet?acao=buscarProduto',
                    type: 'POST',
                    data: '&codigoProduto=' + codigoProduto,
                    beforeSend: function() {
                        //$("#processing-modal").modal('show');
                    },
                    success: function(json) {
                        //$("#processing-modal").modal('hide');
                        $("#nomePreduto").val(json.nome);
                        $('#caminho').val(json.imagem);
                        if (json.imagem === "") {
                            $("#imgProduto").attr("src", "${contexto}/imgs/produto-sem-imagem.gif");
                        } else {
                            $("#imgProduto").attr("src", "${contexto}/imgs/" + json.imagem);
                        }
                        $("#descricao").val(json.descricao);
                        $("#preco").val(json.preco);
                        $("#cmbCategoria").val(json.categoria);
                        $('#codigoProduto').val(codigoProduto);
                    }
                });

            }

            function excluirProduto(codigoProduto, codigoCategoria) {

                $.ajax({
                    url: 'ControllerServlet?acao=excluirProduto',
                    type: 'POST',
                    data: '&codigoProduto=' + codigoProduto,
                    beforeSend: function() {
                        $("#processing-modal").modal('show');
                    },
                    success: function(data) {
                        if (data === "") {
                            buscarCategorias(1);
                        } else {
                            $("#processing-modal").modal('hide');
                            jQuery("#categoria" + codigoCategoria).html(data);
                        }
                        //alert("Produto Excluido com sucesso!");
                    }
                });

            }

            function excluirMesa(codigoMesa) {

                $.ajax({
                    url: 'ControllerServlet?acao=excluirMesa',
                    type: 'POST',
                    data: '&codigoMesa=' + codigoMesa,
                    beforeSend: function() {
                        $("#processing-modal").modal('show');
                    },
                    success: function(data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divMesas").html(data);
                    }
                });

            }

        </script>

    </head>
    <body>

        <div id="divCabecalho">
            <jsp:include page="/cabecalho.jsp" flush="true"></jsp:include>
            </div>

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
                                <button class="btn btn-primary" data-toggle="modal" data-target="#login-modal" onclick="limparProduto();"><i class="glyphicon glyphicon-plus-sign"></i> Adicionar Produto</button> 
                            </div>
                            <div class="panel-group" id="accordionCardapio">
                            <jsp:include page="/pages/categoria.jsp"></jsp:include>
                            </div>
                        </div>
                        <div class="tab-pane fade in" id="tab2">
                            <div style="padding: 5px 0px;">
                                <button class="btn btn-primary" data-toggle="modal" data-target="#mesa-modal" onclick="limparMesa();"><i class="glyphicon glyphicon-plus-sign"></i> Adicionar Mesa</button> 
                            </div>
                            <div id="divMesas">
                            <jsp:include page="/pages/mesa.jsp"></jsp:include>
                            </div>
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
                                <form role="form" action="MeuServlet" method="POST" id="form">
                                    <input type="hidden" id="caminho" name="imagem" value=""/>
                                    <input type="hidden" id="codigoProduto" name="codigoProduto" value=""/>
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                                <div class="form-group">
                                                    <img src="${contexto}/imgs/produto-sem-imagem.gif" class="img-circle pull-left" style="
                                                     margin-top: 0px;margin-left: 35%;" alt="" id="imgProduto">
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
                                                <input class="form-control" placeholder="Nome do Produto" name="nomeProduto" id="nomePreduto" type="text" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Descrição" name="descricao" id="descricao" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Preço" name="preco" id="preco" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" name="cmbCategoria" id="cmbCategoria">
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
                            <form role="form" action="#" method="POST" id="formMesa">
                                <fieldset>
                                    <input type="hidden" id="codigoMesa" name="codigoMesa" value=""/>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Número" name="numeroMesa" id="numeroMesa" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <input type="button" class="btn btn-lg btn-primary btn-block" onclick="salvarMesa();" value="Adicionar">
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

