<cfcomponent output="false">
	<cffunction name="handlecreateComment" access="public" returntype="String">
		<cfargument name="event" type="any" required="true" />				
		<cfsavecontent variable="local.result">
		<cfoutput>
		<div class="#arguments.event.getValue('eventName')#_content data v_center left close">
			<div id="createComment_windowWrapper" class="createCommentContent">
				<h4>Post Your Comment</h4>
				<form id="commentForm" method="post" class="ajaxForm">
					<input type="hidden" name="commentID" value="#createUUID()#" />
					<input type="hidden" name="parentID" value="0" />
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
								<label>Your Website (Optional)</label>
								<span><em>
								<input type="text" name="website">
								</em></span></li>
							<li class="comment_blogPost">
								<textarea name="comment_post" class="input.focus r"></textarea>
							</li>
						</ul>
						<p class="terms">
							<input type="checkbox" name="commentSubscribe" value="1" style="vertical-align:baseline;" />
							Notify me of followup comments via e-mail <a id="#arguments.event.getValue('eventName')#_submit" class="form.validate click scs_submit">Submit</a></p>
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
			contentID = arguments.event.getValue('contentID'),
			website = arguments.event.getValue('contentID'),
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
		<cfset request.contentBean = application.contentManager.getActiveContent(arguments.event.getValue('contentID'), event.getValue('siteID')) >
		<cfsavecontent variable="local.return">
		<cfoutput>
			<div id="#arguments.event.getValue('eventName')#Result">
				<cf_displayComments>
			<!---
				<!--- comment reply --->
				<cfif arguments.event.getValue('parentID') neq 0>
					<li>
						<dl class="cr">
							<dd class="commentBubbleB green">
								<div class="upperB green">
									<div class="commentContentB green"><div class="thread" >#paragraphFormat(commentBean.getComments())#</div></div>
								</div> 
								<div style="margin:0 31px -12px 0; float:right;"><a id="createComment_#commentBean.getCommentID()#_#item.getCommentID()#" class="comment.show link_on click">Reply to this comment</a></div>
							</dd>
							<dd class="profileImage"><img src="#application.themePath#/images/pinhead.png" width="50" height="50"></dd>
							<dd class="profileName">#htmleditformat(commentBean.getName())#</dd>
							<dd class="submissionDate">#LSDateFormat(commentBean.getEntered(),"long")#<br />at #LSTimeFormat(commentBean.getEntered(),"short")#</dd>
						</dl>
					</li>
				<!--- comment --->
				<cfelse>
					<li>				
						<dl>
							<dd class="commentBubble green">
								<div class="upper green">
									<div class="commentContent green"><div class="thread">#paragraphFormat(commentBean.getComments())#</div></div>
								</div> 
								<div style="margin:0 31px -12px 0; float:right;"><a id="createComment_#commentBean.getCommentID()#_#commentBean.getCommentID()#" class="comment.show link_on click">Reply to this comment</a></div>
							</dd>
							<dd class="profileImage"><img src="#application.themePath#/images/hankstevens.png" width="50" height="50"></dd>
							<dd class="profileName">#htmleditFormat(commentBean.getName())#</dd>
							<dd class="submissionDate">#LSDateFormat(commentBean.getEntered(),"long")#<br />at #LSTimeFormat(commentBean.getEntered(),"short")#</dd>
							<!---<cfif kidIterator.getRecordCount()>
							<dd class="reply.show replies click">
								<span class="commentNum">There <cfif kidIterator.getRecordCount() EQ 1>is 1 reply<cfelse>are #kidIterator.getRecordCount()# replies</cfif> to this comment</span>
								<span class="view collapse">View</span>
							</dd>
							</cfif>	--->
						</dl>
					</li>				
				</cfif>
			--->
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