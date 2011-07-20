<cfoutput>
	<div class="leftColumnModule">
		<div id="blogSearch_container" class="">
			<div class="blogSearch_containerInner">
	            <h5 class="cufonNY">Search</h5>
				<form id="searchForm" method="get" action="/blog/search-results/">
					<input name="newSearch" value="true" type="hidden"/>
					<input type="hidden" name="display" value="search"/>
					<input type="hidden" name="nocache" value="1"/>
					<input id="category" type="hidden" name="category" value="blog"/>
					<fieldset class="blogSearchBox">
	                	<ul>
	                    	<li><span><em><input type="text" id="blogSearchField" name="keywords"  value=""></em></span></li>
						</ul>
	            		<a id="requestForm_submit" href="##" onclick="$('##searchForm').submit();" class="btn_submitRequest">Submit</a>
					</fieldset>
				</form>
             </div>
		</div>
	</div>
</cfoutput>