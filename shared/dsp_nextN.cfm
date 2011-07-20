

<cfsilent>
<cfparam name="request.sortBy" default=""/>
<cfparam name="request.sortDirection" default=""/>
<cfparam name="request.day" default="0"/>
<cfparam name="request.pageNum" default="1"/>
<cfparam name="request.startRow" default="1"/>
<cfparam name="request.filterBy" default=""/>

<cfparam name="request.currentNextNID" default=""/>
<cfif nextN.recordsPerPage gt 1>
<cfset paginationKey="startRow">
<cfelse>
<cfset paginationKey="pageNum">
</cfif>
<cfset qrystr="" />
<cfset rbFactory=getSite().getRBFactory() />
<cfif len(request.sortBy)>
	<cfset qrystr="&sortBy=#request.sortBy#&sortDirection=#request.sortDirection#"/>
</cfif>
<cfif len(request.categoryID)>
	<cfset qrystr=qrystr & "&categoryID=#request.categoryID#"/>
</cfif>
<cfif len(request.relatedID)>
	<cfset qrystr=qrystr & "&relatedID=#request.relatedID#"/>
</cfif>
<cfif len(request.currentNextNID)>
	<cfset qrystr=qrystr & "&nextNID=#request.currentNextNID#"/>
</cfif>
<cfif len(request.filterBy)>
<cfif isNumeric(request.day) and request.day>
	<cfset qrystr=qrystr & "&month=#request.month#&year=#request.year#&day=#request.day#&filterBy=#request.filterBy#">
</cfif>
<cfelse>
<cfif isNumeric(request.day) and request.day>
	<cfset qrystr=qrystr & "&month=#request.month#&year=#request.year#&day=#request.day#">
</cfif>
</cfif>
</cfsilent>

<style>
a.yearSort, a.yearSort :visited	{
	color:#ccc;
}
</style>
<cfoutput>
	<cfif (sectionName EQ "In The News" AND listFindNoCase("Articles,Press Releases", theParent.getTitle())) OR nextN.numberofpages GT 1>
		<dl class="pagination">
			<!--- year sorting for Press Releases --->
			<cfif sectionName EQ "In The News" AND listFindNoCase("Articles,Press Releases", theParent.getTitle())>
				<dd style="float:left;">
					<ul class="prYearSort">
					<cfloop from="2008" to="#year(now())#" index="theYear">
						<li><a href="#theParent.getURL()##theYear#/" class="<cfif request.contentBean.getTitle() EQ theYear>yearSort<cfelse>link_on</cfif>">#theYear#</a></li>
					</cfloop>
					</ul>
				</dd>
			</cfif>
			
			<cfif nextN.numberofpages gt 1>
			<script>
				var paging = 'true';
			</script>				
				<dd>
					<ul class="moreResults">
					<cfif nextN.currentpagenumber gt 1>
						<li class="navPrev"><a href="?go=1&#xmlFormat('#paginationKey#=#nextN.previous##qrystr#')#" class="dblarrowbck">#rbFactory.getKey('list.previous')#</a></li>
					</cfif>
					<li>Displaying <strong>#currentNextNIndex#-<cfif evaluate(currentNextNIndex + nextN.recordsperpage - 1) GT iterator.recordcount()>#iterator.recordcount()#<cfelse>#evaluate(currentNextNIndex + nextN.recordsperpage - 1)#</cfif></strong> of <strong>#iterator.recordcount()#</strong></li>
					<!---<cfloop from="#nextN.firstPage#"  to="#nextN.lastPage#" index="i"><cfif nextn.currentpagenumber eq i><li class="current">#i#</li><cfelse><li><a href="#xmlFormat('?#paginationKey#=#evaluate('(#i#*#nextN.recordsperpage#)-#nextN.recordsperpage#+1')##qrystr#')#">#i#</a></li></cfif></cfloop>--->
					<cfif nextN.currentpagenumber lt nextN.NumberOfPages>
						<li class="navNext"><a href="?go=1&#xmlFormat('#paginationKey#=#nextN.next##qrystr#')#" class="dblarrow">#rbFactory.getKey('list.next')#</a></li>
					</cfif>
					</ul>
				</dd>
			</cfif>
		</dl>
	</cfif>
</cfoutput>