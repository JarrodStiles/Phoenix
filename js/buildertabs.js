// Post Login Tabs



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
			var goToTab = $('#navBuilder ul.ui-tabs-nav a').index( $('a[href="#' + urlContainer + '"]') );
			$('#memberTabs').tabs('select', goToTab);
		}
		
		if(url.indexOf("?") !=-1)
		{
			url=url + "&builderTabs=ajax";
		} else {
			url=url + "?builderTabs=ajax";
		} 
		
		$.get(url,{ 'XHR': success },function(data) 
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
				
				// init innertabs
				var tabs = $('.tabs');
				if (tabs.length > 0)
				{
					$(tabs).each(
					this.tabs() 
					)
				}
								 

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