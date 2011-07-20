<!--- Get the blog post content from mura --->
<cfquery name="getBlogContent" datasource="muraPongo">
	SELECT contentID, remoteID
	FROM tcontent
	WHERE remoteID <> NULL
</cfquery>

<cfloop query="getBlogContent">
	<!--- if the remoteID is numeric then this is most likely a blog post --->
	<cfif isNumeric(getBlogContent.remoteID)>
		<cfquery name="getComments" datasource="pongoresume_sql2005">
			SELECT 	blogComment, 
					creationDate, 
					email, 
					name, 
					website,
					ipAddress 
			FROM 	blogComments 
			WHERE 	blogPostID = #remoteID#
					AND approved = 1
			ORDER BY creationDate
		</cfquery>
		
		<cfif getComments.recordCount>
			<cfloop query="getComments">
				<cfset userID = CreateUUID()>
				<cfset commentID = CreateUUID()>
				<cfquery name="q" datasource="muraPongo">
					INSERT INTO tcontentcomments
						(
							[commentid]
						   ,[contentid]
						   ,[contenthistid]
						   ,[url]
						   ,[name]
						   ,[comments]
						   ,[entered]
						   ,[email]
						   ,[siteid]
						   ,[ip]
						   ,[isApproved]
						   ,[subscribe]
						   ,[userID]
						   ,[parentID]
						   ,[path]
					   )
					VALUES (
								<cfqueryparam value="#commentID#" />,
								<cfqueryparam value="#getBlogContent.contentID#" />,	
								NULL,
								<cfqueryparam value="#getComments.website#" />,
								<cfqueryparam value="#getComments.name#" />,
								<cfqueryparam value="#getComments.blogComment#" />,
								<cfqueryparam value="#getComments.creationDate#" />,
								<cfqueryparam value="#getComments.email#" />,																													
								<cfqueryparam value="pr" />,						
								<cfqueryparam value="#getComments.ipAddress#" />,
								<cfqueryparam value="1" />,
								<cfqueryparam value="0" />,
								<cfqueryparam value="#userID#" />,
								<cfqueryparam value="" />,
								<cfqueryparam value="#commentID#" />
							)
				</cfquery>
			
				<!--- checkContentStats --->
				<cfquery name="checkContentStats" datasource="muraPongo">
					SELECT 	contentID
					FROM 	tcontentstats
					WHERE 	contentID = <cfqueryparam value="#getBlogContent.contentID#" />
				</cfquery>
				<cfif checkContentStats.recordcount>
					<!--- update_stats --->
					<cfquery datasource="muraPongo">
						UPDATE 	tcontentstats
						SET 	comments = comments + 1
						WHERE 	contentID = <cfqueryparam value="#getBlogContent.contentID#" />
					</cfquery>
				<cfelse>
					<!--- insert_stats --->
					<cfquery datasource="muraPongo">
						INSERT INTO tcontentstats(contentID,siteID,comments)
						VALUES (
								<cfqueryparam value="#getBlogContent.contentID#" />,
								<cfqueryparam value="pr" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="1" >
								)
					</cfquery>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
</cfloop>
