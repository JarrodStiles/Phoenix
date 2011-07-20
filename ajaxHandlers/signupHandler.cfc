<cfcomponent output="false">
	<cffunction name="handleComparisonChart" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data close">
			<div class="#arguments.event.getValue('eventName')#Content">
				<img src="/pr/includes/themes/pongo/images/comparison_chart.png" width="685" height="327">
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleCountryBilling" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfset countryList = this.getCountryList()>
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data close bottom center">
				<div class="#arguments.event.getValue('eventName')#Content">
					<div class="selectTitle">
						<h2 class="pongoGreen cufonNY">Select Your Country</h2>
					</div>
					<div class="selectData">
						<ul>
							<cfloop query="countryList">
								<li id="#arguments.event.getValue('eventName')#_#countryID#" class="option.save click option">#countryName#</li>
							</cfloop>
						</ul>
					</div>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleStateBilling" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfset stateList = this.getStateList()>
		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data close bottom center">
				<div class="#arguments.event.getValue('eventName')#Content">
					<div class="selectTitle">
						<h2 class="pongoGreen">Select Your State</h2>
					</div>
					<div class="selectData">
						<ul>
							<cfloop query="stateList">
								<li id="#arguments.event.getValue('eventName')#_#stateID#" class="option.save click option">#stateName#</li>
							</cfloop>
						</ul>
					</div>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleCidInfo" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data left top close">
				<img src="/pr/includes/themes/pongo/images/gfx_cid.jpg" width="317" height="375">
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />	
	</cffunction>
	
	<cffunction name="handlePayByPhone" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		<!---  Pay by phone step 1 --->
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data abs h_center v_center close">
			    <div class="inner">
			      <h3>Pay by Phone</h3>
			      <p>Please click Request Callback to have a Customer Support Specialist call you back within the next 15 minutes to complete your order.</p>
			      <fieldset class="signupInfo">
			        <ul>
			          <li class="pbpNameContainer">
			            <label id="pbp_name">your name</label>
			            <span><em>
			            <input name="pbp_name" >
			            </em></span> </li>
			          <li class="pbpPhoneContainer">
			            <label id="pbp_number">phone number</label>
			            <span><em>
			            <input name="pbp_number" >
			            </em></span> </li>
			          <li class="pbpBtnContainer"><a class="btn_requestCallback">Request Callback</a></li>
			        </ul>
			      </fieldset>
			    </div>
			  </div>
	
	<!---  Pay by phone step 2 --->
	  <!---
	  <div class="#eventName#_content data center close">
	    <div class="inner">
	      <h3>Pay by Phone</h3>
	      <p><strong>Thank you</strong><br>
	A Customer Support Specialist will be contacting you at the number provided within the next 15 minutes.</p>
	<p class="btnContinue"><a href="##">Continue</a></p>
	    </div>
	  </div>
	  --->
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />	
	</cffunction>
			
	<cffunction name="handleCCExpMonth" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data close bottom center">
				<div class="#arguments.event.getValue('eventName')#Content">
					<div class="selectTitle">
						<h2 class="pongoGreen">Expiration Month</h2>
					</div>
					<div class="selectData">
						<ul class="selectMonth">
							<cfloop from="1" to="12" index="i">
								<li id="#arguments.event.getValue('eventName')#_#i#" class="option.save click option">
									<cfif i LT 10>
										0
									</cfif>
									#i#</li>
							</cfloop>
						</ul>
					</div>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />	
	</cffunction>
	
	<cffunction name="handleCCExpYear" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="#arguments.event.getValue('eventName')#_content data close bottom center">
				<div class="#arguments.event.getValue('eventName')#Content">
					<div class="selectTitle">
						<h2 class="pongoGreen">Expiration Year</h2>
					</div>
					<div class="selectData">
						<ul class="selectMonth">
							<li id="#arguments.event.getValue('eventName')#_0" class="option.save click option">#year(now())#</li>
							<cfloop from="1" to="15" index="i">
								<li id="#arguments.event.getValue('eventName')#_#i#" class="option.save click option">#year(dateAdd("yyyy", i, now()))#</li>
							</cfloop>
						</ul>
					</div>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />	
	</cffunction>
	
	<cffunction name="handleRefundPolicy" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />

		<cfset policyBean = event.getBean("content").loadBy(contentID="ED610D51-938D-0011-CE31442A4A1065E4", siteID="pr")>
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="refundPolicy_content data abs h_center v_center close">
				<div class="commentsPolicyContent">
					<h2>#policyBean.getTitle()#</h2>
					<p>#policyBean.getBody()#</p>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handlePrivacyPolicy" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />

		<cfset policyBean = event.getBean("content").loadBy(contentID="0DED966A-5056-8D4E-596DA222632669EB", siteID="pr")>
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="privacyPolicy_content data abs h_center v_center close">
				<div class="commentsPolicyContent">
					<h2>#policyBean.getTitle()#</h2>
					<p>#policyBean.getBody()#</p>
				</div>
			</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleTermsOfUse" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />

		<cfset policyBean = event.getBean("content").loadBy(contentID="0DF0E697-5056-8D4E-5948920D26265A28", siteID="pr")>
		<cfset contentIterator = policyBean.getKidsIterator()>
		<cfoutput>
		<cfsavecontent variable="local.content">
			<div class="termsOfUse_content data abs h_center v_center close">
				<div style="width: 542px; padding: 8px;">
					<h2 class="cufonNY">#policyBean.getTitle()#</h2>
					<p>#policyBean.getBody()#</p>
				</div>
				<div id="container_accordionTOS">
	<cfset count = 1>
					<cfloop condition="contentIterator.hasNext()">
						<cfset panel = contentIterator.next()>
						<dl class="accordionContainer" id="panel_0#count#">
							<dt>#panel.getTitle()#</dt>
							<dd>
                            	<div class="accordionOuter">
                                	<div id="accordion_#count#" class="accordion.show click accordion"><span class="accordionExpand collapse">Read</span></div>
                                    <div class="accordionInner">#panel.getBody()#</div>
                                </div>
							</dd>
						</dl>
		<cfset count = count + 1>		
					</cfloop>
				</div>
			</div>
            <script>Cufon.refresh();</script>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="getCountryList" access="public" returntype="Query">
		<cfquery name="getCountryList" datasource="pongoresume">
			SELECT 	countryID, countryName
			FROM 	country
			ORDER BY countryName
		</cfquery>
		<cfreturn getCountryList>
	</cffunction>
	
	<cffunction name="getStateList" access="public" returntype="Query">
		<cfquery name="getStateList" datasource="pongoresume">
			SELECT 	stateID, stateName
			FROM 	state
			ORDER BY stateName
		</cfquery>
		<cfreturn getStateList>
	</cffunction>
</cfcomponent>