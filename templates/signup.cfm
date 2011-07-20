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
  <script type="text/javascript" src="#application.themePath#/js/skynet.js"></script>
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
    <h1 class="logo_h1"><a href="/index.cfm">Pongo Resume</a></h1>
    <div class="utilityNavContainer">
      <div class="utilityNav">
        <ul>
          <li id="supportInfo" class="window.show grayL click">Toll Free Support
            866.486.4660</li>
          <li id="liveHelp">
            <cfinclude template="../shared/provideSupport.cfm">
          </li>
          <!--- <li class="orange click" id="loginForm">My Account - Log Out</li> --->
        </ul>
      </div>
    </div>
    <div id="container_main" class="pp_01">
    <div class="signupTop">&nbsp;</div>
      <div class="inner">
        <h2 class="cufonNY">Get Started Using Pongo Resume Today</h2>
        <p class="cufonLondon introText">Wagon git, hayseed nothin' hardware
          plumb havin' stumped pudneer beer heffer havin', cousin.</p>
        <div id="content_form">
          <form id="signupForm" class="ajaxForm">
            <div id="step1">
              <h3 class="cufonParis ie6_png">Your Profile</h3>
              <fieldset class="signupInfo">
                <ul class="">
                  <li class="firstName">
                    <label id="firstname">first name</label>
                    <span><em>
                    <input type="text" name="firstname" class="input.focus r">
                    </em></span> </li>
                  <li class="midInitial">
                    <label id="middleinitial">MI</label>
                    <span><em>
                    <input name="middleinitial" type="text" maxlength="1" >
                    </em></span></li>
                  <li class="regularRight">
                    <label id="lastname">last name</label>
                    <span><em>
                    <input type="text" name="lastname" class="input.focus r">
                    </em></span> </li>
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
            <hr>
            <div id="step2">
              <h3 class="cufonParis ie6_png">Billing Contact</h3>
              <fieldset class="signupInfo">
                <ul class="">
                  <li class="firstName">
                    <label id="firstnameBilling">first name</label>
                    <span><em>
                    <input type="text" name="firstnameBilling">
                    </em></span> </li>
                  <li class="midInitial">
                    <label id="middleinitialBilling">MI</label>
                    <span><em>
                    <input name="middleinitialBilling" type="text" maxlength="1">
                    </em></span></li>
                  <li class="regularRight">
                    <label id="lastnameBilling">last name on card</label>
                    <span><em>
                    <input type="text" name="lastnameBilling">
                    </em></span></li>
                  <li class="regularLeft">
                    <label id="address1Billing">address 1</label>
                    <span><em>
                    <input name="address1Billing" >
                    </em></span> </li>
                  <li class="regularRight">
                    <label id="address2Billing">address 2</label>
                    <span><em>
                    <input name="address2Billing" >
                    </em></span></li>
                  <li class="regularLeft">
                    <label> country </label>
                    <span><em id="countryBilling" class="window.show click select"></em></span> </li>
                  <input id="countryBilling_input" type="hidden" name="countryBilling" value="" class="input.trigger watch">
                  <li class="regularRight">
                    <label id="cityBilling"> city </label>
                    <span><em>
                    <input type="text" name="cityBilling">
                    </em></span> </li>
                    
                  <li id="stateBilling_block" class="regularLeft">
                    <label> state </label>
                    <span><em id="stateBilling" class="window.show click select"></em></span> </li>
                  <input id="stateBilling_input" type="hidden" name="stateBilling" value="" class="input.trigger watch">
                  <li id="provinceBilling_block" class="regularLeft" style="display:none;">
                    <label id="province"> province </label>
                    <span><em id="provinceBilling" class="window.show click select"></em></span> </li>
                  <input id="provinceBilling_input" type="hidden" name="provinceBilling" value="">
                  <li class="regularRight">
                    <label id="zipBilling"> zip code </label>
                    <span><em>
                    <input type="text" name="zipBilling">
                    </em></span> </li>
                  <li class="regularLeft">
                    <label id="phoneHome">home phone</label>
                    <span><em>
                    <input name="phoneHome" >
                    </em></span> </li>
                  <li class="regularRight">
                    <label id="phoneMobile">mobile phone</label>
                    <span><em>
                    <input name="phoneMobile" >
                    </em></span></li>
                  <li class="checkboxAddress">
                    <input type="checkbox" name="useAddressOnResume">
                    <label id="useAddressOnResume">Use this address on my resume</label>
                  </li>
                </ul>
              </fieldset>
            </div>
            <hr>
            <div id="step3">
              <h3 class="cufonParis ie6_png">Credit Card</h3>
              <div class="liveSupportArea">
              				<cfinclude template="../shared/liveChatOpen.cfm" />
                                <cfif liveChatOpen is true>
                                    <a id="chat" class="ie6 link12_orange" onClick="psw8oHow();">Live Support |</a> 1.866.486.4660
                                </cfif>
                            
                            
			  <!---<a id="payByPhone" class="window.show link_on dblarrow click">Pay
                  by Phone Click Here</a>---></div>
              <!--- Start confirm pricepoint description --->
              <div id="confirm_pp_details">
                <h4><span class="confirm_pp_term cufonLondon">Monthly</span><br>
                  <span class="cufonNY">Membership</span></h4>
                <p class="confirm_pp_cost"><sup>$</sup><strong>9.95</strong></p>
                <p class="confirm_pp_description"><em>Bull poker gospel skinny
                    firewood yer whiskey.</em></p>
              </div>
              <!--- End confirm pricepoint description --->
              <fieldset class="signupInfo">
                <ul class="">
                  <li class="creditCard">
                    <label id="creditCardNumber">Credit Card Number</label>
                    <span><em>
                    <input type="text" id="creditCardNumber_input" name="creditCardNumber">
                    </em></span></li>
                  <li class="creditCID">
                    <label id="creditCardCID">CID</label>
                    <span><em>
                    <input name="creditCardCID" type="text" maxlength="4">
                    </em></span>
                    <div id="cidInfo" class="window.show hover info focus"></div>
                  </li>
                  <li class="expMonth">
                    <label>Expires</label>
                    <span><em id="ccExpMonth" class="window.show click select"> </em></span></li>
                  <li class="expYear">
                    <label>&nbsp;</label>
                    <span><em  id="ccExpYear" class="window.show click select"> </em></span></li>
                  <li class="ccTypes"><img src="#themePath#/images/ccPics.png" width="200" height="25" alt="Visa, Amex, MasterCard, Discover"></li>
                </ul>
              </fieldset>
              <p class="btnCreateAccount"><a id="createAccount_submit" class="form.validate click">Create
                  Account</a></p>
              <p class="confirm_txt">We will not share this information. You
                will receive e-mail newsletters and account updates only from
                Pongo Resume.</p>
              <p class="confirm_txt">By clicking Create Account, you are indicating
                that you have read and agree to Pongo&##8217;s <a id="termsOfUse" class="window.show link_on  click">Terms
                of Use</a> and <a id="privacyPolicy" class="window.show link_on click">Privacy
                Policy</a>. Please also review our <a id="refundPolicy" class="window.show link_on click">Refund
                Policy</a>.</p>
              <!--- start pop ups for Waiting and Thank You gradient layers --->
              <div id="waitScreen" class="popUpGradient ie6_png">
                <h4>Please Wait</h4>
                <p>Your credit card is being processed</p>
                <img class="iconWait" src="../images/icon_waiting.gif" width="41" height="38"> </div>
              <div id="thanksScreen" class="popUpGradient ie6_png">
                <h4>Thank You</h4>
                <p>You will receive an e-mail confirmation</p>
                <a class="ie6_png btnContinue" href="##">Continue</a> </div>
              <!--- end pop ups for Waiting and Thank You gradient layers --->
            </div>
          </form>
        </div>
        <!--- end content_form --->
      </div>
      <!--- end inner div for padding --->
    </div>
    <cfinclude template="../shared/footer_Signup.cfm">
  </div>
  <!--- end wrapper --->
  </body>
  </html>
</cfoutput>