$(document).on('ready page:load', function (){
	$(".order-menu-item").click(function(){
		$("#orders-menu > li").removeClass("selected");
		$(this).addClass("selected");
	});
});