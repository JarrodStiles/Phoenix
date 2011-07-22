<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<!--- 
Toolbox Application Handler Version 3.0 for administriative areas with tabbars
 
All material herein (c) Copyright 2001 Synthenet
All Rights Reserved.
 
Current Administrator: Stefan Knoerk (sknoerk@synthenet.com
 
Changes
 
Purpose and Notes: Main Toolbox processing unit

Required Parameters:

Optional Parameters:
- field_exceptions
- bodyattributes

Returns: Pageoutput
--->
<!--- Can be used for enduser Pages --->
<CFTRY>
<cfset application_handler_version = 2>

<!--- include global functions --->
<cfinclude template="../admin/application/app_functions.cfm">
<!--- include global variables --->
<!---<cfinclude template="app_globals.cfm">--->

<!--- initialize Toolbox variables --->
<cfif findNoCase("Mac OS X",Server.OS.Name)>
	<cfparam name="tool_contact" default="#listlast(gettemplatepath(),'/')#"><!--- name of the current toolcontact file --->
<cfelse>
	<cfparam name="tool_contact" default="#listlast(gettemplatepath(),'\')#"><!--- name of the current toolcontact file --->
</cfif>

<cfset contact_app = listfirst(tool_contact,".")><!--- same as above without fileextesion --->
<!--- allows to escape the requesthandler with the prefix "app_" --->
<cfif listfirst(contact_app,"_") is "app">
	<cfset contact_app = listlast(contact_app,"_")>
</cfif>
<!--- Toolbox Parameters --->
<!--- variables that can be customized --->
<cfparam name="field_exceptions" default="admindir,image,uploadfile1,uploadfile2,uploadfile3,newhl,jsaction,tablelockIDs,uploadfile"> <!--- inizialize fields that should not be processed as regular field --->
<cfparam name="outputtype" default="normal"> <!--- can be changed for app_output.cfm if diffrent framework is needet --->
<cfset bodyattributes = ""><!--- any extra attributes for the HTML body tag --->
<cfparam name="form.tablelockIDs" default=""><!--- initialize locking --->
<!--- predefined variables --->

<!--- <cfmodule template="../shared/tablelock.cfm" action="validate"> --->
<cfparam name="form.tbxfieldnames" default="">
<cfparam name="tabbar" default=""><!--- initialize variable for cutomtag cftabbar --->
<cfparam name="defaultaction" default=""><!--- inizial action --->
<cfparam name="fieldnames" default="#defaultaction#"><!--- initialize CF variable fieldnames --->
<cfparam name="stacksize" default="0"><!--- inizialize size of foprmstack --->
<cfparam name="process" default=""><!--- inizialize list of running processes --->
<cfparam name="process_start" default=""><!--- starts a process, for use in actionhandler --->
<cfparam name="process_end" default=""><!--- kommaseperated list that ends all included processes, for use in actionhandler --->
<cfparam name="formstack" default=""><!--- initialize variable for the formstack --->
<cfparam name="jsaction" default=""><!--- initialize hidden field for Javascript generated actions --->
<cfparam name="form.hl" default="1"><!--- initialze cf_tabbar tag --->
<cfparam name="process" default=""><!--- inizialize list of running processes --->
<cfparam name="tabbar_set" default="">
<cfparam name="form.newhl" default="">
<cfparam name="form.tabbar" default="">
<cfparam name="formattributes" default=""><!--- inizialize variable for formatributes --->
<cfparam name="action" default="shared_none"><!--- initialize variable action --->
<cfparam name="form.form_changed" default="no"><!--- initialize variable action --->
<cfparam name="form_name" default="form"><!--- initialize variable action --->
<cfparam name="debugmode" default=false>
<cfparam name="form.clientdir" default="no">
<cfparam name="form.pagemode" default="">

<cfset hl_set = 1><!--- default highlighter for tabbar --->
<cfset formchanged = ' onchange="formchanged()"'>
<cfset javascripts = ""><!--- list of included js_files --->
<cfset err = ""><!--- error messages --->
<cfset msg = ""><!--- general messages --->
<cfset err_fieldname = ""><!--- name of the first field that gives an error (supports the cf_validate tag) --->
<cfset iconbar = ""> <!--- supports cf_iconbar tag --->
<cfset field_lock_list = ""> <!--- initialize list for fields that should not be returned from formstack --->
<cfset stack_lock = false> <!--- if true this variable will prevent the formstack from returning values --->
<cfset debugmsg = ""><!--- variable for debugmessages --->

<!--- initialize variable for actionhandlers --->
<cfset changetoolbox = "no">
<cfset toolbox = "-none-"> <!--- initialize variable for actionhandlers --->
<cfparam name="form.primary_action" default=""><!--- initialize variable for actionhandlers --->

<!--- Reformating url-actions --->
<cfif isdefined("form.action") and form.action is not "">
	<cfset url.action = form.action>
</cfif>

<cfset formtype = "normal"><!--- normal oder print ... for pagetype handling --->

<cfset formdoubles = "no"><!--- not in use --->

<cfif isdefined("url.action")>
	<cfif left(listfirst(url.action,"_"),3) is not ("act") and left(listfirst(url.action,"_"),4) is not ("2act") and left(listfirst(url.action,"_"),4) is not ("1act")>
		<cfif listlen(url.action,"_") is 1>
			<cfset url.action = "act_" & contact_app &"_" & url.action>
		<cfelse>
			<cfset url.action = "act_" & url.action>
		</cfif>
 	</cfif>
	<cfset fieldnames = listappend(fieldnames,url.action)>
</cfif>

<!--- writing submitted field/Values in an array --->
<cfset newformfields = "">

<!--- add javascript generated action to fieldnames --->
<cfif jsaction is not "">
	<cfset fieldnames = listprepend(fieldnames,jsaction)>
</cfif>

<cfloop list="#form.tbxfieldnames#" index="ii">
	<cfset ii = trim(ii)><!--- bugfix mac --->
	<cfif not isdefined("form.#ii#")>
		<cfset "form.#ii#" = "">
	</cfif>
</cfloop>
<cfif form.tbxfieldnames is not "">
	<cfset fieldnames = listappend(fieldnames,form.tbxfieldnames)>
</cfif>

<!--- parse out action from Buttonnames and writing new formfields in list (newformfields) --->
<cfloop index="fieldname" list="#fieldnames#">
	<cfif listfirst(fieldname,"_") is "act" and listlast(fieldname,".") is not "Y">
		<cfif listlast(fieldname,".") is "X">
			<cfset action = listdeleteat(listfirst(fieldname,"."),1,"_")>
		<cfelse>
			<cfset action = listdeleteat(fieldname,1,"_")>
		</cfif>
		<cfset primary_action = ""><!--- primary action should not be performed --->
		<cfif listfindnocase(action,"act","_") is not 0>
			<cfset action_tmp = "">
			<cfloop list="act_#action#" delimiters="_" index="ii">
				<cfif ii is "act">
					<cfif action_tmp is not "">
						<cfset action_tmp = "act_" & action_tmp >
					</cfif>
					<cfset primary_action = listappend(primary_action, action_tmp)>
					<cfset action_tmp = "">
				<cfelse>
					<cfset action_tmp = listappend(action_tmp,ii,"_")>
				</cfif>
			</cfloop>
			<cfset primary_action = listappend(primary_action, action_tmp)>
			<cfset action = listlast(primary_action)>
			<cfset primary_action = listdeleteat(primary_action,listlen(primary_action))>
		</cfif>
	<cfelseif listfirst(fieldname,"_") is "2act" and listlast(fieldname,".") is not "Y">
		<!--- parsing out double action --->
		<cfset action = listdeleteat(listfirst(fieldname,"."),1,"_")>
		<!--- <cfif form.primary_action is not "">
			<cfset primary_action = listdeleteat(form.primary_action,1,"_")>
		</cfif> --->
	<cfelseif listfirst(fieldname,"_") is "1act" and listlast(fieldname,".") is not "Y">
		<!--- parsing out single action = primary only --->
		<cfif form.primary_action is not "">
			<cfset action = listdeleteat(form.primary_action,1,"_")>
		<cfelse>
			<cfset action = listdeleteat(listfirst(fieldname,"."),1,"_")>
		</cfif>
		<cfset primary_action = "">
	<cfelseif listfindnocase("formstack,process,primary_action,field_exceptions,fieldnames,#field_exceptions#,#newformfields#",fieldname) is 0 and listlast(fieldname,".") is not "Y">	
	    <!--- parsing out fieldnames and name/values --->
		<cftry>
			<cfif isdefined("form.#fieldname#")>
				<cfset "form.#fieldname#" = trim(evaluate("form.#fieldname#"))>
				<cfset "stack_#fieldname#" = evaluate("form.#fieldname#")>
			<cfelse><!--- support for aditional fields like checkboxes --->
				<cfset "form.#fieldname#" = "">
				<cfset "stack_#fieldname#" = "">
			</cfif>
			<cfset newformfields = listappend(newformfields,fieldname)>
			<cfset "err_#fieldname#" = ""><!--- set indicator for errors --->
			<cfset "msg_#fieldname#" = ""><!--- set indicator for errormessages --->
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
  </cfif>
</cfloop>
<cfset new_pagemode = "">

<!--- check for login  --->
<cfinclude template="app_sessionhandler.cfm">
<cfinclude template="../accounts/fct_accounts_validate.cfm">

<!--- increment newsletter Clickthrough --->
<cfif module.newsletter AND IsDefined("URL.broadcastID")>
	<cfinclude template="app_newsletterhandler.cfm">
</cfif>

<!--- increment counter --->
<cfif Not IsDefined("cookie.PSclickthrough") AND ReFindNoCase("#variables.allowedagentlist#",variables.useragent) NEQ 0 AND ReFindNoCase("#variables.excludedAgentList#",variables.useragent) EQ 0>
	<cfcookie name="PSclickthrough" value="true">
	<cfinclude template="../clickthroughs/qry_clickthroughs_add.cfm">
</cfif>

<cfif action is "shared_none">
	<cfset form.primary_action = "">
</cfif>
<cfset field_exceptions = ""><!--- reset field exceptions --->

<cfif newformfields is "">
	<cfset newformfields = "none"><!--- set value to avoid error --->
</cfif>

<cfset newformfields_tmp2 = newformfields><!--- set tmp variable for later use --->

<!--- set size of current formstack --->
<cfset stacksize = listlen(formstack,"\")>
<!--- rewriting values from hidden field --->
<!--- Syntax: template01,field1=value1/field2=value2\template02... --->

<cfif formstack is not "">
	<cfset counter = 0>
	<!--- deserialize Forms and related name/value pairs --->
	<cfloop index="ii" list="#formstack#" delimiters="\+">
		<!--- loop through name/value pairs --->
		<cfloop index="xx" list="#listdeleteat(ii,1,'|')#" delimiters="/">
			<cfset fieldname = replace(listfirst(xx,"="),"|","","all")>
			<!--- prevent current submitted formvars from being overwritten --->
			<cfif not isdefined("stack_#fieldname#")>
				<cfset "form.#fieldname#" = trim(replacelist(listlast(xx & " ","="),"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;,&pipe;,&ero;",'+,/,\,=,",<,>,|,�'))>
				<cfset "err_#fieldname#" = "">
			</cfif>
		</cfloop>
	</cfloop>
</cfif>
<!--- Set Variable if a Value was passed with an Action --->
<cfset variables.passed_values = "">
<cfif listlen(action,":") gt 1>
	<cfset variables.passed_values = ":" & listlast(action,":")>
	<cfloop list="#listlast(action,':')#" INDEX="passedvalues" DELIMITERS="|">
		<cfif listlen(passedvalues,"=") GT 1>
			<cfset "form.#listfirst(passedvalues,'=')#" = listlast(passedvalues,"=")>
		<cfelse>
			<cfset "form.#listfirst(passedvalues,'=')#" = "">
		</cfif>
	</CFLOOP>
	<cfset action = listfirst(action,":")>
</cfif>
<!--- same with primary_action --->
<cfset variables.passed_values_primary = "">
<cfif listlen(primary_action,":") gt 1>
	<cfset variables.passed_values_primary = ":" & listlast(primary_action,":")>
	<cfloop list="#listlast(primary_action,':')#" INDEX="passedvalues" DELIMITERS="|">
		<cfif listfirst(passedvalues,"=") is "pagemode">
			<cfset new_pagemode = listlast(passedvalues,"=")>
		</cfif>
		<cfset "form.#listfirst(passedvalues,'=')#" = listlast(passedvalues,"=")>
	</CFLOOP>
	<cfset primary_action = listfirst(primary_action,":")>
</cfif>

<!--- prepare Primary and Secondary Action --->
<cfset secondary_action = action>

<cfif primary_action is not "">	
	<cfset list_from_tmp = 1><!--- handle single action --->
	<cfset list_to_tmp = listlen(primary_action) + 1>
<cfelse>
	<cfset list_from_tmp = 2><!--- handle double action --->
	<cfset list_to_tmp = 2>
</cfif>

<!--- set variables for debug output --->
<cfset secondary_msg = "">
<cfset primary_msg = "">

<!--- reset variable fieldnames --->
<cfset form.fieldnames = "">

<!--- actionhandling --->

<cfset act_counter_tmp = 0>
<cfset in_clientdir = false>
<!--- initializing stackvars --->
<cfset stack_delete = "">
<cfset stack_replace = "">
<cfset stack_set = "">
<cfset stack_add = "">
<cfset stack_switch = "">
<cfset force_stack_delete_tmp = 0><!--- Primary action can force a stack delete --->
<cfset force_stack_delete = 0>
<cfif debugmode is true>
	<cfparam name="basedirectory" default="#listdeleteat(getcurrenttemplatepath(),listlen(getcurrenttemplatepath(),'\'),'\')#">
</cfif>

<cfloop from="#list_from_tmp#" to="#list_to_tmp#" index="loopcounter">
	<cfset act_counter_tmp = act_counter_tmp + 1>
	<cfif loopcounter LTE listlen(primary_action)>
		<cfset action = replacenocase(listgetat(primary_action,loopcounter),"act_","")>
	<cfelse>
		<cfset action = secondary_action>
	</cfif>
	
	<cfif action is "" or action is "shared_none">
		<!--- allows to reset secondary action in action handler --->
		<cfbreak>
	</cfif>
	<!--- reinitializing stackvars --->
	<cfset stack_delete = "">
	<cfset stack_replace = "">
	<cfset stack_set = "">
	<cfset stack_add = "">
	<cfset stack_switch = "">
	<cfset act_message = ""><!--- ?? --->
	
	<cfset processing_diroffset = "">
	<!--- prepare actionname --->
	
	<cfset toolbox = listfirst(action,"_")>
	
	<cfif contact_app eq toolbox>
		<cfset action = listfirst(listdeleteat(action,1,"_"),":")>
	</cfif>

	<!--- Include Actionhandler for Contact Application --->
	<cfset changetoolbox = "yes">
	<!--- Include Actionhandler from other toolbox if no action was specified--->
	<cfif changetoolbox is "yes">	
		<cfif debugmode is true>
			<cfif not fileexists("#basedirectory#/#toolbox#/act_#toolbox#_handler.cfm")>
				<cfset debugmsg = debugmsg & "<p>The Template '../#toolbox#/act_#toolbox#_handler.cfm' does not exists">
			</cfif>
		</cfif>

		<!--- cut off toolbox-name --->
 		<cfif toolbox neq contact_app>
			<cfset action = listdeleteat(action,1,"_")>
		</cfif>
		<cfif list_from_tmp is 2>
			<cfset secondary_action = action>
		</cfif>
		<cfset changetoolbox = "no">
		<!--- include actionhandler from toolbox --->
		<cfinclude template="../#processing_diroffset##toolbox#/act_#toolbox#_handler.cfm">
		
		<cfif changetoolbox is "yes">
			<cfset changetoolbox = "no">
			<cfif debugmode is true>
				<cfif not fileexists("#basedirectory#/shared/act_shared_handler.cfm")>
					<cfset debugmsg = debugmsg & "<p>The Template 'shared/act_shared_handler.cfm' does not exists">
				</cfif>
			</cfif>
				
			<cfinclude template="../#processing_diroffset#shared/act_shared_handler.cfm">
			
			<cfif changetoolbox is "yes">
				<cfset act_message = "<b>#toolbox#_#action#</b> (no Action Handler specified!)">
				<cfset debugmsg = debugmsg & "No Action Handler specified for action <b>#action#</b>.">
			<cfelse>
				<cfif processing_diroffset is not "">
					<cfset act_message = "<b>#action#</b> (dynamically processed in Toolbox shared in Client Directory)">
				<cfelse>
					<cfset act_message = "<b>#action#</b> (dynamically processed in Toolbox shared)">
				</cfif>
			</cfif>
		<cfelse>
			<cfif processing_diroffset is not "">
				<cfset act_message = "<b>#action#</b> (processed in Toolbox #toolbox# in Client Directory)">
			<cfelse>
				<cfset act_message = "<b>#action#</b> (processed in Toolbox #toolbox#)">
			</cfif>
		</cfif>
	<cfelse>
		<cfset act_message = "<b>#action#</b> (processed in Circuit-Application #contact_app#)">
	</cfif>
	
	<!--- set message for debug information --->
	<cfif loopcounter LTE listlen(primary_action)>
		<cfset primary_msg = listappend(primary_msg,act_message,"|")>
	<cfelse>
		<cfset secondary_msg = act_message>
	</cfif>	
	<!--- end processes --->
	<cfloop index="ii" list="#process_end#">
		<cfset find_tmp = listfindnocase(process,ii)>
		<cfif find_tmp is not 0>
			<cfset process = listdeleteat(process,find_tmp)>
		</cfif>
	</cfloop>
	
	<!--- leave loop if any error --->
	<cfif err is not "">
		<cfset secondary_msg = "#secondary_action# (Not executed because of error)">
		<cfbreak>
	</cfif>
	
	<!--- start processes --->
	<cfloop index="ii" list="#process_start#">
		<cfif listfind(process,ii) is 0>
			<cfset process = listappend(process,ii)>
		</cfif>
	</cfloop>
	<cfset force_stack_delete_tmp = force_stack_delete_tmp + force_stack_delete>
	<cfset force_stack_delete = 0>
	<!--- check if displayfile should be taken from clientdirectory --->
	<cfif processing_diroffset is not "" and stack_add & stack_replace & stack_switch & stack_delete is not "">
		<cfset form.clientdir = "yes">
	</cfif>
</cfloop>

<cfif force_stack_delete_tmp is not 0>
	<cfset stack_delete = force_stack_delete_tmp + val(stack_delete)>
</cfif>
<!--- set highlighter to new value, request from tabbar customtag --->
<cfif isdefined("form.newhl") and form.newhl is not "" and form.newhl is not 1 and err is "" and tabbar_set is "">
	<cfset hl_diff = listlast(form.hl,"-") - listlast(form.newhl,"-")> 
	<cfif hl_diff is - 1>
		<cfset stack_add = stack_add & stack_replace>
		<cfset stack_replace = "">
		<cfset stack_switch = "">
		<cfset stack_delete = "">
	<cfelseif hl_diff is 1>
		<cfset stack_delete = 1>
		<cfset stack_replace = "">
		<!--- <cfset stack_switch = ""> --->
		<cfset stack_add = "">
	<cfelseif stack_switch is "">
		<cfset stack_replace = stack_add & stack_replace>
		<cfset stack_add = "">
		<cfset stack_switch = "">
		<cfset stack_delete = "">
	</cfif>
	<cfset form.hl = form.newhl>
	<!--- reset tabbar (a new tabbar can not be called by a tabbar) --->
</cfif>

<!--- <cfif debugmode is true> --->
	<cfset stackmodifier = "">
	<cfif stack_add is not "">
		<cfset stackmodifier = "stack_add = #stack_add#">
	<cfelseif stack_replace is not "">
		<cfset stackmodifier = "stack_replace = #stack_replace#">
	<cfelseif stack_switch is not "">
		<cfset stackmodifier = "stack_switch = #stack_switch#">
	<cfelse>
		<cfset stackmodifier = "- none -">
	</cfif>
	<cfif stack_delete is not "" and stackmodifier is not "">
		<cfset stackmodifier = "#stackmodifier#<br>stack_delete = #stack_delete#">
	<cfelseif stack_delete is not "">
		<cfset stackmodifier = "stack_delete = #stack_delete#">
	</cfif>
<!--- </cfif> --->

<!--- preparing new formfields for formstack --->
<cfif stack_add & stack_replace & stack_switch neq "">
	<cfset form.pagemode = new_pagemode>
	<cfset newformfields_tmp = "">
	<cfloop index="fieldname" list="#newformfields#">
		<cfif fieldname is not "none">
			<cfset newformfields_tmp = listappend(newformfields_tmp,fieldname & "=" & trim(replacelist(evaluate("stack_#fieldname#"),'+,/,\,=,",<,>,|',"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;,&pipe;")),"/")>
		</cfif>
	</cfloop>
	<cfset newformfields = newformfields_tmp>
</cfif>
<!--- perform stack delete --->
<cfif stack_delete is not "">
	<cfloop index="ii" from="1" to="#stack_delete#">
		<cfif (stacksize GT 1 or stack_add is not "") and stacksize GT 0><!--- dont delete last item in Stack --->
			<cfset formstack = listdeleteat(formstack,stacksize,"\")>
			<cfset stacksize = stacksize - 1>
		</cfif>
	</cfloop>
</cfif>

<!--- reset formstack when form is allready in stack --->
<cfset stack_reset_tmp = false>
<cfif stack_add & stack_replace is not "" and listfindnocase(formstack,stack_add & stack_switch & stack_replace,"|\=+") is not 0>
	<cfset stack_add_tmp = stack_add & stack_replace>
	<cfset formstack_tmp = "">
	<cfloop index="ii" list="#formstack#" delimiters="\">
		<cfloop index="xx" list="#ii#" delimiters="+">
			<cfif listfindnocase("#stack_add#,#stack_switch#,#stack_replace#",listfirst(xx,'|')) is not 0>
				<cfset stack_reset_tmp = true>
			</cfif>
		</cfloop>
		<cfif stack_reset_tmp is true>
			<cfbreak>
		</cfif>
		<cfset formstack_tmp = listappend(formstack_tmp,ii,"\")>
	</cfloop>
	<cfset formstack = formstack_tmp>
</cfif>

<!--- perform stack switch --->
<cfif stack_switch is not "">
	<!--- set hidden field to yes if one form in the group changed --->
	<cfset field_lock_list = listappend(field_lock_list,"form_changed")>
	<cfif stack_delete is ""><!--- not append new formfields in case of stack_swith and stack_delete --->
		<cfset formstack = listappend(formstack,newformfields,"|")>
	</cfif>
	<cfif listfindnocase(listlast(formstack,"\"),stack_switch,"|\+") is 0>
		<!--- form is not in group --->
		<cfset formstack = listappend(formstack, stack_switch,"+")>
	<cfelse>
		<!--- form is in group --->
		<cfset stack_group_tmp = "">
		<cfloop index="ii" list="#listlast(formstack,'\')#" delimiters="+">
			<cfif listfirst(ii,"|") is not stack_switch>
				<cfset stack_group_tmp = listappend(stack_group_tmp,ii,"+")>
			<cfelse>
				<cfset switch_returnfields = listdeleteat(ii,1,"|")>
			</cfif>
		</cfloop>
		<!--- bugfix --->
		<!--- <cfif stack_delete is not "">
			<cfset stack_group_tmp = listdeleteat(stack_group_tmp,listlen(stack_group_tmp))>
		</cfif> --->
	</cfif>
</cfif>

<!--- perform stack replace --->
<cfif stack_replace is not "">
	<!--- add values from previous form to stack --->
	<cfset form.form_changed = "no">
	<cfif listlen(stack_replace,"/") LT 2>
		<cfset stack_replace = contact_app & "/" & stack_replace>
	</cfif>
	<!--- bugfix --->
	<cfset stacksize = listlen(formstack,"\")>
	<cfif stacksize GT 0>
		<cfset formstack = listsetat(formstack,stacksize,stack_replace,"\")>
	<cfelse>
		<cfset formstack = stack_replace>
	</cfif>
</cfif>

<!--- set new tabbar --->
<cfif tabbar_set is not "">
	<cfset form.tabbar = tabbar_set>
	<cfset form.hl = hl_set>
	<!--- Tabbar should be reset when not called by a tabbar --->
<cfelseif form.newhl is "" and stack_add & stack_replace is not "">
	<!--- Tabbar should be set to first tab if called from actionhandler --->
	<cfset form.tabbar = "">
</cfif>

<!--- perform stack add  (if form was not in stack)--->
<cfif stack_add is not "">
	<cfset form.form_changed = "no">
	<cfif listfindnocase(action,toolbox,"_") is 0>
		<cfset initial_tab_action = "#toolbox#_#action#">
	<cfelse>
		<cfset initial_tab_action = "#action#">
	</cfif>
	
	<cfif listlen(stack_add,"/") LT 2>
		<cfset stack_add = contact_app & "/" & stack_add>
	</cfif> 
	
	<cfif stacksize GT 0 and stack_reset_tmp is false and newformfields is not "" and stack_delete is ""><!--- Add Values to the last form --->
		<cfset formstack = listappend(formstack,newformfields,"|")>
	</cfif>
	<cfset stacksize = stacksize + 1>
	<cfif isdefined("switchfields") and switchfields is not "">
		<cfset formstack = listappend(formstack,switchfields,"\")>
		<cfset formstack = listappend(formstack, stack_add,"+")>
	<cfelse>
		<cfset formstack = listappend(formstack, stack_add,"\")>
	</cfif>
</cfif>

<cfset stacksize = listlen(formstack,"\")>

<!--- rewrite variables from stack for use in the next form displayed --->
<cfset stack_reset_tmp = false>
<cfif stack_delete & stack_switch is not "" and stack_lock is false and stack_add is "" and stack_replace is "">
	<!--- rewriting values from hidden field--->
	<cfif stack_delete is not "">
		<cfset newformfields_tmp2 = "">
	</cfif>
	<cfif formstack is not "">
		<!--- deserialize Forms and related name/value pairs --->
		<cfset counter = 0>
		<cfloop index="ii" list="#formstack#" delimiters="\+">
			<cfset counter = counter + 1>
			<!--- loop through name/value pairs --->
			<cfloop index="xx" list="#listdeleteat(ii,1,'|')#" delimiters="/">
				<cfset fieldname = listfirst(xx,"=")>
				<cfif listfindnocase(field_lock_list & "," & newformfields_tmp2,fieldname) is 0>
					<cfif variables.fieldname is not "requesthandler" or counter LT stacksize>
						<!--- <cfoutput>form.#fieldname# = #replacelist(listlast(xx,"="),"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;",'+,/,\,=,",<,>')#<br></cfoutput> --->
						<cfset "form.#fieldname#" = trim(replacelist(listlast(xx & " ","="),"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;,&pipe;,&ero;",'+,/,\,=,",<,>,|,�'))>
						<cfset "err_#fieldname#" = "">
					</cfif>
				<cfelse>
					<cfset stack_reset_tmp = true>
				</cfif>
			</cfloop>
		</cfloop>
	</cfif>
</cfif>

<!--- change values in stack that are locked --->
<cfif stack_add is not "" or stack_switch is not "" and field_lock_list is not "">
	<cfset formstack_tmp = "">
	<cfloop index="ii" list="#formstack#" delimiters="\">
		<cfset counter = 0>
		<cfloop index="zz" list="#ii#" delimiters="+">
			<cfset counter = counter + 1>
			<cfif counter GT 1>
				<cfset delimiter_tmp = "+">
			<cfelse>
				<cfset delimiter_tmp = "\">
			</cfif>
			<cfset values_tmp = "">
			<cfloop index="xx" list="#listdeleteat(zz,1,'|')#" delimiters="/">
				<cfset fieldname = listfirst(xx,"=")>
				<cfif listfindnocase(field_lock_list,fieldname) GT 0>
					<cfset values_tmp = listappend(values_tmp,fieldname & "=" & trim(replacelist(evaluate("form.#fieldname#"),'+,/,\,=,",<,>,|,�',"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;,&pipe;,&ero;")),"/")>
				<cfelse>
					<cfset values_tmp = listappend(values_tmp,xx,"/")>
				</cfif>
			</cfloop>
			<cfset formstack_tmp = listappend(formstack_tmp,listappend(listfirst(zz,'|'),values_tmp,"|"),delimiter_tmp)>
		</cfloop>
	</cfloop>
	<cfset formstack = formstack_tmp>
</cfif>

<!--- <cfoutput><br>#form.PARTNERID#</cfoutput> --->
<!--- remove name/value pairs in case of stack_switch --->
<cfif isdefined("stack_group_tmp")>
	<cfset formstack = listdeleteat(formstack,stacksize,"\") & "\" & stack_group_tmp & "+" & stack_switch>
	<!--- return values for current form in group --->
	<cfloop index="xx" list="#switch_returnfields#" delimiters="/">
		<cfset fieldname = listfirst(xx,"=")>
		<cfif listfindnocase(field_lock_list,fieldname) is 0>
			<cfif fieldname is not listlast(xx,"=")>
				<cfset "form.#fieldname#" = replacelist(listlast(xx,"="),"&plus;,&vslash;,&bslash;,&equal;,&kwot;,&lite;,&grte;,&pipe;",'+,/,\,=,",<,>,|')>
			<cfelse>
				<cfset "form.#fieldname#" = "">
			</cfif>
			<!--- <cfset "err_#fieldname#" = ""> --->
		</cfif>
	</cfloop>
</cfif>

<cfif stack_delete is not "" and stack_replace is "" and stack_add is "">
	<!--- remove values from form that should be displayed --->
	<cfif listlen(listlast(formstack,"\"),"|") GT 1 and stack_switch is "">
		<cfset formstack = listdeleteat(formstack,listlen(formstack,"|"),"|")>
		<!--- <cfset formstack = listdeleteat(formstack,listlen(formstack))> --->
	<!--- <cfelseif listlen(listlast(formstack,"+") GT 1) and stack_switch is "">	
		<cfset formstack = listdeleteat(formstack,listlen(formstack,"+"),"+") & "+" & listfirst(listlast(formstack,"+"))> --->
	</cfif>
</cfif>

<!--- set highlighter to new value, request from tabbar customtag --->
<cfif form.newhl is not "" and tabbar_set is "" and err is "">
	<cfset form.hl = newhl>
</cfif>
<!--- should be displayed  --->
<cfset displayfile = listfirst(listlast(formstack,"\+"),"|")>

<cfif debugmode is true>
	<cfif formstack is "">
		<cfset debugmsg = debugmsg & "<p>There was no displayfile specified for the action &quot;#action#&quot; in ">
		<cfif isdefined("changetoolbox")>
			<cfset debugmsg = debugmsg & "#toolbox#/act_#toolbox#_handler.cfm">
		<cfelse>
			<cfset debugmsg = debugmsg & "#contact_app#/act_#contact_app#_handler.cfm">
		</cfif>
	<cfelseif not fileexists("#basedirectory#/#displayfile#")>
		<cfset debugmsg = debugmsg & "<p>The displayfile #displayfile# specified for the action #action# in ">
		<cfif isdefined("changetoolbox")>
			<cfset debugmsg = debugmsg & "#toolbox#/act_#toolbox#_handler.cfm">
		<cfelse>
			<cfset debugmsg = debugmsg & "#contact_app#/act_#contact_app#_handler.cfm">
		</cfif> 
		<cfset debugmsg = debugmsg & " does not exist">
	</cfif>
</cfif>

<cfset formtype = listlast(listfirst(displayfile,"_"),"/")>

<cfsetting enablecfoutputonly="no">
<cfset primary_action = "">

<!--- Display Please wait page
<cfparam name="waitdisplay" default=false>
<cfif waitdisplay IS true>
	<cfinclude template="../shared/dsp_shared_wait.cfm">
	<cfflush>
</cfif> --->

<!--- Generate Standard Output Elements --->
<!--- generating additionalcontent --->
<cfsavecontent variable= "dummyFormWrapper">
	<cfform action="#tool_contact##timeout#" method="post" name="form" scriptsrc="/scripts">
		<cfsavecontent variable="additionalcontent">
			<cfif displayfile is not "" AND form.clientdir is "yes">
				<cfinclude template="../../#clientdirectory#/#rootdir#/#displayfile#">
			<cfelseif displayfile is not "">
				<cfinclude template="../#displayfile#">
			</cfif>
		</cfsavecontent>
	</cfform>
</cfsavecontent>

<!--- Generating Tabbar --->
<cfif form.tabbar is not "">
	<cfif debugmode is true>
		<cfif not fileexists("#basedirectory#/#tabbar#")>
			<cfset debugmsg = debugmsg & "<p>The Tabbar &quot;../#tabbar#&quot; could not be found">
		</cfif>
	</cfif>
	<cf_bodycontent name = "dsp_tabbar">
			<cfinclude template="../#form.tabbar#">
	</cf_bodycontent>
</cfif>

<!---  Generating Hidden Fields for Toolbox --->
<cf_bodycontent name = "dsp_hiddenfields">
	<cfoutput>
		<!--- Set HTML Form tag --->
		<!--- send formstack from page to page --->
		<input type="hidden" name="formstack" value="#HTMLEditFormat(formstack)#">
		<input type="hidden" name="jsaction" value="">
		<!--- <input type="hidden" name="contentID" value="#form.contentID#"> --->
		<input type="hidden" name="form_changed" value="#HTMLEditFormat(form.form_changed)#">
		<input type="hidden" name="pagemode" value="#form.pagemode#">
		<!--- stores the action which lead into a certain sub process --->
		<cfif process is not "">
			<input type="hidden" name="process" value="#process#">
		</cfif>
		<cfif form.clientdir is "yes">
			<input type="hidden" name="clientdir" value="yes">
		</cfif>
		<!--- Add fieldnames for checkboxes, radiobuttons etc. --->
		<cfif form.fieldnames is not "">
			<input type="hidden" name="tbxfieldnames" value="#form.fieldnames#">
		</cfif>
		<!--- Submit primary action from displayfile to the formhandler --->
		<cfif primary_action is not "">
			<input type="hidden" name="primary_action" value="#primary_action#">
		</cfif>
		<cfif form.tablelockIDs is not "">
			<input type="hidden" name="tablelockIDs" value="#form.tablelockIDs#">
		</cfif>
		<cfif field_exceptions is not "">
			<input type="Hidden" name="field_exeptions" value="#field_exceptions#">
		</cfif>
		<input type="hidden" name="tabbar" value="#form.tabbar#">
		<cfif form.tabbar is not "">
			<input type="Hidden" name="hl" value="#form.hl#">
			<input type="Hidden" name="newhl" value="">
		</cfif>
		<!--- check and set flash version --->
		<cfif variables.flashplayerversion EQ "" AND Not IsDefined("form.flashplayerversion")>
			<cf_displayflash version_fieldname="flashplayerversion" setversion>
		</cfif>
	</cfoutput>
</cf_bodycontent>

<!--- Generate Message-Displayblock --->
<cf_bodycontent name = "dsp_messages">
	<cfinclude template="app_messages.cfm">
</cf_bodycontent>

<!--- Defines how the page elements should be displayed --->
<cfsavecontent variable="outputpage">
	<cfinclude template="app_output.cfm"> 
</cfsavecontent>
<cfoutput>#variables.outputpage#</cfoutput>

<!--- Toolbox Debug Information --->
<cfsavecontent variable="debugoutput">
	<cfoutput>
	<p>
	<table cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td><img src="/interface/spacer.gif" width=10 height=10 alt="" border="0"></td>
		<td>
		<table border="0">
		<tr>
			<td bgcolor="black" colspan="2"><font face="arial,helvetica,sans-serif" size="-1" color="White"><b>Toolbox Debug-Information</b></font></td>
		</tr>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Server Instance</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><cfset thisServer = createObject("java", "jrunx.kernel.JRun").getServerName()>#thisServer#</font></td>
		</tr>
		<cfif form.pagemode is not "">
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Page Mode</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#lcase(form.pagemode)#</font></td>
		</tr>
		</cfif>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Output Type</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#lcase(outputtype)#</font></td>
		</tr>
		<cfif isdefined("variables.loginstatus")>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Login Status</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.loginstatus# <a href="login.cfm?action=act_sessions_logout">Logout</a></font></td>
		</tr>
		</cfif>
		<cfif isdefined("variables.orderID")>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>OrderID</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.orderID# <a href="login.cfm?action=act_sessions_logout">Logout</a></font></td>
		</tr>
		</cfif>
		
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Session Var.</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">SessionID: <cfif isdefined("variables.sid")>#variables.sid#<cfelse>#cookie.sid#</cfif><br>Master SessionID: <cfif isdefined("cookie.masterSID")>#cookie.masterSID#</cfif><br>AffiliateID: #variables.affiliateID#<br>AccountID: #variables.accountID#<br>AddressID: #variables.addressID#<br>Login Status: #variables.loginstatus#<br> Flash Player Version: #variables.flashplayerversion#</font></td>
		</tr>
		
		<cfif primary_msg is not "">
			<tr>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Primary Action</b></font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#replace(primary_msg,"|","<br>","all")#</font></td>
			</tr>
		</cfif>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1" style="color: Black;"><b>Secondary Action</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#secondary_msg#</font></td>
		</tr>
		
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Process</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#process#&nbsp;</font></td>
		</tr>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Stack Modifier</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#stackmodifier#</font></td>
		</tr>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Displayfile</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#displayfile#</font></td>
		</tr>
		<cfif variables.passed_values_primary is not "">
			<tr>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Action Values (Primary)</b></font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">
				<cfloop list="#variables.passed_values_primary#" delimiters="|" index="ii">
					#lcase(listlast(listfirst(ii,"="),":"))# = #lcase(listlast(ii,"="))#<br>
				</cfloop>
				</font>
				</td>
			</tr>
		</cfif>
		<cfif variables.passed_values is not "">
			<tr>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Action Values (Secondary)</b></font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">
				<cfloop list="#variables.passed_values#" delimiters="|" index="ii">
					#lcase(listlast(listfirst(ii,"="),":"))# = #lcase(listlast(ii,"="))#<br>
				</cfloop>
				</font>
				</td>
			</tr>
		</cfif>
		<tr>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Forms</b></font></td>
			<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Stored Values</b></font></td>
		</tr>
		<cfif formstack is not "">
			<cfset counter = 0>
			<cfloop index="ii" list="#formstack#" delimiters="\+"><!--- deserialize Forms and related name/value pairs --->
				<tr>
					<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-2" style="color: Black;">#listfirst(ii,"|")#</font></td>
					<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-2" style="color: Black;">
				<cfloop index="xx" list="#listdeleteat(ii,1,'|')#" delimiters="/"><!--- loop through name/value pairs --->
					<cfset fieldname = listfirst(xx,"=")>	
					<cfif fieldname is not listlast(xx,"=")>
						form.#fieldname# = #replacelist(listlast(xx,"="),"</>,<\>,<=>","/,\,=")#
					<cfelse><!--- workaround for empty string values--->
						form.#fieldname# = 
					</cfif><br>	
				</cfloop>
					&nbsp;</font>
					</td>
				</tr>
			</cfloop>
		</cfif>
		<!--- dispaly systemsettings for modules --->
		<cfif isdefined("syssettings_list") and syssettings_list is not "">
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Systemsettings</b></font></td>
				<td bgcolor="LightGoldenrodYellow">
					<font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">
					<cfloop list="#syssettings_list#" index="ii">
						#ii# = #left(evaluate(ii),50)# <br>
					</cfloop>
					</font>
				</td>
			</tr>
		</cfif>
		<cfif isDefined("bhawk")>
			<tr>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b>Browser Hawk Result:</b></font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;"><b></b></font></td>
			</tr>
			<cfloop collection="#bhawk#" item="result">
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#result#</font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#bhawk[result]#</font></td>
			</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">OS</font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.os#</font></td>
			</tr>
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">Browser</font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.browser#</font></td>
			</tr>
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">Screen Size</font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.screensize#</font></td>
			</tr>
			<tr>
				<td bgcolor="LightGoldenrodYellow" valign="top"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">Flash Player Version</font></td>
				<td bgcolor="LightGoldenrodYellow"><font face="arial,helvetica,sans-serif" size="-1"  style="color: Black;">#variables.flashplayerversion#</font></td>
			</tr>
		</cfif>
		</table>
		</td>
		<td><img src="/interface/spacer.gif" width=10 height=10 alt="" border="0"></td>
	</tr>
	</table>
	</cfoutput>
</cfsavecontent>

<cfif debugmode is true>
	<cfoutput>#variables.debugoutput#</cfoutput>
</cfif>

<CFCATCH TYPE="Database">
<!--- <cfset debugmode = true> --->
	<cfset errortype = "Database Error">
	<cfinclude template="app_exceptions.cfm">
	<cfabort>
</CFCATCH>

<CFCATCH TYPE="any">
<!--- <cfset debugmode = true> --->
	<cfset errortype = "General Error">
	<cfinclude template="app_exceptions.cfm">
</CFCATCH>
</CFTRY> 