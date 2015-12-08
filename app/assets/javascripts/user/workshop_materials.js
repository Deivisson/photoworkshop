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
			    close: function() {
			      $('#workshop-materials-containter').remove();
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
