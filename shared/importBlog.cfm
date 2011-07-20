<cfabort>
<!---<cfset oldTopicList = "30,35,32,31,34,37,36,39">--->
<!---
Resumes (30) AF7E7863-5056-8D4E-59B11AE22C941EB4
Cover Letters (35) AF7C9982-5056-8D4E-59E6434EF22190BE
Interviews (32) AF798109-5056-8D4E-590B425C69E7B010
Job Seeker Tips (31) AF75E801-5056-8D4E-59DB4D7E80EE1C6C
Work/Life (34) AF720BB3-5056-8D4E-59FF71E789037DD3
In the Workplace (37) 3B669CEB-D4D4-A44F-F6FA5987CD114F27
Contests (36) 3B633BA8-981D-F8E2-523899D86AF6FD5A
Graduation (39) 5B921C04-E73F-0695-C48FDAE40289224F
--->
<cfset oldTopicList = "30,35,32,31,34,37,36,39">
<cfset parentList = "AF7E7863-5056-8D4E-59B11AE22C941EB4,AF7C9982-5056-8D4E-59E6434EF22190BE,AF798109-5056-8D4E-590B425C69E7B010,AF75E801-5056-8D4E-59DB4D7E80EE1C6C,AF720BB3-5056-8D4E-59FF71E789037DD3,3B669CEB-D4D4-A44F-F6FA5987CD114F27,3B633BA8-981D-F8E2-523899D86AF6FD5A,5B921C04-E73F-0695-C48FDAE40289224F">

<cfset content2=application.contentManager.getActiveContent('', 'pr')>
<cfdump var="#content2#" abort="true" >
<cfoutput>
<ol>
<cfloop from="1" to="#listLen(oldTopicList)#" index="i">
	<cfset oldTopicID = listGetAt(oldTopicList, i)>
	<cfset newParentID = listGetAt(parentList, i)>
	
	<cfquery name="getPostsByTopic" datasource="pongoresume_sql2005">
		SELECT blogPosts.blogPostID, title, blogPosts.summary, content, keywords, metaDesc, dateFrom, (firstName + ' ' + lastName) AS author
		FROM blogPosts
			INNER JOIN blogPostTopics ON blogPosts.blogPostID = blogPostTopics.blogPostID
			INNER JOIN authors ON blogPosts.authorID = authors.authorID
		WHERE blogPostTopics.blogTopicID = #oldTopicID#
			AND dateFrom > '7/1/2010'
	</cfquery>
	
	<cfset content2.setParentID("#newParentID#")>
	<cfset content2.setType("Page")>
	<cfset content2.setSubType("BlogPost")>
	<cfloop query="getPostsByTopic">
		<cftry>
		<cfset releaseDate = dateformat(getPostsByTopic.dateFrom,"mm/dd/yyyy")>
		<cfset releaseTime = timeformat(getPostsByTopic.dateFrom, "h:mmtt")>
		<cfset content2.setTitle("#getPostsByTopic.title#")>
		<cfset content2.setMenuTitle("#getPostsByTopic.title#")>
		<cfset content2.setSummary("#getPostsByTopic.summary#")>
		<cfset content2.setBody("#getPostsByTopic.content#")>
		<cfset content2.setReleaseDate("#releaseDate#")>
		
		<cfset content2.setMetaDesc("#getPostsByTopic.metaDesc#")>
		<cfset content2.setMetaKeywords("#getPostsByTopic.keywords#")>
		
		<cfset content2.setRemoteID("#getPostsByTopic.blogPostID#")>
		<cfset content2.setRemoteSource("#getPostsByTopic.author#")>
		<cfset content2.setRemoteURL("#releaseTime#")>
		<cfset content2.setApproved(1)>
		<cfset application.contentManager.add(content2)>
		
		<cfcatch type="any"></cfcatch>
		</cftry>
		<li>#getPostsByTopic.title#<!---<cfdump var="#content#">---></li>
	</cfloop>
</cfloop>
</ol>
</cfoutput>