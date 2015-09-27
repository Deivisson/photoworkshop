function UpdateInvitedFriends() {
	alert("ok");
}

// Update that user shared on social network
function UpdateSocialNetworkShared(provider, response) {
	if (response != undefined && !response.hasOwnProperty("error_code")) {
		$.post( "/user/profile/social_network_shared/" + provider, function() {})	;
	}
}