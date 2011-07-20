<cfcomponent output="false">
	<cffunction name="handleVideoSiteTour" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<!--- this should be local scoped but need to fix include --->
		<cfset videoURL = "http://pongo.synthenet.com/pr/flash/videos/bigguns.flv">
		<cfoutput>
		<cfsavecontent variable="local.content">
				<div class="#event.getValue('eventName')#_content data abs v_center h_center close">
					<div style="margin-top:15px;height:395px;width:660px;">
						<cfinclude template="/pr/flash/videoPlayer/popup/popupPlayer.cfm">
					</div>
				</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	<cffunction name="handleVideoPopup" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
	
		<cfset videoBean = event.getBean("content").loadBy(contentID=event.getValue("contentID"), siteID=event.getValue("siteID")) />
				
		<cfif len(videoBean.getValue('videourl'))>
			<cfset videoURL = videoBean.getValue('videourl')>
		<cfelse>
			<cfset videoURL = "http://pongo.synthenet.com/pr/flash/videos/bigguns.flv">
		</cfif>
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#event.getValue('eventName')#_content data abs v_center h_center close">
				<div style="margin-top:15px;height:395px;width:660px;">
					<cfinclude template="/pr/flash/videoPlayer/popup/popupPlayer.cfm">
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>