<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: general.cfc
Purpose: Basic data queires
Last Updated: 7/19/2011 by jstiles
--->

<cfcomponent>
	<cffunction name="getNavigationMenuItems" output="false" returntype="query">		
		<cfargument name="sectionName" type="string" required="true" />
		<cfargument name="dsn" type="string" required="true" />
		
		<cfset var qry_navMenuItems_list = "" />
		
		<cfquery name="qry_navMenuItems_list" datasource="#arguments.dsn#">
			SELECT 	contentCategory.*
			FROM 	contentSection
				INNER JOIN contentCategory ON contentSection.contentSectionID = contentCategory.contentSectionID 
			WHERE 	sectionName = <cfqueryparam value="#arguments.sectionName#" cfsqltype="cf_sql_varchar" />
				AND displayInNavFlag = 1
			ORDER BY contentCategory.sortOrder
		</cfquery>
						
		<cfreturn qry_navMenuItems_list />
	</cffunction>
</cfcomponent>