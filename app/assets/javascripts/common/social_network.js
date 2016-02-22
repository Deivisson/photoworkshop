function UpdateInvitedFriends(provider,response) {
	
}

// Update that user shared on social network
function UpdateSocialNetworkShared(provider, response,share_callback) {
	if (response != undefined && !response.hasOwnProperty("error_code")) {
		if (share_callback == "share_pic2gether") {
			$.post( "/user/profile/social_network_shared/" + provider, function() {})	;	
		}
	}
}