<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: Page Layout for Our Services Pages
Purpose: [Enter a description explaining how this file is used]
Last Updated: 7/18/2011 by jstiles
--->

<!--- TODO: Invoke service to get page copy --->

<cfoutput>
<div class="bodyContent">
	<div class="pageTitleBar">
		<h2 class="fauxshadow">Our Service</h2>
		<h2 class="pagetitle">Our Service</h2>
	</div>
		
	<div class="innerBodyContent">
    	<div class="innerLeftColumn">
			<cfinclude template="../sidebar/dsp_navigation.cfm" />
			<cfif hasSidePollFlag>
				<cf_displayPoll pollData="#pollSideData#" />
			</cfif>
		</div>
		
		<div class="innerRightColumn">
			<div class="innerRightContent">
				<h2></h2>
				<div class="innerContentMargin">
					<div id="billboardDemo">
						<!--- Flash Content Here --->
					</div>
					<div class="">
                        <div class="serv_col1" id="Service">
                            <div class="inner">
                            	<p>What truly sets <a href="/site-map/">Pongo</a> apart is our dedicated team of resume and career experts whose mission is to support you throughout the job search process.<br />
								<br />
								By phone, e-mail, or live chat, our friendly professionals will work with you one-on-one to ensure your success.<br />
								<br />
								Our support team is the best in the business. They receive extensive training, earn certification through the Professional Association of Resume Writers, and keep up with the latest trends through continuous education and research.<br />
								<br />
								Whether your issue is which button to click next, or how to explain a gap in your resume, any team member can provide the expert advice and guidance you need.<br />
								<br />
								We want you to succeed. And we're here to help make it happen.</p>
							</div>
                        </div>						
                        <div class="serv_col2">
                            <p class="signup"><a href="../membership/signupSplash.cfm"><img src="../images/btn_signup_today_38x160.png" width="160" height="38"></a></p>
                            <div id="videoPopup_videoTour" class="video_popup.show click videoTourServices">Video Site Tour</div>
                            <div class="inner">
                                <h3 class="cufonLondon">What You Get</h3>
                                <ul>
                                	<li>Assistance from Certified Professional Resume Writers</li>
									<li>Live Chat (Mon-Fri)</li>
									<li>Answers</li>
									<li>Expert advice and guidance</li>
									<li>Technical support</li>
									<li>Encouragement</li>
									<li>Account assistance</li>                                       
                                </ul>
                            </div>								
                        </div>
                        <div class="cleared">&nbsp;</div>
                    </div>
					<div class="sitetourBar">
                      <div class="inner">
                          <p class="signuptoday_sm"><a id="videoPopup" class="window.show click">Site Tour</a></p>
                          <span class="cufonLondon">Still need to know more about Pongo? Pay Up Big Boy!</span>
                        <div class="cleared">&nbsp;</div>
                      </div>
                    </div>																			
				</div>
			</div>
		</div>
	</div>
</div>
</cfoutput>