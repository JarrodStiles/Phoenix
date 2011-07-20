$(document).ready(function() {
	if($('#backToListing').length){
		var refer = 'pongo.synthenet.com'; 
		var hasHistory = window.history.length; 
		var isFromReferrer = document.referrer.toLowerCase().search('http://'+refer.toLowerCase()+'/*');
		if ((hasHistory > 0)&&(isFromReferrer >= 0 ))
		{
			$('#backToListing').click(function() {  history.back();	});
		}
		else
		{
			$('#backToListing').remove()
		}
	};
});