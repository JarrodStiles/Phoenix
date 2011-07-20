/** 
* @projectDescription History JS
* @author	McArdle Inc.
* @version	0.001
* @Have You Seen My Good Pen Productions - copyright 2010
*/

var initialized = false;

$(document).ready(initHistory);

function initHistory()
{
	if( document.location.href.indexOf('panel.cfm') > 0)
	{
		$.address.change(historyAction);
	}
}

function historyAction(obj)
{	
	var loc = obj.value;
	
	loc  = Number(obj.value.substr(1,1));
	if(loc == 0){loc = 1;}
	
	if (!initialized) 
	{
		initialized = true;
		document.location.href = '#/1';
	}
	
	if (loc > currentStep) 
	{
		animatePanel({panel: $('.signupWrapper'),direction: 'left'});
		currentStep = loc;
		
	}
	else if(loc < currentStep)
	{
		animatePanel({panel: $('.signupWrapper'),direction: 'right'});
		currentStep = loc;
	}
	
}