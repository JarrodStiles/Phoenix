<!--Search Boxes -->
<!--- Set SearchBox Theme --->
<cfswitch expression="#request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].menutitle#">
	<cfcase value="Resources">
		<cfset searchID = "resourcesSearchLg">
		<cfset searchColor = "teal">
		<cfset searchTitle = "Pongo Resources">
		<cfset searchDesc = "Select one of the topics from the menu at left. Or simply type a keyword, phrase, or question in the box below, then click SEARCH to see available resources related to that topic.">
	</cfcase>
	<cfcase value="Help">
		<cfset searchID = "helpSearchLg">
		<cfset searchColor = "pongoGreen">
		<cfset searchTitle = "Welcome To Our Help Page">
		<cfset searchDesc = "Select one of the topics from the menu at left. Or simply type a keyword, phrase, or question in the box below, then click SEARCH to see available resources related to that topic.">
	</cfcase>
</cfswitch>
<cfoutput>
<div class="searchBox" id="#searchID#">
	<div class="searchTitle subText #searchColor#">#searchTitle#</div>
	<cfif searchDesc NEQ "">
		<div class="searchDesc">#searchDesc#</div>
	</cfif>
	<form id="searchForm" method="get" action="/resources/search-results/">
		<input name="newSearch" value="true" type="hidden"/><input type="hidden" name="display" value="search"/>
		<input type="hidden" name="nocache" value="1"/>
		<fieldset class="search">
			<ul>
				<li><span><em><label class="" for="search-text">Enter a Question or Keyword</label><input type="text" id="searchField" name="search" value=""></em></span></li>
				<li class="searchSubmit"><a href="##" onclick="$('##searchForm').submit();"><img src="#application.themePath#/images/buttons/btn_search-trans.png" alt="Search" width="80" height="31" /></a></li>
			</ul>
		</fieldset>
	</form>
</div>
</cfoutput>
<!-- /Search Boxes -->