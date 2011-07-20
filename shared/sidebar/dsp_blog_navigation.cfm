<cfoutput>
  <div class="leftColumnModule module_tabs tabs">
    <div class="tabarea tabs">
      <ul>
        <li id="tab_topics" class=""><a href="##topics" class="tabLink" >Topics</a></li>
        <li id="tab_requests" class=""><a href="##panelRequests" class="tabLink" >Requests</a></li>
        <li id="tab_authors" class=""><a href="##authors" class="tabLink" >Authors</a></li>
      </ul>
    </div>
    <div id="blogNavigation" class="module_inner tabs">
      <div class="module_inner_content" id="topics">
        <ul class="sub_sideNav">
	        <cfset topicIterator = getBean("content").loadBy(filename='Blog', siteID=event.getValue("siteID")).getKidsIterator()>
	        <cfset allPostCount = 0>
	        <cfloop condition="topicIterator.hasNext()">
	            <cfset item=topicIterator.next()>
	            <cfset kidIterator = item.getKidsIterator()>
	            <cfif kidIterator.getRecordCount() GT 0>
					<li><a href="#item.getURL()#" class="link_on">#item.getValue('title')# (#kidIterator.getRecordCount()#)</a></li>
	            	<cfset allPostCount = allPostCount + kidIterator.getRecordCount()>
				</cfif>
	        </cfloop>
          	<li><a href="#application.configBean.getContext()#/blog/" class="link_on">All Posts (#allPostCount#)</a></li>
          	<li class="blog_rss">
					<a href="http://pongo.synthenet.com/tasks/feed/?feedID=B4885BE4-D19D-378F-8B8BD9E99D76B597" target="_blank">Subscribe To RSS Feed</a>
			</li>
        </ul>
      </div>
      <!--- end topics --->
      <div id="panelRequests" class="module_inner_content">
      	<p>Have a specific question or topic that you would like to see Pongo write about?<br />
        Send it in!</p>
        <form id="blogRequestForm" method="post" class="ajaxForm wait">
          <fieldset class="requestInfo">
            <ul class="left">
              <li class="request_email">
                <label>E-Mail</label>
                <span><em><input type="text" name="email" class="input.focus r e"></em></span>
              </li>
              <li class="request_Firstname">
                <label>First Name</label>
                <span><em><input type="text" name="firstName" class="input.focus r"></em></span>
              </li>
              <li class="request_Lastname">
                <label>Last Name</label>
                <span><em><input type="text" name="lastName" class="input.focus r"></em></span>
              </li>
              <li>
                <label>Your Request</label>
                <span class="request_comment">
                <textarea name="request_Commentpost" class="input.focus r"></textarea></span>
              </li>
            </ul>
            <a id="blogRequestForm_submit" class="form.validate click btn_submitRequest">Submit</a>
          </fieldset>
        </form>        
      </div>
      <!--- end requests --->
      <div id="authors" class="module_inner_content">
          <ul class="sub_sideNav">
        <cfset authorIterator=application.feedManager.readByName("Authors",event.getValue('siteID')).getIterator() />
        <cfloop condition="authorIterator.hasNext()">
          <cfset author=authorIterator.next()>
            <li><a href="#author.getURL()#" class="link_on">#author.getValue('firstName')# #author.getValue('lastName')#</a></li>
        </cfloop>
            <li class="guestAuthors"><a href="/blog/authors/guest-authors" class="link_on dblarrow">View Guest Authors</a></li>
          </ul>
      </div>
      <!--- end authors --->
    </div>
  </div>
</cfoutput>