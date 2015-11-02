$(document).on('ready page:load', function (){
	$(".add-workshop-activities-response").click(function(e){
		var h = $(window).height() * 1;
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("workshop-activity-response-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 900,
		    height: h,
		    modal: true,
		    close: function() {
		      $('#workshop-activity-response-containter').remove();
		      jQuery('body').css('overflow','auto');
		    }
		  });

		  dialog_form.load(url + '#workshop-activity-response-containter', function(){
		  	jQuery('body').css('overflow','hidden');
	  		$(this).dialog('option',"title",$("#modal-title-response").text());
	  		$(".ui-widget-overlay").css("opacity","0.8");
	  		$("#workshop-activity-response-modal-dialog").css("overflow-x","hidden");
		  });
		  
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
});
