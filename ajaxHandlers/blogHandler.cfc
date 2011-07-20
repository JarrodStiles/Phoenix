<cfcomponent output="false">
	<cffunction name="handleBlogRequestForm" access="public">
		<cfargument name="event" type="any" required="true" />
		
	  	<!---Send e-mail to content team--->
		<cfmail to="jstiles@pongoresume.com" from="pongo@pongoresume.com" subject="Blog Request Submission" type="html">
			<p>
				Name: #event.getValue('firstName')# #event.getValue('lastName')#<br />
				E-Mail: #event.getValue('email')#
			</p>
			<p>
				#event.getValue('request_Commentpost')#
			</p>
		</cfmail>
		<cfoutput>
		<cfsavecontent variable="local.content">	 
	  		<div id="blogRequestFormResult"></div>
	  	</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>