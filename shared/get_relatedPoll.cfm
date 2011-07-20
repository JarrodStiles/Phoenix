<cfset relatedIterator = item.getRelatedContentIterator()>
<cfset hasPollFlag = 0>
<cfif relatedIterator.getRecordCount() GT 0>
	<cfloop condition="relatedIterator.hasNext()">
		<cfset pollData = relatedIterator.next()>
		<cfif pollData.getParent().getValue('title') IS "Polls">
			<cfset hasPollFlag = 1>
			<cfbreak>
		</cfif>			
	</cfloop>
</cfif>