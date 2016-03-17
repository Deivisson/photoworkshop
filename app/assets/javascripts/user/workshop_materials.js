$(document).on('ready page:load', function (){
	bindWorkshopMaterialDialog();
});

function bindWorkshopMaterialDialog() {
	$("#add-workshop-materials,.edit-workshop-material").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-materials-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 700,
			    height: 350,
			    modal: true,
			    open: function(){
						$(".ui-widget-overlay").addClass("modal-overlay workshop-materials-modal-dialog-class").removeClass("ui-widget-overlay");
	          $('.workshop-materials-modal-dialog-class').bind('click',function(){
	            $('#workshop-materials-modal-dialog').dialog('close');
	          });
	        },
			    close: function() {
			      $('#workshop-materials-containter').remove();
			      if ($("div[aria-describedby='workshop-materials-modal-dialog']").length > 0) {
			      	$("div[aria-describedby='workshop-materials-modal-dialog']").remove();
			      }
			    }
			  });

			  dialog_form.load(url + '#workshop-materials-containter', function(){
		  		$(this).dialog('option',"title",$("#modal-title-material").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		$("#material-description").focus();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}
