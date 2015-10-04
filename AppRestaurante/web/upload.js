
$('#barraDeProgresso').show();
$('#form').ajaxForm({
    uploadProgress: function (event, position, total, percentComplete) {
        $('progress').attr('value', percentComplete);
        $('#porcentagem').html(percentComplete + '%');
    },
    success: function (json) {
        $('progress').attr('value', '100');
        $('#porcentagem').html('100%');
        $('#barraDeProgresso').hide();
        $('#imgProduto').attr('src', json.caminho);
    }

});