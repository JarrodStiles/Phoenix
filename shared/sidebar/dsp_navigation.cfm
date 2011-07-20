<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: dsp_sidebar_navigation.cfm
Purpose: Navigation Component for Sidebar
Last Updated: 7/19/2011 by jstiles
--->

<cfinvoke component="cfc.general" method="getNavigationMenuItems" returnvariable="navigationMenuItems" sectionName="#sectionName#" dsn="phoenix" />

<!--- TODO: 
1) Identify current section
2) Determine if section has a sub menu
3) Determine menu items for logged in members only
--->
<!---<cfif isCurrent>
	<cfset itemClass=listAppend(itemClass,"current"," ")>
	<cfset itemClass="selected">
</cfif>
<cfif (listFindNoCase("Articles,Videos", menuItem.getMenuTitle()) AND menuItem.getParent().getTitle() IS "Resources") AND isCurrent>
	<cfset hasSubMenu = 1>
</cfif>--->
<cfif navigationMenuItems.recordCount>
	<cfoutput>
	<div class="leftColumnModule">
		<h2></h2>
		<ul class="leftNav">			
			<cfloop query="navigationMenuItems">
				<cfif pageName IS navigationMenuItems.categoryName>
					<cfset menuItemSelected = "selected" />
				<cfelse>
					<cfset menuItemSelected = "" />
				</cfif>
				
				<li class="#menuItemSelected#">
					<h6 class="<cfif len(menuItemSelected)>cufonNY<cfelse>cufonLondon</cfif>"><a href="/#replaceNoCase(sectionName, ' ', '', 'All')#/#replaceNoCase(categoryName, ' ', '-', 'All')#.cfm">#navigationMenuItems.categoryName#</a></h6>
					<!---<cfif hasSubMenu>
						<cfset subCurrent = 0>
						<ul class="subNav">
						<cfloop condition="subMenuIterator.hasNext()">
							<cfset subMenuItem = subMenuIterator.next()>
							<cfset itemClass = "">
							<cfset isCurrent = listFind(request.contentBean.getPath(),"#subMenuItem.getContentID()#") />
				
							<cfif isCurrent>
								<cfset itemClass=listAppend(itemClass,"current"," ")>
								<cfset itemClass="subselect">
							</cfif>
							<li<cfif len(itemClass)> class="#itemClass#"</cfif>><a href="#subMenuItem.getURL()#">#subMenuItem.getMenuTitle()#</a></li>
						</cfloop>
						</ul>
					</cfif>--->
				</li>
	        </cfloop>
		</ul>
	</div>
	</cfoutput> 
</cfif> 
<!---<cfif menuItem.getValue("memberContent") IS NOT "Yes">
	<li class="#itemClass#" <cfif len(itemClass) AND hasSubMenu AND menuIterator.recordCount() NEQ menuLast>style="padding-bottom:0;"</cfif>>
		<h6 class="<cfif len(itemClass)>cufonNY<cfelse>cufonLondon</cfif>"><a href="#menuItem.getURL()#">#menuItem.getMenuTitle()#</a></h6>
		<cfif hasSubMenu>
			<cfset subCurrent = 0>
			<ul class="subNav">
			<cfloop condition="subMenuIterator.hasNext()">
				<cfset subMenuItem = subMenuIterator.next()>
				<cfset itemClass = "">
				<cfset isCurrent = listFind(request.contentBean.getPath(),"#subMenuItem.getContentID()#") />
	
				<cfif isCurrent>
					<cfset itemClass=listAppend(itemClass,"current"," ")>
					<cfset itemClass="subselect">
				</cfif>
				<li<cfif len(itemClass)> class="#itemClass#"</cfif>><a href="#subMenuItem.getURL()#">#subMenuItem.getMenuTitle()#</a></li>
			</cfloop>
			</ul>
		</cfif>
	</li>
<cfelseif menuItem.getValue("memberContent") IS "Yes" AND session.loggedInFlag>
	<cfif session.paidMemberFlag>
		<li class="#itemClass#" <cfif len(itemClass) AND hasSubMenu AND menuIterator.recordCount() NEQ menuLast>style="padding-bottom:0;"</cfif>>
			<h6 class="<cfif len(itemClass)>cufonNY<cfelse>cufonLondon</cfif>"><a href="#menuItem.getURL()#">#menuItem.getMenuTitle()# (P)</a></h6>
		</li>
	<cfelse>
		<li class="#itemClass#" <cfif len(itemClass) AND hasSubMenu AND menuIterator.recordCount() NEQ menuLast>style="padding-bottom:0;"</cfif>>
			<h6 class="<cfif len(itemClass)>cufonNY<cfelse>cufonLondon</cfif>"><a href="#menuItem.getURL()#">#menuItem.getMenuTitle()# (F)</a></h6>
		</li>
	</cfif>
</cfif>--->
