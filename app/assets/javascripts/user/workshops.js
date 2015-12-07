$(document).on('ready page:load', function (){
	$("#allow-pre-enrolls-input").click(function(){
		if($(this).is(':checked'))	{
			$("#allow-queued-input").attr("disabled",false);
		}	else {
			$('#allow-queued-input').attr('checked', false);
			$("#allow-queued-input").attr("disabled","disabled");
		}
	});
});

function showImageWorkshopPreview(input) {
	if (input.files && input.files[0]) {
		var filerdr = new FileReader();
		filerdr.onload = function(e) {
			$('#image-upload').attr('src', e.target.result);
		}
		filerdr.readAsDataURL(input.files[0]);
		$("#workshop-description").focus();
	}
}