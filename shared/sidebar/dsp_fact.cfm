<cfset feedBean = $.getBean("feed").loadBy(name="Its a Fact", siteID=event.getValue('siteID'))>
<cfset iterator = feedBean.getIterator()>
<cfset item=iterator.next()>

<cfoutput>
	<div class="leftColumnModule module_fact">
		<div class="module_fact_top"></div>
        <h3>It's a Fact!</h3>
		<div class="module_fact_inner">
            <p class="fact_number">###item.getValue("factNumber")#</p>
            <p class="fact_itself">#item.getValue("fact")#</p>
            <cfif len(item.getValue("factSource"))>
				<p class="fact_source"><span>Source:</span> #item.getValue("factSource")#</p>
			</cfif>
		</div>
	</div>
</cfoutput>