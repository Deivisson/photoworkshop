$(document).on('ready page:load', function (){
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