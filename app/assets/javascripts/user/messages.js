$(document).on('ready page:load', function (){
	$("#menu-messages > li").click(function() {
		$("#menu-messages > li").removeClass("selected");
		$(this).addClass("selected");
	});

	// Move scroll to end
	if($("#messages-list").length > 0) {
		$("#messages-list").animate({scrollTop: $('#messages-list').prop("scrollHeight")}, 0);
	}
	TriggerSendMessage();
});

function TriggerSendMessage(){
	$("#message-send-button").unbind('click');
	$("#message-send-button").bind('click', function(e) {
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("new-message-modal-dialog")).dialog({
	    autoOpen: false,
	    width: 500,
	    height: 350,
	    modal: true,
	    show: {effect: 'fadeIn',duration: 1000},
	    hide: {effect: 'fadeOut',duration: 500},
	    open: function(){
				$(".ui-widget-overlay").addClass("modal-overlay new-message-modal-dialog-class").removeClass("ui-widget-overlay");
        $('.new-message-modal-dialog-class').bind('click',function(){
          $('#new-message-modal-dialog').dialog('close');
        });
      },
	    close: function() {
	      $('#workshop-activities-containter').remove();
	      if ($("div[aria-describedby='new-message-modal-dialog']").length > 0) {
	      	$("div[aria-describedby='new-message-modal-dialog']").remove();
	      }
	    },
	    draggable: true,
      resizable: false
	  });
	  dialog_form.load(url + '#new-message-modal-container', function(){
	  	$(this).dialog('option',"title",$("#modal-title-message").text());
  		jQuery('body').css('overflow','hidden');
  		$(".ui-dialog-content").css("overflow-x", "hidden");
	  });
	  dialog_form.dialog('open');
	  e.preventDefault(); 
	});
}
