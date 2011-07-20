<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: index.cfm
Purpose: Pongo Homepage
Last Updated: 7/18/2011 by jstiles
--->
<cfset sectionName = "Home" />

<!--- Include scripts and styles --->
<cfinclude template="shared/html_head.cfm" />

<body id="homepage" class="home">
    <cfoutput>
	<div id="sysHome" class="wrapper">
        <cfinclude template="shared/header.cfm">
        <div class="bodyContent">
        	<!--- Start Billboard area --->
            <div class="homeBanner">
            	<h2>Prepare To Get Hired!&reg;</h2>
                <p class="pongo_intro">Walking you through the <strong>essential steps</strong> to <strong>job search success</strong> — resume and letter writing, interviewing, salary negotiation and <strong>job offer</strong> acceptance.</p>
                <p><a href="membership/signupSplash.cfm" class="btn_signupHome ie6_png">SIGN UP TODAY!</a></p>
                <p><a id="videoPopup_videoTour" class="video_popup.show click videoTour btn_videoTourHome ie6_png">Video Site Tour</a></p>
            </div>
        	<!--- End Billboard area --->
            <div class="lowerHomeBodyContent">
            	<div class="innerb clearfixed">
                	<cfinclude template="shared/dsp_homepage_inTheNews.cfm" />
					<cfinclude template="shared/dsp_homepage_successStory.cfm" />
					<cfinclude template="shared/dsp_homepage_announcements.cfm" />
                </div>
            </div>
        </div>
        <cfinclude template="shared/footer.cfm">
    </div>
    <br clear="all">
	</cfoutput>
</body>
</html>