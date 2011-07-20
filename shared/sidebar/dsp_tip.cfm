<cfset feedBean = $.getBean("feed").loadBy(name='Todays Tip', siteID=event.getValue('siteID'))>
<cfset iterator = feedBean.getIterator()>
<cfset item=iterator.next()>

<cfoutput>
	<cfset authorNames = "Rick Saia,Julie O'Malley,Brianna Raymond">
	<cfset authorImages = "rsaia|85|95,jomalley|84|93,braymond|82|102">
	<cfset r = randRange(1,3)>
	<div class="leftColumnModule" id="todaysTip">
		<h2>Todays Tip</h2>
		<div class="moduleHeader" id="todaysTip">
			<dl class="authorThumb">
				<img src="#application.themePath#/images/#listGetAt(listGetAt(authorImages, r), 1, '|')#.png" width="#listGetAt(listGetAt(authorImages, r), 2, '|')#" height="#listGetAt(listGetAt(authorImages, r), 3, '|')#">
				<dt>#listGetAt(authorNames, r)#</dt>
				<dd>Editor CPRW</dd>	
			</dl>
		</div>
		<dl class="calendar">
			<dt class="dayofmonth">#dateformat(now(),'d')#</dt>
			<dd>#dateformat(now(),'mmmm')#</dd>
		</dl>
		<div class="moduleContent cufonDakota" id="tipContent">#item.getValue("body")#</div>
	</div>
</cfoutput>