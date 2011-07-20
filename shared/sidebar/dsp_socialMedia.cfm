<cfoutput>
	<div class="leftColumnModule module_tabs tabs">
		<div class="tabarea tabs">
			<ul>
				<li id="tab_twitter" class=""><a href="##panelTwitter" class="tabLink" >Twitter</a></li>
				<li id="tab_facebook" class=""><a href="##panelFacebook" class="tabLink" >Facebook</a></li>
				<li id="tab_youtube" class=""><a href="##panelYoutube" class="tabLink" >YouTube</a></li>
			</ul>
		</div>
		<div id="socialMediaNavigation" class="tabs">
			<div class="module_inner_content" id="panelTwitter">
				<p style="text-align:center; padding-bottom:10px;">
					<a href="http://twitter.com/pongoresume" target="_blank">
						<img src="#application.themePath#/images/btn_twitter_follow_167x34.png" width="167" height="34" alt="Follow Us on Twitter" />
					</a>
				</p>
				<!--- may want to put these somewhere else. --->
				<script src="#application.themePath#/js/twitter_widget.js"></script>
				<script src="#application.themePath#/js/twitter_widget_config.js"></script>		
				<script src="#application.themePath#/js/jquery.twitter_followers.js"></script>
				<div id="friends"></div>---><!--- twitter follower thumbs --->				
			</div><!--- end Twitter Panel --->
			
			<div id="panelFacebook" class="module_inner_content">
				<div class="content_fb">
                    <script type="text/javascript" src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US"></script>
<script type="text/javascript">FB.init("122114821135354");</script>
<fb:fan profile_id="67594638715" stream="1" connections="6" width="224" height="550" css="http://www.pongoresume.com/application/fb10.css" ></fb:fan>                   
				</div>
			</div>
			<!--- end Facebook Panel --->
			<div id="panelYoutube" class="module_inner_content">
				<div id="youtubevideos"></div>
				<script src="#application.themePath#/js/jquery.youtube.channel.js"></script>
			</div>
			<!--- end YouTube Panel --->
		</div>
	</div>
</cfoutput>