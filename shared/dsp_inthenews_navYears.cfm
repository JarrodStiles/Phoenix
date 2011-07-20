<cfoutput>
<ul class="prYearSort">
	<cfloop from="2008" to="#year(now())#" index="theYear">
		<li><a href="/in-the-news/press-releases/#theYear#/" class="link_on">#theYear#</a></li>
	</cfloop>
</ul>
</cfoutput>