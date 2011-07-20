<cfsilent>
	<cfset rbFactory=getSite().getRBFactory() />
</cfsilent>

<cfset iterator = request.iterator />
<cfset iterator.setNextN(10)>
<cfset iterator.setStartRow(request.startrow)>
<!---<cfoutput>
	Records: #iterator.recordcount()#<br>
	Current Row: #iterator.currentRow()#<br>
	Page Index: #iterator.getPageIndex()#<br>
	Pages: #iterator.pageCount()#<br>
	NextN: #iterator.getNextN()#<br>
</cfoutput>--->

<!---<cfdump var="#iterator#" abort="true" />--->
<cfset totalRecords = iterator.recordcount() />
<cfset currentRow = iterator.currentRow() />
<cfset recordsPerPage=iterator.getNextN() />
<cfset numberOfPages= iterator.pageCount() />
<cfset currentPageNumber=iterator.getPageIndex() />
<cfset next= request.startrow + recordsperpage	/>
<cfset previous= request.startrow - recordsperpage	/>
<!---<cfset through= iif(totalRecords lt next,totalrecords,next-1) />--->
<cfset theParent = request.crumbdata[evaluate(arrayLen(request.crumbdata)-1)].menutitle>
<cfif theParent EQ "Resources">
	<cfoutput>#dspObject_Include(thefile='dsp_resources_search.cfm')#</cfoutput>
</cfif>

<cfoutput>
<dl class="searchResultSummary">
	<dt class="cufonNY">#rbFactory.getKey('search.searchresults')#</dt>
	<dd>Your search for "#request.keywords#" found #totalRecords# matching results</dd>
</dl>

<div id="svSearchResults">	
	<cfset totalOnPage = 0>
	<cfset args=arrayNew(1)>
	<cfset args[1]=totalRecords />
	<cfif totalrecords>		
		<dl id="svPortal" class="svIndex">			
			<!---<cfloop from="1" to="#recordsPerPage#" index="i">--->
			<cfloop condition="iterator.hasNext()">
				<cfsilent> 
					<cfset class = iif(currentRow eq 1,de('first'),de(iif(currentRow eq totalRecords,de('last'),de(''))))>
					<cfset item = iterator.next()>
					
					<cfset class=""/>
						<cfif not iterator.hasPrevious()> 
							<cfset class=listAppend(class,"first"," ")/> 
						</cfif>
						<cfif not iterator.hasNext()> 
							<cfset class=listAppend(class,"last"," ")/> 
						</cfif>
				</cfsilent>
				<cfset titleBreakPoint = find(" ", item.getTitle(), 50)>
				<dt class="searchTitle #class#"><span class="teal" style="width:25px; float:left;">#iterator.getRecordIndex()#</span> <a href="#item.getURL("keywords=#urlEncodedFormat(request.keywords)#")#" class="searchhref"><cfif len(item.getTitle()) GT 50 AND titleBreakPoint GT 0>#left(item.getTitle(), titleBreakPoint-1)#...<cfelse>#item.getTitle()#</cfif></a>&nbsp;&nbsp;<a href="#item.getParent().getURL()#" class="searchcathref link_on">#item.getParent().getTitle()#</a></dt>
		 		<cfif len(item.getValue('summary'))>
					<dd class="searchDescription #class#">#replaceNoCase(highlightKeywords(setDynamicContent(item.getValue('summary'),request.keywords),request.keywords),"<p>","<p class='searchResultDesc'>","all")#<a href="#item.getURL()#" class="dblarrow link_on">Continue Reading</a></dd>
				</cfif>
				<cfset totalOnPage = totalOnPage + 1>
			</cfloop>
		</dl>
	
		
			
			<ul class="moreResults" style="padding:53px 0 0;">
				<cfif currentPageNumber GT 1><li class="navPrev"><a href="?startrow=#previous#&display=search&keywords=#HTMLEditFormat(request.keywords)#&tag=#HTMLEditFormat(request.tag)#&category=#request.category#" class="dblarrowbck">#rbFactory.getKey('list.previous')#</a></li></cfif>
				<li>Displaying <strong>#request.startrow#-#evaluate(request.startrow + totalOnPage - 1)#</strong> of <strong>#totalRecords#</strong></li>
				<!---<cfloop from="1" to="#numberOfPages#" index="i"><cfif currentPageNumber EQ i><li class="current">#i#</li><cfelse><li><a href="?startrow=#evaluate(((i-1)*recordsPerPage)+1)#&display=search&keywords=#HTMLEditFormat(request.keywords)#&tag=#HTMLEditFormat(request.tag)#&category=#request.category#">#i#</a></li></cfif></cfloop>--->				
				<cfif numberOfPages gt 1 AND currentPageNumber NEQ numberOfPages><li class="navNext"><a href="?startrow=#next#&display=search&keywords=#HTMLEditFormat(request.keywords)#&tag=#HTMLEditFormat(request.tag)#&category=#request.category#" class="dblarrow">#rbFactory.getKey('list.next')#</a></li></cfif>
			</ul>
			
			
	<cfelse>
		<h1>No matches found...try changing your search.</h1>
		<!--- No results matched your search criteria --->
	</cfif>	
</div>
</cfoutput>

