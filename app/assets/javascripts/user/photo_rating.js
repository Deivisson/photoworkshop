$(document).on('ready page:load', function (){
	$("#photo-rating-button").click(function(e){
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("#photo-rating-modal-dialog")).dialog({
		    autoOpen: false,
		    width: 500,
		    height: 600,
		    modal: true,
		    close: function() {
		      $('#photo-rating-modal-dialog').remove();
		      jQuery('body').css('overflow','auto');
		    },
		    draggable: false,
        resizable: false,
        dialogClass: 'noTitleStuff'
		  });
		  dialog_form.load(url + '#photo-rating-modal-container', function(){
	  		jQuery('body').css('overflow','hidden');
	  		$(".ui-dialog-content").css("overflow-x", "hidden");
	  	// 	$("#notification-modal-close-button").click(function() {
	  	// 		$("#photo-rating-modal-dialog").dialog( "close" );
				// });
		  });
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
});
