<cfset sectionTitle = event.getContentBean().getTitle()>
<cfset parentCategory = event.getContentBean().getParent().getParent().getTitle()>  
<cfif parentCategory EQ "Members">
	<cfset feedNameList = "Member Help #sectionTitle#">
<cfelse>
	<cfset feedNameList = "Help #sectionTitle#">
</cfif>

<cfoutput>

<cfloop index="thisFeedName" list="#feedNameList#"> 
	<cfset feedBean = getBean("feed").loadBy(name=thisFeedName, siteID=event.getValue("SiteID"))>
	<cfset iteratorLinks = feedBean.getIterator()>
	<cfset iteratorContent = feedBean.getIterator()>
   
	<cfsilent>
		<cfset checkMeta = feedBean.getDisplayRatings() or feedBean.getDisplayComments()>
		<cfset doMeta = 0>
	</cfsilent>
	<div class="helpTopics"> 
        <div class="upper">
            <h2 class="topTen cufonNY"><cfif sectionTitle EQ "Highlights">Top #iteratorLinks.getRecordCount()# Questions<cfelse>#sectionTitle#</cfif></h2>
            <br clear="all" />
            <ol class="questions">
                <cfloop condition="iteratorLinks.hasNext()">
                    <cfsilent>
                        <cfset item=iteratorLinks.next()>
                        <cfif checkMeta> 
                            <cfset doMeta=item.getValue('type') eq 'Page' or showItemMeta(item.getValue('type')) or (len(item.getValue('fileID')) and showItemMeta(item.getValue('fileEXT')))>
                        </cfif>					
                    
                		<cfset theGrandParent = item.getParent().getParent()>
                		<cfset theParent = item.getParent()>
                        
               			<cfif theGrandParent.getTitle() eq "Help">
                    		<cfset resourceCategory = theParent.getTitle()>
                		<cfelse>
                    		<cfset resourceCategory = theGrandParent.getTitle()>
                		</cfif>
                		<cfset contentCategory = theParent.getTitle()>
                    </cfsilent>
                	<li><a href="###iteratorLinks.getRecordIndex()#">#item.getTitle()#</a></li>
                </cfloop>
            </ol>
        </div>
		<div class="lower">
    		<cfset i = 0>
     		<cfloop condition="iteratorContent.hasNext()">
      			<cfset i = i + 1>
				<cfset item = iteratorContent.next()>				
                <dl>
                	<dt><a name="#iteratorContent.getRecordIndex()#"></a><span class="answerNumber">#i#.</span> #item.getTitle()#</dt>
                    <dd>#item.getBody()#</dd>
                    <dd class="anchorTop"><a href="##top">Back To Top</a></dd>
                </dl>  
      		</cfloop>  	
   	 	</div>
	</div>
</cfloop>

</cfoutput>