<script language="javascript">
	var initedContainers=new Array(0);

	function doAjaxRequest(requestContainer,url){
		var urlContainer="";
		urlContainer = getContainerFromUrl(url)		
		
		//This is a search or pagination click so create proper URLs
		if(urlContainer == "#")
		{
			urlContainer = requestContainer;
			var category = requestContainer;
			if(category == 'resources')
			{
				var keywords = $('#searchField').val();
			}
			else 
			{
				var keywords = $('#blogSearchField').val();
			}
			url = '/' + category + '/search-results/?newSearch=true&display=search&nocache=1&category=' + category + '&keywords=' + keywords;
		}				
		//Handle search pagination
		else if (urlContainer.substring(0,9) == "?startrow")
		{
			url = '/' + requestContainer + '/search-results/' + urlContainer;
			urlContainer = requestContainer;
		}
		//Handle general pagination
		else if (urlContainer.substring(0,3) == "?go")
		{
			var pagePath = $('.subselect a').attr('href');
			url = pagePath + urlContainer;
			urlContainer = requestContainer;
		}
						
		if(requestContainer != urlContainer)
		{
			//requestContainer = urlContainer;
			initedContainers.push(urlContainer);			
			var goToTab = $('ul.ui-tabs-nav a').index( $('a[href="#' + urlContainer + '"]') );
			$('#memberTabs').tabs('select', goToTab);
		}
		
		if(url.indexOf("?") !=-1)
		{
			url=url + "&builderTabs=ajax";
		} else {
			url=url + "?builderTabs=ajax";
		}
		
		$.get(url,
			function(data)
			{
				// add html to page
				$("#" + requestContainer).html(data);								

				if(typeof Shadowbox != 'undefined')
				{
					Shadowbox.setup();
				}
				
				// loop over all links in the loaded page and switch them to click events
			$("#" + requestContainer + " a").each(
					function(){	
						if(($(this).hasClass('tabLink') == false) && ($(this).hasClass('click') == false) && ($(this).hasClass('backButton') == false) && ($(this).attr('target') != '_blank'))
						{
							// create a click event from the link
							var temphref = this.href;
							this.setAttribute("href","javascript: reloadContainer('"+requestContainer+"','"+temphref+"');");								
						}
					}
				);
					
				if ($('.searchBox').length == 0) 
				{
					$('.txp dl:first').css({'border':'none'});
				}
				// remove any back links
				$('#backToListing').remove()	
			}
		);
	}
	
	// checks to see if container is already loaded, if not loads container
	function loadContainer(container,url)
	{
		var isLoaded=false;
		var arrLen=initedContainers.length;		
		//Set the current container to load ajax requests.
		currentContainer=container;		
		if(arrLen)
		{
			for (var i = 0; i < arrLen; i++) 
			{
				 if(initedContainers[i]==container)
				 {
					isLoaded=true;
				 }
			}	
		}	
		if(!isLoaded)
		{
			initedContainers.push(container);
			doAjaxRequest(container,url);
		}
	}
	
	// always fetches new content for container. For internal links
	function reloadContainer(container,url)
	{	
		currentContainer=container;		
		doAjaxRequest(container,url);
	}
	
	function getContainerFromUrl(url)
	{	
		var urlContainer = "";
		//Clean up the url	
		var cleanURL = url.replace('http://'+top.location.host,"");
		cleanURL = cleanURL.replace('/',"");								
		var splitURL = cleanURL.split('/');
		//Get the requested container out of the url var 
		if(splitURL[0] == 'members')
		{
			urlContainer = splitURL[1];				
		}
		else
		{
			urlContainer = splitURL[0];
		}
		//End URL creation
		 
		urlContainer = urlContainer.replace("-", "");
		return urlContainer;
	}
</script>

<cfset rootLink = "http://#SERVER_NAME#">
<cfoutput>
    <h1 class="logo_h1"><a href="#rootLink#">Pongo Resume</a></h1>
    <div class="utilityNavContainer">
      <div class="utilityNav">
        <ul>
          <li id="supportInfo" class="window.show grayL click">Toll Free Support 866.486.4660</li>
          <li id="liveHelp"><cfinclude template="provideSupport.cfm"><!---<span class="led">Live Help</span>---></li>
            <cfif session.mura.isLoggedIn>
				<li class="orange"><form id="logoutForm" method="post"><input type="hidden" name="doaction" value="logout"><span id="memberLogout_0" class="form.submit logoutBtn click"></span></form></li>
				<cfelse>
				<li class="orange"><span id="createAccount_0" class="window.show loginBtn click" ></span></li>
			</cfif>
        </ul>
      </div>
    </div>    
    
	<div id="hidden_var">
		<div id="confirm_win" class="popUpGradient ie6_png">
			<div id="confirm">
				<div class="confirm_container">
					<div class="slide1">
						<div class="inner_confirm">
							<h4>Please Wait</h4>
							<p>Your request is being processed...</p>
						</div>
						
						<img class="iconWait" src="#themePath#/images/icon_waiting.gif" width="41" height="38">
					</div>
					<div class="slide2">
						<div class="inner_confirm">
							<h4>Thank You</h4>
							<p>Your submission was successful.</p>	
						</div>
						<a class="confirm.hide click ie6_png btnContinue">Continue</a>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" name="mura_contentID" value="#request.contentBean.getContentID()#">
	
	</div>
</cfoutput>