<cfoutput>
<cfinclude template="../shared/html_head.cfm" />
<body id="#renderer.gettopid()#" class="twoColSL">
<div id="#renderer.CreateCSSid(request.contentBean.getMenuTitle())#" class="wrapper">
	<cfinclude template="../shared/header.cfm" />
	<div id="content" class="bodyContent">
			<!---#renderer.dspCrumbListLinks("crumbList","&nbsp;&raquo;&nbsp;")#
			#renderer.dspBody(body=request.contentBean.getbody(),pageTitle=request.contentBean.getTitle(),crumbList=0,showMetaImage=0)#--->
			#renderer.dspObjects(2)#
	</div>
	<cfinclude template="../shared/footer.cfm" />
</div>
    <br clear="all">
</body>
</html>
</cfoutput>