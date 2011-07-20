<cfsetting showdebugoutput="false">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Pongo Resume</title>
    <link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="../sifr/css/sifr.css" rel="stylesheet" type="text/css" media="screen">
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.include.js"></script>
	<script type="text/javascript" src="../js/includes/address.min.js"></script>
    <script src="../js/global.js" type="text/javascript"></script>
    <script src="../sifr/js/sifr.js" type="text/javascript"></script>
    <script src="../sifr/js/sifr-config.js" type="text/javascript"></script>
</head>

<body>
<cfoutput>
 <div class="wrapper">
 	<div class="utilityNavContainer">
    	<div class="utilityNav">
            <ul>
                <li class="gray">Toll Free Support 866.486.4660</li>
                <li class="orange led click" id="liveHelp">Live Help</li>
                <!--- <li class="orange click" id="loginForm">My Account - Log Out</li> --->
            </ul>
        </div>
    </div>
    <div class="header">
        <div class="companyLogo"><a href="index.cfm"><img src="../images/pongo.png" width="215" height="66" alt="Pongo Resume" title="Pongo Resume"></a></div>
    </div>
    <div class="bodyContent">
	<form>
		<div class="signupForm">
			<div class="signupWrapper">
				<ul class="signupContainer">
					<li class="signupWindow">
						<div class="signupContent" id="one">
                        	<div class="signupBoundary">
                                <div class="slideStep">
                                    <span class="left">step 1 of 3</span>
                                </div>
                                <fieldset class="accountInfo">
                                    <ul class="left">
                                        <li><label id="firstname">first name</label></li>
                                        <li><span><em><input type="text" name="firstname"></em></span></li>
                                        <li><label id="lastname">last name</label></li>
                                        <li><span><em><input type="text" name="lastname"></em></span></li>
                                        <li><label id="email">e-mail</label></li>
                                        <li><span><em><input type="text" name="email" ></em></span></li>
                                        <li><label id="password">password</label></li>
                                        <li><span><em><input type="password" name="password" ></em></span><div class="info_win info hover" id="passwordInfo"></div></li>
                                        <li><label id="confirmPassword">confirm password</label></li>
                                        <li><span><em><input type="password" name="confirmPassword" ></em></span></li>
                                    </ul>
                                    <ul class="right">
                                        <li><label id="employed">are you currently employed</label></li>
                                         <li id="selectEmployed" class="click select_win"><span><em class="select"></em></span><div class="info_win info hover" id="employmentInfo"></div></li>
                                        <li><label id="bestDescribes">what best describes you</label></li>
                                        <li id="selectBestDescribes" class="click select_win"><span><em class="select"></em></span><div class="info_win info hover" id="describesInfo"></div></li>
                                    </ul>
                                    <div class="signupTextArea">
                                        <p>
                                        <strong>TERMS OF USE</strong><br>
                                        You will receive e-mail newsletters and account updates only from Pongo Resume. By clicking continue you are indicating that you have read and agree to Pongo's <a href="##" class="link_on">Terms of Use</a> and Privacy Policy.
                                        </p>
                                        <p>
                                        Get full functionality for only <span class="lightTeal bold" style="font-size:12px;">$9.95</span>/month. Membership includes all services. <a class="link_on click info_win" id="comparisonChart">Learn more</a>.
                                        </p>
                                    </div>
                                </fieldset>
							</div>
                            <div class="slideAdvance right">
                                <div class="buttonAdvance">
                                    <a rel="address:/2" href="##2" ><img src="../images/btn_continue.png" width="92" height="26"></a>
                                </div>
                            </div>
                        </div>
					</li>
                    <li class="signupWindow">
						<div class="signupContent" id="two">
                        	<div class="signupBoundary">
                                <div class="slideStep">
                                    <span class="left">step 2 of 3</span>
                                    <span class="right">if you would like to skip this step, <a rel="address:/3" href="##3" class="link_on">click here</a></span>
                                </div>
                                <fieldset class="letterInfo">
                                    <ul class="left">
                                        <li><label id="lettertype">choose type of letter</label></li>
                                        <li><label id="organization">level of experience (any related)</label></li>
                                        <li><label id="towho">are you applying to a particular<br>&nbsp;company/organization?</label></li>
                                        <li><label id="interest">position of interest (job title)</label></li>
                                    </ul>
                                    <ul class="right">
                                        <li id="selectLetterType" class="click select_win"><span><em class="select"></em></span></li>
                                        <li><span><em><input type="text" name="organization"></em></span></li>
                                        <li><span><em><input type="text" name="towho" ></em></span></li>
                                        <li><span><em><input type="text" name="interest" ></em></span></li>
                                    </ul>
                                </fieldset>
                                <div class="slideThumbWrapper">
                                	<ul class="slideThumbContainer">
                                    	<li class="slideThumbWindow">
                                        	<div>
                                            </div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                            </div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                            </div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                        <li class="slideThumbWindow">
                                        	<div>
                                        	</div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="slideAdvance right">
                            	<div class="slideInstructionText">CHOOSE A LETTER LAYOUT - You'll be able to change this at any time.</div>
                            	<div class="buttonAdvance">	
                            		<a rel="address:/3" href="##3"><img src="../images/btn_continue.png" width="92" height="26"></a>
                                </div>
                            </div>
						</div>
					</li>
					<li class="signupWindow">
						<div class="signupContent" id="two">
                        	<div class="signupBoundary">
                                <div class="slideStep">
                                    <span class="left">step 2 of 3</span>
                                    <span class="right">if you would like to skip this step, <a rel="address:/4" href="##4" class="link_on">click here</a></span>
                                </div>
                                <fieldset class="letterInfo">
                                    <ul class="left">
                                        <li><label id="lettertype">area of interest</label></li>
                                        <li><label id="organization">company organization applying to</label></li>
                                        <li><label id="towho">who are you sending it to?</label></li>
                                        <li><label id="interest">position of interest (job title)</label></li>
                                    </ul>
                                    <ul class="right">
                                        <li id="selectLetterType" class="click select_win"><span><em class="select"></em></span></li>
                                        <li><span><em><input type="text" name="organization"></em></span></li>
                                        <li><span><em><input type="text" name="towho" ></em></span></li>
                                        <li><span><em><input type="text" name="interest" ></em></span></li>
                                    </ul>
                                </fieldset>     
                            </div>
                            <div class="slideAdvance right">
                                <div class="buttonAdvance">
                                    <a rel="address:/4" href="##4"><img src="../images/btn_continue.png" width="92" height="26"></a>
                                </div>
                            </div>     
						</div>
					</li>
					<li class="signupWindow">
						<div class="signupContent" id="three">
                        	<div class="signupBoundary"> 
                                <div class="slideStep">
                                    <span class="left">step 3 of 3</span>
                                </div>
                                <div id="signupFormSubmit" class="click">submit</div>
                            </div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
     </div>
        <div class="footer">
        	<ul>
            	<li><a href="##">About Us</a></li>
                <li><a href="##">In The News</a></li>
                <li><a href="##">Affiliate Program</a></li>
                <li><a href="##">Legal</a></li>
                <li><a href="##">Subscribe To Newsletters and Blog</a></li>
                <li><a href="##">Site Map</a></li>
            </ul>
            <ul class="clearfix">
            	<li>&copy;2004-#dateformat(now(),'yyyy')# Pongo Resume. All rights reserved.</li>
            </ul>
        </div>
    </div>
    <br clear="all">
    </cfoutput>
</body>
</html>