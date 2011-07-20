<cfoutput>
<cfswitch expression="#form.id#">
	<cfcase value="selectEmployed">
		<div class="#form.id#Content data form close bottom">
			<input type="hidden" name="#form.id#ID" />
		 	<div class="selectTitle">
	        	<h2 class="pongoGreen">Are You Currently Employed</h2>
	        </div>
			<div class="selectData">
			    <ul>
			        <li id="1" class="#form.id#ID">Yes</li>
			        <li id="2" class="#form.id#ID">No</li>
			    </ul>
			</div>
		</div>
	</cfcase>
	
	<cfcase value="selectBestDescribes">
		<div class="#form.id#Content data form close bottom">
			<input type="hidden" name="#form.id#ID" />
		 	<div class="selectTitle">
				<h2 class="pongoGreen">What Best Describes You</h2>
		    </div>
				<div class="selectData">
			   <ul>
			        <li id="1" class="#form.id#ID">Leader</li>
			        <li id="2" class="#form.id#ID">Follower</li>
			        <li id="3" class="#form.id#ID">Ax Murderer</li>
			        <li id="4" class="#form.id#ID">Bounty Hunter</li>
			        <li id="5" class="#form.id#ID">Out for Vengeance</li>
			        <li id="6" class="#form.id#ID">Destructor</li>
			        <li id="7" class="#form.id#ID">Optimus Prime</li>
		            <li id="8" class="#form.id#ID">McArdle Inc.</li>
			    </ul>
			</div>
		</div>
	</cfcase>
	
	<cfcase value="selectLetterType">
		<div class="#form.id#Content data form close bottom">
			<input type="hidden" name="#form.id#ID" />
		 	<div class="selectTitle">
		    	<h2 class="pongoGreen">Choose Type Of Letter</h2>
		    </div>
			<div class="selectData">
			    <ul>
			        <li id="1" class="#form.id#ID">Cover Letter</li>
			        <li id="2" class="#form.id#ID">Resume</li>
		            <li id="3" class="#form.id#ID">Resignation</li>
			        <li id="4" class="#form.id#ID">Manifesto</li>
			    </ul>
			</div>
		</div>
	</cfcase>
	
	
	<cfcase value="selectInterest">
		<div class="#form.id#Content data form close bottom">
			<input type="hidden" name="#form.id#ID" />
		 	<div class="selectTitle">
		    	<h2 class="pongoGreen">Select Area of Interest</h2>
		    </div>
			<div class="selectData">
			    <ul>
			        <li id="1" class="#form.id#ID">Badminton</li>
			        <li id="2" class="#form.id#ID">Bantha Fodder</li>
		            <li id="3" class="#form.id#ID">Crocheting</li>
			        <li id="4" class="#form.id#ID">Puppy Juggling</li>
					<li id="5" class="#form.id#ID">Dwarf Tossing</li>
			    </ul>
			</div>
		</div>
	</cfcase>
</cfswitch>
</cfoutput>
