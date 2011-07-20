<cfset accordionIterator = getBean("content").loadBy(contentID="#request.crumbdata[1].contentID#", siteID=event.getValue("siteID")).getKidsIterator()>
<cfoutput>
	<cfset count = 1>
	<cfloop condition="accordionIterator.hasNext()">
		<cfset panel = accordionIterator.next()>
			<dl class="accordionContainer" id="panel_0#count#">
				<dt>#panel.getTitle()#</dt>
				<dd>
					<div class="accordionOuter">
						<div id="accordion_#count#" class="accordion.show click accordion"><span class="accordionExpand collapse">Read</span></div>
						<div class="accordionInner">#panel.getBody()#</div>
					</div>
				</dd>
			</dl>
		<cfset count = count + 1>		
	</cfloop>
</cfoutput>