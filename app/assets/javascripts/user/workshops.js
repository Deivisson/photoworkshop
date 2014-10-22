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