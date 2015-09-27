module User::SocialNetworkHelper
	#https://developers.facebook.com/docs/javascript/reference/FB.ui
	def facebook_script
		script = <<-SCRIPT
			<script src="http://connect.facebook.net/en_US/all.js"></script>
		  <script>
		    FB.init({
		      appId:'1546622365584604',
		      cookie:true,
		      status:true,
		      xfbml:true
		    });
			</script>
		SCRIPT
		script.html_safe
	end

	def facebook_invite_friends
		script = <<-SCRIPT
			<script>
				function FacebookInviteFriends()
		    {
		      FB.ui({
		        method: 'apprequests',
		        message: 'Convidar Amigos',
		        display:'iframe'
		      }, function(response){
		        UpdateInvitedFriends();
		      });
		    }
	    </script>
		SCRIPT
		script.html_safe
	end

	def facebook_share
		script = <<-SCRIPT
			<script>
				function FacebookShare()
		    {
		      FB.ui({
		        method: 'share',
					  href: 'http://pic2gether.com',
		      }, function(response){
		        UpdateSocialNetworkShared('facebook',response);
		      });
		    }
	    </script>
		SCRIPT
		script.html_safe		
	end
	
	def twitter_share
		script = <<-SCRIPT
			<script>
				function TwitterShare() {	
		    	UpdateSocialNetworkShared('twitter',JSON.stringify("[]"));
	      };
	    </script>
		SCRIPT
		script.html_safe		
	end


	
end