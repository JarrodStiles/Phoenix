<cfset commentsList = getComments()>

<cfoutput>
  <div class="leftColumnModule module_tabs tabs">
    <div class="tabarea tabs">
      <ul>
        <li id="tab_comments" class=""><a href="##panelComments" class="tabLink" >Comments</a></li>
        <li id="tab_popular" class=""><a href="##panelPopular" class="tabLink" >Popular</a></li>
        <li id="tab_favblogs" class=""><a href="##panelFavBlogs" class="tabLink" >Fav Blogs</a></li>
      </ul>
    </div>
    <div id="" class="module_inner tabs">
      <div id="panelComments" class="module_inner_content">
	  <cfset commentCount = 0>
	  <cfloop query="commentsList">
		<cfset content = $.getBean("content").loadBy( contentID="#commentsList.contentID#", siteID="pr" )>
		
		<cfset section = content.getParent().getParent()>
		<cfif section.getTitle() IS "Blog">
			<cfset commentBreakPoint = find(" ", commentsList.comments, 140)>
			<h5><em><span class="blogPost_commenter">#listFirst(commentsList.name, " ")#</span> commented on:</em> <span class="blogPost_title">#content.getTitle()#</span></h5>
      		<p><cfif commentBreakPoint>&##8220;#replaceNoCase(left(commentsList.comments, commentBreakPoint-1),"<p>","","all")#...&##8221;<cfelse>&##8220;#replaceNoCase(commentsList.comments,"<p>","","all")#...&##8221;</cfif><br><a href="#content.getURL()###comments" class="dblarrow">Continue Reading</a></p>
	  		<cfset commentCount = commentCount + 1>
			<cfif commentCount EQ 5>
				<cfbreak>
			</cfif>
		</cfif>
	  </cfloop>
      </div>
      <!--- end panelComments --->
      <div id="panelPopular" class="module_inner_content">
        <cfset popularIterator=application.feedManager.readByName("Blog - Popular Posts",event.getValue('siteID')).getIterator() />
        <cfloop condition="popularIterator.hasNext()">
          <cfset popular=popularIterator.next()>
		  <cfset authorBean = getBean("content").loadBy(remoteID=listFirst(popular.getValue("author")), siteID=event.getValue("SiteID"))>
            	<h5><a href="#popular.getURL()#" class="link_on">#popular.getValue('title')#</a></h5>
				<p><a href="<cfif authorBean.getValue('featuredAuthor') EQ 1>#authorBean.getURL()#<cfelse>/blog/authors/guest-authors</cfif>"><span class="publishedBy">By #popular.getValue('author')#</span></a> #dateFormat(popular.getValue("releaseDate"), "m/d/yyyy")# (#popular.getValue('releaseTime')#)</p>
        </cfloop>
      </div>
      <!--- end panelPopular --->
      <div id="panelFavBlogs" class="module_inner_content">
        <cfset favBlogIterator=application.feedManager.readByName("Blog - Favorite Blogs",event.getValue('siteID')).getIterator() />
          <ul class="sub_sideNav">
        <cfloop condition="favBlogIterator.hasNext()">
          <cfset favBlog=favBlogIterator.next()>
            <li><a href="#favBlog.getValue('blogURL')#" class="link_on">#favBlog.getValue('title')#</a></li>
        </cfloop>
          </ul>
      </div>
      <!--- end panelFavBlogs --->
    </div>
  </div>
</cfoutput>
