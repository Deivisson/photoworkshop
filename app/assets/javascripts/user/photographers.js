$(document).on('ready page:load', function (){
	$(".photographer-profile").click(function(e){
			//var w = $(window).width() * 1;
			var h = $(window).height() * 1;
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer("photographer-modal-dialog")).dialog({
			    autoOpen: false,
			    width: 900,
			    height: h,
			    modal: true,
			    close: function() {
			      $('#photographer-modal-dialog').remove();
			    },
			    draggable: false,
          resizable: false,
          dialogClass: 'noTitleStuff'
			  });
			  dialog_form.load(url + ' #photographer-show-modal-container', function(){
			  		// jQuery('body').css('overflow','hidden');

			  		// $(".ui-dialog-titlebar").css("display","none");
			  		// $(".ui-widget-overlay").css("opacity","1");
			  		//adjustLayout();
			  });
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});	
});