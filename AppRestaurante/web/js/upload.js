
$('#form').ajaxForm({
    beforeSerialize: function ($form, options) {
        deletarImg();
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
        $('#caminho').val(json.caminho);
        //$('#imgProduto').attr('src', json.caminho+"?"+ new Date().getTime());
    }

});