<cfoutput>
	<div class="ratingsComments">	
		<cfif item.getValue('allowCommentRateFlag') IS "Yes">
			<!---<cf_displayRating static="true" ratingData="#item#">--->
				#displayRating('true', 'false', '#item#')#
			<cfif item.getComments() GT 0>
				<div class="commentCounter">
					<ul>
						<li class="label">Comments</li>
						<li class="counter arial12 pongoGreen">#item.getComments()#</li>
					</ul>
				</div>
			</cfif>
		<cfelse>
			&nbsp;
		</cfif>
	</div>
</cfoutput>