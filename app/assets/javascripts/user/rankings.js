$(document).on('ready page:load', function (){
	$("#full-rankings").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("full-rankings-modal-dialog")).dialog({
			    autoOpen: false,
			    width: 860,
			    height: 700,
			    modal: true,
			    close: function() {
			      $('#full-rankings-container').remove();
			      jQuery('body').css('overflow','auto');
			    }
			  });

			  dialog_form.load(url + '#full-rankings-container', function(){
		  		///$(this).dialog('option',"title",$("#modal-title-edit-cover").text());
		  		jQuery('body').css('overflow','hidden');
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		$("#full-rankings-modal-dialog").css("overflow-x","hidden");
		  		photographerPreview();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
});