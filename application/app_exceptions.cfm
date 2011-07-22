<!--- 
All material herein (c) Copyright 2001 Synthenet
All Rights Reserved.
 
Current Administrator: Stefan Knoerk (sknoerk@synthenet.com)
 
Changes

Purpose and Notes: Errorhandler for toolbox Applications

Required Parameters: pagename

Optional Parameters: outputtype

Returns: Error Message or Email
--->
<cfparam name="action" default="not defined!!">
<cfparam name="formstack" default="not defined!!">
<cfparam name="toolbox" default="not defined!!">
<cfparam name="debugmode" default=false>
<cfparam name="debugmsg" default="">
<cfparam name="mailserver" default="not defined!!">
<cfparam name="form.pagemode" default="not defined!!">
<cfparam name="DeveloperMail" default="">
<cfparam name="DeveloperDepartment" default="">
<cfparam name="contact_app" default="not defined!!">
<cfparam name="passed_value" default="not defined!!">
<cfparam name="passed_value_name" default="not defined!!">
<cfparam name="primary_msg" default="not defined!!">
<cfparam name="secondary_msg" default="not defined!!">
<cfparam name="process" default="not defined!!">
<cfparam name="stackmodifier" default="not defined!!">
<cfparam name="variables.passed_values_primary" default="">
<cfparam name="variables.passed_values" default="">
<cfparam name="cgi.http_user_agent" default="">
<cfparam name="ERRORSUBJECT" default="">
<cfparam name="ERRORFROM" default="">
<cfif not isdefined("DeveloperMailcc")>
	<cfinclude template="app_globals.cfm">
</cfif>
<cfif isdefined("url.erroroccured")>
	<cfset debugmode = true>
</cfif>

<!--- remove the password --->
<cfset structDelete(variables,"ACCOUNTSPASS") />
<cfset structDelete(form,"ACCOUNTSPASS") />

<cfif structKeyExists(form,"accountpass")>
	<cfset form.accountpass = repeatString("*",len(form.accountpass)) />
</cfif>

<cfif structKeyExists(form,"accountpass_confirm")>
	<cfset form.accountpass_confirm = repeatString("*",len(form.accountpass_confirm)) />
</cfif>

<cfif structKeyExists(form,"confirm_accountpass")>
	<cfset form.confirm_accountpass = repeatString("*",len(form.confirm_accountpass)) />
</cfif>

<cfset position = ArrayLen(CFCATCH.TAGCONTEXT)>
<CFSET sCurrent = CFCATCH.TAGCONTEXT[position]>
<cfset message = "">
<CFSET cr = chr(13) & chr(10)>
<CFSET line = "__________________________________________#cr#">
<CFSET line2 = "#cr#-----------------------------------------------------------#cr#">
<cfset form_variables = "">

<cfset counter = 0>
<cfloop index="ii" list="#formstack#" delimiters="\"><!--- deserialize Forms and related name/value pairs --->
	<cfloop index="xx" list="#listdeleteat(ii,1)#" delimiters="/"><!--- loop through name/value pairs --->
		<cfset fieldname = listfirst(xx,"=")>	
		<cfif fieldname is not listlast(xx,"=")>
			<cfset form_variables = form_variables & "form.#fieldname#" & " = " & replacelist(listlast(xx,"="),"</>,<\>,<=>","/,\,=") & cr>
		<cfelse><!--- workaround for empty string values--->
			<cfset form_variables = form_variables & "form.#fieldname#" & " = " & "[none]" & cr>
		</cfif>
	</cfloop>
</cfloop>
<cftry>
<cfset row = "">
<cfset template = "">
<cfif cfcatch.detail contains "HTTP/1.0 404 Object Not Found" or cfcatch.detail contains "Template file not found.">
	<CFSET sCurrent = CFCATCH.TAGCONTEXT[ArrayLen(CFCATCH.TAGCONTEXT)]>
	<cfset template = lcase(sCurrent['TEMPLATE'])>
	<cfset row = sCurrent["LINE"]>
<cfelseif cfcatch.message contains "Error near line">
	<CFSET sCurrent = CFCATCH.TAGCONTEXT[ArrayLen(CFCATCH.TAGCONTEXT)]>
	<cfset template = lcase(sCurrent['TEMPLATE'])>
	<cfset start = findnocase("Error near line ",cfcatch.message) + 16>
	<cfset end = findnocase(",",cfcatch.message,start)>
	<cfset row = Mid(cfcatch.message, start, end - start)>
<cfelseif cfcatch.detail contains "The specific sequence of files included or processed is:">
	<!--- find template --->
	<cfset start = findnocase("<code>",cfcatch.detail) + 6>
	<cfset end = findnocase("</code>",cfcatch.detail)>
	<cfset result = Mid(cfcatch.detail, start, end - start)>
	<cfset result = replacenocase(result,"<br>","|","all")>
	<cfset result = listlast(result,"|")>
	<cfset start = findnocase(":\",result) - 1>
	<cfset end = findnocase("&nbsp;",result,start)>
	<cfset result = trim(Mid(result, start, end - start))>
	<cfset path_tmp = "">
	<cfif find("\..\",result) is not 0>
		<cfset path_tmp = listdeleteat(listfirst(result,"."),listlen(listfirst(result,"."),"\"),"\")>
		<cfset start = findnocase("\..\",result) + 4>
		<cfset result = trim(Mid(result, start, end - start))>
		<cfset template = "#path_tmp#\#result#">
	<cfelse>
		<cfset template = path_tmp>
	</cfif>
	<cfset start = findnocase("position (",cfcatch.detail) + 10>
	<cfset end = findnocase(").",cfcatch.detail,start)>
	<cfset result = trim(Mid(cfcatch.detail, start, end - start))>
	<cfset row = listfirst(result,":")>
</cfif>
<!--- <cfoutput>#template#</cfoutput> --->
<cfif template is  not "">
	<cfset template_name = template>
	<cfif fileexists(template)>
		<cffile action="READ" file="#template#" variable="template">
		<cfset template = replace(template,chr(13)," #chr(13)# ","all")>
		
		<cfset templaterow = row>
		<cfset row = listgetat(template,row,chr(13))>
		<cfset row = replacelist(row,"<,>","&lt;,&gt;")>
		<cfif row contains("##")>
			<cfset start = 1>
			<cfloop condition="1 is 1">
				<cfset start = find("##",row,start)+1>
				<cfif start is 1>
					<cfbreak>
				</cfif>
				<cfset end = find("##",row,start)>
				<cfif end - start LT 1>
					<cfbreak>
				</cfif>
				<cfset variable = mid(row, start,end-start)>
				<cfif isdefined(variable)>
					<cfset row = replace(row,"###variable###","#evaluate(variable)#")>
				</cfif>
				<cfset start = end-1>
			</cfloop>
		</cfif>
	<cfelse>
		<cfset row = "">
	</cfif>
</cfif>
<cfcatch></cfcatch>
</cftry>
<cfsavecontent variable="message">
<cfoutput>
	
	<table width="500">
	<tr>
		<td colspan="2" bgcolor="black" nowrap><font face="arial,helvetica,sans-serif" color="white"><b>Toolbox Error Message:</b>(#errortype#)</font></td>
	</tr>
	<tr>
		<td align="right" valign="top" nowrap><font face="arial,helvetica,sans-serif" size="-1"><b>Debug Message:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1" color="Red"><b>#debugmsg#</b></font></td>
	</tr>
	<tr>
		<td align="right" nowrap><font face="arial,helvetica,sans-serif" size="-1"><b>Server Instance:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1"><cftry><cfset thisServer = createObject("java", "jrunx.kernel.JRun").getServerName()>#thisServer#<cfcatch></cfcatch></cftry></font></td>
	</tr>
	<tr>
		<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Unclosed Tags:</b></font></td>
		<td>
			<font face="arial,helvetica,sans-serif" size="-1">
			<ol>
			<CFLOOP index=i from=1 to = #ArrayLen(CFCATCH.TAGCONTEXT)#>
				<CFSET sCurrent = #CFCATCH.TAGCONTEXT[i]#>
				<li> <!--- #sCurrent["ID"]# ---> (#sCurrent["LINE"]#, #sCurrent["COLUMN"]#) #lcase(sCurrent["TEMPLATE"])#   
			</CFLOOP>
			</ol>
			</font>
		</td>
	</tr>
	<cfif row is not "" and template is not "">
		<tr>
			<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Erroring Code:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#row#</font></td>
		</tr>
		<tr>
			<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Template:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#template_name# in Line #templaterow#</font></td>
		</tr>
	<cfelse>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Position:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">Line #sCurrent["LINE"]#, Column #sCurrent["COLUMN"]#</font></td>
		</tr>
	</cfif>
	<tr>
		<td align="right" nowrap><font face="arial,helvetica,sans-serif" size="-1"><b>Processed Tag:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#sCurrent["ID"]#</font></td>
	</tr>
	<tr>
		<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Message:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#replacelist(cfcatch.message,"<pre>,<PRE>,</PRE>,</pre>",",,,")#</font></td>
	</tr>
	
	<tr>
		<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Details:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#cfcatch.detail#</font></td>
	</tr>
	<cfif errortype is "Database Error">
		<tr>
			<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>SQL State:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#cfcatch.SQLSTATE#</font></td>
		</tr>
	</cfif>
	<tr>
		<td align="right" nowrap><font face="arial,helvetica,sans-serif" size="-1"><b>Contact Application:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#contact_app#</font></td>
	</tr>
	<tr>
		<td align="right" nowrap><font face="arial,helvetica,sans-serif" size="-1"><b>Stack Modifier:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#stackmodifier#</font></td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Toolbox:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#toolbox#</font></td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Action:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#action#<br>#primary_msg#<br>#secondary_msg#</font></td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Process:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#process#</font></td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Formstack:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#formstack#</font></td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Referer:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#http.referer#</font></td>
	</tr>
	<cfif isdefined("contentID")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>ContentID:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#contentID#</font></td>
		</tr>
	</cfif>
	<cfif isdefined("orderID")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>OrderID:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#OrderID#</font></td>
		</tr>
	</cfif>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Passed Values (primary):</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">
			<cfloop list="#variables.passed_values_primary#" delimiters="|" index="ii">
				#listfirst(ii,"=")# = #listlast(ii,"=")# <br>
			</cfloop>
		</font>
		</td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Passed Values (secondary):</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">
			<cfloop list="#variables.passed_values#" delimiters="|" index="ii">
				#listfirst(ii,"=")# = #listlast(ii,"=")# <br>
			</cfloop>
		</font>
		</td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Page Mode:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#form.pagemode#</font></td>
	</tr>
	<tr>
		<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Variables:</b></font></td>
		<td>
			<font face="arial,helvetica,sans-serif" size="-1">
				<cfif formstack is not "">
					<cfset counter = 0>
					<cfloop index="ii" list="#formstack#" delimiters="\"><!--- deserialize Forms and related name/value pairs --->
						<cfloop index="xx" list="#listdeleteat(ii,1)#" delimiters="/"><!--- loop through name/value pairs --->
							<cfset fieldname = listfirst(xx,"=")>	
							<cfif fieldname is not listlast(xx,"=")>
								form.#fieldname# = #replacelist(listlast(xx,"="),"</>,<\>,<=>","/,\,=")#
							<cfelse><!--- workaround for empty string values--->
								form.#fieldname# = 
							</cfif><br>	
						</cfloop>
					</cfloop>
				</cfif>
			</font>
		</td>
	</tr>
	<tr>
		<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Client System:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">#cgi.http_user_agent#</font></td>
	</tr>
	<cfif isdefined("HTTP_COOKIE")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Cookie:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#HTTP_COOKIE#</font></td>
		</tr>
	</cfif>
	<cfif isdefined("HTTP_HOST")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Host:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#HTTP_HOST#</font></td>
		</tr>
	</cfif>
	<cfif isdefined("REMOTE_HOST")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>IP:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#REMOTE_HOST#</font></td>
		</tr>
	</cfif>
	<cfif isdefined("QUERY_STRING")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Query String:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#QUERY_STRING#</font></td>
		</tr>
	</cfif>
	<cfif isdefined("variables.sid")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>SessionID:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#variables.sid# <cfif isdefined("url.sid")>(url)</cfif></font></td>
		</tr>
	</cfif>
	<cfif isdefined("linktitle")>
		<tr>
			<td align="right"><font face="arial,helvetica,sans-serif" size="-1"><b>Linktitle:</b></font></td>
			<td><font face="arial,helvetica,sans-serif" size="-1">#linktitle#</font></td>
		</tr>
	</cfif>
	<tr>
		<td align="right" valign="top"><font face="arial,helvetica,sans-serif" size="-1"><b>Formfields:</b></font></td>
		<td><font face="arial,helvetica,sans-serif" size="-1">
			<cftry>
			<cfloop item="fieldname" collection="#form#">
				<cfset fieldname = trim(fieldname)><!--- bugfix mac --->
				#fieldname# = <cftry>#evaluate("form.#fieldname#")#<cfcatch>Invalid</cfcatch></cftry><br>
			</cfloop>
			<cfcatch>#cfcatch.detail#</cfcatch>
			</cftry>
		</font></td>
	</tr>
	
	</table>
</cfoutput>
</cfsavecontent>
<cfparam name="variables.emailErrors" default="true">
<cfif FindNoCase("ScanAlert",CGI.HTTP_USER_AGENT)>
	<cfset variables.emailErrors = "false">
</cfif>
<cfif cfcatch.message contains "Element SID is undefined in COOKIE.">
	<cfset variables.emailErrors = "false">
</cfif>
<cfif debugmode IS false AND NOT isdefined("erroroccured") AND NOT isdefined("url.error") AND variables.emailErrors>
 	<cfmail to="#DeveloperMail#" cc="#DeveloperMailcc#" from="#errorfrom#" subject="Error on #server_name#" type="HTML" debug="yes">#message#</cfmail> 
	<cflocation url="index.cfm?erroroccured=yes" addtoken="No">
<cfelseif debugmode IS true>
	<cfoutput>#message#</cfoutput>
<cfelse>
	Sorry, we experienced Problems anwering your request. Please try again later.
</cfif>
<cfabort><!--- needed when application is called from within the admin directory ... HTML ouput for newsletters --->

	
