$(document).on('ready page:load', function (){
  if ($("#first-login-tag").length == 0) {
    ShowCommunication();
  }
});

function ShowCommunication(){
  if ($("#communication_tag").length > 0) {
    var url = $("#communication_tag").attr("href");
    var dialog_form = $(getModalContainer("communication-modal-dialog")).dialog({
      autoOpen: false,
      width: 460,
      height: 450,
      modal: true,
      close: function() {
        $('#communication-modal-dialog').remove();
      },
      draggable: false,
      resizable: false,
      dialogClass: 'noTitleStuff',
      closeOnEscape: false
    });
    dialog_form.load(url + ' #communication-container', function(){
      
    });
    dialog_form.dialog('open');
  }
}