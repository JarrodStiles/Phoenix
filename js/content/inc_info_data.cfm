<cfoutput>
<cfswitch expression="#form.id#">
	<cfcase value="passwordInfo">
		<div class="#form.id#Content data right">
		 	<dl class="infoBlurb">
		        <dt>Password Security</dt>
		        <dd>Ipsum dolor unim consectetuer et mi vendicio</dd>
		    </dl>
		</div>
	</cfcase>
	
	<cfcase value="employmentInfo">
		<div class="#form.id#Content data right">
		 	<dl class="infoBlurb">
		        <dt>Employment Status</dt>
		        <dd>Ipsum dolor unim consectetuer et mi vendicio. Ipsum dolor unim consectetuer et mi vendicio.</dd>
		    </dl>
		</div>
	</cfcase>
	
	<cfcase value="describesInfo">
		<div class="#form.id#Content data right">
		 	<dl class="infoBlurb">
		        <dt>Describe Yourself</dt>
		        <dd>Ipsum dolor unim consectetuer et mi vendicio. Ipsum dolor unim consectetuer et mi vendicio.</dd>
		    </dl>
		</div>
	</cfcase>
    
    <cfcase value="comparisonChart">
    	<div class="#form.id#Content data close">
            <div class="#form.id#Content">
                <img src="http://pongo/pr/includes/themes/pongo/images/comparison_chart.png" width="685" height="327">
            </div>
    </cfcase>
	
	<!--- Header Support Info --->
	<cfcase value="supportInfo">
		<div class="#form.id#Content data close">
			<div class="#form.id#Content">
			 	<dl class="supportBlurb">
			        <dt>Toll Free Support</dt>
			        <dd class="tollFreeNum teal">866-486-4660 test</dd>
					<dd>Available Monday - Friday 9AM - 5PM</dd>
					<dd>Eastern Standard Time</dd>
			    </dl>
			</div>
		</div>
	</cfcase>
	
	<!--- Header Login --->
	<cfcase value="memberLogin">
		<div class="#form.id#Content data close">
			<div class="#form.id#Content">
		    <fieldset class="loginWin">
		    	<legend>Member Login</legend>
                    <ul>
                        <li><label id="email">e-mail</label></li>
						<li><label id="password">password</label></li>
                        <li style="margin-right:9px;"><span><em><input type="text" name="email" id="email"></em></span><div class="errorMsg">field cannot be blank</div></li>
                        <li><span><em><input type="password" name="password" id="pwd"></em></span><div class="errorMsg">field cannot be blank</div></li>
						<li><img src="../images/buttons/btn_login.png" width="58" height="24" alt="log In" style="padding: 5px 0 0 9px;"></li>
                    </ul>
				</fieldset>
			</div>
		</div>
	</cfcase>
	
		<cfcase value="postComment">
		<div class="#form.id#Content data bottom close">
			<div class="#form.id#Content">
		    <fieldset class="loginWin">
		    	<legend>Post Comment</legend>
				<form>
                	<input type="text" height="200" width="200">
				</form>
				</fieldset>
			</div>
		</div>
	</cfcase>
</cfswitch>
</cfoutput>

