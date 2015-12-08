$(document).on('ready page:load', function (){
	bindWorkshopActivityDialog();
	bindShowWorkshopActivityDialog();

	$('li[id*="activity-participant-"]').click(function(){
		$("#workshop-participants-show > li").removeClass("selected");
		$(this).addClass("selected");
	});
});

function bindWorkshopActivityDialog() {
	$("#add-workshop-activities,.edit-workshop-activity").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-activities-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 500,
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
		  		setFieldMasks();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}


function bindShowWorkshopActivityDialog() {
	$(".show-workshop-activity").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-show-activity-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 600,
			    height: 600,
			    modal: true,
			    close: function() {
			      $('#workshop-activities-containter').remove();
			    }
			  });

			  dialog_form.load(url + '#workshop-show-activities-containter', function(){
		  		$(this).dialog('option',"title",$("#show-modal-title-activity").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}


