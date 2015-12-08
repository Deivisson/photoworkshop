function flashNoticeMessage(message){
	var html ="";
	html += "<div id='flash_notice'>"
	html += message  
	html += "</div>" 
	flashMessages(html);
}

function flashWarningMessage(message){
	var html ="";
	html += "<div id='flash_warning'>"
	html += message  
	html += "</div>" 
	flashMessages(html);
}

function flashMessages(innerHtml){
	removeModalFlashMenssage();
	var html = "";
	html += "<div class='flash_container' id='modalFlashMessageContainer'>"
	html += innerHtml
	html += "</div>";
	$("html").append(html);
	setTimeout(removeModalFlashMenssage,6000);
}

function removeModalFlashMenssage() {
	if($("#modalFlashMessageContainer").length > 0) {
  	$("#modalFlashMessageContainer").remove();
	}
}