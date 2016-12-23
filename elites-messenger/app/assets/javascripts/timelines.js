$(function(){

    $('form.input_message_form input.post').click(function(e){
        var form = $('form.input_message_form');
        form.removeAttr('data-remote');
        form.removeData('remote');
        form.attr('action', form.attr('action').replace('.json',''));
    });

    $('form.input_message_form').on('ajax:complete', function(event, data, status){
        
        if (status=='success') {
            var json = JSON.parse(data.responseText);
            if (json.js_error == null) {
                $('div.timeline').prepend($(json.timeline));
            } else {
                $('.html-alert').empty();
                $('.js-alert').empty();
                $('.js-alert').append($('<p>'+json.js_error+'</p>'));
            }
        }
        
    });

});


