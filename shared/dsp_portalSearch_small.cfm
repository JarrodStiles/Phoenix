<!--Search Boxes -->
<!--- Set SearchBox Theme --->
<cfswitch expression="#request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].menutitle#">
	<cfcase value="Resources">
		<cfset searchID = "resourcesSearch">
		<cfset searchColor = "teal">
		<cfset searchTitle = "Hi There, Find quick answers to your questions">
		<cfset searchDesc = "">
	</cfcase>
	<cfcase value="Help">
		<cfset searchID = "helpSearch">
		<cfset searchColor = "pongoGreen">
		<cfset searchTitle = "Hi There, Find quick answers to your questions">
		<cfset searchDesc = "">
	</cfcase>
</cfswitch>
<cfoutput>
<div class="searchBox" id="#searchID#">
	<div class="searchTitle subText #searchColor#">#searchTitle#</div>
	<cfif searchDesc NEQ "">
		<div class="searchDesc">#searchDesc#</div>
	</cfif>
	<form id="searchForm">
		<fieldset class="search">
			<ul>
				<li><span><em><label class="" for="search-text">Enter a Question or Keyword</label><input type="text" id="searchField" name="search" value=""></em></span></li>
				<li class="searchSubmit"><img src="#application.themePath#/images/buttons/btn_search-trans.png" alt="Search" width="80" height="31"></li>
			</ul>
		</fieldset>
	</form>
</div>
</cfoutput>
<!-- /Search Boxes -->