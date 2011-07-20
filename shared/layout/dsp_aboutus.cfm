<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: Page Layout for About Us Pages
Purpose: [Enter a description explaining how this file is used]
Last Updated: 7/18/2011 by jstiles
--->

<!--- TODO: Invoke service to get page copy --->

<cfoutput>
<div class="bodyContent">
	<div class="pageTitleBar">
		<h2 class="fauxshadow">About Us</h2>
		<h2 class="pagetitle">About Us</h2>
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
					<div class="contentData">
						<cfswitch expression="#pageName#">							
							<cfcase value="Who We Are">
								<div id="about_WhoWeAre">
								 <h3 class="banner">Our Mission</h3>
								 <!---#$.getSummary()#
								  </div>
								  <cfloop condition="subIterator.hasNext()">
								  	<cfset subItem = subIterator.next()>
									<div class="about_mission<cfif subIterator.getRecordIndex() MOD 2>_alt</cfif>">
									<img src="#application.configBean.getContext()#/tasks/render/file/?fileID=#subItem.getValue('fileID')#" alt="Who We Are Image">
	                                <h3 class="cufonLondon">#subItem.getTitle()#</h3>
									<p>#subItem.getBody()#</p>
								</div>							
								  </cfloop>--->
							</cfcase>
							<cfcase value="Pongo Team">
								<div id="about_teamValues">
								 <h3 class="banner">Team Core Values</h3>
								  <!---#$.getSummary()#
								  #$.getBody()#
								  </div>
								  <cfloop condition="subIterator.hasNext()">
								  	<cfset subItem = subIterator.next()>
									<div class="about_dept<cfif subIterator.getRecordIndex() MOD 2>_alt</cfif>">
									<img class="ie6_png" src="#application.configBean.getContext()#/tasks/render/file/?fileID=#subItem.getValue('fileID')#" alt="Who We Are Image">
									<h3 class="cufonLondon">#subItem.getTitle()#</h3>
									<p>#subItem.getBody()#</p>
	                                </div>
								  </cfloop>--->
							</cfcase>
							<cfcase value="Contact Us">
								<div id="contact_map" class="">
	                                <div class="contact_directions">
	                                    <h3>We Are Here</h3>
	                                    <p><a id="getDirections" class="window.show click ">Get Directions</a></p>
	                                </div>
	                                <div class="contact_addressBlock">
	                                    <h3 class="cufonNY">Pongo Resume</h3>
	                                    <p>44 Bearfoot Road<br>
	                                    Northborough, MA 01532<br>
	                                    (508) 393-4528</p>
	    
	                                    <p>Toll Free <span class="">(866) 486-4660</span><br>
	                                    Monday - Friday, 9-5 EST</p>
	
	                                    <ul>
	                                        <li class="contact_fb"><a href="http://www.facebook.com/pongoresume" target="_blank">Facebook</a></li>
	                                        <li class="contact_twitter"><a href="http://twitter.com/ask_pongo" target="_blank">Twitter</a></li>                                    
	                                    </ul>
	                                </div>
	                                <div class="contact_csrPic">
	                                    <h3>Real Live People</h3>
	                                    <p>OUR CUSTOMER SERVICE TEAM Bridget, Kati, Dallas, Leslie, Brett, Cassi, Dan</p>
	                                </div>
	                            </div>
							</cfcase>
						</cfswitch>																			
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</cfoutput>