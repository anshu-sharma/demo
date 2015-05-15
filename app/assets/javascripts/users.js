$(document).ready(function(){
	$("#search_btn").click(function(){
		var text = $("#search").val();
		$.get('users/search_user',{val: text},function(data){
			$(".users").html(data);
		});
	});

$('#search').keyup(function(){
	var text = $("#search").val();
		$.get('users/search_user',{val: text},function(data){
			$(".users").html(data);
		});
});

$("#imagesize").click(function(){
	$(this).height(800);
    $(this).width(800);
  
});
// $("#imagesize").click(function PopupPic(sPicURL) {
// 	sPicURL=@user.avatar.url
// window.open("popup.htm?"+sPicURL, "","resizable=1,HEIGHT=200,WIDTH=200");
// } 
// });
// $("#imagesize").click(function(){
// 	window.open(testimage);
// })

});
