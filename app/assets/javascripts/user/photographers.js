$(document).on('ready page:load', function (){
	photographerPreview();
	PhotoAvoidRightClick("#user-profile-cover-pic");
	PhotoAvoidRightClick(".cover-pic");
});

function photographerPreview(){
	$(".photographer-profile").unbind("click");
	$(".photographer-profile").bind("click",function(e){
		var h = $(window).height() * 1;
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("photographer-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 900,
		    height: h,
		    modal: true,
		    show: {effect: 'fadeIn',duration: 1000},
		    hide: {effect: 'fadeOut',duration: 500},
				open: function(){
					$(".ui-widget-overlay").addClass("modal-overlay photographer-modal-dialog-class").removeClass("ui-widget-overlay");
          $('.photographer-modal-dialog-class').bind('click',function(){
            $('#photographer-modal-dialog').dialog('close');
          })
        },		    
		    close: function() {
		      $('#photographer-modal-dialog').remove();
					if ($("div[aria-describedby='photographer-modal-dialog']").length > 0) {
		      	$("div[aria-describedby='photographer-modal-dialog']").remove();
		      }		      
		      jQuery('body').css('overflow','auto');
		    },
		    draggable: false,
        resizable: false,
        dialogClass: 'noTitleStuff'
		  });

		  dialog_form.load(url + ' #photographer-show-modal-container', function(){
	  		jQuery('body').css('overflow','hidden');
	  		$(".ui-dialog-content").css("overflow-x", "hidden");
	  		photoView();
	  		PhotoAvoidRightClick();
	  		PhotoAvoidRightClick(".cover-photo");
	  		TriggerSendMessage();
	  		$("#modal-close-button").click(function() {
					$('#photographer-modal-dialog').dialog("close");
				});
		  });
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	


}