<cfcomponent output="false">
	<cffunction name="handleVideoPopup" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
	
		<cfset videoBean = event.getBean("content").loadBy(contentID=event.getValue("contentID"), siteID=event.getValue("siteID")) />
		
		<cfswitch expression="#event.getValue('videoType')#">
			<cfcase value="blog">
				<cfset videoURL = videoBean.getValue('videoURL')>
			</cfcase>
			<cfcase value="interviewee,interviewer" delimiters=",">
				<cfset videoURL = videoBean.getValue('#event.getValue('videoType')#VideoURL')>
			</cfcase>
			<cfdefaultcase>
				<cfset videoURL = "http://pongo.synthenet.com/pr/flash/videos/bigguns.flv">
			</cfdefaultcase>
		</cfswitch>
				
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#event.getValue('eventName')#_content data abs v_center h_center close" id="poppycock">
				<div style="margin-top:15px;height:395px;width:660px;">
					<cfinclude template="/pr/flash/videoPlayer/popup/popupPlayer.cfm">
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>