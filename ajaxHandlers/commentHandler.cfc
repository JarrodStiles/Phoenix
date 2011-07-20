<cfcomponent output="false">
	<cffunction name="handleCreateComment" access="public" returntype="String">
		<cfargument name="event" type="any" required="true" />				
		<cfsavecontent variable="local.result">
		<cfoutput>
		<div class="#arguments.event.getValue('eventName')#_content data v_center left close" id="commentID">
			<div id="createComment_windowWrapper" class="createCommentContent">
				<h4 class="cufonLondon">Post Your Comment</h4>
				<form id="commentForm" method="post" class="ajaxForm">
					<input type="hidden" name="commentID" value="#createUUID()#" />
					<input type="hidden" name="parentID" value="0" />
					<input type="hidden" name="pageID" value="0" />
					<input type="hidden" name="returnURL" value="#CGI.HTTP_REFERER#" />
					<fieldset class="accountInfo">
						<div class="formError"></div>
						<ul class="left">
							<li class="comment_name">
								<label>Your Name</label>
								<span><em>
								<input type="text" name="name" class="input.focus r">
								</em></span></li>
							<li class="comment_email">
								<label>E-Mail</label>
								<span><em>
								<input type="text" name="email" class="input.focus r e">
								</em></span></li>
							<li class="comment_website">
								<label>Your Website URL</label>
								<span><em>
								<input type="text" name="website">
								</em></span></li>
							<li class="comment_blogPost">
								<span><textarea name="comment_post" class="input.focus r"></textarea></span>
							</li>
						</ul>
						<ul class="terms">
							<li><span id="fauxCheck" class="checkState click">Notify me of follow-up comments via e-mail</span><input type="checkbox" name="commentSubscribe" value="1" class="hideCheckBox  input.focus"/></li>
							<li><a id="#arguments.event.getValue('eventName')#_submit" class="form.validate click scs_submit">Submit</a></li>
						</ul>
					</fieldset>

				</form>
			</div>
		</div>
		</cfoutput>	
		</cfsavecontent>			
		<cfreturn local.result />
	</cffunction>

	<cffunction name="handleCommentForm" access="public" returntype="String">
		<cfargument name="event" type="any" required="true" />		
		<cfset var commentBean = event.getBean('contentManager').getCommentBean() />
		<cfset var args = {
			commentID = arguments.event.getValue('commentID'),
			contentID = arguments.event.getValue('pageID'),
			url = arguments.event.getValue('website'),
			name = arguments.event.getValue('name'),
			email = arguments.event.getValue('email'),
			comments = arguments.event.getValue('comment_post'),
			subscribe = arguments.event.getValue('commentSubscribe'),
			siteID = event.getValue('siteID'),
			isApproved = 1,
			userID = event.getBean('userBean').getUserID()
		} />		
		<cfset commentBean.set(args) />
		<cfif arguments.event.getValue('parentID') neq 0>
			<cfset commentBean.setParentID(arguments.event.getValue('parentID')) />
		</cfif>
		<cfset commentBean.save() />	
		<cfset request.contentBean = application.contentManager.getActiveContent(arguments.event.getValue('pageID'), event.getValue('siteID')) >
		<cfsavecontent variable="local.return">
		<cfoutput>
			<div id="#arguments.event.getValue('eventName')#Result">
				<cf_displayComments>
			</div>
		</cfoutput>
		</cfsavecontent>		
		<cfreturn local.return />
	</cffunction>
	
	<cffunction name="handleCommentsPolicy" access="public" returntype="String">
		<cfargument name="event" type="any" required="true" />		
		<cfset policyBean = event.getBean("content").loadBy(contentID="E4946633-97AF-9028-D5CCE74789FB3B66", siteID="pr")>		
		<cfsavecontent variable="local.return">
		<cfoutput>
			<div class="commentsPolicy_content data abs h_center v_center close">
				<div class="commentsPolicyContent">
					<h2>#policyBean.getTitle()#</h2>
					<p class="legalSize">#policyBean.getBody()#</p>
				</div>
			</div>
		</cfoutput>
		</cfsavecontent>		
		<cfreturn local.return />
	</cffunction>
</cfcomponent>