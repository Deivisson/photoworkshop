$(document).on('ready page:load', function (){
	bindWorkshopStudentsDialog();
});

function bindWorkshopStudentsDialog() {
	$("#add-workshop-students").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-students-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 700,
			    height: 650,
			    modal: true,
			    open: function(){
						$(".ui-widget-overlay").addClass("modal-overlay workshop-students-modal-dialog-class").removeClass("ui-widget-overlay");
	          $('.workshop-students-modal-dialog-class').bind('click',function(){
	            $('#workshop-students-modal-dialog').dialog('close');
	          });
	        },
			    close: function() {
			      $('#workshop-students-containter').remove();
			      if ($("div[aria-describedby='workshop-students-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='workshop-students-modal-dialog']").remove();
			      }
			    }
			  });

			  dialog_form.load(url + '#workshop-students-container', function(){
		  		$(this).dialog('option',"title",$("#modal-title-student").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		$("#user-search-field").focus();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}
