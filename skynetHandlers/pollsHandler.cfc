<cfcomponent output="false">
	<cffunction name="handlePollForm" access="public" output="false" returntype="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfset local.result = "" />
		<cfparam name="cookie.pollsAnswered" default="" />
		<cfif event.valueExists("pollChoice")>
			<cfset cookie.pollsAnswered = listAppend(cookie.pollsAnswered,form.pollID) />
			<cfset args = {contentID=event.getValue("pollID"),answer=event.getValue("pollChoice")} />
			<cfif isDefined("session.mura.remoteID") and val(session.mura.remoteID) neq 0>
				<cfset args.personID = session.mura.remoteID />
			</cfif>
			<cfset voteResponse = createObject("component","private.com.pongo.poll.pollService").submitVote(argumentCollection=args) />
			<cfset contentBean = event.getBean("content").loadBy(contentID=event.getValue("pollID"), siteID=event.getValue("siteID")) />
			<cfsavecontent variable="local.result">
				<div id="pollFormResult">
				<cf_displayPoll pollData="#contentBean#" voteResponse="#voteResponse#" display="result" layer="true"/>
				</div>
			</cfsavecontent>
		</cfif>
		<cfreturn local.result />
	</cffunction>
	
	<cffunction name="handlePollLayer" access="public" output="false" returntype="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfset local.pollBean = event.getBean("content").loadBy(contentID=event.getValue("contentID"), siteID=event.getValue("siteID")) />
		<cfoutput>

		<cfsavecontent variable="local.result">
			<div class="#event.getValue('eventName')##event.getValue('contentID')#_content left v_center data close">
				<div class="#event.getValue("eventName")#Content">
					<div id="bodyElement" class="left" style="margin-top:13px;">
						<cf_displayPoll pollData="#local.pollBean#" />
					</div>
					<div style="height: 15px; width: 100%; float: left;">&nbsp;</div>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.result />
	</cffunction>
</cfcomponent>