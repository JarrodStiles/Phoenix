<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: application.cfm
Purpose: 
Last Updated: 7/21/2011 by jstiles
--->
<cfapplication name="resumebuilder" sessionmanagement="true" sessiontimeout="#createtimespan(2,0,0,0)#">

<cfcookie name="clientdirectory" value="pongosoftware\pongoresume">

<cfparam name="querycachetime" default="0">
<cfparam name="sid" default="0">
<cfparam name="variables.metakeywords" default="">
<cfparam name="variables.metadesc" default="">
<cfparam name="variables.metatages" default="">
<cfparam name="timeout" default="">

<!--- FUSEGUARD WEB APP FIREWALL RUNS FIRST --->
<cfif server_name IS "www.pongoresume.com">
	<cfif NOT IsDefined("server.fuseguard")>
		<cfinvoke component="fuseguard.components.firewall" method="init" returnvariable="server.fuseguard" configurator="MyConfigurator" />
	</cfif>
	<cfset server.fuseguard.processRequest()>
</cfif>
<!--- END FUSEGUARD --->

<!--- Set default variables --->
<cfset applicationName = "pongoresume" />
<cfset application.baseURL = "www.pongoresume.com">
<cfset dbtype = "ODBC">
<cfset datasource = "pongoresume">
<cfset Application.datasource = "pongoresume">
<cfset variables.allowedIPList = "">
<cfset variables.blockedIPList = "">
<cfset variables.localDevPort = "">

<!--- Set some values based on the server being used --->
<cfif listFindNoCase("www.pongoresume.com,admin.pongoresume.com", CGI.server_name)>
	<cffile action="read" file="d:\scanIPs.txt" variable="variables.scanIPs">
	<cfset variables.scanAlertIPs = ListChangeDelims(variables.scanIPs,",","#chr(13)##chr(10)#")>	
</cfif>

<!--- Set up lists of IPs allowed/blocked from accessing the admin directory --->
<cfif script_name contains "/admin">
	<cfinclude template="/admin/accessRestrictions/qry_accessRestrictions_all.cfm">
	<cfloop query="accessRestrictions_all">
		<cfif grantAccess EQ 1>
			<cfset variables.allowedIPList = ListAppend(variables.allowedIPList,accessRestrictions_all.IPAddress)>
		<cfelseif grantAccess EQ 0>
			<cfset variables.blockedIPList = ListAppend(variables.blockedIPList,accessRestrictions_all.IPAddress)>
		</cfif>
	</cfloop>
</cfif>

<!--- Run Web app firewall to block access to pages/sections based on IP --->
<cfif listFindNoCase("www.pongoresume.com,admin.pongoresume.com", CGI.server_name)>
	<cf_WebAppFirewall safeIPList="#variables.scanAlertIPs#" allowedIPList="#variables.allowedIPList#" blockedIPList="#variables.blockedIPList#" accessDeniedMessage="You don't have access to view this page.">

	<cferror type="exception" template="../../../appError.cfm" mailto="errors@pongosoftware.com">
</cfif>

<cfif ListLen(CGI.server_name,".") EQ 2 AND CGI.script_name NEQ "/serverStatus.cfm">
	<cfset variables.scriptName = "">
	<cfif script_name NEQ "/index.cfm">
		<cfset variables.scriptName = CGI.script_name>
	</cfif>
	<cfheader statuscode="301" statustext="Moved Permanently">
	<cfheader name="Location" value="http://www.#CGI.server_name##variables.scriptName#">
	<cfabort>
</cfif>

<cfif listFindNoCase("www.pongoresume.com,admin.pongoresume.com", CGI.server_name)>	
	<cfset baseURL = "http://#server_name#/">
	<cfset secureURL = "https://#server_name#/">
	<cfset primaryURL = "http://www.pongoresume.com">
	<cfset basedir = ReplaceNoCase(cf_template_path,Replace(script_name,'/','\','All'),'','All')>
	<cfset tempdir = ReplaceNoCase(cf_template_path,Replace(script_name,'/','\','All'),'','All') & "\tmp">
	<cfset Application.cr = chr(13) & chr(10)>
	<cfset Application.baseDir = basedir>
	<cfif ListLen(Application.baseDir,'\') GT 5>
		<cfset Application.baseDir = ListDeleteAt(Application.baseDir,6,'\')>
	</cfif>
	<cfset debugmode = false>
	<cfset scriptsDir = "/scripts">
	<cfinclude template="/shared/10minuteresumeRedirect.cfm">
<cfelse>
	<cfset baseURL = "http://#cgi.server_name##variables.localDevPort#/">
	<cfset secureURL = "http://#cgi.server_name##variables.localDevPort#/">
	<cfset primaryURL = "http://#cgi.server_name##variables.localDevPort#">
	<cfset basedir = ReplaceNoCase(cf_template_path,Replace(script_name,'/','\','All'),'','All')>
	<cfset tempdir = ReplaceNoCase(cf_template_path,Replace(script_name,'/','\','All'),'','All') & "\tmp">	
	<cfset Application.cr = chr(13) & chr(10)>
	<cfset Application.baseDir = ReplaceNoCase(cf_template_path,Replace(script_name,'/','\','All'),'','All')>
	<cfif ListLen(Application.baseDir,'\') GT 5>
		<cfset Application.baseDir = ListDeleteAt(Application.baseDir,6,'\')>
	</cfif>	
	<cfset debugmode = true>
	<cfset querycachetime = 0>
	<cfif cgi.SERVER_PORT IS "8081">
		<cfset variables.localDevPort = ":8081">
	</cfif>
	
	<!--- Set up scripts location for CF8, CF9 & Mac CF servers --->
	<cfif cgi.SERVER_PORT IS "8081" AND NOT findNoCase("Mac OS X",Server.OS.Name)>
		<cfset scriptsDir = "/scriptsCF9">
	<cfelseif cgi.SERVER_PORT IS "8081" AND findNoCase("Mac OS X",Server.OS.Name)>
    	<cfset scriptsDir = "/OSXscripts">
    <cfelse>
		<cfset scriptsDir = "/scripts">
	</cfif>
</cfif>

<cfset cr = chr(13) & chr(10)>
<cfset nl = chr(10)>
<cfset tab = chr(9)>
<cfset sessiontimeout = 60><!--- Timeout for a session --->
<cfset groupsize = 15>
<cfset alphanumeric = "2346789abcdefghijkmnprstuvwxyz">
<cfset affiliateTestSubscribeIDs = "255">
<cfset variables.allowedagentlist = "window|WinNT|win98|win32|macintosh|unix|linux|Mac_PowerPC|Mac_PPC|BlackBerry|Avant|Konqueror|WebTV|Firefox|iPhone|PLAYSTATION|Nintendo|iPod|SunOS|Danger">
<cfset variables.excludedAgentList = "scanalert">
<cfset request.allowedCharsInPageURL = "a-zA-z0-9&">
<cfset request.replaceWithCharInURL = "-">
<cfset variables.adminSessionTimeOut = 0>
<cfset variables.realtimeauth = true>
<cfset variables.processor = "verisign">
<cfset variables.servermode = "Live">
<cfset variables.workingForYouTrialIDs = "24,25,26">
<cfset variables.workingForYouPaidIDs = "27,28">
<cfset variables.blogSubscribeID = "36">
<cfset migration_datasource = "ca">
<cfset variables.bounceaddress = "bounce@pongoresume.com">
<cfset funnelStartLink = "membership/options.cfm" />
<cfset variables.datemask = "mmm dd, yyyy">
<cfset variables.timemask = "hh:mm tt">

<!--- error  handling --->
<cfset mailserver="mail.synthenet.com">
<cfset errorfrom = "errors@pongosoftware.com"><!--- email address of developers --->
<cfset developermail = "errors@pongosoftware.com"><!--- email address of developers --->
<cfset developermailcc = ""><!--- email address of developers --->
<cfset errorsubject = "Pongo Resume - Error"><!--- email address of developers --->
<cfset module.newsletter = "true">
<cfset module.affiliate = "false">
<cfset module.sessionmanagement = true>
<cfset listserveremail = "pongo@pongoresume.com">
<cfset companyaddress = "">
