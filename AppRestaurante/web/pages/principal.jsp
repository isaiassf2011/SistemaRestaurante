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
        <link href="${contexto}/css/estiloMsgErro.css" rel="stylesheet">

        <script src="${contexto}/js/jquery-1.11.3.min.js"></script>
        <script src="${contexto}/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${contexto}/js/bootstrap-filestyle.min.js"></script>
        <script src="${contexto}/js/jquery.form.js" type="text/javascript"></script>
        <script src="${contexto}/js/upload.js" type="text/javascript"></script>
        <script src="${contexto}/js/jquery.maskMoney.js" type="text/javascript"></script>
        <script src="${contexto}/js/jquery.maskedinput.js" type="text/javascript"></script>
        <script language="JavaScript" src="${contexto}/js/jquery.validate.js" type="text/javascript"></script>
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

            var codigoP;
            var codigoC;
            var codMesa;

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

                $("#preco").maskMoney({
                    symbol: 'R$ ',
                    showSymbol: true,
                    thousands: '.',
                    decimal: ','
                });

                $("#formMesa").validate({
                    ignore: ":hidden",
                    rules: {
                        numeroMesa: {
                            required: true,
                            number: true
                        }
                    },
                    messages: {
                        numeroMesa: {
                            required: "Digite o número da mesa",
                            number: "Digite apenas números"
                        }
                    },
                    submitHandler: function (form) {
                        buscarMesaPorNumero($('#codigoMesa').val());
                        return false;
                    }
                });

            });

            function verificaCampos() {

                validarFormulario();
                var erro = false;

                if ($("#nomePreduto").val() === "") {
                    $("#erroNomeProduto").html("Digite o nome do produto");
                    $("#erroNomeProduto").css('display', '');
                    erro = true;
                }else{
                    $("#erroNomeProduto").css('display', 'none');
                }
                if ($("#preco").val() === "") {
                    $("#erroPreco").html("Digite o preço do produto");
                    $("#erroPreco").css('display', '');
                    erro = true;
                }else{
                    $("#erroPreco").css('display', 'none');
                }
                if ($("#cmbCategoria").val() === "") {
                    $("#erroCmbCategoria").html("Selecione uma categoria");
                    $("#erroCmbCategoria").css('display', '');
                    erro = true;
                }else{
                    $("#erroCmbCategoria").css('display', 'none');
                }
                
                if(!erro){
                    salvar();
                }

                
            }

            function limparMesa() {
                $("#formMesa").validate().resetForm();
                $("#formMesa")[0].reset();
                $('#codigoMesa').val("");
                $('#msgSucessoMesa').html("");
            }

            function limparProduto() {
                $("#form").validate().resetForm();
                $("#form")[0].reset();
                $('#codigoProduto').val("");
                $('#msgSucessoProduto').html("");
                removerImagem();
            }

            function removerImagem() {
                $(":file").filestyle('clear');
                $('#caminho').val("");
                $('#imgProduto').attr('src', "${contexto}/imgs/imgsSistema/produto-sem-imagem.gif");
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
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    //colocamos o retorno na tela
                    success: function (data) {
                        if ($('#codigoProduto').val() !== "") {
                            $('#msgSucessoProduto').html("Produto Alterado com Sucesso!");
                        } else {
                            $('#msgSucessoProduto').html("Produto Adicionado com Sucesso!");
                            $("#form")[0].reset();
                            $('#codigoProduto').val("");
                            removerImagem();
                        }
                        $("#processing-modal").modal('hide');
                        jQuery("#accordionCardapio").html(data);
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
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#msgSucessoMesa").css('color', 'green');
                        if ($('#codigoMesa').val() !== "") {
                            $('#msgSucessoMesa').html("Mesa Alterada com Sucesso!");
                        } else {
                            $('#msgSucessoMesa').html("Mesa Adicionada com Sucesso!");
                            $("#formMesa")[0].reset();
                            $('#codigoMesa').val("");
                        }
                        $("#processing-modal").modal('hide');
                        jQuery("#divMesas").html(data);
                    }
                });
            }

            function buscarMesaPorNumero(codigoMesa) {
                $.ajax({
                    url: 'ControllerServlet?acao=buscarMesaNumero',
                    type: 'POST',
                    data: '&codigoMesa=' + codigoMesa +
                            '&numeroMesa=' + $("#numeroMesa").val(),
                    beforeSend: function () {
                        //$("#processing-modal").modal('show');
                    },
                    success: function (json) {
                        if (json.ok === "S") {
                            salvarMesa();
                        } else {
                            $("#msgSucessoMesa").css('color', 'red');
                            $('#msgSucessoMesa').html("Você já possui uma mesa cadastrada com o numero " + $("#numeroMesa").val());
                        }
                        //$("#processing-modal").modal('hide');
                    }
                });

            }

            function buscarMesa(codigoMesa) {
                $("#formMesa").validate().resetForm();
                $.ajax({
                    url: 'ControllerServlet?acao=buscarMesa',
                    type: 'POST',
                    data: '&codigoMesa=' + codigoMesa,
                    beforeSend: function () {
                        //$("#processing-modal").modal('show');
                    },
                    success: function (json) {
                        $('#msgSucessoMesa').html("");
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
                        beforeSend: function () {
                            $("#processing-modal").modal('show');
                        },
                        success: function (data) {
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
                    beforeSend: function () {
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#accordionCardapio").html(data);
                    }
                });

            }

            function buscarProduto(codigoProduto) {
                $("#form").validate().resetForm();
                $.ajax({
                    url: 'ControllerServlet?acao=buscarProduto',
                    type: 'POST',
                    data: '&codigoProduto=' + codigoProduto,
                    beforeSend: function () {
                        //$("#processing-modal").modal('show');
                    },
                    success: function (json) {
                        //$("#processing-modal").modal('hide');
                        $('#msgSucessoProduto').html("");
                        $("#nomePreduto").val(json.nome);
                        $('#caminho').val(json.imagem);
                        if (json.imagem === "") {
                            $("#imgProduto").attr("src", "${contexto}/imgs/imgsSistema/produto-sem-imagem.gif");
                        } else {
                            $("#imgProduto").attr("src", "${contexto}/imgs/imgsRestaurante/" + json.imagem);
                        }
                        $("#descricao").val(json.descricao);
                        $("#preco").val(json.preco);
                        $("#cmbCategoria").val(json.categoria);
                        $('#codigoProduto').val(codigoProduto);
                    }
                });

            }

            function excluirProdutoModal(produto, categoria) {

                codigoP = produto;
                codigoC = categoria;
                $("#excluir-modal").modal('show');

            }

            function excluirProduto(opcao) {

                if (opcao === 1) {
                    $.ajax({
                        url: 'ControllerServlet?acao=excluirProduto',
                        type: 'POST',
                        data: '&codigoProduto=' + codigoP,
                        beforeSend: function () {
                            $("#processing-modal").modal('show');
                        },
                        success: function (data) {
                            $("#excluir-modal").modal('hide');
                            if (data === "") {
                                buscarCategorias(1);
                            } else {
                                $("#processing-modal").modal('hide');
                                jQuery("#categoria" + codigoC).html(data);
                            }
                        }
                    });
                } else {
                    $("#excluir-modal").modal('hide');
                }

            }

            function reativarProduto(produto, categoria) {

                $.ajax({
                    url: 'ControllerServlet?acao=reativarProduto',
                    type: 'POST',
                    data: '&codigoProduto=' + produto,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#categoria" + categoria).html(data);
                    }
                });

            }

            function validarFormulario() {
                $("#barraDeProgresso ").hide();
                $('#msgSucessoProduto').html("");
            }

            function validarFormMesa() {
                $('#msgSucessoMesa').html("");
            }

            function excluirMesaModal(codigoMesa) {

                codMesa = codigoMesa;
                $("#excluirMesa-modal").modal('show');

            }

            function reativarMesa(codigoMesa) {

                $.ajax({
                    url: 'ControllerServlet?acao=reativarMesa',
                    type: 'POST',
                    data: '&codigoMesa=' + codigoMesa,
                    beforeSend: function () {
                        $("#processing-modal").modal('show');
                    },
                    success: function (data) {
                        $("#processing-modal").modal('hide');
                        jQuery("#divMesas").html(data);
                    }
                });

            }

            function excluirMesa(opcao) {

                if (opcao === 1) {
                    $.ajax({
                        url: 'ControllerServlet?acao=excluirMesa',
                        type: 'POST',
                        data: '&codigoMesa=' + codMesa,
                        beforeSend: function () {
                            $("#processing-modal").modal('show');
                        },
                        success: function (data) {
                            $("#processing-modal").modal('hide');
                            $("#excluirMesa-modal").modal('hide');
                            jQuery("#divMesas").html(data);
                        }
                    });
                } else {
                    $("#excluirMesa-modal").modal('hide');
                }

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
                                                    <img src="${contexto}/imgs/imgsSistema/produto-sem-imagem.gif" class="img-circle pull-left" style="
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
                                                <label id="erroNomeProduto" for="nomeProduto" class="error"></label>
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Descrição" name="descricao" id="descricao" type="text" >
                                            </div>
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Preço" name="preco" id="preco" type="text" >
                                                <label id="erroPreco" for="preco" class="error"></label>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control" name="cmbCategoria" id="cmbCategoria">
                                                    <option value="">Selecione a Categoria</option>
                                                    <c:forEach var="lc" items="${listaCategorias}" varStatus="i">
                                                        <option value="${lc.codigo}">${lc.descricao}</option>
                                                    </c:forEach>
                                                </select>
                                                <label id="erroCmbCategoria" for="cmbCategoria" class="error"></label>
                                            </div>
                                            <div class="form-group">
                                                <h5 id="msgSucessoProduto" style="color: green; font-weight: bold;"></h5>
                                            </div>
                                            <div class="form-group">
                                                <input type="button" class="btn btn-lg btn-primary btn-block" onclick="verificaCampos();" value="Concluir">
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
                            <form role="form" action="" method="POST" id="formMesa" onsubmit="validarFormMesa();
                                    return false;">
                                <fieldset>
                                    <input type="hidden" id="codigoMesa" name="codigoMesa" value=""/>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <input class="form-control" placeholder="Número" name="numeroMesa" id="numeroMesa" type="text" value="">
                                            </div>
                                            <div class="form-group">
                                                <h5 id="msgSucessoMesa" style="color: green; font-weight: bold;"></h5>
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

            <div class="modal fade" id="excluir-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; top: 50% !important; margin-top: -100px;">
                <div class="modal-dialog">
                    <div class="msgmodal-container">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center">
                                <h5 id="msgTexto" >Deseja Realmente excluir esse produto?</h5>
                                <input type="button" class="btn btn-lg btn-primary btn-block" value="Sim" onclick="excluirProduto(1);">
                                <input type="button" class="btn btn-lg btn-danger btn-block" value="Não" onclick="excluirProduto(0);">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="excluirMesa-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; top: 50% !important; margin-top: -100px;">
                <div class="modal-dialog">
                    <div class="msgmodal-container">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;">
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center">
                                <h5 id="msgTexto" >Deseja Realmente excluir essa mesa?</h5>
                                <input type="button" class="btn btn-lg btn-primary btn-block" value="Sim" onclick="excluirMesa(1);">
                                <input type="button" class="btn btn-lg btn-danger btn-block" value="Não" onclick="excluirMesa(0);">
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

