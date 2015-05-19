$(document).ready(function(){
    $("button").click(function(){
        var id =$(this).attr("id")
        $('#'+id+"div").toggle();
        // $('.comment').toggle();
    });
});