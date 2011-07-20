<cfset feedBean=application.feedManager.readByName("Pongo Success Story",event.getValue('siteID')) />
<cfset iterator = feedBean.getIterator()>
<cfset item=iterator.next()>

<cfoutput>
	<!--- Pongo Testimonial Module ---> 
	<div class="leftColumnModule">
	<h2></h2>
	<cfif len(item.getValue('sidebarImage'))>
		<div class="moduleHeader" id="pongotestimonial">
			<div class="testimonialHighlightImage">
				<img src="#application.configBean.getContext()#/tasks/render/file/?fileID=#item.getValue('sidebarImage')#" width="61" height="71" alt="Success Story Image">
			</div>
		</div>
 	<cfelse>
		<div class="moduleHeader" id="pongotestimonial_alt"></div>
	</cfif>
	<dl class="moduleContent" id="testimonialContent">
		<dt>#item.getValue("summary")#</dt>
		<dd>#item.getValue("firstName")# #left(item.getValue("lastName"), 1)#</dd>
		<dd class="moreTestimonials"><a href="" class="dblarrow">Read More</a></dd>
	</dl>
	
	</div>   
	<!---/Pongo Testimonial Module --->
</cfoutput>