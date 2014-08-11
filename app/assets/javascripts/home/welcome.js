$(document).ready(function(){
	var value = $(window).height() ;
	$('#welcome-cover, #welcome-how-work, #welcome-jurors').height(value);
	//$('#welcome-jurors').height(value);
	$('#welcome-how-work').css("margin-top",value);
	$('#welcome-content').css("margin-top",value - $('#welcome-content').height());


	$('#how-work-link').click(function(){
    $('html,body').animate({scrollTop: $('#welcome-how-work').offset().top},'easeInSine');
	});

	$('#jurors-link').click(function(){
    $('html,body').animate({scrollTop:$("#welcome-jurors").offset().top},'easeInSine');
  });

});
