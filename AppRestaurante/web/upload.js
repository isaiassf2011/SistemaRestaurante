$('#form').ajaxForm({
    uploadProgress: function(event, position, total, percentComplete) {
        $('progress').attr('value', percentComplete);
        $('#porcentagem').html(percentComplete + '%');
    },
    success: function(data) {
        $('progress').attr('value', '100');
        $('#porcentagem').html('100%');
        $('pre').html(data);
    }

});