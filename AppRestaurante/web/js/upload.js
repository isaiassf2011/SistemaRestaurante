
$('#form').ajaxForm({
    beforeSerialize: function ($form, options) {
        $('#barraDeProgresso').show();
    },
    uploadProgress: function (event, position, total, percentComplete) {
        $('progress').attr('value', percentComplete);
        $('#porcentagem').html(percentComplete + '%');
    },
    success: function (json) {
        $('progress').attr('value', '100');
        $('#porcentagem').html('100%');
        //$('#btnExcluir').show();
        $('#barraDeProgresso').hide();
        //$('#imgProduto').attr('src', json.caminho+"?"+ new Date().getTime());
    }

});