<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: dsp_homepage_successStory.cfm
Purpose: Display random success story entry with link 
Last Updated: 7/18/2011 by jstiles
--->

<!--- TODO: Get random success story and return as query --->

<cfoutput>
<div class="home_success">
	<div class="innerContent">
		<h3 class="cufonNY">Success Story</h3>
      	<p class="quote cufonLondon"><!--- Quote --->Don't look at me...I'm hideous.</p>
      	<!--- Summary --->I don't know. Mesa day startin pretty okee-day with a brisky morning  munchy, then BOOM! Gettin very scared and grabbin that Jedi and POW!  Mesa here! Mesa gettin' very very scared!
      	<p class="signature cufonBizPen"><!--- First Name w/ Last Initial --->Jar Jar B.</p>
      	<a href="about-us/success-stories/" class="dblarrow">Read More</a>
		<!---<cfif getRandomSuccessStory.successStoryType IS "Short">
			<a href="#theParent.getParent().getURL()#" class="dblarrow">Read More</a>
		<cfelse>
			<a href="#item.getURL()#" class="dblarrow">Read More</a>
		</cfif>--->
	</div>   
</div>
</cfoutput>