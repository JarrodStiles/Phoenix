<!---
All material herein (c) Copyright 2011 Pongo, LLC
All Rights Reserved.
Page name: footer.cfm
Purpose: Bottom of page links nad grpahics.
Last Updated: 7/18/2011 by jstiles
--->

<cfoutput>
    <div class="footer">
    	<div class="container_navFooter">
            <ul class="nav_footer">
                <li><a href="/aboutus">About Us</a></li>
                <li><a href="/inTheNews">In The News</a></li>
                <li><a href="/legal">Legal</a></li>
                <li><a href="##">Site Map</a></li>
				<li><a href="/members">Builder</a></li>
            </ul>
            <ul class="copywright clearfix">
                <li>&copy;&nbsp;2004-#dateformat(now(),'yyyy')# Pongo Resume. All rights reserved.</li>
            </ul>
        </div>
      <!--- Begin logos --->
      <ul id="logos">
        <li class="inc500"><img class="ie6_png" src="../images/temp-inc500.png" width="61" height="43" alt="Inc. 5000" /></li>
        <li class="verisign"><img class="ie6_png" src="../images/temp-verisign.png" width="76" height="41" alt="Verisign" />
        </li>
        <li class="mcafee"><a target="_blank"
href="https://www.scanalert.com/RatingVerify?ref=#server_name#"><img width="65" height="37" border="0" hspace="8" src="//images.scanalert.com/meter/www.pongoresume.com/31.gif" alt="HACKER SAFE certified sites prevent over 99.9% of hacker crime." oncontextmenu="alert('Copying Prohibited by Law - HACKER SAFE is a Trademark of ScanAlert'); return false;"></a></li>
      </ul>
      <!--- End logos --->
    </div>
</cfoutput>
<script type="text/javascript"> Cufon.now(); </script> 