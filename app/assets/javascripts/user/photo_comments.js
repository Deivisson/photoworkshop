$(document).on('ready page:load', function (){
	$(".photo-comment-input-text").keypress(function(e) {
    if(e.which == 13) {
    	e.preventDefault();
    	if ($(this).val().trim() != "" ) {
    		$(this).closest("form").submit();	
    	}
    }
	});
});
