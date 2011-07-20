<cfsetting showdebugoutput="no">
<cfoutput>
  <cfinclude template="../shared/html_head.cfm" />
  <cfif findNoCase("MSIE 6", cgi.HTTP_USER_AGENT)>
    <!--- fix IE6 png transparency --->
    <script src="../js/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>
    DD_belatedPNG.fix('.ie6_png');
  </script>
  </cfif>
  <body id="builder" class="">
  <!-- IE 6 hacks -->
  <!--[if lt IE 7]>
    <script src="../js/IE7.js" type="text/javascript"></script> 
<![endif]-->
<!--- tab button for video site tour --->
<a id="videoPopup_#request.contentBean.getContentID()#_videoTour" class="video_popup.show click videoTour">Video Site Tour</a>
<!--- Get related content and check for a related poll --->
<cfset sectionBean = getBean("content").loadBy(contentID="#request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].contentID#", siteID=event.getValue("siteID"))>
<cfset sidePollIterator = sectionBean.getRelatedContentIterator()>

<cfset hasSidePollFlag = 0>
<cfif sidePollIterator.getRecordCount() GT 0>
	<cfloop condition="sidePollIterator.hasNext()">
		<cfset pollSideData = sidePollIterator.next()>
		<cfif pollSideData.getParent().getValue('title') IS "Polls">
			<cfset hasSidePollFlag = 1>
			<cfbreak>
		</cfif>			
	</cfloop>
</cfif>
<!--- End check for related poll --->

<div id="containerMainBuilder" class="wrapper">
    <cfinclude template="../shared/headerBuilder.cfm">
    #$.renderTabs($)#
  	<cfinclude template="../shared/footer.cfm">
</div>
  <br clear="all">
  </body>
</cfoutput>
</html>