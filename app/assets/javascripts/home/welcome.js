
$(document).on('ready page:load', function (){
  var link;
  resizeContainer();

  // Default move to top
  $('html,body').animate({scrollTop: 0},250);
	$('#how-work-link, #made-for-who-link, #top-link, #professionals-link,#sign-up-link, #welcome-contact-us-link, #welcome-contact-us-link2').click(function(event) {
   
    $(".how_work,.made-for-who,.professionals,.sign-up-container,.contact-us").css("visibility","visible");

    link = $(this);
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

  $("#welcome-contact-us-link, #welcome-contact-us-link2").click(function() {
    $("#contact-name-field").focus();
  });

  // Resize windows
  $( window ).resize(function() {
    resizeContainer();
    link.click();
  });
});

function resizeContainer() {
  var value = $(window).height() ;
  $('#welcome-cover,#welcome-cover-mask, #welcome-how-work, #welcome-made-for-who, #welcome-professionals, #welcome-sign-up, #welcome-contact-us').height(value);
  $('#welcome-how-work').css("margin-top",value);
  $('#welcome-content').css("margin-top",value - $('#welcome-content').height() + 50);
}