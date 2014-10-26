$(document).on('ready page:load', function (){
	bindWorkshopActivityDialog();
});

function bindWorkshopActivityDialog() {
	$("#add-workshop-activities,.edit-workshop-activity").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-activities-modal-dialog")).dialog({
			    autoOpen: false,
			    width: 700,
			    height: 600,
			    modal: true,
			    close: function() {
			      $('#workshop-activities-containter').remove();
			    }
			  });

			  dialog_form.load(url + '#workshop-activities-containter', function(){
		  		$(this).dialog('option',"title",$("#modal-title-activity").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		$("#workshop-activity-description").focus();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}
