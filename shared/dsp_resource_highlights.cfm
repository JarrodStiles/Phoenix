<cfset feedNameList = "Resources Recent Articles,Resources Recent Videos,Resources Recent Polls">
  
<cfloop list="#feedNameList#" index="thisFeedName"> 
	<cfset feedBean = getBean("feed").loadBy(name=thisFeedName, siteID=event.getValue("SiteID"))>
	<cfset iterator = feedBean.getIterator()>
	<cfsilent>
		<cfset checkMeta=feedBean.getDisplayRatings() or feedBean.getDisplayComments()>
		<cfset doMeta=0 />
	</cfsilent>
	<div class="resources">
     	<cfloop from="1" to="2" index="listing">
			<cfsilent>
				<cfset item=iterator.next()>
				<cfif checkMeta> 
					<cfset doMeta=item.getValue('type') eq 'Page' or showItemMeta(item.getValue('type')) or (len(item.getValue('fileID')) and showItemMeta(item.getValue('fileEXT')))>
				</cfif>					
			</cfsilent>
			<cfset theGrandParent = item.getParent().getParent()>
			<cfset theParent = item.getParent()>
			<cfif theGrandParent.getTitle() EQ "Resources">
				<cfset resourceCategory = theParent.getTitle()>
			<cfelse>
				<cfset resourceCategory = theGrandParent.getTitle()>
			</cfif>
			
			<cfif resourceCategory IS "Videos">
				<cfset varWidth = "videoWidth">
				<cfset dtclass = "video">
			<cfelse>
				<cfset varWidth = "articleWidth">
				<cfset dtclass = "image">
			</cfif>

			<cfoutput>
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
			</cfoutput>
		</cfloop>
	</div>
</cfloop>