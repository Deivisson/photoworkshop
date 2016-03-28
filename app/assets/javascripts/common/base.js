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
	
	$(function(){
    if ($("#flash_notice").length > 0 || $("#flash_warning").length > 0 || $("#flash_alert").length > 0)  {
      setTimeout(removeFlashMenssage,7000);
    }
  });
	mouseWheelForHorizontalScroll();

	

});

function InitializeTinyMce(){
	tinymce.init({
    mode : "specific_textareas",
    editor_selector : "mceEditor",
    theme: "modern",
    plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern imagetools"
    ],
    toolbar1: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent ",
    toolbar2: "print preview | forecolor backcolor emoticons | link fullscreen",
    image_advtab: true,
    menubar: false,
    toolbar_items_size: 'small'
	});
}

// Popups menu on photo (show Options: Like, Share, Favorit e etc..)
// function PhotoPopupMenuTrigger(){
// 	if ($(".photo-menu-popup-arrow").length > 0) {
// 		$(".photo-menu-popup-arrow").unbind("click");
// 		$(".photo-menu-popup-arrow").bind("click",function(e){
// 			var elementid = $(this).attr("photo-id");
// 			closeAllMenus();
// 			e.stopPropagation();
// 			menuTrigger($("#"+elementid));
// 		});
// 	}
// 	if($(".photo-share-menu-link").length > 0) {
// 		$(".photo-share-menu-link").unbind("click");
// 		$(".photo-share-menu-link").bind("click", function(e) {
// 			e.preventDefault();
// 		});
// 	}
// }


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


// Remove flash messages
function removeFlashMenssage() {
  $("#flash_notice").remove();
  $("#flash_warning").remove();
  $("#flash_alert").remove();  
}


// 
function mouseWheelForHorizontalScroll() {
	if ($(".horizontal-scrolling").length > 0) {
		$(".horizontal-scrolling").mousewheel(function(event, delta) {
			this.scrollLeft -= (delta * 80);
			this.scrollRight -= (delta * 80);
			event.preventDefault();
		});
	}
}