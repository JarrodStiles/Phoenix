/* Twitter widget created from http://twitter.com/goodies/widget_profile */
//$(document).ready(function(){
	new TWTR.Widget({
	  version: 2,
	  type: 'profile',
	  rpp: 4,
	  interval: 6000,
	  width: 235,
	  height: 300,
	  theme: {
		shell: {
		  background: 'none',
		  color: '##ffffff'
		},
		tweets: {
		  background: '##ffffff',
		  color: '##626262',
		  links: '##ff9900'
		}
	  },
	  features: {
		scrollbar: false,
		loop: false,
		live: false,
		hashtags: true,
		timestamp: true,
		avatars: false,
		behavior: 'all'
	  }
	}).render().setUser('pongoresume').start();
//});
