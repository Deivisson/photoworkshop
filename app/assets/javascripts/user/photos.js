
$(document).on('ready page:load', function (){
	$(".photo-picture").click(function(e){
			var w = $(window).width() * 1;
			var h = $(window).height() * 1;
			var url = $(this).attr('href');
			var dialog_form = $(getModalContainer()).dialog({
			    autoOpen: false,
			    width: w,
			    height: h,
			    modal: true,
			    close: function() {
			      $('#dialog-form').remove();
			      jQuery('body').css('overflow','auto');
			    },
			    draggable: false,
          resizable: false
			  });

			  dialog_form.load(url + ' #modal-container', function(){
			  		jQuery('body').css('overflow','hidden');
			  		adjustLayout();
			  });
			  
			  dialog_form.dialog('open');
			  e.preventDefault();  
	});
});

$(window).resize(function () {
  adjustLayout();
});

function adjustLayout(){
	 //alert("Size " + w + "x" + h);
	 $(".ui-widget-content").css({
	 	height:"100%",
	 	width: "100%"
	 });
	 var w = $("#photo-container").width();
	 var h = $("#photo-container").height();
	 $("#photo-picture").css("left",(w/2) - ($("#photo-picture").width()/2));
	 $("#photo-toolbar").css("left",(w/2) - ($("#photo-toolbar").width()/2));
	 
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

