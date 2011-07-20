
<cfcomponent output="false">
	<!--- Updates content and Reset Password form --->
	<cffunction name="handleForgotPassword" access="public">
		<cfargument name="event" type="any" required="true" />
		<cfoutput>
            <cfsavecontent variable="local.content">
            <cfinclude template="#application.themePath#/shared/liveChatOpen.cfm" />	 
                <div class="forgotPasswordProcess">
                    <ol>
                        <li class="title cufonLondon">How the process works.</li>
                        <p class="desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent scelerisque convallis ipsum vel dignissim.</p>
                        <li class="title cufonLondon">How the process works.</li>
                        <p class="desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent scelerisque convallis ipsum vel dignissim.</p>
                    </ol>
                    <span class="chatNow">
                    <cfif liveChatOpen is true>
                    <a onClick="psw8oHow();" class="link_on">Chat Now</a> or call Toll Free 866.486.4660
                    <cfelse>
                    E-Mail Us or <a href="/ourservice">click here</a> to Learn More
                    </cfif></span>
                </div>
                <div class="interactionContainer">
                    <div class="loginBox" id="small">
                        <form id="resetPasswordForm" class="ajaxForm">	         
                            <fieldset class="welcomeLogin">
                            <legend class="cufonNY">RESET PASSWORD</legend>
                                <ul>
                                    <li>
                                        <label id="email">e-mail</label>
                                        <span><em><input name="email" type="email" class="input.focus r e" value=""></em></span></li>
                                    </li>
                                </ul>
                                <ul class="loginSubmit">
                                    <li id="resetPassword" class="password.reset click">Submit</li>
                                </ul>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="socializeWithUs"> 
                    <ul>
                        <li><a href="http://www.twitter.com/pongoresume" target="_blank" class="Twitter">Twitter</a></li>
                        <li><a href="http://www.facebook.com/pongoresume" target="_blank" class="Facebook">Facebook</a></li>
                        <li><a href="http://www.youtube.com/pongoresume" target="_blank" class="YouTube">YouTube</a></li>
                        <li><a href="http://www.linkedin.com/groups?mostPopular=&gid=3452108" target="_blank" class="LinkedIn">LinkedIn</a></li>
                    </ul>
                </div>
            </cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
    
    <!--- Validates e-mail address and sends reset URL --->
    <cffunction name="handleResetPassword" access="public">
		<cfargument name="event" type="any" required="true" />
		<cfoutput>
            <cfparam name="local.content" default="">
            <!---temp email set --->
            <cfset form.email  = "jscaglione@synthenet.com">
            
            <!--- temp server validation --->
            <cfset passed = true>
            
            <!--- Send E-Mail with Reset Link --->
            <cfif passed is true>
                <cfmail to="#form.email#" from="auto-respond@pongoresume.com" subject="Password Reset for Pongo Resume" type="text">
                    Dear username,
                    
                    Please click here to reset your password for your Pongo Resume account or go to http://pongo.synthenet.com/welcome-back/?rp=#form.email#
                    
                    Thank you,
                    Pongo Resume
                </cfmail>
    
                <cfsavecontent variable="local.content">	 
                    <div class="loginBox" id="small">
                        <p class="emailConfirmationTitle cufonNY" style="text-align:center;">PLEASE CHECK YOUR E-MAIL AT:</p>
                        <p class="emailRecipient" style="text-align:center;">#form.email#</p>
                    </div>
                </cfsavecontent>
            </cfif>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
   
   <!--- Validates E-Mail Link params and checks reset flag in db---> 
    <cffunction name="handleResetEmailPassword" access="public">
		<cfargument name="event" type="any" required="true" />
			<cfoutput>
                <cfparam name="local.content" default="">
                    <cfsavecontent variable="local.content">
                    <!--- Test Return --->	 
                        CFC Return E-Mail Validation Test 
                    </cfsavecontent>
            </cfoutput>
		<cfreturn local.content />
	</cffunction>
   
   	<!--- Updates database with new password and displays new content ---> 
    <cffunction name="handleUpdatePassword" access="public">
		<cfargument name="event" type="any" required="true" />
			<cfoutput>
                <cfparam name="local.content" default="">
                    <cfsavecontent variable="local.content">	 
                    <div class="loginBox" id="large">
                        <p class="resetConfirmationTitle cufonNY">YOUR PASSWORD HAS BEEN RESET</p>
                        <p class="resetConfirmationMsg">Shlobblenockle ven mis calipoop mud dea deadly poop.  Un valihatro mus canimoo bah jibbernock trum slaggo. Et mi sus shrinkydink poo poo bobafett.</p>
                        <p class="myAccountBtn"><a href="/members"><img src="#application.themePath#/images/buttons/btn_myaccount.png" height="31" width="112" alt="My Account"></a>
                    </div>
                    </cfsavecontent>
            </cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>
