<cfparam name="url.layout" default="1">
<cfoutput>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <!--- Temporary set for app themepath --->
  <cfset application.themePath = "/pr/includes/themes/pongo">
  <link href="#application.themePath#/css/styles.css" rel="stylesheet" type="text/css" media="screen">
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/cufon.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/includes/fonts/ChaletNY1960.font.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/includes/fonts/ChaletLondon1960.font.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/includes/fonts/ChaletParis1960.font.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/includes/fonts/Dakota_500.font.js"></script>
  <script type="text/javascript">
		Cufon.replace('.cufonLondon,.subText,.leftNav li h6,.dayofmonth,.pageTitleBar h2,.moduleContent##feeds dt,dl.supportBlurb dd,fieldset.loginWin legend', { fontFamily: 'ChaletLondon1960' });
		Cufon.replace('.cufonNY,.leftNav li.selected h6', { fontFamily: 'ChaletNY1960' });
		Cufon.replace('.cufonDakota', { fontFamily: 'Dakota' });
		Cufon.replace('.cufonParis', { fontFamily: 'ChaletParis1960' });
	</script>
  <script type="text/javascript" src="#application.themePath#/js/ui.core.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/ui.tabs.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/pongo.js"></script>
  <script type="text/javascript" src="#application.themePath#/js/retweet.js"></script>
  <cfif findNoCase("MSIE 6", cgi.HTTP_USER_AGENT)>
    <!--- fix IE6 png transparency --->
    <script src="#application.themePath#/js/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>
    DD_belatedPNG.fix('.ie6_png');
  </script>
  </cfif>
  <!--[if lt IE 7]>
    	<script src="../js/IE7.js" type="text/javascript"></script> 
		<link href="#application.themePath#/css/ie6_styles.css" rel="stylesheet" type="text/css" media="screen">
	<![endif]-->
  <!--[if IE 7]>
		<link href="#application.themePath#/css/ie7_styles.css" rel="stylesheet" type="text/css" media="screen">
	<![endif]-->
  </head>
  <body id="signup_single">
  <div class="wrapper">
    <h1 class="logo_h1"><a href="index.cfm">Pongo Resume</a></h1>
    <div class="utilityNavContainer">
      <div class="utilityNav">
        <ul>
		  <li id="supportInfo" class="window.show grayL click">Toll Free Support 866.486.4660</li>
          <li id="liveHelp"><cfinclude template="includes/themes/pongo/shared/provideSupport.cfm"></li>
          <!--- <li class="orange click" id="loginForm">My Account - Log Out</li> --->
        </ul>
      </div>
    </div>
    <div id="container_main" class="pp_splash<cfif url.layout eq 2>_b</cfif>">
      <div class="inner">
        <h2 class="cufonNY">Lament and sam-hell plug-nickel locality cipherin</h2>
        <p class="cufonLondon introText">Wagon git, hayseed nothin' hardware plumb havin' stumped pudneer beer heff <a style="cursor:pointer;" class="linkLine" onclick="$('##popUpList').show();">What&##8217;s Included?</a></p>
        
        <div class="pp_desc_01">
          <h3 class="cufonLondon">Monthly</h3>
          <p class="pp_cost"><strong><sup>$</sup>9.95</strong></p>
          <p class="pp_description"><em>Some type to visualize what the actual copy might look like here.</em></p>
          <a class="btnSignUp ie6_png" href="##">SIGN UP!</a>
        </div>

        <div class="pp_desc_02">
          <h3 class="cufonLondon">Quarterly</h3>
          <p class="pp_cost"><strong><sup>$</sup>22.95</strong></p>
          <p class="pp_description"><em>Some type to visualize what the actual copy might look like here.</em></p>
          <a class="btnSignUp ie6_png" href="##">SIGN UP!</a>
        </div>

        <div class="pp_desc_03">
          <h3 class="cufonLondon">Yearly</h3>
          <p class="pp_cost"><strong><sup>$</sup>99.95</strong></p>
          <p class="pp_description"><em>Some type to visualize what the actual copy might look like here.</em></p>
          <a class="btnSignUp ie6_png" href="##">SIGN UP!</a>
        </div>
        
        <p class="txtBottom">Not ready to make a commitment? <a href="signupTrial.cfm">Try Pongo Free</a>  -  <a style="cursor:pointer;" onclick="$('##popUpListTrial').show();">What&##8217;s Included?</a></p>
        
        <div id="popUpList" class="ie6_png" onclick="$('##popUpList').hide();">
            <h3>All The Tools You Need</h3>
            <p>Membership Includes the Following:</p>
            <ul>
              <li>Personalized guidance</li>
              <li>Resume builder</li>
              <li>Cover letter builder</li>
              <li>Reference builder</li>
              <li>Live, expert help</li>
              <li>FAQs &amp; online self-help</li>
              <li>22 professional layouts</li>
              <li>Job search tools</li>
              <li>Job listings from Indeed</li>
              <li>Interview tips</li>
              <li>Videos, articles, blog</li>
              <li>One more bullet</li>
            </ul>
            <p>*Free memberships include all services without the ability to download, email or fax.</p>
        </div>
        
        <div id="popUpListTrial" class="ie6_png" onclick="$('##popUpListTrial').hide();">
            <h3>Trial Account Tools</h3>
            <p>Trial Membership Includes the Following:</p>
            <ul>
              <li>Personalized guidance</li>
              <li>Resume builder</li>
              <li>Cover letter builder</li>
              <li>Reference builder</li>
              <li>22 professional layouts</li>
              <li>Job search tools</li>
              <li>Job listings from Indeed</li>
            </ul>
            <p>*Free memberships include all services without the ability to download, email or fax.</p>
        </div>


      </div>
      <!--- end inner div for padding --->
    </div>
    <cfinclude template="includes/themes/pongo/shared/footer_Signup.cfm">
  </div>
  <!--- end wrapper --->
  </body>
  </html>
</cfoutput>