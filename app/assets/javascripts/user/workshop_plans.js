$(document).on('ready page:load', function (){
	WorkshopPlansTrigger();
});

function WorkshopPlansTrigger() {

	$("#workshop-plans-link, #workshop-plans-link3").unbind('click');
	$("#workshop-plans-link, #workshop-plans-link3").bind('click',function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-plans-modal-dialog",true)).dialog({
			    autoOpen: false,
			    //width: 1000,
					//height: 500,
			    width: 600,
			    height: 400,
			    modal: true,
			    show: {effect: 'fadeIn',duration: 1000},
	    		hide: {effect: 'fadeOut',duration: 500},
			    close: function() {
			      $('#workshop-plans-modal-dialog').remove();
			    }
			  });

			  dialog_form.load(url + '#workshop-plans-container', function(){
		  		//$(this).dialog('option',"title",$("#modal-title-workshop-plan").text());
		  		$(this).dialog('option',"title","Gerenciamento simples de Workshops");
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		
		  		//disable all hire plan buttons
		  		$(".btn-to-hire-plan").click(function(){
						$(".btn-to-hire-plan").addClass("disabled");
					});
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});


	$("#workshop-plans-link2,#workshop-plans-link3").unbind('click');
	$("#workshop-plans-link2,#workshop-plans-link3").bind('click',function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-plans-modal-dialog",true)).dialog({
			    autoOpen: false,
			    width: 1000,
					height: 500,
			    modal: true,
			    close: function() {
			      $('#workshop-plans-modal-dialog').remove();
			    }
			  });

			  dialog_form.load(url + '#workshop-plans-container', function(){
		  		$(this).dialog('option',"title",$("#modal-title-workshop-plan").text());
		  		$(".ui-widget-overlay").css("opacity","0.8");
		  		
		  		//disable all hire plan buttons
		  		$(".btn-to-hire-plan").click(function(){
						$(".btn-to-hire-plan").addClass("disabled");
					});
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
}