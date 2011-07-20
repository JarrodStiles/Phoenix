<script type="text/javascript">
	var flashvars = {};
	flashvars.videoSource = "<cfoutput>#item.getValue('videourl')#</cfoutput>";
	flashvars.playerSkin = "inline";
	var params = {wmode: "transparent"};
	var attributes = {};
	attributes.id = "videoplayerinline";
	swfobject.embedSWF("/pr/flash/videoPlayer/Main.swf", "flashContent", "650", "365", "10.0.45", "playerProductInstall.swf", flashvars, params, attributes);
</script>
<!---<div>
<input type="button" value="p" onclick="pauseMovie();" />
</div>--->
<div id="flashContent">
	<a href="http://www.adobe.com/go/getflashplayer">
		<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
	</a>
</div>
<!---<script type="text/javascript">
	//"videoplayer" is the id of the swf 
	function pauseMovie() {
		getFlexApp('videoplayer').pauseMovie();
	}	
	function getFlexApp(appName) {
		if (navigator.appName.indexOf ("Microsoft") !=-1) return window[appName];
			else return document[appName];
	}
</script>--->
