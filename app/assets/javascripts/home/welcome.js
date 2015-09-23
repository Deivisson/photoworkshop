
$(document).ready(function(){

	var value = $(window).height() ;
	$('#welcome-cover, #welcome-how-work, #welcome-made-for-who, #welcome-professionals, #welcome-sign-up').height(value);
	$('#welcome-how-work').css("margin-top",value);
	$('#welcome-content').css("margin-top",value - $('#welcome-content').height() + 50);

    // Default move to top
    $('html,body').animate({scrollTop: top},250);

	$('#how-work-link, #made-for-who-link, #top-link, #professionals-link, #sign-up-link').click(function(event) {
		var link = $(this);
		var linkId = link.attr("id");
		var top = (linkId == "top-link" ? 0 : $("#"+link.attr("target")).offset().top);
		
		$(".step").removeClass("hover");
		$("#welcome-header").removeClass("dark");

		$("#menu-home").find("li > a").removeClass("selected");
		link.addClass("selected");
        $('html,body').animate({scrollTop: top},250, function(){
        	
        	//Efect on click How Work link
        	if (linkId == "how-work-link")	{
        		$("#step1").addClass("hover");
        	} else if(linkId == "professionals-link") {
        		$("#welcome-header").addClass("dark");
        		$("#pic-professionals").addClass("showed");
        		$("#professionals-text-box").addClass("showed-text-box");
        	}  else if(linkId == "sign-up-link") {
                $("#sign-up-box").addClass("showed");
        		$("#welcome-header").addClass("dark");
                $("#user-full-name").focus();
        	}
        		
        });
        event.preventDefault();
	});

	//Remover hover class from all .step element
	$(".step ").mouseenter(function(){
    $(".step").removeClass("hover");
  });
});
