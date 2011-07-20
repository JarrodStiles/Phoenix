<cfcomponent output="false">	
	<cffunction name="handleMemberLogin" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />
		
		<cfoutput>
		<cfsavecontent variable="local.content">
		<div class="#arguments.event.getValue('eventName')#_content data close bottom left">
			<div class="#arguments.event.getValue('eventName')#Content">
				<fieldset class="loginWin">
					<legend>Member Login</legend>
					<ul>
						<li>
							<label id="email">e-mail</label>
						</li>
						<li>
							<label id="password">password</label>
						</li>
						<li style="margin-right:9px;"><span><em>
							<input type="text" name="email" id="email" >
							</em></span>
							<!---<div class="errorMsg">field cannot be blank</div>--->
						</li>
						<li><span><em>
							<input type="password" name="password" id="pwd">
							</em></span>
							<!---<div class="errorMsg">field cannot be blank</div>--->
						</li>
						<li><img src="#application.themePath#/images/buttons/btn_login.png" width="58" height="24" alt="log In" style="padding: 5px 0 0 9px;"></li>
					</ul>
				</fieldset>
			</div>
		</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="handleCreateAccount" access="public" returnType="String">
		<cfargument name="event" type="any" required="true" />

		<cfoutput>
		<cfsavecontent variable="local.content">
		<div class="#arguments.event.getValue('eventName')#_content data left top close">
			<div class="createAccountContent">
				<div class="layerTitleText"> <span class="title01 cufonLondon">Got Something to Say?</span><span class="title02">Login or Create a New Account to Comment</span> </div>
				<div id="slidey" class="slideAccountContent">
					<div  class="slidey">
						<div class="slide1">
							<form id="memberLoginForm" method="post" class="ajaxForm">
								<fieldset class="memberLogin left">
									<legend>PONGO MEMBERS</legend>
									<div class="formError"></div>
									<ul class="left">
										<li>
											<label>E-Mail</label>
										</li>
										<li><span><em>
											<input type="text" name="username">
											</em></span></li>
										<li>
											<label>PASSWORD</label>
										</li>
										<li><span><em>
											<input type="password" name="password">
											</em></span></li>
										<li style="padding-top:12px; display:inline-block;">
											<ul class="loginOptions">
												<li class="forgotPassword"><a class="link_on" href="##">forgot password?</a></li>
												<li><img id="memberLoginForm_submit" src="#application.themePath#/images/buttons/btn_login_lg.png" class="form.submit click"></li>
											</ul>
										</li>
									</ul>
								</fieldset>
								<input type="hidden" name="doaction" value="login" />
							</form>
							<dl class="slideLayer">
								<dt>Sign Up Today</dt>
								<dd>Interview tips to build the skills and confidence you need to secure the job</dd>
							</dl>
							<div class="secondaryActionBtn"><img id="slidey_next" src="#application.themePath#/images/buttons/btn_create_account.png" class="panel.next click"></div>
						</div>
						<div class="slide2">
							<fieldset class="signupInfo">
								<legend>CREATE A NEW ACCOUNT</legend>
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
										<label id="password">password</label>
										<span><em>
										<input name="password" type="password">
										</em></span></li>
									<li class="regularRight">
										<label id="confirmPassword">confirm password</label>
										<span><em>
										<input name="confirmPassword" type="password">
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
									<li class="regularLeft" style="padding-top:12px;">
										<ul class="createAcctOptions">
											<li class="forgotPassword" style="display:inline-block;"><a id="slidey_prev" class="panel.prev link_on dblarrowbck click">Back to Log In</a></li>
											<li style="margin-right:-7px; float:right;"><img  src="#application.themePath#/images/buttons/btn_create_account.png" class="click"></li>
										</ul>
									</li>
								</ul>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</div>
		</cfsavecontent>
		</cfoutput>
		<cfreturn local.content />
	</cffunction>
</cfcomponent>