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
  <script type="text/javascript" src="#application.themePath#/js/skynet.js"></script>
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
    <div id="container_main" class="pp_00">
    <div class="signupTop">&nbsp;</div>
      <div class="inner">
        <h2 class="cufonNY">Get Started Using Pongo Resume Today</h2>
        <p class="starburstTrial">FREE Membership</p>
        <p class="cufonLondon introText">Wagon git, hayseed nothin' hardware plumb havin' stumped pudneer beer heffer havin', cousin.</p>
        <div id="content_form">
          <div id="step1">
            <h3 class="cufonParis ie6_png">Your Profile</h3>
            <fieldset class="signupInfo">
              <ul class="">
                <li class="firstName">
                  <label id="firstname">first name</label>
                  <span><em>
                  <input type="text" name="firstname">
                  </em></span></li>
                <li class="midInitial">
                  <label id="middleinitial">MI</label>
                  <span><em>
                  <input name="middleinitial" type="text" maxlength="1">
                  </em></span></li>
                <li class="regularRight">
                  <label id="lastname">last name</label>
                  <span><em>
                  <input type="text" name="lastname">
                  </em></span></li>
                <li class="regularLeft">
                  <label id="email">e-mail</label>
                  <span><em>
                  <input type="text" name="email" >
                  </em></span></li>
                <li class="regularRight">
                  <label id="confirmEmail">confirm e-mail</label>
                  <span><em>
                  <input type="text" name="confirmEmail" >
                  </em></span></li>
                  <li class="regularLeft">
                    <label id="password">choose password</label>
                    <span><em> <span id="password_lbl" class="label.hide click overlabel">Minimum
                    8 Characters</span>
                    <input name="password" type="password" value="" >
                    </em></span> </li>
                  <li class="regularRight">
                    <label id="confirmPassword">confirm password</label>
                    <span><em> <span id="confirmPassword_lbl" class="label.hide click overlabel">Minimum
                    8 Characters</span>
                    <input name="confirmPassword" type="password" value="" >
                    </em></span></li>
              </ul>
            </fieldset>
          </div>
          <div class="txtTrial">
          <p><strong>Your 30-day free trial lasts until midnight on #dateFormat(dateAdd("m", 1, now()), "mmmm d, yyyy")#.</strong> If you don't want to continue using Pongo Resume, just cancel before the trial ends and you won't be charged (we'll email you 5 days before the trial ends to remind you). Otherwise, you'll pay just $9.95/month for the service as long as your account is open. <strong>You can upgrade, downgrade, or cancel any time.</strong></p>
          </div>
            <p class="confirm_txt"><span class="checkState click" id="fauxCheck">&nbsp;</span><input type="checkbox" class="hideCheckBox  input.focus r" value="1" name="commentSubscribe">Newsletter hogjowls, huntin' dirty skinny caboodle give watchin' diesel tarnation, watchin' fancy mule, confounded.</p>
            <p class="confirm_txt">By clicking Create Account, you are indicating that you have read and agree to Pongo&##8217;s <a id="termsOfUse" class="window.show link_on click">Terms of Use</a> and <a id="privacyPolicy" class="window.show link_on click">Privacy Policy</a>. Please also review our <a id="refundPolicy" class="window.show link_on click">Refund Policy</a>.</p>
            <p class="submitBtnArea"><a class="btnSignUp" href="##">Create Account</a></p>
        </div>
        <!--- end content_form --->
      </div>
      <!--- end inner div for padding --->
    </div>
    <cfinclude template="includes/themes/pongo/shared/footer_Signup.cfm">
  </div>
  <!--- end wrapper --->
  </body>
  </html>
</cfoutput>