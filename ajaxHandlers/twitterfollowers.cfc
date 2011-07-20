<cfcomponent output="yes">	

	<cfset variables.username = 'pongoresume' />
	<!---<cfset variables.url = 'http://api.twitter.com/statuses/followers.xml' />--->
	<cfset variables.url = 'http://api.twitter.com/statuses/followers.json' />	
	<cfset variables.cache_file = 'twitterfollowers.txt' />
	
	<cffunction name='cacheTwitterFollowers' access="public" returntype="void" >
		<cfset local.cache_file = expandpath('.') & '\pr\ajaxhandlers\' & variables.cache_file />
		<cfset local.cache_file = replaceNoCase(local.cache_file, "admin\", "") />	
		<!--- get user data from Twitter --->		
		<cfhttp url="#variables.url#" result="userResponse" method="get" >
			<cfhttpparam type="url" name="id" value="#variables.username#" />
		</cfhttp> 
		<cfset local.users = userResponse.filecontent.toString() />	
		<cffile action="write" file="#local.cache_file#" output="#local.users#" nameconflict="overwrite" />
	</cffunction>
	
	<!---<cffunction name='getTwitterFollowers' access="remote" returntype="string" >
		<cfset local.users = '' />
		<cfset local.cache_file = expandpath('.') & '\' & variables.cache_file />
		<cfif fileExists(local.cache_file) >
			<cffile action="read" file="#local.cache_file#" variable="local.users" />
		</cfif>
		<cfreturn local.users />
	</cffunction>--->
	
	<cffunction name='handlegetTwitterFollowers' access="remote" returntype="string" >
		<cfargument name="event" type="any" required="true" />
		<cfset local.cache_file = 'twitterfollowers.txt' />		
		<cfset local.cache_file = expandpath('.') & '\' & local.cache_file />
		<cfset local.users = '' />
		<cfif fileExists(local.cache_file) >
			<cffile action="read" file="#local.cache_file#" variable="local.users" />
		</cfif>
		<cfcontent type="application/json;" />
		<cfreturn local.users />
	</cffunction>
	
</cfcomponent>