<cfset relatedIterator = getBean("content").loadBy(contentID="#request.contentBean.getContentID()#", siteID=event.getValue("siteID")).getRelatedContentIterator()>



<cfoutput>
	<!--- Pongo Testimonial Module --->
    <cfif relatedIterator.getRecordCount()> 
	<div id="moduleRelated" class="leftColumnModule">
	<div class="topModuleLeftColumn"></div>
	<h3 class="moduleHeader cufonNY" id="">Related Links</h3>
	<ul class="moduleContent" id="">
	<cfloop condition="relatedIterator.hasNext()">
			<cfset item=relatedIterator.next()>
			<li><a href="#item.getURL()#" class="link_on">#item.getTitle()#</a></li>
		</cfloop>
	</ul>
	
	</div>  
    </cfif> 
	<!---/Pongo Testimonial Module --->
</cfoutput>