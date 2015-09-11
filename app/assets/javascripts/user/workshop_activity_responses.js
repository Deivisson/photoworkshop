$(document).on('ready page:load', function (){
	$(".add-workshop-activities-response").click(function(e){
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("workshop-activity-response-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 700,
		    height: 700,
		    modal: true,
		    close: function() {
		      $('#workshop-activity-response-containter').remove();
		    }
		  });

		  dialog_form.load(url + '#workshop-activity-response-containter', function(){
	  		$(this).dialog('option',"title",$("#modal-title-activity").text());
	  		$(".ui-widget-overlay").css("opacity","0.8");
		  });
		  
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
});
