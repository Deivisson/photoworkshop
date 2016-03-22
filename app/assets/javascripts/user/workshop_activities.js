$(document).on('ready page:load', function (){
	bindWorkshopActivityDialog();
	bindShowWorkshopActivityDialog();

	$('li[id*="activity-student-"]').click(function(){
		$("#workshop-students-show > li").removeClass("selected");
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
		    open: function(){
					$(".ui-widget-overlay").addClass("modal-overlay workshop-activities-modal-dialog-class").removeClass("ui-widget-overlay");
          $('.workshop-activities-modal-dialog-class').bind('click',function(){
            $('#workshop-activities-modal-dialog').dialog('close');
          });
        },
		    close: function() {
		      $('#workshop-activities-containter').remove();
		      if ($("div[aria-describedby='workshop-activities-modal-dialog']").length > 0) {
		      	$("div[aria-describedby='workshop-activities-modal-dialog']").remove();
		      }
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
			    open: function(){
						$(".ui-widget-overlay").addClass("modal-overlay workshop-show-activity-modal-dialog-class").removeClass("ui-widget-overlay");
	          $('.workshop-show-activity-modal-dialog-class').bind('click',function(){
	            $('#workshop-show-activity-modal-dialog').dialog('close');
	          });
	        },
			    close: function() {
			      $('#workshop-activities-containter').remove();
			      if ($("div[aria-describedby='workshop-show-activity-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='workshop-show-activity-modal-dialog']").remove();
			      }
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


