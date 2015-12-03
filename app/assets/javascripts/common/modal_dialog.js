function getModalContainer(formId,removeOpenedModal) {
	if (removeOpenedModal != undefined ) {
		$('.ui-dialog').remove();
	}
  formId = formId || "dialog-form";
  return '<div id="'+ formId +'"><div class="loading-gif"></div>';
}