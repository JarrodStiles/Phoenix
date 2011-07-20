<cfcomponent output="false">
	<cffunction name="handleRatingForm" access="public" output="false" returntype="String">
		<cfargument name="event" required="true" />
		
		<cfset local.starLabels = "Bantha Fodder,So-so,Ok,Good,Awesome" />
		<cfif isDefined("cookie.preLoginID")>
			<cfset local.userID = cookie.preLoginID />
		<cfelse>
			<cfset local.userID = event.getBean('userBean').getUserID() />
			<cfset cookie.preLoginID = local.userID />
		</cfif>
		<cfset application.raterManager.saveRate(
				event.getValue('contentID'),
				event.getValue('siteID'),
				userID,
				event.getValue('rating')) />

	  <cfset local.userRating=application.raterManager.readRate(arguments.event.getValue('contentID'),arguments.event.getValue('siteID'),userID) />
	  <cfoutput>
	  <cfsavecontent variable="local.result">
		<div id="ratingFormResult">
		#event.getContentRenderer().displayRating(false,true,event.getBean("content").loadBy(contentID=arguments.event.getValue("contentID"), siteID=arguments.event.getValue('siteID')))#
	  	</div>
	  </cfsavecontent>
	  </cfoutput>
	  <cfreturn local.result />
	</cffunction>
</cfcomponent>