$(document).on('ready page:load', function (){
	$("#allow-pre-enrolls-input").click(function(){
		if($(this).is(':checked'))	{
			$("#allow-queued-input").attr("disabled",false);
		}	else {
			$('#allow-queued-input').attr('checked', false);
			$("#allow-queued-input").attr("disabled","disabled");
		}
	});


	$(".ws-example-info").click(function(e){
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("workshop-example-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 500,
		    height: 600,
		    modal: true,
				open: function(){
					$(".ui-widget-overlay").addClass("modal-overlay workshop-example-modal-dialog-class").removeClass("ui-widget-overlay");
          $('.workshop-example-modal-dialog-class').bind('click',function(){
            $('#workshop-example-modal-dialog').dialog('close');
          });
        },		    
		    close: function() {
		      $('#workshop-example-modal-dialog').remove();
		      if ($("div[aria-describedby='workshop-example-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='workshop-example-modal-dialog']").remove();
		      }
		    },
		    draggable: false,
        resizable: false,
        dialogClass: 'noTitleStuff'
		  });
		  dialog_form.load(url + '#workshop-example-modal-container', function(){
	  		$("#example-modal-close-button,#notification-modal-close-button").click(function() {
					$('#workshop-example-modal-dialog').dialog("close");
				});
		  });
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
	InitializeTinyMce();
});

function showImageWorkshopPreview(input) {
	if (input.files && input.files[0]) {
		var filerdr = new FileReader();
		filerdr.onload = function(e) {
			$('#image-upload').attr('src', e.target.result);
		}
		filerdr.readAsDataURL(input.files[0]);
		$("#workshop-description").focus();
	}
}