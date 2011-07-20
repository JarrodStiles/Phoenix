<!---<cfswitch expression="#request.contentBean.getMenuTitle()#">
	<cfcase value="Highlights">
		<cfset searchID = "resourcesSearchLg">
		<cfset searchColor = "teal">
		<cfset searchTitle = "Pongo Resources">
		<cfset searchDesc = "Select one of the topics from the menu at left. Or simply type a keyword, phrase, or question in the box below, then click SEARCH to see available resources related to that topic.">
	</cfcase>
	<cfcase value="Help">
		<cfset searchID = "helpSearch">
		<cfset searchColor = "pongoGreen">
		<cfset searchTitle = "Hi There, Find quick answers to your questions">
		<cfset searchDesc = "">
	</cfcase>
	<cfcase value="Help">
		<cfset searchID = "helpSearchLg">
		<cfset searchColor = "pongoGreen">
		<cfset searchTitle = "Welcome To Our Help Page">
		<cfset searchDesc = "Select one of the topics from the menu at left. Or simply type a keyword, phrase, or question in the box below, then click SEARCH to see available resources related to that topic.">
	</cfcase>
	<cfdefaultcase>
		<cfset searchID = "resourcesSearch">
		<cfset searchColor = "teal">
		<cfset searchTitle = "Hi There, Find quick answers to your questions">
		<cfset searchDesc = "">
	</cfdefaultcase>
</cfswitch>--->
<cfoutput>
<div class="searchBox" id="resourcesSearch">
	<!---<div class="searchTitle subText teal">#searchTitle#</div>--->
		<div class="searchDesc cufonLondon">Cipherin' fit water bull tools wild java caught crop truck.</div>
	<form id="searchForm" method="get" action="/resources/search-results/">
		<input id="newSearch" name="newSearch" value="true" type="hidden"/>
		<input id="display" type="hidden" name="display" value="search"/>
		<input id="nocache" type="hidden" name="nocache" value="1"/>
		<input id="category" type="hidden" name="category" value="resources"/>
		<fieldset class="search">
			<ul>
				<li><span><em><span id="keywords_lbl" class="label.hide click overlabel">Enter a Question or Keyword</span><input type="text" id="searchField" name="keywords" value=""></em></span></li>
				<li class="searchSubmit"><a href="##" onclick="$('##searchForm').submit();"><img src="#application.themePath#/images/btn_search_icon_37x27.png" alt="Search" width="37" height="27" /></a></li>
			</ul>
		</fieldset>
	</form>
</div>
</cfoutput>