<cfoutput>
	<div class="leftColumnModule">
		<div class="tabTop tabs">	
			<ul style="margin-left:7px;">
				<li><a href="##subscribe">Subscribe</a></li>
				<li class="rss"><a href="##feeds">Feeds</a></li>
			</ul>
		</div>
		<div class="moduleHeader tabs" id="subscription">
			<div class="moduleContent" id="subscribe">
				<fieldset class="subscribe">
                	<ul>
                    	<li><label id="email">e-mail</label></li>
                    	<li><span><em><input type="text" name="email" ></em></span></li>
					</ul>
				</fieldset>
				<!--- Jarrod, query for # of subscribers --->
				<span class="subscriberCount arial10 grayMed">#NumberFormat(456789,',')# Subscribers</span>
				<span class="subscribeBtn click"><img src="#application.themePath#/images/buttons/btn_subscribe.png" height="30" width="92"></span>
			</div>
			<cfset rssFeedNames = "The Pongo Blog,In The News,Resources">
			<cfset rssFeedIDs = "B4885BE4-D19D-378F-8B8BD9E99D76B597,B4D5CFF8-FCC4-A30C-FB990269D5BED5D5,B4ED8C2C-FB52-234C-0DCE269194F9F20B">			
			<div class="moduleContent" id="feeds">
				<dl>
					<cfloop from = "1" to = "#ListLen(rssFeedIDs)#" index="i">
						<dt>#ListGetAt(rssFeedNames, i)#</dt>
						<dd><a href="http://pongo.synthenet.com/tasks/feed/?feedID=#ListGetAt(rssFeedIDs, i)#" target="_blank"><img src="#application.themePath#/images/buttons/btn_subscribe_rss.png" height="27" width="183" title="Subscribe To RSS Feed" alt="Subscribe To RSS Feed"></a></dd>
					</cfloop>
				</dl>
			</div>
		</div>
	</div>
</cfoutput>