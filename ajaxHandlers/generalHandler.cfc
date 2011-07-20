<cfcomponent output="false">
	<cffunction name="handlePasswordInfo" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#event.getValue('eventName')#_content data right">
				<dl class="infoBlurb">
					<dt>Password Security</dt>
					<dd>Ipsum dolor unim consectetuer et mi vendicio</dd>
				</dl>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleSupportInfo" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#event.getValue('eventName')#_content data close">
				<div class="#event.getValue('eventName')#Content">
					<dl class="supportBlurb">
						<dt>Toll Free Support</dt>
						<dd class="tollFreeNum teal">866-486-4660</dd>
						<dd>Available Monday - Friday 9AM - 5PM</dd>
						<dd>Eastern Standard Time- uga</dd>
					</dl>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleAddThis" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#event.getValue('eventName')#_content data close" id="addThisID">
				<div class="#event.getValue('eventName')#Content" style="width:220px; height:70px;">
					<div class="addthis_toolbox">
						<ul class="column1">
							<li><a class="addthis_button_twitter">Twitter</a></li>	
					        <li><a class="addthis_button_facebook">Facebook</a></li>  
					        <li><a class="addthis_button_linkedin">LinkedIn</a></li>
						</ul>
						<ul class="column2">
							<li><a class="addthis_button_delicious">Delicious</a></li>
							<li><a class="addthis_button_stumbleupon">Stumble</a></li>
					        <li><a class="addthis_button_digg">Digg</a></li>
						</ul>
			    	</div>
				</div> 
				<div class="addthis_toolbox">
					<a href="http://www.addthis.com/bookmark.php?v=250&amp;username=pongo"></a>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>