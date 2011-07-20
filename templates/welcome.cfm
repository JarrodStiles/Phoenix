<cfsetting showdebugoutput="no">
<cfoutput>

<!--- Sets proper form for password reset and calls cfc --->
<cfparam name="showReset" default="false">

<!--- temp param until url is validated --->
<cfparam name="url.urlIsValid" default="">

<!--- temp url var until cookie logic is set --->
<cfparam name="url.cookie" default="">
<cfif IsDefined('url.rp') AND url.rp NEQ "">  
   <!---  Use this for Skynet Method (cfc) of Link Validation <input type="hidden" name="resetEmailPassword" class="password.onload"> --->      
	<cfif url.urlIsValid eq 1>
        <cfset showReset = 'true'>
    </cfif>
</cfif>

<cfif showReset is true>
	<cfset pageTitle = 'Reset Password'>
<cfelse>
	<cfif url.cookie eq 1>
        <cfset pageTitle = 'Welcome Back Rodney'> <!--- Return real username --->
    <cfelse>
        <cfset pageTitle = 'Please Login'>
    </cfif>
</cfif> 

<cfinclude template="../shared/html_head.cfm" />
<cfset announcementBean = getBean("content").loadBy(contentID="#request.crumbdata[2].contentID#", siteID=event.getValue("siteID"))>
<cfset announcementIterator = announcementBean.getRelatedContentIterator()>

<body id="#renderer.gettopid()#" class="welcomeBackLogin">
	<div id="#renderer.CreateCSSid(request.contentBean.getMenuTitle())#" class="wrapper">
	    <div class="utilityNavContainer">
      		<div class="utilityNav">
        		<ul>
          			<li id="supportInfo" class="window.show grayL click">Toll Free Support 866.486.4660</li>
          			<li id="liveHelp"><cfinclude template="../shared/provideSupport.cfm"></li>
        		</ul>
      		</div>
    	</div>
		<div class="welcomeBackBorder">
        	<div class="welcomeUser">
            	<div class="cufonParis">
                	#pageTitle#
                </div>
			   <cfif url.cookie eq 1>
            		<div class="notUser"><a href="/welcome-back">Not Rodney?</a></div><!--- needs logic to clear cookie when clicked--->
            	</cfif>
            </div>
           
       		<h1 class="logo">Pongo Resume</h1><br clear="left">
            <div class="ajaxReplace">
            <div class="welcomeHeadlines">
            	<ul id="twitter_update_list">
                    <script type="text/javascript">
						$.getScript("http://twitter.com/javascripts/blogger.js");
                    	$.getScript("http://twitter.com/statuses/user_timeline/pongoresume.json?callback=twitterCallback2&count=1",function(){																												
                        	$('##twitter_update_list li:eq(0)').addClass('tweetHeadline');
                        	$('##twitter_update_list li.tweetHeadline').prepend('<strong>Overheard On Twitter:</strong> ');
						});
                    </script>
                    </ul>
                    <ul id="twitter_update_list">
                	<cfloop condition="announcementIterator.hasNext()">
						<cfset announceData = announcementIterator.next()>
						<cfif FindNoCase("/blog",announceData.getURL())>
                            <cfset iconClass = "blogHeadline">
                            <cfset text = "Recent Blog Post">
                        <cfelse>
                            <cfset iconClass = "newsHeadline">
                            <cfset text = "Latest News">
                        </cfif>
						<li class="#iconClass#"><strong>#text#:</strong> #announceData.getTitle()#</li>
					</cfloop> 
                </ul>
            </div>
            <div class="interactionContainer">
            	<cfif showReset is true>
                	<div class="loginBox" id="large">
                        <form class="welcomeLogin passwordReset" id="updatePasswordForm">	         
                            <fieldset class="welcomeLogin">
                            <legend class="cufonNY">RESET PASSWORD</legend>
                                <ul>
                                      <li>
                                        <label id="password">new password</label>
                                        <span><em><span id="password_lbl" class="label.hide click overlabel">Minimum 8 Characters</span>
                                        <input name="password" id="password" type="password" value="" class="input.focus p r"></em></span>
                                    </li>
                                     <li>
                                        <label id="password">confirm password</label>
                                        <span><em><span id="password_lbl" class="label.hide click overlabel">Minimum 8 Characters</span>
                                        <input name="password_confirm" id="password_confirm" type="password" value="" class="input.focus p r c"></em></span>
                                    </li>
                                </ul>
                                <ul class="loginSubmit">
                                    <li id="updatePassword_submit" class="form.validate click">Update</li>
                                </ul>
                            </fieldset>
                        </form>
                    </div>
            	<cfelse>
                    <div class="loginBox" id="large">	
                        <form>         
                            <fieldset class="welcomeLogin">
                            <legend class="cufonNY">MEMBER LOGIN</legend>
                                <ul>
                                    <li>
                                        <label id="email">e-mail</label>
                                        <span><em><input name="email" type="email" value="" class="input.focus r"></em></span></li>
                                    </li>
                                    <li>
                                        <label id="password">password</label>
                                        <span><em><input name="password" type="password" value="" class="input.focus p r"></em></span>
                                    </li>
                                </ul>
                                <ul class="loginSubmit">
                                    <li id="forgotPassword" class="password.forgot forgotPassword click">Forgot Password?</li>
                                    <li id="createAccount_submit" class="form.validate memberLogin click"></li>
                                </ul>
                        	</fieldset>
                      	</form>
                    </div>
                    <cfif url.cookie neq 1>
                        <p class="noAccount">Don't have an account?&nbsp;&nbsp;<a href="/pr/signupSplash.cfm">Sign up</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/ourservice">Learn More</a></p>
                    </cfif>
                </cfif>
            	</div>
				<div class="socializeWithUs"> 
                    <ul>
                        <li><a href="http://www.twitter.com/pongoresume" target="_blank" class="Twitter">Twitter</a></li>
                        <li><a href="http://www.facebook.com/pongoresume" target="_blank" class="Facebook">Facebook</a></li>
                        <li><a href="http://www.youtube.com/pongoresume" target="_blank" class="YouTube">YouTube</a></li>
                        <li><a href="http://www.linkedin.com/groups?mostPopular=&gid=3452108" target="_blank" class="LinkedIn">LinkedIn</a></li>
                    </ul>
            	</div>
            </div>
       	</div>
        <cfinclude template="../shared/footer_Signup.cfm">   
    </div>
    <br clear="all">
     
</body>
</cfoutput>
</html>