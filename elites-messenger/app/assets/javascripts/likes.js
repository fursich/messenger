$(function(){

    $('.clickale-like-link a').on('ajax:complete', function(event, data, status){
        
        if (status=='success') {

            var jsonData = JSON.parse(data.responseText);

            $(".likes-counter-"+jsonData.t_id).html(jsonData.likes_count_html);
            $(".clickable-like-link-"+jsonData.t_id).empty();
        }
        
    });

});


