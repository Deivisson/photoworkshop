$(document).on('ready page:load', function (){
	
	$("#user-full-name").blur(function(e) {
		if ($("#user-name-input").val() == "" && e.target.value != "") {
			$.get("/home/user_profile/" + e.target.value + "/format_user_name.js");
		}
	});

	$("#user-name-input").blur(function(e){
		if (e.target.value != "") {
			$.get("/home/user_profile/" + e.target.value + "/check_user_name.js");
		} else {
			$("#user-name-available").removeClass("success").removeClass("failure");
		}
	});
});