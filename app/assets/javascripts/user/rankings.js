$(document).on('ready page:load', function (){
	RankingPreview();
});

function RankingPreview(){
	$("#full-rankings").unbind("click");
	$("#full-rankings").bind("click",function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("full-rankings-modal-dialog")).dialog({
			    autoOpen: false,
			    width: 860,
			    height: 700,
			    modal: true,
					open: function(){
						$(".ui-widget-overlay").addClass("modal-overlay full-rankings-modal-dialog-class").removeClass("ui-widget-overlay");
	          $('.full-rankings-modal-dialog-class').bind('click',function(){
	            $('#full-rankings-modal-dialog').dialog('close');
	          });
	        },
        	close: function() {
			      $('#full-rankings-container').remove();
			      if ($("div[aria-describedby='full-rankings-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='full-rankings-modal-dialog']").remove();
			      }
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
}	