$(document).on('ready page:load', function (){
	$(".add-workshop-activities-response").click(function(e){
		//var h = $(window).height() * 1;
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("workshop-activity-response-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 960,
		    height: 640,
		    modal: true,
		    open: function(){
					$(".ui-widget-overlay").addClass("modal-overlay workshop-activity-response-modal-dialog-class").removeClass("ui-widget-overlay");
          $('.workshop-activity-response-modal-dialog-class').bind('click',function(){
            $('#workshop-activity-response-modal-dialog').dialog('close');
          });
        },
		    close: function() {
		      $('#workshop-activity-response-containter').remove();
		      if ($("div[aria-describedby='workshop-activity-response-modal-dialog']").length > 0) {
		      	$("div[aria-describedby='workshop-activity-response-modal-dialog']").remove();
		      }
		      jQuery('body').css('overflow','auto');
		    }
		  });

		  dialog_form.load(url + '#workshop-activity-response-containter', function(){
		  	$(this).dialog('option',"title",$("#modal-title-response").text());
		  	jQuery('body').css('overflow','hidden');
	  		$(".ui-widget-overlay").css("opacity","0.8");
	  		$("#workshop-activity-response-modal-dialog").css("overflow-x","hidden");
		  });
		  
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
});


