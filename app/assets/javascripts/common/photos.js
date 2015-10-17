
$(document).on('ready page:load', function (){
	photoView();
	adjustLayout();
});

function photoView(){
	$(".photo-picture").click(function(e){
		var w = $(window).width() * 1;
		var h = $(window).height() * 1;
		var url = $(this).attr('href');
		var dialog_form = $(getModalContainer("photo-modal-dialog")).dialog({
		    autoOpen: false,
		    width: w,
		    height: h,
		    modal: true,
		    close: function() {
		      $('#photo-modal-dialog').remove();
		      jQuery('body').css('overflow','auto');
		    },
		    draggable: false,
        resizable: false,
        dialogClass: 'noTitleStuff'
		  });
			$(".ui-widget-content").addClass("ui-widget-content-full");
		  dialog_form.load(url + ' #photo-show-modal-container', function(){
		  		jQuery('body').css('overflow','hidden');
		  		$(".ui-widget-overlay").css("opacity","1");
		  		adjustLayout();
		  });
		  dialog_form.dialog('open');
		  e.preventDefault();  
	});	
}

$(window).resize(function () {
	adjustLayout();	
});

function adjustLayout(){
	 //alert("Size " + w + "x" + h);
	if($("#photo-show-modal-container").length > 0)	{
		$(".ui-widget-content").css({
			height:"100%",
			width: "100%"
		});
		var w = $("#photo-container").width();
		var h = $("#photo-container").height();
		$("#photo-picture").css("left",(w/2) - ($("#photo-picture").width()/2) + 10);
		$("#photo-toolbar").css("left",(w/2) - ($("#photo-toolbar").width()/2));
		$(".photo-show-extra-content").css("top", h + 10);


		$(".ui-widget-content-full").css("overflow-y","hidden");
		$("#photo-modal-dialog").css("overflow-y","visible").css("width","97.8%");
	  $("#down-page-photo-view").click(function(){
	  	var top = $('#photo-list-comments').offset().top - 200;
	  	$('#photo-modal-dialog').animate({scrollTop: top},250);
	  });
 	}
}

function resizeModalDialog(){
	var w = $(window).width() * 1;
	var h = $(window).height() * 1;
	$("#ui-widget-overlay").css("height",h);
	$("#ui-widget-overlay").css("width",w);
	$("#ui-widget-content").css("height",h);	
	$("#ui-widget-content").css("width",w);
}


function handleFileUpload(files,obj)
{
   for (var i = 0; i < files.length; i++)
   {
        var fd = $("#new_photo");
        fd.append('file', files[i]);
   }
}


function showImagePreview(input) {
	if (input.files && input.files[0]) {
		var filerdr = new FileReader();
		filerdr.onload = function(e) {
			$('#image-upload').attr('src', e.target.result);
		}
		filerdr.readAsDataURL(input.files[0]);
		$("#dragandrophandler").css("border","1px solid #777")
		$("li#photo_picture_input > label").hide();
		$("#photo_title").focus();
	}
}

