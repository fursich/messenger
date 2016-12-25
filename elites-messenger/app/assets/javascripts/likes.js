$(function(){

    $('.clickale-like-link a').on('ajax:complete', function(event, data, status){
        
        if (status=='success') {

            var jsonData = JSON.parse(data.responseText);
            
            // console.log(jsonData.t_id);
            // console.log(jsonData.likes_count_html);

            if (jsonData.saved=='true') {
                $(".likes-counter-"+jsonData.t_id).html(jsonData.likes_count_html);
                $(".clickable-like-link-"+jsonData.t_id).empty();
            }
        }
        
    });

});


