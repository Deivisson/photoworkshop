$(document).on('ready page:load', function (){
	TriggerButtonPhotoRating();		
});

function TriggerButtonPhotoRating() {
	$("#photo-rating-button").click(function(e){
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("photo-rating-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 300,
		    height: 500,
		    modal: false,
		    close: function() {
		      $('#photo-rating-modal-dialog').remove();
		      jQuery('body').css('overflow','auto');
		    },
		    draggable: true,
        resizable: false
		  });
		  dialog_form.load(url + '#photo-rating-modal-container', function(){
		  	$(this).dialog('option',"title",$("#modal-title-photo-rating").text());
	  		jQuery('body').css('overflow','hidden');
	  		$(".ui-dialog-content").css("overflow-x", "hidden");
		 		$('div[id*="slider-range-photo"]').slider({
					range: "max",
					min: 0,
					max: 5,
					value: 0,
					slide: function( event, ui ) {
						var id = $(this).attr("criterium");
						$("#score-for-criterium-"+id).css("width",(ui.value * 20) + "%");
						$("#score-value-"+id).val(ui.value);
					}	
				});
		  });
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
}