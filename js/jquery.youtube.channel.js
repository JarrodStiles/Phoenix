/**
 *  Plugin which renders the YouTube channel videos list to the page
 *  @author:  H. Yankov (hristo.yankov at gmail dot com)
 *  @version: 1.0.0 (Nov/27/2009)
 *	http://yankov.us
 *  Modified my Dan Hounshell (Jan/2010) to work for favorites or 
 *  uploads feeds and simplified output 
 */

 var __mainDiv;
 var __preLoaderHTML;
 var __opts;

 function __jQueryYouTubeChannelReceiveData(data) {	
		 var cnt = 0;	
		 $.each(data.feed.entry, function(i, e) {
			 if (cnt < __opts.numberToDisplay) {
				e.views = e.content.$t.match(/Views:\<\/span\>\s*\d*\</)[0].match(/(\d+)/)[0]; //Get Just View Count from Content			
				var parts = e.id.$t.split('/');
				var videoId = parts[parts.length-1];
				var out = '<div class="video">';
				out += '<a href="' + e.link[0].href + '"><img src="http://i.ytimg.com/vi/' + videoId + '/2.jpg"/></a>';
				out += '<p class="description_yt"><a href="' + e.link[0].href + '">' + e.title.$t + '</a></p>';
				out += '<p class="author_yt">';
				 if (!__opts.hideAuthor) {
					 out += 'Author: ' + e.author[0].name.$t + '';
				 }
				out += '</p>'
				out += '<p class="views">'+e.views+' views </p>'
				out += '<p class="time">'+getTimeLengthDescription(e.published.$t) +'</p>' //
				out += '</div>';
				 __mainDiv.append(out);
				 cnt = cnt + 1;
			 }
		 });
				
		// Open in new tab?
		if (__opts.linksInNewWindow) {
			$(__mainDiv).find("li > a").attr("target", "_blank");
		}
		
		// Remove the preloader and show the content
		$(__preLoaderHTML).remove();
		__mainDiv.show();
	}

	function getTimeLengthDescription(t)
	{
		
		var one_hour=1000*60*60;	// 1 hour in milliseconds
		var one_day=1000*60*60*24;	// 1 day in milliseconds
		var one_month=1000*60*60*24*30;	// about 1 month in milliseconds
		var today = new Date();
		var published = new Date(t);
		
		var age = Math.ceil((today.getTime()-published.getTime())/(one_month))+ ' months ago';
		if (age < 1)
		{	
			var age = Math.ceil((today.getTime()-published.getTime())/(one_day))+ ' days ago';	
			if (age < 1)
			{
				var age = Math.ceil((today.getTime()-published.getTime())/(one_hour))+ ' hours ago';
			}
		}
		return age;
	}
                
(function($) {
    $.fn.youTubeChannel = function(options) {
        var videoDiv = $(this);

        $.fn.youTubeChannel.defaults = {
            userName: null,
            channel: "uploads", //options are favorites or uploads
            loadingText: "Loading...",
            numberToDisplay: 3,
            linksInNewWindow: true,
            hideAuthor: true
        }

        __opts = $.extend({}, $.fn.youTubeChannel.defaults, options);

        return this.each(function() {
            if (__opts.userName != null) {
                videoDiv.append("<div id=\"channel_div\"></div>");
                __mainDiv = $("#channel_div");
                __mainDiv.hide();

                __preLoaderHTML = $("<p class=\"loader\">" + 
                    __opts.loadingText + "</p>");
                videoDiv.append(__preLoaderHTML);

                // TODO: Error handling!
                $.ajax({
                    url: "http://gdata.youtube.com/feeds/base/users/" + 
                        __opts.userName + "/" + __opts.channel + "?alt=json",
                    cache: true,
                    dataType: 'jsonp',                    
                    success: __jQueryYouTubeChannelReceiveData
                });
            }
        });
    };
})(jQuery);
//auto load div with class set to related-tweets
$(document).ready(function() {
						$('#youtubevideos').youTubeChannel({ 
							userName: 'pongoresume', 
							channel: "uploads", 
							hideAuthor: true,
							numberToDisplay: 4,
							linksInNewWindow: true
							//other options
							//loadingText: "Loading...",                    
						});
					});  