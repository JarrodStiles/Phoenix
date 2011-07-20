<cfcomponent output="false">	
	<cffunction name="handlePostSuccessStory" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfset policyBean = event.getBean("content").loadBy(contentID="55B1090B-B5E0-09CC-FFB977CB7DE5D8AC", siteID="pr")>
		<cfoutput>
		<cfsavecontent variable="local.content">
		<div class="#arguments.event.getValue('eventName')#_content data left top close">
			<!---<div class="win #arguments.event.getValue('eventName')#Confirm" class="#arguments.event.getValue('eventName')#Confirm">
		</div>--->
		<div class="#arguments.event.getValue('eventName')#Content">
			<div id="successStoryDivArea" class="">
				<h4 class="cufonNY">Submit Your Success Story</h4>
				<div id="slidePanel">
					<div class="slideContainer">
						<div class="slide1">
							<p class="cufonLondon instruct">Him shot fetched ya pick-up, trespassin'. Bull poker gospel skinny firewood yer whiskey confounded co-op pot. </p>
							<form id="sendSuccessStory" method="post" class="ajaxForm wait">
								<fieldset class="accountInfo">
									<div class="formError"></div>
									<ul class="left">
										<li class="scs_FirstName">
											<label>First Name</label>
											<span><em>
											<input type="text" name="firstName" class="input.focus r">
											</em></span></li>
										<li class="scs_LastName">
											<label>Last Name</label>
											<span><em>
											<input type="text" name="lastName" class="input.focus r">
											</em></span></li>
										<li class="scs_email">
											<label>E-Mail</label>
											<span><em>
											<input type="text" name="email" class="input.focus r e">
											</em></span></li>
										<li class="scs_emailConfirm">
											<label>Confirm E-Mail</label>
											<span><em>
											<input type="text" name="email_confirm" class="input.focus r e c">
											</em></span></li>
										<li class="scs_story">
											<span><textarea name="story" class="input.focus r"></textarea></span>
										</li>
									</ul>
									<ul class="terms">
										<li><span id="fauxCheck" class="checkState click">Please read and agree to <a id="slidePanel_next" class="panel.next click">let us use your story.</a></span><input name="successStory_agreeTerms" type="checkbox" value="" class="hideCheckBox input.focus r" /></li>
										<li> <a id="sendSuccessStory_submit" class="form.validate click scs_submit">Submit</a></li>
									</ul>
								</fieldset>
							</form>
						</div>
						<div class="slide2">
							<div class="slide2_innerContainer">
								<h5 class="cufonLondon">Pongo Usage Agreement</h5>
								#policyBean.getBody()# </div>
							<p><a id="slidePanel_prev" class="panel.prev checkState click scs_agree" onClick="$('input[name=successStory_agreeTerms]').attr('checked', true);$('##fauxCheck').removeClass('error');$('##fauxCheck').addClass('checked');$('##fauxCheck').siblings('.validationMsg').css('visibility', 'hidden');">Agree</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
			
	<cffunction name="handleSendSuccessStory" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
	  <!---Submit to database--->
		<cfquery name="update_stats" datasource="pongoresume">
			INSERT INTO		successStory
							(
							firstName,
							lastName,
							emailAddress,
							successStory
							)
			VALUES			(
							<cfqueryparam value="#arguments.event.getValue('firstName')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#arguments.event.getValue('lastName')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#arguments.event.getValue('email')#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#arguments.event.getValue('story')#" cfsqltype="cf_sql_longvarchar" >
							)
		</cfquery>
	  <!---Send e-mail to content team--->
		<cfmail to="jstiles@pongoresume.com" from="pongo@pongoresume.com" subject="Success Story Submission" type="html">
			<p>
				Name: #arguments.event.getValue('firstName')# #arguments.event.getValue('lastName')#<br />
				E-Mail: #arguments.event.getValue('email')#
			</p>
			<p>
				#arguments.event.getValue('story')#
			</p>
		</cfmail>

		<cfsavecontent variable="local.content">	 
	  		<div id="sendSuccessStoryResult"></div>
	  	</cfsavecontent>

		<cfreturn local.content />
	</cffunction>
</cfcomponent>