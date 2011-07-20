<cfset feedNameList = "In The News - Videos,In The News - Articles,In The News - Press Releases">
  
<cfloop list="#feedNameList#" index="thisFeedName"> 
	<cfset feedBean = getBean("feed").loadBy(name=thisFeedName, siteID=event.getValue("SiteID"))>
	<cfset iterator = feedBean.getIterator()>
	<cfsilent>
		<cfset checkMeta=feedBean.getDisplayRatings() or feedBean.getDisplayComments()>
		<cfset doMeta=0 />
	</cfsilent>
	<div class="left" id="inTheNewsHighlights">
     	<cfloop from="1" to="2" index="listing">
			<cfsilent>
				<cfset item=iterator.next()>
				<cfif checkMeta> 
					<cfset doMeta=item.getValue('type') eq 'Page' or showItemMeta(item.getValue('type')) or (len(item.getValue('fileID')) and showItemMeta(item.getValue('fileEXT')))>
				</cfif>					
			</cfsilent>
			<cfset theGrandParent = item.getParent().getParent()>
			<cfset theParent = item.getParent()>
			<cfif theGrandParent.getTitle() EQ "In The News">
				<cfset resourceCategory = theParent.getTitle()>
			<cfelse>
				<cfset resourceCategory = theGrandParent.getTitle()>
			</cfif>
			
			<cfswitch expression="#resourceCategory#">
				<cfcase value="Articles,Press Releases" delimiters=",">
					<cfset varWidth = "articleWidth">
					<cfset dtclass = "image">
				</cfcase>
				<cfcase value="Videos">
					<cfset varWidth = "videoWidth">
					<cfset dtclass = "video">
				</cfcase>
			</cfswitch>
			
			<cfoutput>
				<div class="inTheNews txp">					
					<dl>
						<cfif resourceCategory EQ "Videos">
							<dt><a href="#item.getURL()#" class="playVideo">&nbsp;</a></dt>
						</cfif>
						<!--- Listing image --->
						<dt class="#dtclass#"><a href="#item.getURL()#"><img src="#createHREFForImage(item.getValue('siteID'),item.getValue('fileID'),item.getValue('fileEXT'),'small')#" alt="Article Image" class="artshadow"></a></dt>
						<!--- /Listing image --->
						<dt class="date #varWidth#"><cfif isDate(item.getValue('releaseDate'))>#LSDateFormat(item.getValue('releaseDate'),getLongDateFormat())#</cfif><a href="../#replaceNoCase(resourceCategory, ' ', '-')#" class="resourceCatList link_on" style="padding-left:8px;"id="#resourceCategory#">#resourceCategory#</a></dt>
						<dt class="title subText #varWidth#"><a href="#item.getURL()#">#item.getTitle()#</a></dt>
						<cfif len(item.getSubtitle())>
							<dt class="subtitle subText #varWidth#">#item.getSubtitle()#</dt>
						</cfif>
						<dd class="#varWidth#"><cfset summary_tmp = #replaceNoCase(item.getSummary(), "<p>", "","all")#>#replaceNoCase(summary_tmp, "</p>", "","all")#<a href="#item.getURL()#" class="link_on dblarrow">Continue Reading</a></dd>
					</dl>
				</div>
			</cfoutput>
		</cfloop>
	</div>
</cfloop>