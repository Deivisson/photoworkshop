$(document).on('ready page:load', function (){
	TriggerSubmitOnEnterCommentInputField();	
});

function TriggerSubmitOnEnterCommentInputField(){
  	$(".photo-comment-input-text").unbind('keypress');
	$(".photo-comment-input-text").keypress(function(e) {
    if(e.which == 13) {
    	e.preventDefault();
    	if ($(this).val().trim() != "" ) {
    		$(this).closest("form").submit();	
    	}
    }
	});
}


