$(document).on('ready page:load', function (){
	$(".category-item").click(function() {
		$(".category-item").removeClass("selected");
		$(this).addClass("selected");
	})
});
