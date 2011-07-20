(function($) 
{
	$.fn.twitterFollowers = function(allOptions) 
	{  
		//options
		var op = 	{	
						username: 'pongoresume'
						,user_per_page: 18
						,user_link:0
						,user_image:30
						,user_replace_delay:5000
						,user_animate:'opacity'
						,repeat: 1
					};
		var current_user=null;
		var current_user_count=0;
		var users = null
		
		// create tf-users div if it does not exists already
		if ($('.followers').length == 0 )
		{			
			$('#friends').append($('<div class="followers"></div>'));
		}
		
		//
		getFollowers();
		
		//get follower data from twitter
		function getFollowers() {
			//var url = 'http://twitter.com/statuses/followers.json';
			var url = '/data/getTwitterFollowers';
			var data = {screen_name:op.username,cursor:-1};
			$.ajax({url:url,data:data,success:requestedUsers,dataType:'jsonp',cache:true});
		};
		
		//response from requesting the follower data
		function requestedUsers(json){
			// Error!
			if(!json.users){
				if(op.debug) div.html('<b style="color:red">Error:'+(json.error? json.error:'unknown')+'</b>');
				return; //exit
			};
			//keep new users last
			users = json.users.reverse();
			preloadIcons();
			showFollowers();
		};
		
		function preloadIcons()
		{
			// pre-load the first page of user images +1 more
			for(i=0;i<op.user_per_page+1;i++)
			{
				var image = new Image;
				image.src = users[i].profile_image_url; 
			}
		}		
		
		function showFollowers()
		{
			var followers = $('div.followers');
			
			// count is total users per page or total users which ever is less. 
			if (op.user_per_page < users.length)
			{
				count = op.user_per_page;
			}
			else
			{
				count = users.length;
			}
			
			// set up the page with the first page of users 
			for(current_user_count=0;current_user_count<count;current_user_count++)
			{								
				current_user = users[current_user_count];
				$(followers).append(getUserHTML(current_user));
			}
			
			//from here on out swap the followers until we reach the end
			swapFollower();
			
		}
		
		function swapFollower()
		{
			current_user_count++;
			if (current_user_count < users.length)
			{
				/* if we are not at the end of the users, 
					pre-load the next image so it is ready for next time */
				var i = current_user_count+1
				if (i<users.length)
				{
					var image = new Image;
					image.src = users[i].profile_image_url; 
				}
				
				current_user = users[current_user_count];
				n = (current_user_count%op.user_per_page);
				var effect = new Object; effect[op.user_animate] = 'show';
				$('div.followers > a:eq('+n+')').replaceWith(getUserHTML(current_user)).animate(effect,op.user_replace_delay,"linear", swapFollower);

			}
			else if (op.repeat == 1)
			{
				current_user_count = 0;
				swapFollower();
			}
		}
		
		var getUserHTML = function(user)
		{			
						
			var u = op.user_link && user.url? user.url :'http://twitter.com/' +user.screen_name;
			var t = user.name + (user.status && op.tweet ?': '+ user.status.text :'');			
			t= t.replace(/"/g,'&quot;').replace(/'/g,'&#39;');
			user = $('<a style="height:'+op.user_image+'px" href="'+u+'" title="'+ t +'">'
				+'<img src="'+user.profile_image_url+'" border="0" height="'+op.user_image+'" width="'+op.user_image+'"/>'+'</a>');
			return user; 
			//display:none;
		};
	}
})(jQuery);  
//auto load div with class set to related-tweets
$(document).ready(function(){ $('#friends').twitterFollowers();  });