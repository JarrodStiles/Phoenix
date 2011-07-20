<cfset feedBean = $.getBean("feed").loadBy(name='Blog - Sidebar - Recent Posts', siteID=event.getValue('siteID'))>
<cfset iterator = feedBean.getIterator()>
<cfoutput>
	<div class="leftColumnModule">
		<h2>The Pongo Blog</h2>
		<div class="moduleHeader" id="pongoBlog"></div>
			<div class="moduleContent" id="blogContent">
			<div class="recentPosts">Recent Posts:</div>
			<cfloop condition="iterator.hasNext()">
				<cfset item=iterator.next()>
				<cfset blogBreakPoint = find(" ", item.getValue('summary'), 85)>				
				<dl>
					<dt class="blogTitle">#item.getValue('title')#</dt>
					<dd class="blogDesc">#replaceNoCase(left(item.getValue('summary'), blogBreakPoint-1),"<p>","","all")#...</dd>
					<dd class="blogLink"><a href="#item.getURL()#" class="dblarrow">Continue Reading</a></dd>
				</dl>
			</cfloop>			
		</div>
	</div>
</cfoutput>