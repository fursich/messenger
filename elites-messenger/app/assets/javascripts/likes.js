$(function(){

    $('.emotion-icons-row').hide();

    $('.per').mouseenter(function(){
        $(this).find('.emotion-icons-row').slideDown('fast');
    })
    $('.per').mouseleave(function(){
        $(this).find('.emotion-icons-row').slideUp('fast');
    })


    $('.emotion-icon').on('ajax:complete', function(event, data, status){
        
        if (status=='success') {

            var jsonData = JSON.parse(data.responseText);
            
            // console.log(jsonData.t_id);
            // console.log(jsonData.likes_count_html);

            if (jsonData.saved=='true') {

                var unselectedBtn = $(".clickable-like-link-"+jsonData.t_id+" .selected");
                unselectedBtn.removeClass("selected");
                unselectedBtn.addClass("not-selected");
                if (jsonData.b_id != 0) {
                    var selectedBtn = $(".clickable-like-link-"+jsonData.t_id+" .emotion-icon:nth-child("+jsonData.active_button+")");
                    selectedBtn.removeClass("not-selected");
                    selectedBtn.addClass("selected");
                }

                if ( jsonData.likes_count_html != null) {
                    $(".likes-counter-"+jsonData.t_id).html(jsonData.likes_count_html);
                } else {
                    $(".likes-counter-"+jsonData.t_id).empty();
                }
            } else {
                console.log ("save failure");
            }
        }
        
    });

});


