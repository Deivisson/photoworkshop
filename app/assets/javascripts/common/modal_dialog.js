function getModalContainer(formId) {
	$('.ui-dialog').remove();
  formId = formId || "dialog-form";
  return '<div id="'+ formId +'"><div class="loading-gif"></div>';
}