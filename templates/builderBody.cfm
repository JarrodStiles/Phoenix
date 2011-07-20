<!--- Get related content and check for a related poll --->
<cfset sectionBean = getBean("content").loadBy(contentID="#request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].contentID#", siteID=event.getValue("siteID"))>
<cfset sidePollIterator = sectionBean.getRelatedContentIterator()>

<cfset hasSidePollFlag = 0>
<cfif sidePollIterator.getRecordCount() GT 0>
	<cfloop condition="sidePollIterator.hasNext()">
		<cfset pollSideData = sidePollIterator.next()>
		<cfif pollSideData.getParent().getValue('title') IS "Polls">
			<cfset hasSidePollFlag = 1>
			<cfbreak>
		</cfif>			
	</cfloop>
</cfif>
<!--- End check for related poll --->
<cfoutput>
<div class="bodyContent">
	<div class="innerBodyContent">
    	<div class="innerLeftColumn">
			#renderer.dspObjects(1)#
			<cfif hasSidePollFlag>
				<cf_displayPoll pollData="#pollSideData#" />
			</cfif>
		</div>
		<div class="innerRightColumn">
			<div class="innerRightContent">
				<h2></h2>
				<div class="innerContentMargin">
                <cfif request.contentBean.getParent().getTitle() IS "Help">
                    <cfinclude template="../shared/liveChatOpen.cfm" />
                    <div class="helpbillboard">
                        <div class="csteam">Real People. Real Support. Live Support Available Monday-Friday 9AM-5PM EST</div>
                        <ul id="optionbtns">
                        <cfif liveChatOpen is true>
                            <li class="support"><span id="call" class="ie6 support"></span></li>
                            <li class="support"><span id="chat" class="ie6 support" onClick="psw8oHow();"></span></li>
                        </cfif>
                            <li><a href="" id="email" class="ie6"></a></li>
                            <li><a href="http://www.facebook.com/pongoresume" target="_blank" id="facebook" class="ie6"></a></li>
                            <li><a href="http://twitter.com/pongoresume" target="_blank" id="twitter" class="ie6"></a></li>
                            <li><a href="http://www.linkedin.com/groups?mostPopular=&gid=3452108" target="_blank" id="linkedin"></a></li>
                        </ul> 
                    </div>
                <cfelse>
					<cfif request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].menutitle IS "Blog">
					<h1 class="pageTitle cufonNY">
							<div id="blogHdr">
								<img src="#application.themePath#/images/hdr_blog.png" alt="The Pongo Blog" width="419" height="86" />
							</div>
					</h1>
					<cfelseif request.contentBean.getParent().getTitle() IS "Interviews">
					<h1 class="pageTitle interviewTips">
						<span class="ie6_png">Interview Tips</span>
					</h1>
                    
					<cfelse>
					<h1 class="pageTitle cufonNY">
						#request.contentBean.getTitle()#
					</h1>
					</cfif>
                    
                    <!--- if this is a trial account show this upgrade button --->
                    <a href="##" class="btn_upgradeNow">Upgrade Now</a>
                    </cfif>
					<!---<dl class="getStarted">
						<dt><a href="/pr/signupSplash.cfm"><img src="#themePath#/images/buttons/btn_get_started.png" width="161" height="38"></a></dt>
						<dd id="videoPopup_#request.contentBean.getContentID()#_videoTour" class="video_popup.show click videoTour">Video Site Tour</dd>
					</dl>--->
					#renderer.dspObjects(2)#
					
					<cfif len(request.contentBean.getValue("customCopy"))>
						<div class="contentDescription subText cufonLondon" id="blurbDesc">#request.contentBean.getValue("customCopy")#</div>
					</cfif>
					
					<div class="contentData">
						<cfif len(renderer.dspBody(body=request.contentBean.getbody(),crumbList=0,showMetaImage=0))>
							<div class="contentBody" id="#request.contentBean.getSubType()#">#renderer.dspBody(body=request.contentBean.getbody(),crumbList=0,showMetaImage=0)#</div>
						</cfif>
						#renderer.dspObjects(3)#													
					</div>
					<cfif request.contentBean.getValue('allowCommentRateFlag') IS "Yes">
                   		<cf_displayComments>
                   </cfif>
				</div>
			</div>
		</div>
	</div>
</div>
</cfoutput>
<script type="text/javascript"> Cufon.refresh(); </script>