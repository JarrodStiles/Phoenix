<cfswitch expression="#eventName#">
	<cfcase value="pollLayer">
		<cfset pollBean = application.contentutility.getBean("content").loadBy(contentID="#contentID#", siteID="pr")>
		<div class="#eventName##contentID#_content left v_center data close">
			<div class="#eventName##contentID#Content">
				<div id="bodyElement" class="left" style="margin-top:13px;">
					<cf_displayPoll pollData="#pollBean#" />
				</div>
				<div style="height: 15px; width: 100%; float: left;">&nbsp;</div>
			</div>
		</div>
	</cfcase>
		
	<cfcase value='commentForm' >												
		<cfset data.insertComment() />
	</cfcase>				
	<cfcase value='memberLoginForm' >			
		<cfif (data.checkCredentials()) >					
			<cfset arrayAppend(resultArr,'<div id="goodCred"></div>') />
		</cfif>
	</cfcase>			
	<cfcase value='successStoryForm' >		
		<cfset data.sendSuccessStory() />		
	</cfcase>			
	<cfcase value= 'ratingForm' >			
		<cfset arrayAppend(resultArr,data.insertRating(event)) />
	</cfcase>
</cfswitch>

<cffunction name="checkCredentials" access="public">
	<cfreturn true>
</cffunction>

<cffunction name="checkSession" access="public">
	<!--- Should get External User Data here even if it replicates then use that instead of mura data--->
	<cfif session.mura.isLoggedIn>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>
	