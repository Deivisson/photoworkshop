$(document).on('ready page:load', function (){
	$("#workshop-plans-link").click(function(e){
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("workshop-plans-modal-dialog",true)).dialog({
			    autoOpen: false,
			    //width: 1000,
					//height: 500,
			    width: 600,
			    height: 400,
			    modal: true,
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

	$("#workshop-plans-link2").click(function(e){
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

});

