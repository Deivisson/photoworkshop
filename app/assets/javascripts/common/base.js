$(document).on('ready page:load', function (){

	// User Menu
	$("#menu-trigger").click(function(e){
		closeAllMenus();
		e.stopPropagation();
		menuTrigger($('#menu-dropdown'));
	});

	// Notification Menu
	$("#notifications-menu-trigger").click(function(e){
		closeAllMenus();
		if ($("#notification-bubble-count").length == 0) {
			e.stopPropagation();	
		}
		menuTrigger($('#notifications-menu-dropdown'));
	});


	function menuTrigger(elemId) {
		if ($(elemId).is('.open-menu')) {
			$(elemId).removeClass("open-menu");
			jQuery(document).off("click"); 
		} else {
			$(elemId).addClass("open-menu");
			jQuery(document).on("click", function() {
        $(elemId).removeClass("open-menu");
      });
		}
	}

	// Close all menu
	function closeAllMenus() 
	{
		if($('#notifications-menu-dropdown').length > 0) {
			$('#notifications-menu-dropdown').removeClass("open-menu");
		}
		if($('#menu-dropdown').length > 0) {
			$('#menu-dropdown').removeClass("open-menu");
		}
	}

	$(function(){
    if ($("#flash_notice").length > 0 || $("#flash_warning").length > 0 || $("#flash_alert").length > 0)  {
      setTimeout(removeFlashMenssage,7000);
    }
  });
});

function removeFlashMenssage() {
  $("#flash_notice").remove();
  $("#flash_warning").remove();
  $("#flash_alert").remove();  
}