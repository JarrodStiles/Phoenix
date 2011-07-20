<cfparam name="videourl" type="string" />

<script type="text/javascript">
	var flashvars = {};
	/*
	flashvars.videoSource = "<cfoutput>#videourl#</cfoutput>";
	*/
	flashvars.playerSkin = "window";
	
	var params = {
		wmode: "transparent",
		allowScriptAccess:"always"
	};
	var attributes = {};
	attributes.id = "videoplayer";
	swfobject.embedSWF("/pr/flash/videoPlayer/Main.swf?videoSource=<cfoutput>#videourl#</cfoutput>", "flashContent", "640", "395", "10.0.45", "playerProductInstall.swf", flashvars, params, attributes);
</script>

<div id="flashContent" style="height:395px;width:640px;">
	<a href="http://www.adobe.com/go/getflashplayer">
		<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
	</a>
		<!---<object id="videoplayer" name="videoplayer" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="640" height="395">
        <param name="movie" value="/pr/flash/videoPlayer/Main.swf?playerSkin=window&videoSource=<cfoutput>#videourl#</cfoutput>" />
		<param name="allowScriptAccess" value="sameDomain" />
        <!--[if !IE]>-->
        <object type="application/x-shockwave-flash" data="/pr/flash/videoPlayer/Main.swf?playerSkin=window&videoSource=<cfoutput>#videourl#</cfoutput>" width="640" height="395">
        <!--<![endif]-->
          <p>Alternative content</p>
        <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>--->
</div>
