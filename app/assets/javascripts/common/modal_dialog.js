function getModalContainer(formId) {
	$('.ui-dialog').remove();
  formId = formId || "dialog-form";
  return '<div id="dialog-form">Loading form...</div>';
}