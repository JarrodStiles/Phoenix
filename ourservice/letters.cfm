<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: index.cfm
Purpose: Our Service - Letters
Last Updated: 7/18/2011 by jstiles
--->
<cfset sectionName = "Our Service" />
<cfset pageName = "Letters" />

<cfinclude template="../shared/html_head.cfm" />
<body id="ourservice">
	<!-- IE 6 hacks -->
	<!--[if lt IE 7]>
	    <script src="../js/IE7.js" type="text/javascript"></script> 
	<![endif]-->

	<!--- TODO: Check to see if a poll needs to be loaded --->
	<cfset hasSidePollFlag = false />

	<div id="Letters" class="wrapper">
		<cfinclude template="../shared/header.cfm" />
		<cfinclude template="../shared/layout/dsp_ourService.cfm" />
		<cfinclude template="../shared/footer.cfm" />
	</div>
    <br clear="all">
</body>
</html>