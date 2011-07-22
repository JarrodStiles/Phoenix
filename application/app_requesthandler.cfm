<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: app_requesthandler.cfm
Purpose: Handle all page requests
Last Updated: 7/20/2011 by jstiles
--->
<cfif Isdefined("URL.RequestTimeout")>
	<cfsetting RequestTimeout = "#URL.RequestTimeout#">
</cfif>

<cfset variables.identifier = listfirst(cgi.SCRIPT_NAME,"/") />
<cfset variables.pageRequested = replaceNoCase(listlast(cgi.SCRIPT_NAME,"/"), ".cfm", "") />

<cfif cgi.QUERY_STRING NEQ "">
	<cfset variables.querystring = "?#cgi.QUERY_STRING#" />
<cfelse>
	<cfset variables.querystring = "" />
</cfif>

<cfswitch expression="#variables.identifier#">
	<cfcase value="ourservice">
		<cfset sectionName = "Our Service" />
		<cfset pageName = replace(variables.pageRequested, "-", " ", "all") />
		
		<cfinclude template="../shared/pageTemplate/#variables.identifier#.cfm">
	</cfcase>
	
	
	
	
	<cfcase value="content">
		<cfset form.contentID = val(listgetat(PATH_INFO,2,"/"))>
		
		<cfif form.contentID EQ 11>
			<cflocation url="http://#server_name##variables.localDevPort#/#funnelStartLink#" addtoken="false" statuscode="301">
		</cfif>
		
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		<cfif val(form.contentID) is not 0>
			<cfquery name="content_details" datasource="#datasource#">
				SELECT contentID,title,defaultaction,metadesc,keywords, content, robots
				FROM content
				WHERE contentID = #val(form.contentID)#
			</cfquery>
			<cfset variables.robots = content_details.robots>
			<cfset variables.metadesc = content_details.metadesc>
			<cfset variables.metakeywords = content_details.keywords>
			<cfset variables.pagetitle_DB = lcase(ReReplace(content_details.title,"[^#request.allowedCharsInPageURL#]","-","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfif content_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
				<cfinclude template="app_handler.cfm">
				<cfabort>
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/content/#contentID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
			</cfif>
			
			<cfif form.contentID EQ 11 AND isDefined("cookie.promoCode")>
				<cfset defaultaction = "act_promotions_validate">
			</cfif>
			
			<cfif trim(content_details.defaultaction) EQ "act_affiliateproducts_list">
				<cfif Isdefined("URL.promotionID")>
					<cfparam name="defaultaction" default="act_affiliateproducts_list_sec:returningcustomer=1">
					<cfset form.returningcustomer = "1">
				<cfelse>
					<cfparam name="defaultaction" default="act_affiliateproducts_list">
					<cfset form.returningcustomer = "0">
				</cfif>
			<cfelseif trim(content_details.defaultaction) NEQ "">
				<cfset defaultaction = "#content_details.defaultaction#">
			<cfelse>
				<cfset defaultaction = "act_content_details:contentID=#form.contentID#">
			</cfif>
			<cfset variables.pathoffset = "content/#form.contentID#/">
		<cfelse>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		
		<cfinclude template="app_handler.cfm">
	</cfcase>
	
	<cfcase value="services,servicedetails.cfm">
		<cfif variables.identifier EQ "servicedetails.cfm">
			<cfset form.serviceID = URL.serviceID>
			<cfset variables.pagetitle_URL = "">
			<cfset variables.passQueryString = false>
		<cfelse>
			<cfset form.serviceID = val(listgetat(PATH_INFO,2,"/"))>
			<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
			<cfset variables.passQueryString = true>
		</cfif>
		<cfif Not variables.passQueryString>
			<cfset variables.querystring = "">
		</cfif>
		<cfif val(form.serviceID) is not 0>
			<cfquery name="service_details" datasource="#datasource#">
				SELECT serviceID,servicename,metadesc,keywords
				FROM services
				WHERE serviceID = <cfqueryparam value="#form.serviceID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			<cfset variables.metadesc = service_details.metadesc>
			<cfset variables.metakeywords = service_details.keywords>
			<cfset variables.pagetitle_DB = lcase(ReReplace(service_details.servicename,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "services/#form.serviceID#/">
			<cfif service_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/services/#serviceID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfset defaultaction = "act_services_details:serviceID=#form.serviceID#">
			</cfif>
		<cfelse>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		<cfinclude template="app_handler.cfm">
	</cfcase>
    <cfcase value="articleTopics">
		<cfset form.tagID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		
		<cfif val(form.tagID) is not 0>
			         
            <cfquery name="tag_details" datasource="#datasource#">
				SELECT tagID,tagName
				FROM tags
				WHERE tagID = <cfqueryparam value="#form.tagID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			
			<cfset variables.pagetitle_DB = lcase(ReReplace(tag_details.tagname,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "articleTopics/#form.tagID#/">
			
			<cfif tag_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/articleTopics/#tagID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfset defaultaction = "act_articleTopics_list:tagID=#form.tagID#">
			</cfif>
			
		<cfelse>
			
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			
		</cfif>
		
		<cfinclude template="app_handler.cfm">
		
	</cfcase>
	
	<cfcase value="articles">
		<cfset form.articleID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		<cfif val(form.articleID) is not 0>
			<cfquery name="article_details" datasource="#datasource#">
				SELECT articleID, title, secureFlag
				FROM articles
				WHERE articleID = #val(form.articleID)#
			</cfquery>
			<cfset variables.pagetitle_DB = lcase(ReReplace(article_details.title,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "articles/#form.articleID#/">
			<cfif article_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/articles/#articleID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfif article_details.secureFlag>
					<cfset action = "articles_details_sec">
				<cfelse>
					<cfset defaultaction = "act_articles_details:articleID=#form.articleID#">
				</cfif>
			</cfif>
		<cfelse>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		<cfinclude template="app_handler.cfm">
	</cfcase>

	<cfcase value="newsletters,newsletters.cfm">
		<cfif variables.identifier EQ "newsletters">
			<cfset form.newsletterID = val(listgetat(PATH_INFO,2,"/"))>
			<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
			<cfset variables.pathoffset = "newsletters/#form.newsletterID#/">
		<cfelseif variables.identifier EQ "newsletters.cfm">
			<cfparam name="url.newsletterID" default="0">
			<cfparam name="url.action" default="">
			<cfif url.action EQ "newsletters_details">
				<cfset form.newsletterID = val(url.newsletterID)>
			<cfelseif url.action EQ "act_newsletters_redirect">
				<cfset form.newsletterID = -1>
			<cfelse>
				<cfset form.newsletterID = 0>
			</cfif>
			<cfset variables.pagetitle_URL = "">
			<cfset variables.querystring = "">
		</cfif>
		<cfif val(form.newsletterID) GT 0>
			<cfif form.newsletterID EQ 38>
				<cfquery name="blogPost_details" datasource="#datasource#">
					SELECT title
					FROM blogPosts
					WHERE blogPostID = 128
				</cfquery>
			
				<cfset variables.pagetitle_DB = lcase(ReReplace(blogPost_details.title,"[^#request.allowedCharsInPageURL#]","-","all"))>
				<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
				
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/blogPosts/128/#variables.pagetitle_DB#.cfm">
				<cfabort>
			<cfelse>
				<cfquery name="newsletter_details" datasource="#datasource#">
					SELECT newsletterID,title,metadesc,keywords
					FROM newsletters
					WHERE newsletterID = #val(form.newsletterID)#
				</cfquery>
				<cfset variables.metadesc = newsletter_details.metadesc>
				<cfset variables.metakeywords = newsletter_details.keywords>
				<cfset variables.pagetitle_DB = lcase(ReReplace(newsletter_details.title,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
				<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
				<cfif newsletter_details.recordcount EQ 0>
					<cfheader statuscode="404">
					<cfset defaultaction = "act_content_404">
				<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
					<cfheader statuscode="301" statustext="Moved Permanently">
					<cfheader name="Location" value="http://#server_name##variables.localDevPort#/newsletters/#newsletterID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
					<cfabort>
				<cfelse>
					<cfheader statuscode="200">
					<cfset defaultaction = "act_newsletters_details:newsletterID=#form.newsletterID#">
				</cfif>
			</cfif>
		<cfelseif val(form.newsletterID) EQ 0>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		<cfinclude template="app_handler.cfm">
	</cfcase>
    <cfcase value="blogs,blog" delimiters=",">
		<cfset form.blogID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		<cfif val(form.blogID) is not 0>
			<cfquery name="blog_details" datasource="#datasource#">
				SELECT blogID,blogTitle,metadesc,keywords
				FROM blogs
				WHERE blogID = #val(form.blogID)#
			</cfquery>
			<cfset variables.metadesc = blog_details.metadesc>
			<cfset variables.metakeywords = blog_details.keywords>
			<cfset variables.pagetitle_DB = lcase(ReReplace(blog_details.blogTitle,"[^#request.allowedCharsInPageURL#]","-","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfif blog_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
				<cfinclude template="app_handler.cfm">
				<cfabort>
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/blogs/#blogID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
			</cfif>
			<cfset defaultaction = "act_blogs_list_posts:blogID=#form.blogID#">
			<cfset variables.pathoffset = "blogs/#form.blogID#/">
		<cfelse>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		<cfinclude template="app_handler.cfm">
	</cfcase>
    <cfcase value="blogTopics">
		<cfset form.blogTopicID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		<cfif val(form.blogTopicID) is not 0>
            <cfquery name="blogTopic_details" datasource="#datasource#">
				SELECT blogTopicID, blogTopic, metadesc, keywords, robots
				FROM blogTopics
				WHERE blogTopicID = #val(form.blogTopicID)#
			</cfquery>
			<cfset variables.metadesc = blogTopic_details.metadesc>
			<cfset variables.metakeywords = blogTopic_details.keywords>
			<cfset variables.robots = blogTopic_details.robots>
			<cfset variables.pagetitle_DB = lcase(ReReplace(blogTopic_details.blogTopic,"[^#request.allowedCharsInPageURL#]","-","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfif blogTopic_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
				<cfinclude template="app_handler.cfm">
				<cfabort>
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/blogTopics/#blogTopicID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
			</cfif>
			<cfset defaultaction = "act_blogTopics_list_posts:blogTopicID=#form.blogTopicID#">
			<cfset variables.pathoffset = "blogTopic/#form.blogTopicID#/">
			<cfset customTitle = "#metadesc#">
		<cfelse>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
		</cfif>
		<cfinclude template="app_handler.cfm">
	</cfcase>
    <cfcase value="blogPosts">
		
		<cfset form.blogPostID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		<cfparam name="URL.preview" default="0">
		
		<cfif val(form.blogPostID) is not 0>
			
			<cfquery name="blogPost_details" datasource="#datasource#">
				SELECT blogPostID, title, metadesc, keywords, approved, dateFrom
				FROM blogPosts
				WHERE (
                	blogPostID = <cfqueryparam value="#form.blogPostID#" cfsqltype="cf_sql_numeric" />
                	<cfif NOT URL.preview>
                    AND approved = <cfqueryparam value="1" cfsqltype="cf_sql_numeric" />
    				AND getDate() BETWEEN dateFrom AND dateTo
                    </cfif>
                    ) 
			</cfquery>
			
			<cfset variables.metadesc = blogPost_details.metadesc>
			<cfset variables.metakeywords = blogPost_details.keywords>
			<cfset variables.pagetitle_DB = lcase(ReReplace(blogPost_details.title,"[^#request.allowedCharsInPageURL#]","-","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			
			<cfif blogPost_details.recordcount EQ 0>
			
				<cfif listFind("277", form.blogPostID)>
					<cfheader statuscode="301" statustext="Moved Permanently">
					<cfheader name="Location" value="http://#server_name#/blogs/1/pongo.cfm">
				<cfelseif listFind("412", form.blogPostID)>
					<cfheader statuscode="301" statustext="Moved Permanently">
					<cfheader name="Location" value="http://#server_name#/blogPosts/264/laid-off-try-these-short-term-jobs-to-bridge-the-gap.cfm">
				<cfelse>
					<cfheader statuscode="404">
					<cfset defaultaction = "act_content_404">
					<cfinclude template="app_handler.cfm">
				</cfif>
			
				<cfabort>			
			<!--- <cfelseif listFind("268", form.blogPostID)>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name#/blogs/1/pongo.cfm">
				<cfabort> --->
			
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/blogPosts/#blogPostID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
				
			<cfelse>
				
				<cfheader statuscode="200">
				
			</cfif>
			
			<cfset defaultaction = "act_blogPosts_details:blogPostID=#form.blogPostID#">
			<cfset variables.pathoffset = "blogPost/#form.blogPostID#/">
			
		<cfelse>
			
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			
		</cfif>
		
		<cfinclude template="app_handler.cfm">
		
	</cfcase>
	
	<cfcase value="authors">
		<cfset form.authorID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		
		<cfif val(form.authorID) is not 0>
			
			<cfquery name="author_details" datasource="#datasource#">
				SELECT authorID,lastName,firstName
				FROM authors
				WHERE authorID = <cfqueryparam value="#form.authorID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			
			<cfset variables.pagetitle_DB = lcase(ReReplace(author_details.firstName,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "authors/#form.authorID#/">
			
			<cfif author_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/authors/#authorID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfset defaultaction = "act_authors_details:authorID=#form.authorID#">
			</cfif>
			
		<cfelse>
			
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			
		</cfif>
		
		<cfinclude template="app_handler.cfm">
		
	</cfcase>
	
	<cfcase value="career">
		
		<cfset URL.keywordID = ListLast(ListFirst(PATH_INFO,"-"),"/")>
		
		<cfif isNumeric(URL.keywordID) AND val(URL.keywordID) IS NOT 0>
			<cfquery name="keyword_details" datasource="#datasource#">
				SELECT keyword
				FROM keywords
				WHERE keywordID = <cfqueryparam value="#URL.keywordID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			
			<cfif keyword_details.recordCount>
				<cfset defaultaction = "act_index_list">
				<cfinclude template="app_handler.cfm">
			<cfelse>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name#">
				<cfabort>
			</cfif>
			
		<cfelse>
			
			<cfheader statuscode="301" statustext="Moved Permanently">
			<cfheader name="Location" value="http://#server_name#">
			<cfabort>
			
		</cfif>
		
	</cfcase>
	
    <cfcase value="supportTopics">
		
		<cfset form.tagID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		
		<cfif val(form.tagID) is not 0>    
			     
            <cfquery name="tag_details" datasource="#datasource#">
				SELECT tagID,tagName
				FROM tags
				WHERE tagID = <cfqueryparam value="#form.tagID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			
			<cfset variables.pagetitle_DB = lcase(ReReplace(tag_details.tagname,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "supportTopics/#form.tagID#/">
			
			<cfif tag_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/supportTopics/#tagID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfset defaultaction = "act_supportTopics_list:tagID=#form.tagID#">
			</cfif>
			
		<cfelse>
			
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			
		</cfif>
		
		<cfinclude template="app_handler.cfm">
		
	</cfcase>
	
	<cfcase value="support">	
			
		<cfset form.articleID = val(listgetat(PATH_INFO,2,"/"))>
		<cfset variables.pagetitle_URL = ListLast(ListFirst(PATH_INFO,"."),"/")>
		
		<cfif val(form.articleID) is not 0>
			
			<cfquery name="article_details" datasource="#datasource#">
				SELECT articleID, title, secureFlag
				FROM articles
				WHERE articleID = <cfqueryparam value="#form.articleID#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			
			<cfset variables.pagetitle_DB = lcase(ReReplace(article_details.title,"[^#request.allowedCharsInPageURL#]","#request.replaceWithCharInURL#","all"))>
			<cfset variables.pagetitle_DB = ReReplace(variables.pagetitle_DB,"(#request.replaceWithCharInURL#+)","#request.replaceWithCharInURL#","all")>
			<cfset variables.pathoffset = "support/#form.articleID#/">
			
			<cfif article_details.recordcount EQ 0>
				<cfheader statuscode="404">
				<cfset defaultaction = "act_content_404">
			<cfelseif variables.pagetitle_URL NEQ variables.pagetitle_DB>
				<cfheader statuscode="301" statustext="Moved Permanently">
				<cfheader name="Location" value="http://#server_name##variables.localDevPort#/support/#articleID#/#variables.pagetitle_DB#.cfm#variables.querystring#">
				<cfabort>
			<cfelse>
				<cfheader statuscode="200">
				<cfif article_details.secureFlag>
					<cfset action = "support_details_sec">
                    <cfset msg = "A login is required to view this Support entry.">
				<cfelse>
					<cfset defaultaction = "act_support_details:articleID=#form.articleID#">
				</cfif>
                
			</cfif>
			
		<cfelse>
			
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			
		</cfif>
		
		<cfinclude template="app_handler.cfm">
		
	</cfcase>
	
	<cfdefaultcase>
		
		<cfset variables.request = listlast(listfirst(PATH_INFO,"."),"/")>
		<cfset variables.pathoffset = "">
		<cfif Not FileExists(cf_template_path)>
			<cfheader statuscode="404">
			<cfset defaultaction = "act_content_404">
			<cfinclude template="app_handler.cfm">
			<cfabort>
		</cfif>
		
	</cfdefaultcase>
	
</cfswitch>
