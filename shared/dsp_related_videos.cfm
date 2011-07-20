<cfset feedName = "Resources - Videos - #request.contentBean.getParent().getTitle()#">
<cfset feedBean = getBean("feed").loadBy(name=feedName, siteID=event.getValue("SiteID"))>
<cfset iterator = feedBean.getIterator()>

<cfif iterator.getRecordCount()>
	<cfset scrollCount = (iterator.getRecordCount()-1)/3>
	<cfif len(scrollCount) GT 1>
		<cfset scrollCount = left(scrollCount, 1) + 1>
	</cfif>
	<cfoutput>
		<h3 class="relatedVideoTitle cufonLondon">Related Videos</h3>
		<div class="relatedVideosContainer">
			<cfif scrollCount GT 1>
				<ul class="carouselCount">
					<cfloop from="1" to="#scrollCount#" index="i">
						<li <cfif i EQ 1>class="counterLED_on"</cfif>></li>
					</cfloop>
				</ul>
			</cfif>
			<span id="carousel#request.contentBean.getContentID()#_prev" class="video_panel.prev rewind click" style="display:none;"></span>
			<div id="carousel#request.contentBean.getContentID()#" class="carousel">
				<ul class="carouselList">
					<cfloop from="1" to="#scrollCount#" index="panes">
						<cfset vidCount = 0>
						<li>
							<cfloop condition="vidCount LESS THAN 3">
								<cfset item=iterator.next()>
								<cfif item.getContentID() NEQ request.contentBean.getContentID() AND item.getContentID() IS NOT "">						
									<cfset rsRating=application.raterManager.getAvgRating(item.getContentID(),item.getSiteID())>
									<div class="carouselVideo"><div><a href="#item.getURL()#" class="playVideoBtn">&nbsp;</a></div><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" class="artshadow"><span class="title">#item.getTitle()#</span><br><span class="category">#item.getParent().getTitle()#</span><span class="ministars_#val(rsRating.theAvg)#"></span></div>
									<cfset vidCount = vidCount + 1>
								<cfelseif item.getContentID() IS "">
									<div class="carouselVideo" style="background:none;"></div>
									<cfset vidCount = vidCount + 1>
								</cfif>
							</cfloop>
						</li>
					</cfloop>
				</ul>
			</div>
			<cfif scrollCount GT 1>
			<span id="carousel#request.contentBean.getContentID()#_next" class="video_panel.next advance click"></span>
			</cfif>
		</div>
	</cfoutput>
</cfif>