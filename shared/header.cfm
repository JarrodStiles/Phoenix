<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: header.cfm
Purpose: Mast head on top of every page
Last Updated: 7/18/2011 by jstiles
--->

<cfif cgi.SERVER_PORT IS "8081">
	<cfset rootLink = "http://#SERVER_NAME#:8081">
<cfelse>
	<cfset rootLink = "http://#SERVER_NAME#">
</cfif>

<cfoutput>
<div class="utilityNavContainer">
	<div class="utilityNav">
        <ul>
            <li id="supportInfo" class="window.show grayL click">Toll Free Support 866.486.4660</li>
            <li id="liveHelp" class="ie6_png"><!---<cfinclude template="provideSupport.cfm">---></li>
            <cfif 1 EQ 0>
				<li ><form id="logoutForm" method="post"><input type="hidden" name="doaction" value="logout"><span id="memberLogout_0" class="form.submit logoutBtn click"></span></form></li>
			<cfelse>
				<li class="divider"><span id="createAccount_0" class="window.show loginBtn click" ></span></li>
			</cfif>
			<li id="signUp"><a href="/membersehip/signupSplash.cfm"><span style="display:block;">Sign Up</span></a></li>
        </ul>
    </div>
</div>
<div class="header">
<!--- <div id="pagepeel" class="xteam-pagepeel">
    <span class="peel">
        <map name="peelmap">
            <area shape="poly" coords="0,0,614,0,614,614,0,0" title="Go!" href="##" class="peel-hotzone" />
        </map>
        <img src="#themepath#/images/page-peel.png" alt="" class="peel" />
        <span class="back corner"></span>
        <span class="back link">
            <img src="#themepath#/images/trans.gif" alt="" class="map" usemap="##peelmap" />
            <span class="peel-content">

            </span>
        </span>
    </span>
</div> --->
<!---<div id="pageflip" class="pageflip.show hover">
		<a href="#contest.getURL()#">
			<img src="#themepath#/images/bkg2.png" alt="" class="ie6_png"/>
			<span class="msg_block" style="background:url(#themepath#/images/corner_bkg2.png) no-repeat right top;">Special Offer</span>
			<!---<span class="msg_block" style="background:url(#application.configBean.getContext()#/tasks/render/file/?fileID=#contest.getValue('fileID')#) no-repeat right top;">Special Offer</span>--->
		</a>
	</div> --->
    <div class="companyLogo"><a href="#rootLink#"><img src="../images/pongo.png" width="215" height="66" alt="Pongo Resume" title="Pongo Resume"></a></div>
    <div class="siteNav">
        <ul>
        	<!---<cfset sectionName = "HOME">---> <!--- TODO: Set the section name --->
			<cfif 1 EQ 1><!--- TODO: If page loaded is not homepage, then display home button --->
            	<li id="homeNav" class="ie6_png cufonLondon"><a href="#rootLink#">HOME</a></li>
			</cfif>
            <li id="servicesNav" class="ie6_png cufonLondon <cfif sectionName EQ "Our Service">selected</cfif>"><a href="#rootLink#/ourservice/">OUR SERVICE</a></li>
            <li id="resourcesNav" class="ie6_png cufonLondon <cfif sectionName EQ "Resources">selected</cfif>"><a href="#rootLink#/resources/">RESOURCES</a></li>
            <li id="helpNav" class="ie6_png cufonLondon <cfif sectionName EQ "Help">selected</cfif>"><a href="#rootLink#/help/">HELP</a></li>
            <li id="blogNav" class="ie6_png cufonLondon <cfif sectionName EQ "Blog">selected</cfif>"><a href="#rootLink#/blog/">BLOG</a></li>
        </ul>
    </div>
</div> 

<div id="hidden_var">
	<div id="confirm_win" class="popUpGradient ie6_png">
		<div id="confirm">
			<div class="confirm_container">
				<div class="slide1">
					<div class="inner_confirm">
						<h4>Please Wait</h4>
						<p>Your request is being processed...</p>
					</div>
					
					<img class="iconWait" src="../images/icon_waiting.gif" width="41" height="38">
				</div>
				<div class="slide2">
					<div class="inner_confirm">
						<h4>Thank You</h4>
						<p>Your submission was successful.</p>	
					</div>
					<a class="confirm.hide click ie6_png btnContinue">Continue</a>
				</div>
			</div>
		</div>
	</div>
</div>
</cfoutput>
