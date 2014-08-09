$(document).ready(function(){
	var value = $(window).height() ;
	$('div[id*="welcome-cover-"]').height(value);
	//$('#welcome-how-work').height(value);
	$('#welcome-how-work').css("margin-top",value);
	$('#welcome-content').css("margin-top",value - $('#welcome-content').height());
});
