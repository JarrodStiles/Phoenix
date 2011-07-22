<cfabort>
<!---<cfset oldTopicList = "30,35,32,31,34,37,36,39">--->
<!---
Resumes (30) 11
Cover Letters (35) 12
Interviews (32) 13
Job Seeker Tips (31) 14
Work/Life (34) 15
In the Workplace (37) 16
Contests (36) 17
Graduation (39) 18
--->
<cfset oldTopicList = "30,35,32,31,34,37,36,39">
<cfset newContentCategoryList = "11,12,13,14,15,16,17,18">

<cfoutput>
<ol>
<cfloop from="1" to="#listLen(oldTopicList)#" index="i">
	<cfset oldTopicID = listGetAt(oldTopicList, i)>
	<cfset newContentCategoryID = listGetAt(newContentCategoryList, i)>
	
	<cfquery name="getPostsByTopic" datasource="pongoVolumeTest">
		SELECT blogPosts.*
		FROM blogPosts
			INNER JOIN blogPostTopics ON blogPosts.blogPostID = blogPostTopics.blogPostID
		WHERE blogPostTopics.blogTopicID = #oldTopicID#
	</cfquery>
	
	<cfloop query="getPostsByTopic">	
		<cfquery name="getPoints" datasource="pongoVolumeTest">
			SELECT SUM(pointValue * totalCount) AS points 
			FROM blogPostPoints
				INNER JOIN blogPointRatings ON blogPostPoints.blogPointRatingID = blogPointRatings.blogPointRatingID
			WHERE blogPostID = <cfqueryparam value="#getPostsByTopic.blogPostID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfquery name="addContent" datasource="phoenix" result="newContent">
			INSERT INTO content
			(
			contentCategoryID
			,pageTitle
			,browserTitle
			,urlTitle
			,subTitle
			,summary
			,body
			,authorID
			,releaseDate
			,releaseTime
			,startDate
			,displayFlag
			,allowCommentsFlag
			,allowRatingsFlag
			,popularScore
			,metaDescription
			,metaRobots
			,originalID
			)
			VALUES
			(
			<cfqueryparam value="#newContentCategoryID#" cfsqltype="cf_sql_integer" />
			,<cfqueryparam value="#getPostsByTopic.title#" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="#getPostsByTopic.browserTitle#" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="#listLast(getPostsByTopic.linkTitle, '/')#" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="#getPostsByTopic.summary#" cfsqltype="cf_sql_longvarchar" />
			,<cfqueryparam value="#getPostsByTopic.content#" cfsqltype="cf_sql_longvarchar" />
			,<cfqueryparam value="#getPostsByTopic.authorID#" cfsqltype="cf_sql_integer" />
			,<cfqueryparam value="#getPostsByTopic.dateFrom#" cfsqltype="cf_sql_timestamp" />
			,'#timeformat(getPostsByTopic.dateFrom, "h:mm tt")#'
			,<cfqueryparam value="#getPostsByTopic.dateFrom#" cfsqltype="cf_sql_timestamp" />
			,<cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			,<cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			,<cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			,<cfqueryparam value="#val(getPoints.points)#" cfsqltype="cf_sql_integer" />
			,<cfqueryparam value="#getPostsByTopic.metaDesc#" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="#getPostsByTopic.robots#" cfsqltype="cf_sql_varchar" />
			,<cfqueryparam value="#oldTopicID#" cfsqltype="cf_sql_integer" />
			)
		</cfquery>
		
		<!--- Query for comments to import those --->
		<cfquery name="getComments" datasource="pongoVolumeTest">
			SELECT 	* 
			FROM 	blogComments 
			WHERE 	blogPostID = #getPostsByTopic.blogPostID#
					AND approved = 1
			ORDER BY creationDate
		</cfquery>
		
		<cfif getComments.recordCount>
			<cfloop query="getComments">
				<cfquery name="addComment" datasource="phoenix">
					INSERT INTO contentComments
					(
					contentID
					,comment
					,approvedFlag
					,accountID
					,email
					,name
					,website
					,ipAddress
					,createdDate
					)
					VALUES
					(
					<cfqueryparam value="#newContent.IDENTITYCOL#" cfsqltype="cf_sql_integer" />
					,<cfqueryparam value="#getComments.blogComment#" cfsqltype="cf_sql_longvarchar" />
					,<cfqueryparam value="#getComments.approved#" cfsqltype="cf_sql_bit" />
					,<cfqueryparam value="#getComments.accountID#" cfsqltype="cf_sql_integer" />
					,<cfqueryparam value="#getComments.email#" cfsqltype="cf_sql_varchar" />
					,<cfqueryparam value="#getComments.name#" cfsqltype="cf_sql_varchar" />
					,<cfqueryparam value="#getComments.website#" cfsqltype="cf_sql_varchar" />
					,<cfqueryparam value="#getComments.ipAddress#" cfsqltype="cf_sql_varchar" />
					,<cfqueryparam value="#getComments.creationDate#" cfsqltype="cf_sql_timestamp" />
					)
				</cfquery>
			</cfloop>
		</cfif>
		
		<li>#getPostsByTopic.title#<!---<cfdump var="#content#">---></li>
		<cfflush>
	</cfloop>
</cfloop>
</ol>
</cfoutput>