<!--- Share Bar --->
<cfset commentCount = $.content().getStats().getComments()>
<cfset pdfFileID = $.content().getValue('ArticlePDF')>
<cfset showShareBar = 'true'>


<cfoutput>
<div class="shareBar">
	<div class="shareInner" >
		<ul class="socialMedia">
			<li><a class="retweet" title="Article Name"></a></li>
			<li><a name="fb_share" type="button" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script></li>
			<li class="label" style="border:none;"><a href="##comments" class="noAjax">Comments</a></li>
			<li style="border:none;" class="counterBubble counter"><a href="##comments" class="noAjax">#commentCount#</a></li>
		</ul>
		<ul class="pageOptions">
			<cfif isDefined("pdfFileID") AND len(pdfFileID)>
				<a href="#application.configBean.getContext()#/tasks/render/file/?fileID=#pdfFileID#" target="_blank"><span><li class="print">Print</li></span></a>
			</cfif>
			<span><li class="window.show click share" id="addThis">Share</li></span>
			<!--- <span><li class="favorites">Favorites</li></span> --->
		</ul>	
	</div>
</div>
</cfoutput>
<!--- /Share Bar --->