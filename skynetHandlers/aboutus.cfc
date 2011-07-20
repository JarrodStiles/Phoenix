<cfcomponent output="false">
	<cffunction name="handlegetDirections" access="public" output="false" returnType="String">
		<cfargument name="event" type="any" required="true" />		
		
		<cfset directionBean = event.getBean("content").loadBy(contentID="96CC3D1A-EBEE-0C57-9D459904E5378FFE", siteID="pr")>
		<cfsavecontent variable="local.content">
		<cfoutput>
			<div class="#event.getValue('eventName')#_content abs v_center h_center close">
				<div id="getDirections_windowWrapper" class="getDirections">
					<h4>#directionBean.getTitle()#</h4>
					#directionBean.getBody()#
				</div>
			</div>
		</cfoutput>
		</cfsavecontent>		
		<cfreturn local.content />
	</cffunction>
</cfcomponent>