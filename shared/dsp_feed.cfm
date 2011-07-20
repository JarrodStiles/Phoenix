<!---
	Displays Feeds for Listing Pages exc. Highlights (see dsp_<section>_higlights.cfm files)
--->

<cfparam name="hasSummary" default="true"/>
<cfparam name="averageRating" default="0">
<cfset sectionName = request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].menutitle>
<cfset feedBean=application.feedManager.read(arguments.objectID) />
<cfset cssID=createCSSid(feedBean.renderName())>
<cfset editableControl.editLink = "">
<cfset editableControl.innerHTML = "">
		
<!--- Initiate feed by setting iterators and next-N paging values --->
<cfsilent>
	<cfset rsPreFeed=application.feedManager.getFeed(feedBean) />
	<cfif getSite().getExtranet() eq 1 and request.r.restrict eq 1>
		<cfset rs=queryPermFilter(rsPreFeed)/>
	<cfelse>
		<cfset rs=rsPreFeed />
	</cfif>
	
	<cfset iterator=application.serviceFactory.getBean("contentIterator")>
	<cfset iterator.setQuery(rs,feedBean.getNextN())>
	<cfset rbFactory=getSite().getRBFactory() />
	<cfset checkMeta=feedBean.getDisplayRatings() or feedBean.getDisplayComments()>
	<cfset doMeta=0 />
	<cfset event.setValue("currentNextNID",feedBean.getFeedID())>
	
	<cfif not len(event.getValue("nextNID")) or event.getValue("nextNID") eq event.getValue("currentNextNID")>
		<cfif event.getContentBean().getNextN() gt 1>
			<cfset currentNextNIndex=event.getValue("startRow")>
			<cfset iterator.setStartRow(currentNextNIndex)>
		<cfelse>
			<cfset currentNextNIndex=event.getValue("pageNum")>
			<cfset iterator.setPage(currentNextNIndex)>
		</cfif>
	<cfelse>	
		<cfset currentNextNIndex=1>
		<cfset iterator.setPage(1)>
	</cfif>
	
	<cfset nextN=application.utility.getNextN(rs,feedBean.getNextN(),currentNextNIndex)>
</cfsilent>
  	
<cfif iterator.getRecordCount()>
	<div class="resources">
		<cfloop condition="iterator.hasNext()">
			<cfsilent>
				<cfset item=iterator.next()>
				<cfset class=""/>
				<cfif not iterator.hasPrevious()> 
					<cfset class=listAppend(class,"first"," ")/> 
				</cfif>
				<cfif not iterator.hasNext()> 
					<cfset class=listAppend(class,"last"," ")/> 
				</cfif>				
				<cfset hasImage=len(item.getValue('fileID')) and showImageInList(item.getValue('fileExt')) />	
				<cfif hasImage>
					<cfset class=listAppend(class,"hasImage"," ")>
				</cfif>
				<cfif checkMeta> 
					<cfset doMeta=item.getValue('type') eq 'Page' or showItemMeta(item.getValue('type')) or (len(item.getValue('fileID')) and showItemMeta(item.getValue('fileEXT')))>
				</cfif>
			</cfsilent>
			
			<!--- Set family tree and initial classes --->		
			<cfset theParent = item.getParent()>	
			<cfset theGrandParent = theParent.getParent()>
			<cfset dtclass = "image">
			<cfset varWidth = "articleWidth">
			<cfif len(item.getValue('videoURL'))>
				<cfset dtclass = "video">
				<cfset varWidth = "videoWidth">
			</cfif>
			
			<cfoutput>
				<cfswitch expression="#sectionName#">
					<!--- ****************** Blog Section ******************** --->
					<cfcase value="Blog">
						<div class="blog txp">					
							<dl>				
								#dspObject_Include(thefile='dsp_ratings.cfm')#					
								<!--- Add video play button for video thumbs --->
								<cfif len(item.getValue('videoURL'))>
									<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
								</cfif>					
								<!--- Display listing based on section --->
								<cfset contentCategory = theParent.getTitle()>
								<cfif len(item.getValue('videoURL'))>
									<cfset varWidth = "blogVideoWidth">
								<cfelse>
									<cfset varWidth = "blogWidth">
								</cfif>
								<cfset authorBean = getBean("content").loadBy(remoteID=listFirst(item.getValue("author")), siteID=event.getValue("SiteID"))>
								<!--- Show image thumb & link --->
								<dt class="#dtclass#">
									<a href="#item.getURL()#"><cfif len(item.getValue('fileID'))><img src="#application.configBean.getContext()#/tasks/render/file/?fileID=#item.getValue('fileID')#" alt="Blog Post Image" class="artshadow"><cfelse><img src="#application.themePath#/images/listDefaultIcon#randRange(1,13)#.png" alt="Blog Post Image" class="artshadow"></cfif></a>
								</dt>
								<!--- Show category --->
								<dt class="date #varWidth#">			
									<a href="#theParent.getURL()#" class="resourceCatList link_on" id="#contentCategory#">#theParent.getTitle()#</a>
								</dt>
								<!--- Show title --->
								<dt class="title subText #varWidth# quotation">
									<a href="#item.getURL()#">#item.getTitle()#</a>
								</dt>
								<!--- Show author name and release time --->
								<dt class="publishDetails #varWidth#">
									<a href="<cfif authorBean.getValue('featuredAuthor') EQ 1>#authorBean.getURL()#<cfelse>/blog/authors/guest-authors</cfif>"><span class="publishedBy">By #item.getValue('author')#</span></a> (#item.getValue('releaseTime')#)</dt>
								<!--- Show calendar icon and summary --->
								<dd class="#varWidth#">
									<dd class="right" style="width:100px;">
										<div class="blogListing">
											<dl class="calendar">
												<dt class="dayofmonth">#dateFormat(item.getValue('releaseDate'),'d')#</dt>
												<dd class="bl">#dateformat(item.getValue('releaseDate'),'mmmm')#</dd>
											</dl>
										</div>
									</dd>	
									<dd class="left" style="width:100%; position:relative;<cfif varWidth EQ "blogVideoWidth">padding-top:44px;<cfelse>padding-top:19px;</cfif>">
										<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
										#replaceNoCase(summary_tmp, "</p>", "","all")#
										<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a></p>
									</dd>
								</dd>
							</dl>
						</div>
					</cfcase>
							
					<!--- ****************** Company Section ******************** --->
					<cfcase value="About Us">
					<cfset contentCategory = theParent.getTitle()>
						<cfif contentCategory EQ "Announcements">
							<div class="inTheNews txp">
								<dl>						
									<!--- Add video play button for video thumbs --->
									<cfif len(item.getValue('videoURL'))>
										<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
									</cfif>
									<cfset contentCategory = theParent.getTitle()>						
									<!--- Show image thumb & link --->						
									<dt class="#dtclass#">
										<a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>><cfif len(item.getValue('fileID'))><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"><cfelse><img src="#application.themePath#/images/listDefaultIcon#randRange(1,13)#.png" alt="Blog Post Image" class="artshadow"></cfif></a>
									</dt>
									<!--- Show release date & category --->
									<dt class="date #varWidth#">
										<cfif isDate(item.getValue('releaseDate'))>
											#LSDateFormat(item.getValue('releaseDate'),getLongDateFormat())#
										</cfif>		
										<a href="#theParent.getURL()#" class="resourceCatList link_on" id="#contentCategory#">#theParent.getTitle()#</a>
									</dt>
									<!--- Show title & subtitle --->
									<dt class="title subText #varWidth# quotation"><a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>>#item.getTitle()#</a></dt>
									<cfif len(item.getSubtitle())>
										<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
									</cfif>
									<!--- Show summary --->
									<dd class="#varWidth#">	
										<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
										#replaceNoCase(summary_tmp, "</p>", "","all")#
										<cfif contentCategory IS "Polls">
											<!--- Set poll link text --->
											<cfif (isDefined('cookie.pollsAnswered') AND listContains(cookie.pollsAnswered,item.getContentID())) OR (isDate(item.getValue('freezeDate')) AND dateCompare(item.getValue('freezeDate'),now()) lte 0)>
												<cfset pollLinkText = "View Poll Results">
											<cfelse>
												<cfset pollLinkText = "Take the Poll">
											</cfif>
												<a id="pollLayer_#item.getContentID()#" class="poll.show link_on dblarrow click ">#pollLinkText#</a>
										<cfelse>
											<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a>
										</cfif>
									</dd>
								</dl>
							</div>	
								
						<cfelse>
							<div class="company txp">
								<dl>
									#dspObject_Include(thefile='dsp_ratings.cfm')#					
									<!--- Add video play button for video thumbs --->
									<cfif len(item.getValue('videoURL'))>
										<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
									</cfif>	
									<cfset contentCategory = theGrandParent.getTitle()>
									<cfif dtclass IS "video">
										<cfset varWidth = "successStoryVideoWidth">
									<cfelse>
										<cfset varWidth = "successStoryWidth">
									</cfif>
									<!--- Conditional styling for Success Story Listing --->
									<style>
										.resources dl	{
											padding-top:0;
										}
										.playVideo	{
											top:57px;
										}
									</style>
									<!--- Show image thumb & link --->
									<dt class="#dtclass#">
										<cfif theParent.getTitle() IS NOT "Short Success Story">
											<a href="#item.getURL()#">
											<img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"></a>
										<cfelse>
											<img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow">
										</cfif>
									</dt>						
									<!--- Show name & occupation --->
									<dt class="profileListingInfo">
										<ul>
											<li class="teal bold">Name:</li>
											<li>#item.getValue('firstName')#&nbsp;#left(item.getValue('lastName'),1)#.</li>
											<cfif len(item.getValue('occupation'))>
												<li class="teal bold" style="padding-top:6px;">Occupation:</li>
												<li>#item.getValue('occupation')#</li>
											</cfif>
										</ul>
									</dt>
									<!--- Show quote --->
									<dt class="title subText #varWidth# quotation">
										#item.getValue('quote')# 
									</dt>
									<cfif len(item.getSubtitle())>
										<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
									</cfif>
									<!--- Show summary --->
									<dd class="#varWidth#">												
										<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
										#replaceNoCase(summary_tmp, "</p>", "","all")# 
										<cfif theParent.getTitle() IS NOT "Short Success Story">
											<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a>
										</cfif>
									</dd>
								</dl>
							</div>
						</cfif>
					</cfcase>
					
					<!--- ****************** In The News ******************** --->
					<cfcase value="In The News">
						<div class="inTheNews txp">
							<dl>						
								<!--- Add video play button for video thumbs --->
								<cfif len(item.getValue('videoURL'))>
									<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
								</cfif>
								<cfset contentCategory = theParent.getTitle()>						
								<!--- Show image thumb & link --->						
								<dt class="#dtclass#">
									<a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"></a>
								</dt>
								<!--- Show release date & category --->
								<dt class="date #varWidth#">
									<cfif isDate(item.getValue('releaseDate'))>
										#LSDateFormat(item.getValue('releaseDate'),getLongDateFormat())#
									</cfif>		
									<a href="#theParent.getURL()#" class="resourceCatList link_on" id="#contentCategory#">#theParent.getTitle()#</a>
								</dt>
								<!--- Show title & subtitle --->
								<dt class="title subText #varWidth# quotation"><a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>>#item.getTitle()#</a></dt>
								<cfif len(item.getSubtitle())>
									<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
								</cfif>
								<!--- Show summary --->
								<dd class="#varWidth#">	
									<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
									#replaceNoCase(summary_tmp, "</p>", "","all")# 
									<cfif contentCategory IS "Polls">
										<!--- Set poll link text --->
										<cfif (isDefined('cookie.pollsAnswered') AND listContains(cookie.pollsAnswered,item.getContentID())) OR (isDate(item.getValue('freezeDate')) AND dateCompare(item.getValue('freezeDate'),now()) lte 0)>
											<cfset pollLinkText = "View Poll Results">
										<cfelse>
											<cfset pollLinkText = "Take the Poll">
										</cfif>
											<a id="pollLayer_#item.getContentID()#" class="poll.show link_on dblarrow click ">#pollLinkText#</a>
									<cfelse>
										<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a>
									</cfif>
								</dd>
							</dl>
						</div>	
					</cfcase>
					
					<!--- ****************** All Other Sections ******************** --->
					<cfdefaultcase>
					<cfset contentCategory = theParent.getTitle()>
						<!--- ****************** Content Category Switching for Polls ******************** --->
						<cfif contentCategory NEQ "Polls">
							<div class="default txp">
								<dl>
									#dspObject_Include(thefile='dsp_ratings.cfm')#
									<!--- Add video play button for video thumbs --->
									<cfif len(item.getValue('videoURL'))>
										<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
									</cfif>						
									<!--- Show image thumb & link --->						
									<dt class="#dtclass#">
										<a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"></a>
									</dt>
									<!--- Show release date & category --->
									<dt class="date #varWidth#">
										<cfif isDate(item.getValue('releaseDate'))>
											#LSDateFormat(item.getValue('releaseDate'),getLongDateFormat())#
										</cfif>		
										<a href="#theParent.getURL()#" class="resourceCatList link_on" id="#contentCategory#">#theParent.getTitle()#</a>
									</dt>
									<!--- Show title & subtitle --->
									<dt class="title subText #varWidth# quotation"><a <cfif contentCategory IS "Polls">id="pollLayer_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>>#item.getTitle()#</a></dt>
									<cfif len(item.getSubtitle())>
										<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
									</cfif>
									<!--- Show summary --->
									<dd class="#varWidth#">	
										<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
										#replaceNoCase(summary_tmp, "</p>", "","all")# 
										<cfif contentCategory IS "Polls">
											<!--- Set poll link text --->
											<cfif (isDefined('cookie.pollsAnswered') AND listContains(cookie.pollsAnswered,item.getContentID())) OR (isDate(item.getValue('freezeDate')) AND dateCompare(item.getValue('freezeDate'),now()) lte 0)>
												<cfset pollLinkText = "View Poll Results">
											<cfelse>
												<cfset pollLinkText = "Take the Poll">
											</cfif>
												<a id="pollLayer_#item.getContentID()#" class="poll.show link_on dblarrow click ">#pollLinkText#</a>
										<cfelse>
											<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a>
										</cfif>
									</dd>
								</dl>
							</div>
						<cfelse>
							<div class="polls txp">
								<dl>
									<!--- Add video play button for video thumbs --->
									<cfif len(item.getValue('videoURL'))>
										<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
									</cfif>						
									<!--- Show image thumb & link --->						
									<dt class="#dtclass#">
										<a <cfif contentCategory IS "Polls">id="pollLayer#item.getContentID()#_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"></a>
									</dt>
									<!--- Show release date & category --->
									<dt class="date #varWidth#">
										<cfif isDate(item.getValue('releaseDate'))>
											#LSDateFormat(item.getValue('releaseDate'),getLongDateFormat())#
										</cfif>		
										<a href="#theParent.getURL()#" class="resourceCatList link_on" id="#contentCategory#">#theParent.getTitle()#</a>
									</dt>
									<!--- Show title & subtitle --->
									<dt class="title subText #varWidth# quotation"><a <cfif contentCategory IS "Polls">id="pollLayer#item.getContentID()#_#item.getContentID()#" class="poll.show click"<cfelse>href="#item.getURL()#"</cfif>>#item.getTitle()#</a></dt>
									<cfif len(item.getSubtitle())>
										<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
									</cfif>
									<!--- Show summary --->
									<dd class="#varWidth#">	
										<cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>
										#replaceNoCase(summary_tmp, "</p>", "","all")#
										<cfif contentCategory IS "Polls">
											<!--- Set poll link text --->
											<cfif (isDefined('cookie.pollsAnswered') AND listContains(cookie.pollsAnswered,item.getContentID())) OR (isDate(item.getValue('freezeDate')) AND dateCompare(item.getValue('freezeDate'),now()) lte 0)>
												<cfset pollLinkText = "View Poll Results">
											<cfelse>
												<cfset pollLinkText = "Take the Poll">
											</cfif>
												<a id="pollLayer#item.getContentID()#_#item.getContentID()#" class="poll.show link_on dblarrow click ">#pollLinkText#</a>
										<cfelse>
											<a href="#item.getURL()#" class="link_on dblarrow"><cfif dtclass IS "image">Continue Reading<cfelse>Watch Video</cfif></a>
										</cfif>
									</dd>
								</dl>
							</div>
						</cfif>
					</cfdefaultcase>
				</cfswitch>
			</cfoutput>
		</cfloop>
			
		<cfif sectionName IS "Company">
			<cfoutput>#dspObject_Include(thefile='dsp_success_submit.cfm')#</cfoutput>
		</cfif>	
		<cfoutput>#dspObject_Include(thefile='dsp_nextN.cfm')#</cfoutput>
	</div> <!---/resources --->
</cfif>