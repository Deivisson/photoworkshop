$(document).on('ready page:load', function (){
	bindWorkshopParticipantsDialog();
});

function bindWorkshopParticipantsDialog() {
	$("#add-workshop-participants").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-participants-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 700,
			    height: 650,
			    modal: true,
			    open: function(){
						$(".ui-widget-overlay").addClass("modal-overlay workshop-participants-modal-dialog-class").removeClass("ui-widget-overlay");
	          $('.workshop-participants-modal-dialog-class').bind('click',function(){
	            $('#workshop-participants-modal-dialog').dialog('close');
	          });
	        },
			    close: function() {
			      $('#workshop-participants-containter').remove();
			      if ($("div[aria-describedby='workshop-participants-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='workshop-participants-modal-dialog']").remove();
			      }
			    }
			  });

			  dialog_form.load(url + '#workshop-participants-container', function(){
		  		$(this).dialog('option',"title",$("#modal-title-participant").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		$("#user-search-field").focus();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}
