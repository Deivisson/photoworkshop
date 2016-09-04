$(document).on('ready page:load', function (){
	setLayoutTheme();
	PortfolioMenuClick();
	SetCustomScrollBar();
});

function setLayoutTheme() {
	// $("#dark-layout").click(function(e) {
	// 	//$("#portfolio-template").removeClass("light");
	// 	$("#dark-layout").addClass("selected");
	// 	$("#light-layout").removeClass("selected");
	// 	//e.preventDefault();
	// });
	// $("#light-layout").click(function(e) {
	// 	//$("#portfolio-template").addClass("light");
	// 	$("#dark-layout").removeClass("selected");
	// 	$("#light-layout").addClass("selected");
	// 	//e.preventDefault();
	// });
}

function PortfolioMenuClick() {
	$(".portfolio-menu-item").click(function(){
		$(".portfolio-menu-item").removeClass("active");
		$(this).addClass("active");
		//alert("Ok");
	});
}

function SetCustomScrollBar(){
	if ($("#portfolio-simple-image-thumbs").length > 0) {
		$("#portfolio-simple-image-thumbs").mCustomScrollbar();
	}
}