<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: app_sessionhandler.cfm
Purpose: [Enter a description explaining how this file is used]
Last Updated: 7/21/2011 by jstiles
--->

<!--- Set default variables --->
<cfparam name="sessiontimeout" default="60" />
<cfset variables.promotionID = 0 />
<cfset variables.tellafriendID = 0 />
<cfset variables.keywordID = 0 />
<cfset variables.partnerID = 0 />

<!--- user visits the site the first time --->
<cfif http.referer does not contain "#http_host#">
	<cfinclude template="../referrers/qry_referrers_upd.cfm">
<cfelseif http.referer contains "#http_host#/admin">
	<cfset variables.referrerID = -999999 />
	<cfquery name="updsid" datasource="#datasource#">
		UPDATE sessions
		SET referrerID = <cfqueryparam value="#variables.referrerID#" cfsqltype="cf_sql_integer" />
		WHERE sid = <cfqueryparam value="#sid#" cfsqltype="cf_sql_varchar" />
	</cfquery>
<cfelse>
	<cfset variables.referrerID = 0>
</cfif>

<!--- detect browser/system settings --->
<cfif not isdefined("cookie.sid") OR Not IsNumeric(cookie.sid) OR IsDefined("URL.bhclear")>
	<cfset variables.os = "" />
	<cfset variables.browser = "" />
	<cfset variables.screensize = "" />
	<cfset variables.flashplayerversion = "" />
	<cfset variables.cookiesenabled = "" />
	<cfset variables.javascriptenabled = "" />
	<!--- 301 redirect for requests with bhcp=1 --->
	<cfif FindNoCase("bhcp=1",cgi.QUERY_STRING) GT 0>
		<cfset variables.queryString = ReReplace(CGI.QUERY_STRING,"bhcp=1&|&bhcp=1|bhcp=1","","one")>
		<cfif variables.queryString NEQ "">
			<cfset variables.queryString = "?#variables.queryString#">
		</cfif>
		<cfheader statuscode="301" statustext="Moved Permanently">
		<cfheader name="Location" value="http://#CGI.server_name##cgi.SCRIPT_NAME##variables.queryString#">
		<cfabort>
	</cfif>
</cfif>

<cfif NOT isdefined("cookie.sid")>
	<!--- Set default variables --->
	<cfset variables.accountID = 0>
	<cfset variables.addressID = 0>
	<cfset variables.oneaddress = 0>
	<cfset variables.loginstatus = 0>
	<cfset variables.orderID = 0>
	<cfset variables.logincount = 0>
	<cfset variables.affiliateproductID = 0>
	<cfset variables.broadcastID = 0>
	<cfset variables.logintype = 0>
	<cfset variables.useragent = "#CGI.http_user_agent#">
	<cfset variables.diagnosticsPass = 0>
	<cfset session_timeout = false>
	
	<!--- Identify affiliate based on URL variables or set a default --->
	<cfif isDefined("URL.affiliateID")>
		<cfset variables.affiliateID = URL.affiliateID>
	<cfelse>
		<cfquery name="getAffiliate" datasource="#datasource#">
			SELECT 	affiliateID
			FROM 	affiliates 
				INNER JOIN addresses ON affiliates.addressID = addresses.addressID
			<cfif isDefined("URL.affiliate")>
				WHERE 	website LIKE <cfqueryparam value="http://www.#URL.affiliate#.%" cfsqltype="cf_sql_varchar" /> 
					OR website = <cfqueryparam value="http://#URL.affiliate#.pongosoftware.com" cfsqltype="cf_sql_varchar" />
					OR website = <cfqueryparam value="http://#URL.affiliate#.synthenet.com" cfsqltype="cf_sql_varchar" />
			<cfelseif isDefined("URL.utm_source")>
				WHERE 	website LIKE <cfqueryparam value="http://www.#URL.utm_source#.%" cfsqltype="cf_sql_varchar" /> 
					OR website = <cfqueryparam value="http://#URL.utm_source#.pongosoftware.com" cfsqltype="cf_sql_varchar" />
					OR website = <cfqueryparam value="http://#URL.utm_source#.synthenet.com" cfsqltype="cf_sql_varchar" />
			<cfelse>
				WHERE 	website = <cfqueryparam value="http://#CGI.server_name#" cfsqltype="cf_sql_varchar" />
						OR website = <cfqueryparam value="http://www.#CGI.server_name#" cfsqltype="cf_sql_varchar" />			
			</cfif>
		</cfquery>	
		<!--- If the above query retrieves 0 records, then do a simple search based on the server_name variable --->
		<cfif NOT getaffiliate.recordCount>
			<cfquery name="getAffiliate" datasource="#datasource#">
				SELECT 	affiliateID
				FROM 	affiliates 
					INNER JOIN addresses ON affiliates.addressID = addresses.addressID
				WHERE 	website = <cfqueryparam value="http://#CGI.server_name#" cfsqltype="cf_sql_varchar" />
						OR website = <cfqueryparam value="http://www.#CGI.server_name#" cfsqltype="cf_sql_varchar" />
			</cfquery>
		</cfif>
		
		<cfset variables.affiliateID = val(getaffiliate.affiliateID) />
	</cfif>
	
	<!--- Set promotion ID based on URL variable existing --->
	<cfif isDefined("URL.promotionID")>
		<cfset variables.promotionID = URL.promotionID />
	</cfif>
	
	<!--- Set promotion ID based on URL variable existing --->
	<cfif isDefined("URL.promotionCode")>
		<cfinclude template="../promotions/fct_promotions_set.cfm">
	</cfif>
	
	<!--- Update tellafriend based on URL variable existing --->
	<cfif isDefined("URL.friendID")>
		<cfset variables.tellafriendID = val(URL.friendID)>
		<cfquery name="upd_tellafriend" datasource="#datasource#">
			UPDATE 	tellafriend
			SET 	clicked = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
			WHERE 	tellafriendID = <cfqueryparam value="#variables.tellafriendID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cfif>
	
	<!--- Set resume posting cookie based on URL variable existing --->
	<cfif isDefined("URL.resumeposting")>
		<cfcookie name="resumeposting" value="true">
	</cfif>
	
	<!--- Set keyword ID based on URL variable existing --->
	<cfif isDefined("URL.keywordID")>
		<cfset variables.keywordID = val(URL.keywordID) />
	<cfelseif isDefined("URL.keyword") OR isDefined("URL.utm_term")>
		<cfquery name="getKeyword" datasource="#datasource#">
			SELECT 	keywordID
			FROM 	keywords
			WHERE 	1 = 1
			<cfif isDefined("URL.keyword")>
				AND keyword = <cfqueryparam value="#URL.keyword#" cfsqltype="cf_sql_varchar" />
			<cfelseif IsDefined("URL.utm_term")>
				AND keyword = <cfqueryparam value="#urlDecode(URL.utm_term)#" cfsqltype="cf_sql_varchar" />
			</cfif>
		</cfquery>
		<cfif getKeyword.recordCount>
			<cfset variables.keywordID = val(getkeyword.keywordID) />
		</cfif>
	</cfif>
	
	<!--- Set partner ID based on URL variable existing --->
	<cfif isDefined("URL.PID")>
		<cfquery name="getpartner" datasource="#datasource#">
			SELECT 	partnerID
			FROM 	partners
			WHERE 	PID = <cfqueryparam value="#URL.PID#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		
		<cfif NOT getpartner.recordcount>
			<cfquery name="addPartner" datasource="#datasource#" result="newPartner">
				INSERT INTO partners 
					(
					PID
					,affiliateID
					,startdate
					)
				VALUES 
					(
					<cfqueryparam value="#URL.PID#" cfsqltype="cf_sql_varchar" />
					,<cfqueryparam value="#val(variables.affiliateID)#" cfsqltype="cf_sql_integer" />
					,getDate()
					)
			</cfquery>
			<cfset variables.partnerID = newPartner.IDENTITYCOL />
		<cfelse>
			<cfset variables.partnerID = getpartner.partnerID />
		</cfif>
	</cfif>
	
	<!--- create a new sessionID and set the cookie; exclude bots and scans --->
	<cfif ReFindNoCase("#variables.allowedagentlist#",cgi.http_user_agent) NEQ 0 AND ReFindNoCase("#variables.excludedAgentList#",cgi.http_user_agent) EQ 0>
		<cfinclude template="../sessions/qry_sessions_add.cfm">
	</cfif>
<cfelse>
	<!--- get session details--->
	<cfquery name="getsid" datasource="#datasource#">
		SELECT 	*
		FROM 	sessions 
		WHERE 	sid = <cfqueryparam value="#cookie.sid#" cfsqltype="cf_sql_varchar" />
	</cfquery>
	
	<cfset sid = cookie.sid />
	<cfset variables.logincount = val(getsid.failedlogincount)>
	<cfset variables.accountID = val(getsid.accountID)>
	<cfset variables.addressID = val(getsid.addressID)>
	<cfset variables.loginstatus = val(getsid.loginstatus)>
	<cfset variables.orderID = val(getsid.orderID)>
	<cfset variables.lasthit = getsid.lasthit>
	<cfset variables.referrerID = val(getsid.referrerID)>
	<cfset variables.affiliateproductID = val(getsid.affiliateproductID)>
	<cfset variables.broadcastID = val(getsid.broadcastID)>
	<cfset variables.promotionID = val(getsid.promotionID)>
	<cfset variables.tellafriendID = val(getsid.tellafriendID)>
	<cfset variables.logintype = val(getsid.logintype)>
	<cfset variables.keywordID = val(getsid.keywordID)>
	<cfset variables.partnerID = val(getsid.partnerID)>
	<cfset variables.useragent = getsid.user_agent>
	<cfset variables.os = getsid.os>
	<cfset variables.browser = getsid.browser>
	<cfset variables.screensize = getsid.screensize>
	<cfset variables.flashplayerversion = getsid.flashplayerversion>
	<cfset variables.cookiesenabled = getsid.cookiesenabled>
	<cfset variables.javascriptenabled = getsid.javascriptenabled>
	<cfset variables.diagnosticsPass = getsid.diagnosticsPass>
	<cfif getsid.recordcount GT 0>
		<cfset variables.affiliateID = val(getsid.affiliateID)>
	<cfelse>
		<cfif isDefined("URL.affiliateID")>
			<cfset variables.affiliateID = URL.affiliateID>
		<cfelseif isDefined("URL.affiliate")>
			<cfquery name="getaffiliate" datasource="#datasource#">
				SELECT 	affiliateID
				FROM 	affiliates 
					INNER JOIN addresses ON affiliates.addressID = addresses.addressID
				WHERE 	website LIKE <cfqueryparam value="http://www.#URL.affiliate#.%" cfsqltype="cf_sql_varchar" /> 
						OR website = <cfqueryparam value="http://#URL.affiliate#.pongosoftware.com" cfsqltype="cf_sql_varchar" />
						OR website = <cfqueryparam value="http://#URL.affiliate#.synthenet.com" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfset variables.affiliateID = val(getaffiliate.affiliateID)>
		<cfelse>
			<cfquery name="getaffiliate" datasource="#datasource#">
				SELECT 	affiliateID
				FROM 	affiliates 
					INNER JOIN addresses ON affiliates.addressID = addresses.addressID
				WHERE 	website = <cfqueryparam value="http://#cgi.server_name#" cfsqltype="cf_sql_varchar" /> 
						OR website = <cfqueryparam value="http://www.#cgi.server_name#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfset variables.affiliateID = val(getaffiliate.affiliateID)>
		</cfif>
	</cfif>
	
	<cfif isDefined("URL.affiliateID") AND isdefined("adminpreview") AND adminpreview EQ 1>
		<cfset variables.affiliateID = URL.affiliateID>
		<cfquery name="updsid" datasource="#datasource#">
			UPDATE 	sessions
			SET 	affiliateID = <cfqueryparam value="#val(variables.affiliateID)#" cfsqltype="cf_sql_integer" />
			WHERE 	sid = <cfqueryparam value="#sid#" cfsqltype="cf_sql_varchar" />
		</cfquery>
	</cfif>

	<cfif NOT getsid.recordcount>
		<!--- add sessionID if cookie exists but entry in DB is missing --->
		<cfquery name="savesession" datasource="#datasource#">
			INSERT INTO sessions 
				(
				sID
				,orderID
				,IPaddress
				,affiliateID
				,accountID
				,loginstatus
				,referrerID
				,lasthit
				,hitscounter
				,sessioncounter
				,affiliateproductID
				)
			VALUES 
				(
				<cfqueryparam value="#cookie.sid#" cfsqltype="cf_sql_varchar" />
				,<cfqueryparam value="0" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="#CGI.REMOTE_ADDR#" cfsqltype="cf_sql_varchar" />
				,<cfqueryparam value="#val(variables.affiliateID)#" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="0" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="0" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="#variables.referrerID#" cfsqltype="cf_sql_integer" />
				,getDate()
				,<cfqueryparam value="1" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="1" cfsqltype="cf_sql_integer" />
				,<cfqueryparam value="0" cfsqltype="cf_sql_integer" />
				)
		</cfquery>
		<cfset variables.lasthit = createODBCdatetime(now())>
	</cfif>
	
	<!--- check if session is expired --->
	<cfif getsid.recordcount GT 0 AND DateCompare(getsid.lasthit, DateAdd("n",-sessiontimeout,now()) ,"n") IS -1>		
		<cfquery name="updsid" datasource="#datasource#">
			UPDATE 	sessions with (rowlock)
			SET 	loginstatus = 0
					,referrerID = <cfqueryparam value="#variables.referrerID#" cfsqltype="cf_sql_integer" />
					,IPaddress = <cfqueryparam value="#CGI.REMOTE_ADDR#" cfsqltype="cf_sql_varchar" />
					,lasthit = #createODBCdatetime(now())#
					,hitscounter = hitscounter + 1
					,sessioncounter = sessioncounter + 1
			WHERE 	sid = <cfqueryparam value="#sid#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfset variables.loginstatus = 0>
		<cfset session_timeout = true>
	<cfelse>
		<cfquery name="updsid" datasource="#datasource#">
			UPDATE 	sessions with (rowlock)
			SET 	IPaddress = <cfqueryparam value="#CGI.REMOTE_ADDR#" cfsqltype="cf_sql_varchar" />
					,lasthit = #createODBCdatetime(now())#
					,hitscounter = hitscounter + 1
			WHERE 	sid = <cfqueryparam value="#sid#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfset session_timeout = false>
	</cfif>
</cfif>

<cfif variables.loginstatus NEQ 0>
	<!--- set personalization variables --->
	<cfquery name="get_account_details" datasource="#datasource#">
		SELECT 	
				accountpass,
				firstname,
				lastname,
				middleinitial,
				address1,
				address2,
				city,
				addresses.stateID,
				stateCode,
				province,
				zip,
				addresses.countryID,
				countryname,
				email,
				phone,
				adminpass,
				accountpass,
				freeTrialStartDate,
				membershipType,
				membershipStatus,
				billingFrequency,
				dateCreated,
				nextActivityDate
		FROM 	accounts 
			INNER JOIN addresses ON accounts.addressID = addresses.addressID
			LEFT JOIN states ON addresses.stateID = states.stateID
			LEFT JOIN countries ON addresses.countryID = countries.countryID
		WHERE 	accounts.accountID = <cfqueryparam value="#variables.accountID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfset variables.accountpass = get_account_details.accountpass>
	<cfset variables.firstname = get_account_details.firstname>
	<cfset variables.lastname = get_account_details.lastname>
	<cfset variables.middleinitial = get_account_details.middleinitial>
	<cfset variables.address1 = get_account_details.address1>
	<cfset variables.address2 = get_account_details.address2>
	<cfset variables.city = get_account_details.city>
	<cfset variables.stateCode = get_account_details.stateCode>
	<cfset variables.stateID = get_account_details.stateID>
	<cfset variables.province = get_account_details.province>
	<cfset variables.zip = get_account_details.zip>
	<cfset variables.countryname = get_account_details.countryname>	
	<cfset variables.countryID = get_account_details.countryID>	
	<cfset variables.email = get_account_details.email>
	<cfset variables.phone = get_account_details.phone>
	<cfset variables.adminpass = get_account_details.adminpass>
	<cfset variables.accountpassword = get_account_details.accountpass>
	<cfset variables.name = get_account_details.firstname & " " & get_account_details.lastname>
	<cfset variables.freeTrialStartDate = get_account_details.freeTrialStartDate>
	<cfset variables.membershipType = get_account_details.membershipType>
	<cfset variables.membershipStatus = get_account_details.membershipStatus>
	<cfset variables.billingFrequency = get_account_details.billingFrequency>
	<cfset variables.accountCreatedDate = get_account_details.dateCreated>
	<cfset variables.nextActivityDate = get_account_details.nextActivityDate>
<cfelse>
	<cfset variables.accountpass = "">
	<cfset variables.firstname = "">
	<cfset variables.middleinitial = "">
	<cfset variables.lastname = "">
	<cfset variables.address1 = "">
	<cfset variables.address2 = "">
	<cfset variables.city = "">
	<cfset variables.stateCode = "">
	<cfset variables.stateID = 0>
	<cfset variables.province = "">
	<cfset variables.zip = "">
	<cfset variables.countryname = "">
	<cfset variables.countryID = 0>
	<cfset variables.email = "">
	<cfset variables.phone = "">
	<cfset variables.adminpass = "">
	<cfset variables.accountpassword = "">
	<cfset variables.name = "">
	<cfset variables.freeTrialStartDate = "">
	<cfset variables.membershipType = "">
	<cfset variables.membershipStatus = "">
	<cfset variables.billingFrequency = "">
	<cfset variables.accountCreatedDate = now()>
	<cfset variables.nextActivityDate = now()>
</cfif>

<!--- check for secure actions --->
<cfif variables.referrerID NEQ -999999 AND listfind("act_accounts_validate,act_accounts_verify,act_accounts_add,act_accounts_upd_new",primary_action) is 0>
	<cfloop list="#action#" index="ii">
		<cfif listfindnocase(ii,"sec","_") is not 0>
			<!--- check for loginstatus --->
			<cfif variables.accountID * variables.loginstatus is 0>
				<!--- user is not logged in or session has timed out --->
				<!--- session has timed out or accountID is not valid because of error --->
				<cfif form.primary_action is not "">
					<cfset form.action = form.primary_action & "_" & action>
				</cfif>
				<cfset primary_action = "act_accounts_validate">
				<cfif session_timeout>
					<cfset msg = "Your Session has timed out, please login again.">
				</cfif>
				<cfif trim(query_string) NEQ "">
					<cfset action = Replace(action,ii,"#ii#:#Replace(query_string,'&','|','all')#")>
				</cfif>
			</cfif>
			<cfif process is "ecommerce" and variables.orderID is 0 and action is not "orders_upd">
				<!--- check for valid orderID --->
				<cfset action = "orderitems_list">
				<cfset primary_action = "">
			</cfif>
			<!--- <cfoutput>The Action "#ii#" is secure - Login status was tested</cfoutput> --->
			<cfbreak>
		</cfif>
	</cfloop>
<cfelseif primary_action EQ "act_accounts_validate" AND action NEQ "" AND trim(query_string) NEQ "" AND (variables.accountID * variables.loginstatus) EQ 0>
	<cfset action = action & ":#Replace(query_string,'&','|','all')#">
</cfif>
