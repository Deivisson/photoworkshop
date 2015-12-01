$(document).on('ready page:load', function (){
	bindWorkshopActivityDialog();
	bindShowWorkshopActivityDialog();

	// $( "#slider-range-max" ).slider({
	// 	range: "max",
	// 	min: 0,
	// 	max: 5,
	// 	value: 0,
	// 	slide: function( event, ui ) {
	// 		$("#amount" ).text( ui.value );
	// 		$("#score-comp").css("width",(ui.value * 20) + "%");
	// 	}
	// });
	// $("#amount").text( $( "#slider-range-max" ).slider( "value" ) );

});

function bindWorkshopActivityDialog() {
	$("#add-workshop-activities,.edit-workshop-activity").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-activities-modal-dialog")).dialog({
			    autoOpen: false,
			    width: 700,
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
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}


function bindShowWorkshopActivityDialog() {
	$(".show-workshop-activity").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-show-activity-modal-dialog")).dialog({
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


