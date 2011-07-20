/* Window Class */
$.extend({
		skyWindow: function (win_id){
				
		this.id = win_id;
		this.win_frame = $('#'+ this.id + '_window');		
		this.options = '';
		this.content = '';
		this.inner_width = 0;
		this.inner_height = 0;
						
		this.create = function create()
		{
			//getContent; 
			this.getContent();
			
			//Create Initial Window
			this.win_frame = $('<div id="'+ this.id +'_window" class="' + this.id + '_window uniLayer"></div>');
	
			//Insert Elements
			this.win_frame.append('<div class="tl"></div>');
			this.win_frame.append('<div class="tm x"></div>');
			
			//Add close button ?
			if($(this.options + ':contains("close")'))
			{
				this.win_frame.append('<div class="tr"><div id="' + this.id + '_close" class="window.hide closeWin click"></div></div>');
			}
			else
			{
				this.win_frame.append('<div class="tr"></div>');
			} 											
		   
			this.win_frame.append('<div class="ml y"></div>');
			//  create div and add in classes from content so we have positioning data if that was passed 
			this.win_frame.append('<div class="mm x y ' + this.content.attr('class')+ ' ' + this.id  + '_content"></div>'); 
			this.win_frame.append('<div class="mr y"></div>');
			this.win_frame.append('<div style="float:left"><div class="bl"></div><div class="bm x"></div><div class="br"></div></div>');						
			
			//Append to Global Store + Wrapper
			$('.wrapper').append(this.win_frame); 
			
			//Set Dimensions
			this.win_frame.width(this.content.width() +  42);
			this.win_frame.contents('.x').add('div .x').width(this.content.width());
			this.win_frame.contents('.y').add('div .y').height(this.content.height());
			
			//Set content
			this.win_frame.contents('.' + this.id + '_window' + ' .mm').html(this.content.html());							
			
			//requires Focus?
			/*if (this.content.hasClass('focus')) 
			{
				this.win_frame.attr('class','window.focus ' + win_frame.attr('class'));
				this.win_frame.addClass('hover');
			}*/
			return this;
		}	
		
		this.destroy = function destroy()
		{
			this.win_frame.remove();
			return null;
		}		
		
		this.focus = function focus(evt)
		{
			// this creates error 
			/*var posY = (evt.pageY - parseInt(this.win_frame.css('top')) -  $('.wrapper').offset().top);
			var posX = (evt.pageX - parseInt(this.win_frame.css('left')) -  $('.wrapper').offset().left);
			
			if (posY >= this.win_frame.height() || posY <= 0 || posX >= this.win_frame.width() || posX <= 0) 
			{
				this.win_frame.css('visibility','hidden');	
			}*/
			return this;
		}
		
		this.getContent = function getContent()
		{						
			if(!$(this.content).html())
			{			
				this.content = $('.' + this.id + '_content:last');	
				if($(this.content).html())
				{	
					this.inner_width = this.content.width();
					this.inner_height = this.content.height();					
					this.content.removeClass('data'); // remove data class (if it exists)	
					this.options = this.content.attr('class');	
				}			
			}			
			Cufon.refresh();
			return this;
		}
		
		this.position = function postion(relative_to_obj)
		{ 
			// if we don't have a relative obj just set it to the wrapper 
			if (!relative_to_obj)
			{
				relative_to_obj = $('.wrapper');
			}		
			//make sure we have content: get Content
			this.getContent();
			// make sure our window is the correct size: size to fit content
			this.size();		
			// begin positioning
			var page_x	= $(window).scrollLeft();
			var page_y	= $(window).scrollTop();		
			var page_w	= $(document).width();
			var page_h	= $(document).height();
			
			var view_h	= $(window).height();
			var view_w	= $(window).width();
		
			var fold_y	= page_y + view_h;
			var fold_x	= page_x + view_w;
			
			var target_x	= relative_to_obj.offset().left - $('.wrapper').offset().left;
			var target_y	= relative_to_obj.offset().top - $('.wrapper').offset().top;			
			var target_h = relative_to_obj.height();
			var target_w = relative_to_obj.width();
			
			var win_h = this.win_frame.height();
			var win_w = this.win_frame.width();
			
			var pos_x = target_x;
			var pos_y = target_y;
			
			var content_cl	= this.options.split(' ');
			
			//relative positioning
			for(var i = 0; i < content_cl.length; i++) 
			{					
				switch(content_cl[i])
				{
					case 'abs':
						target_y =  page_y + (view_h/2) - $('.wrapper').offset().top;
						target_x =  page_x + (view_w/2) - $('.wrapper').offset().left;
						
						pos_x = target_x;
						pos_y = target_y;
					break;
					
					case 'top' :
						pos_y = target_y - win_h - target_h;
					break;
					
					case 'left' :
						pos_x = target_x - win_w;
					break;
					
					case 'right':
						pos_x = target_x + target_w;
					break;
					
					case 'bottom':
						pos_y = target_y + target_h;
					break;	
					
					case 'v_center' :
						pos_y = target_y - win_h / 2;
					break;
					
					case 'h_center' :
						pos_x = target_x - win_w / 2;
					break;
				}
			}
			
			if(pos_y < page_y || pos_y < 0)
			{
				pos_y = page_y + 30;
			}
			
			if((pos_y + win_h) > fold_y)
			{
				pos_y = fold_y - win_h - 30;
			}
			
			if(pos_x > fold_x || pos_x + win_w > fold_x)
			{
				pos_x = target_x - win_w;
			}
			
			if(pos_x < 0)
			{
				pos_x = target_x + target_w;
			}
			
			this.win_frame.css('left',pos_x);
			this.win_frame.css('top', pos_y);
			
			return this;
		}
		
		this.size = function size(refreshContent)
		{		
			// size window 
			$('.' + this.id + '_window').width(this.inner_width +  42);
			$('.' + this.id + '_window' + ' .x').width(this.inner_width);
			$('.' + this.id + '_window' + ' .y').height(this.inner_height);
			return this;
		}
		
		this.show = function show()
		{
			
			//this.getContent();//Set content
			this.size();
			
			//show
			$('.uniLayer').css('visibility','hidden'); // hide any other windows 
			this.win_frame.css('visibility','visible'); // set to visible
			return this;
		}
		
		this.hide = function hide()
		{
			this.win_frame.css('visibility','hidden');
			return this;
		}		
	}
});(jQuery);


/* Skynet */
$.extend({

	skynet: function() {	
		var root 		= null;
		var data		= null;
		var evt			= null;
		var err			= {name:[],ele_err:[]};	// error array for forms 
		var animated	= false;
		var muraID		= null;
		var hostname	= window.location.hostname;
		var protocol	= window.location.protocol + '//';
		var base_path 	= protocol + hostname + '/data/';
		var baseURL		= protocol + hostname;
		var path 		= base_path;
		var id			= null;		//
		var win_id		= null;		//
		var page_id		= null;		//
		var obj			= null;		// 
		var dir			= null;		// directive name. Used inside functions to determine action. 
		var func		= null; 	// function name to be called. Also used by results() to determine how to handle the ajax response		
		var connected	= false;
		var timer		= {start:null,end:null,total:null}; 	// timer for ajax calls using the 'wait' class. 
		var MIN_WAIT	= 1500;
		
		
	 	return	{
	 	init:function()	{
			root = this;
			
			//adds Data holder
			$('body').append('<div id="data" class="data"></div>');
			data = $('#data');
			
			muraID = $('input[name=mura_contentID]').val();
			
			//Listeners			
			$('.click').live('click',root.run);
			$('.hover').live('hover',root.run,root.run);
			$('.watch').bind('change',root.run); // error in IE7&8 if we use .live()
			
			$('input[type=text]').live('focusin',root.run);
			$('input[type=text]').live('focusout',root.run);
			
			$('input[type=password]').live('focusin',root.run);
			$('input[type=password]').live('focusout',root.run);
			
			$('textarea').live('focusin',root.run);
			$('textarea').live('focusout',root.run);
			
			$('li.error span').live('click',root.error);
			$('li.error > textarea').live('click',root.error);
			$('li.error label').live('hover',root.error,root.error);
			
			//Back to listings
			if($('#backToListing').length){
			var refer = hostname; 
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
			
			
			//Tab Functions
			var tabs = $('.tabs');
			if(tabs.length > 0)
			{
				tabs.tabs();
			}
			
			// Loads Twitter asyncronously
			if($('.twitterTweet').length != 0)
			{
				$.getScript('http://platform.twitter.com/widgets.js')
			}

			
			// initializes AddThis API
			if($('#addThis').length != 0)
			$.getScript('http://s7.addthis.com/js/250/addthis_widget.js')
			{
				$('#addThis').hover(function(){
					addthis.toolbox('.addthis_toolbox')
				});
			}
			
			// Adjusts helpbtn margin when chat is offline
			if($('li.support').length == 0)
			{
				$('.helpbillboard ul#optionbtns').css({'margin-top':'51px'});
			}
			
			// hides dotted line in page header - JS
			var descLength = $('#blurbDesc').html();
			
			if ($('.searchBox').length == 0) 
			{
	    		$('.txp dl:first').css({'border':'none'});
			}
			if (descLength != null)
			{
	    		$('.txp dl:first').css({'border-top':'1px dotted #CBCBCB'});
			}
			
			// removes padding on last element for listings - JS
 			var l = ['.company','.inTheNews','.blog','.default','.polls'];
			$.each(l,function(k,v){
			if($(v).length != 0 )
				{
					var meg = $('dl:last').closest('dl');
					meg.css({'padding-bottom' : '0'}); 	
				}
			});
			
			//fires reset password function onload
			//if ($('.onload').length != 0) 
			//{
				//root.password('validateReturnLink');
			//}
			
			
			root.shadow();
		},
		
		run:function(e){
			var cl		= null;
			var arg 	= null;
			
			//Set Globals
			id  		= e.currentTarget.id;
		 	obj 		= $(e.currentTarget);
			cl			= obj.attr('class').split(' ');
			win_id = id.split('_')[0];
			arg 		= cl[0].split('.');	
			func		= arg[0];
			dir			= arg[1];
			evt			= e;
			
			if (dir != 'hide') path	= base_path  + win_id + '/'; 
	
			if (func == '')func = obj.attr('tagName').toLowerCase();
		
			//Call function
			root[func](e);
		},
		
		accordion:function(e){
			
			var i = $('.accordion').index(obj);
			var accordionPanel = $($('.accordionInner')[i]);
			
			if(accordionPanel.css('display') == 'block'){dir = 'hide';}
			
			switch(dir)
			{
				case 'show':
					accordionPanel.show();
					$($(".accordionOuter span.accordionExpand")[i]).removeClass('collapse').addClass('expand');
				break;	
				
				case 'hide':
					accordionPanel.hide();
					$($(".accordionOuter span.accordionExpand")[i]).removeClass('expand').addClass('collapse');
				break;
			}
		},
		
		comment:function(e){			
			var win_id = id.split('_')[1];
			page_id = id.split('_')[3];
						
			switch(dir)
			{
				case 'show':
					path = base_path + 'createComment/';
					$.get(path,root.result);
				break;
			}
		},
		
		confirm:function(){
			switch(dir)
			{
				case 'hide':
					$('#confirm_win').hide();
				break;
				
				case 'show':
					var win = $('#confirm_win');
					var page_x	= $(window).scrollLeft();
					var page_y	= $(window).scrollTop();
				
					var view_h	= $(window).height();
					var view_w	= $(window).width();
					
					
					var target_x = page_x + (view_w/2) - $('.wrapper').offset().left;
					var target_y = page_y + (view_h/2) - $('.wrapper').offset().top;;
					
					var pos_y = target_y - win.height()/ 2;
					var pos_x = target_x - win.width()/ 2;
					
					win.css('top',pos_y);
					win.css('left',pos_x);
					
					$('.uniLayer').css('visibility','hidden');
					$('#confirm_win').show();
				break;
				
				case 'next':					
					id = 'confirm_panel';
					dir = 'next';
					
					// if we timed this and it took less than MIN_WAIT hang here for a bit
					if ((timer.total != null)&&(timer.total < MIN_WAIT))
					{						
						wait = MIN_WAIT - timer.total;						
						setTimeout(function(){root.panel();},wait);
					}
					else
					{
						// do it now 
						root.panel();
					}
				break;
				
				case 'prev':
					id = 'confirm_panel';
					dir = 'prev';
					root.panel();
				break;
			}
		},
		
		error:function(e){
			var curr_input = null;
			var err_list = null;
			var err_div = null;
			
			if(dir != 'hide')
			{
				if(e == null)
				{
					dir = 'create';
				}
				else
				{
					dir = 'show';
				}
			}
			
			
			switch(dir)
			{
				case 'create':
					if(err.name.length > 0)
					{
						for(i=0;i < err.name.length; i++)
						{
							curr_input = $(err.ele_err[i].ele).closest('li');
							err_list = err.ele_err[i].err_arr;
							err_div = $('<dl class="validationMsg" style="display:none;"><dt></dt></dl>');
							curr_input.addClass('error');
							
							for(e=0; e < err_list.length;e++)
							{								
								err_div.append('<dd> - ' + err_list[e] + '</dd>');
							}
							
							curr_input.append(err_div);
							
							if(i == 0)
							{
								curr_input.find('.validationMsg').show();
							}							
						}	
					}
				break;
				
				case 'show' :
					$('.validationMsg').hide();
					curr_input =  $(e.currentTarget).closest('li');
					curr_input.find('.validationMsg').show();
				break;
				
				case 'hide':
					$('.validationMsg').hide();
				break;
			}
			
		},
		
		form:function(e){
			var form = obj.closest('form');
			var form_id	= form.attr('id').split('_')[0];
			if(form_id == 'commentForm' || form_id == 'ratingForm')
			{
				page_id = $('input[name=pageID]').val();
			}
					
			switch(dir)
			{
				case 'submit':
					var form_data = form.serializeArray();
					var post_data = {};
					
					if(form.hasClass('ajaxForm'))
					{
						form_data.push({name:'id',value:form_id});
						form_data.push({name:'contentID',value:muraID});
						
						$.each(form_data,function(i,item){post_data[item.name] = item.value;});												
						$.post(path,post_data,root.result);
						
						if(form.hasClass('wait'))
						{
							timer.start = new Date().getTime();//start timing the post request
							dir = 'show';
							root.confirm();
						}
					}
					else if (form.hasClass('passwordReset'))
					 {
						root.password('update');
					 }
					else
					{						
						form.submit();
					}
					
				break;
				
				case 'process':
					switch(form_id)
					{
						case 'blogRequestForm':
							var blogRequestForm_result	= $('#blogRequestFormResult');
							if(blogRequestForm_result.length > 0)
							{
								//Clear the submission form
								$(':input','#blogRequestForm')
								 .not(':button, :submit, :reset, :hidden')
								 .val('')
								 .removeAttr('checked')
								 .removeAttr('selected');

								dir = 'next';
								root.confirm();
							}
						break;
						
						case 'commentForm':		
							var result = $('#commentFormResult');
							if(result.length > 0)
							{
								var content = $('#articleComments' + page_id);
								// replace comments with updated comments 
								content.replaceWith(result.html());
								result.remove();
								Cufon.refresh();
								$('#data').empty();
							}
							
							// hide window
							dir = 'hide';
							root.window(evt);
						break;
						
						case 'memberLoginForm':
							if($('#goodCred').length > 0)
							{
								$('#memberLoginForm').removeClass('ajaxForm');
								dir = 'submit';
								root.form();
							}

						break;
						
						case 'pollForm':
							var poll_result = $('#pollFormResult');

							if(poll_result.length > 0)
							{
								var poll_id = form.attr('id').split('_')[1];
								var poll_content = $('.pollContent_' + poll_id);

								poll_content.html(poll_result.html());
								poll_result.remove();
							}
						break;
						
						case 'ratingForm':
							var rating_result = $('#ratingFormResult');		
							
							if(rating_result.length > 0)
							{
								$('#ratingForm span.label').text('You Rated'); 
								//var newRate_content = $('#ratingStatic_' + page_id + ':eq(1)');
								//alert(newRate_content.length + " B");
								
								$('#ratingStatic_' + page_id + ':eq(0)').replaceWith(rating_result.html());								
							}
						break;
						
						case 'successStoryForm':
							var successStory_result	= $('#sendSuccessStoryResult');
							if(successStory_result.length > 0)
							{
								dir = 'next';
								root.confirm();
							}
						break;
						
						case 'updatePasswordForm':
								dir = 'update';
								root.password();
						break;
						
						default: 
							var result	= $('#'+form_id+'Result');	
							
							if(result.length > 0)
							{
								if(form.hasClass('wait'))
								{
									dir = 'next';
									root.confirm();
								}
							}
						break;
					}
										
				break;
				
				case 'validate':
					var form_inputs = form.find('textarea,input');// create an array containing all form inputs	
					err = {name:[],ele_err:[]}; // object to hold all this form's validation errors
					
					// reset form if there were validation errors
					$('.error').removeClass('error');
					$('.validationMsg').remove();
					
					// for each input field in form perform validation
					for(f=0;f < form_inputs.length;f++)
					{
						var input_obj	= $(form_inputs[f]); // get current input field
						var input_id	= input_obj[0].name; 
						var input_val	= input_obj[0].value;
						var cl			= input_obj.attr('class').split(' '); // get classes on input field
						var err_obj		= {ele:input_obj,err_arr:[]} // create empty error object for this field
						var e_list		= []; // error array for this field						
						
						// checkboxes have a different way to get its value
						if(input_obj[0].type == 'checkbox')
						{
							input_val = input_obj.attr('checked');
						}
						
						// for each class on the input field, do validation if it is a validation class
						for(i=0; i < cl.length;i++)
						{							
							switch(cl[i])
							{								
								case 'r' :
									// required field cannot be blank
									if(input_val == '' || input_val == false)
									{										
										e_list.push('This field is required.');
									}
									if(input_obj[0].type == 'checkbox')
									{
										if (!$('#fauxCheck').hasClass('checked'))
										{
											$('#fauxCheck').addClass('error');
										}
									}

								break;
								
								case 'p' :
									//basic password rules
									if(e_list.length <= 0)
									{
										var minChar = input_val.length;
										if(minChar < 8)
										{
											e_list.push('Password must have at least 8 characters.');
										}
									}
								break;
								
								case 'ph':
									// phone number
									if(e_list.length <= 0)
									{
																			
									}
								break;
								
								case 'cc':
									//credit card
									if(e_list.length <= 0)
									{
									
									}
								break;
								
								case 'e':
									//validate email address
									if(e_list.length <= 0)
									{										
										var email_regex = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$/;
										if (!email_regex.test(input_val))
										{
											e_list.push('Invalid email address.');
										}
										//else
										//{
										//	e_list.push('Email is not found in database');
										//}
									}
								break;
								
								case 'c':
									// compare confirm field to original field
									if(e_list.length <= 0)
									{										
										if ( input_id.search('_confirm') )
										{
											var fieldname_to_match = form.find('input[name='+input_id.split('_')[0]+']')
											if (fieldname_to_match.length)
											{
												if (fieldname_to_match[0].value != input_val)
												{											
													e_list.push('Fields do not match.');
												}
											}
										}
									}
								break;
							}	
						}
						if(e_list.length > 0)
						{
							// add errors for current field into a global error object
							err_obj.err_arr = e_list;
							err.name.push(input_id);
							err.ele_err.push(err_obj);
						}
					}	
										
					if(err.name.length > 0)
					{
						root.error(); // if there is an error, display
					}
					else
					{
						// submit form 
						dir = 'submit';
						root.form(evt);
					}
				break;
			}
			
		},
		
		input:function(e){
			
			var input_id	= e.currentTarget.name;
			var input_val	= e.currentTarget.value;
			
			if(e.type != 'click' && dir != 'validate')
			{
				dir = e.type;
			}

			switch(dir)
			{
				case 'change':
					switch(input_id)
					{
						case 'countryBilling':
							if(input_val == 230)
							{
								$('#stateBilling_block').show();
								$('#provinceBilling_block').hide();
							}
							else
							{
								$('#stateBilling_block').hide();
								$('#provinceBilling_block').show();
							}
						break;
					}
				break;
				
				case 'focusin' :
					
				break;
				
				case 'click' :
					if(input_val == '')
					{
						$('#' + input_id + '_lbl').show();
					}
					
					dir = 'hide';
					root.error();
				break;
				
				case 'focusout' :
					if(input_val == '')
					{
						$('#' + input_id + '_lbl').show();
					}
					
					dir = 'hide';
					root.error();
				break;
			}			
		},
		
		nav:function(e){
			
			var win			= null;
			var win_id = id.split('_')[1];
			var win_hidden	= true;
			
			if(e.type == 'click')
			{
				dir = 'follow';
			}
			else
			{
				var posY = (evt.pageY - obj.offset().top - $('.wrapper').offset().top);
				if(!win_hidden && posY <= obj.height() -10) 
				{
					dir = 'hide';
				}
			}
			
			switch(dir)
			{
				case 'follow':
					document.location = obj.children()[0].href;
				break;
				
				case 'show' :
					root.window(evt);
				break;
				
				case 'hide' :
					root.window(evt);
				break;
			}
		},
		
		label:function(e){
			var label_id = id.split('_')[0];
			var input = $('input[name=' + label_id + ']');
			
			switch(dir)
			{
				case 'hide':
					obj.hide();
					input.focus();
				break;
				
				case 'show':
					$('#' + label_id + '_lbl').show();
				break;
			}
			
		},
		
		/* On a fake checkbox, check the real form checkbox and then clear any error message associated with this input */
		checkState:function(e){
			
			var checked = $('#' + id).hasClass('checked')
			var erchecked = $('#' + id).hasClass('error')
			
			if(checked)
				{
					$('#' + id).removeClass('checked');
					$('input[type=checkbox]').attr('checked', false);	
					dir = 'hide';
					root.error();	
				}
			else
				{
					$('#' + id).addClass('checked');
					$('input[type=checkbox]').attr('checked', true);
					dir = 'hide';
					root.error();
				}
				
			if(erchecked)
				{
					$('#' + id).removeClass('error').addClass('checked');
					$('input[type=checkbox]').attr('checked', true);
					dir = 'hide';
					root.error();	
				}
		},
		
		option:function(e){
			
			var txt = obj.text();
			var val = id.split('_')[1];
			var option_id = id.split('_')[0];
			var option_field = $('input[name=' + option_id + ']');
			
			switch(dir)
			{
				case 'save':
					//set Text + set value
					$('#' + option_id).html(txt);
					
					//close window
					dir = 'hide';
					root.window(evt);
					
					//need to set value here
					option_field.val(val);
					option_field.change();
				break;
			}
		},
		
		pageflip:function(e){			
			if(e.type == 'mouseout'){				
				dir = 'hide';
			}
			
			switch(dir)
			{
				case 'show':
					$("#pageflip img , .msg_block").stop().animate({width: '277px',height: '278px'}, 500);
				break;
				
				case 'hide':
					$("#pageflip img").stop().animate({width: '50px',height: '52px'}, 220);
					$(".msg_block").stop().animate({width: '50px',height: '50px'}, 200);
				break;
			}
		},
		
		panel:function(e){
			
			var panel_id	=  id.split('_')[0];
			var panel		= $('#' + panel_id);
			var pos			= panel.scrollLeft();
			var dist 		= $(panel.children().children()[0]).width();
			
			
			switch(dir)
			{
				case 'next':
					panel.animate({scrollLeft: dist}, 800);
				break;
				
				case 'prev':
					panel.animate({scrollLeft: 0}, 800);
				break;
			}
		},
		
		poll:function(e){
			var poll_id = id.split('_')[1];
			path = base_path + 'contentID/' + poll_id + '/pollLayer/'
			
			switch(dir)
			{
				case 'show':
					$.get(path,root.result);
				break;
			}
		},
		
		rating:function(e){
			var rating_val = id.split('_')[1];
			if(evt.type != 'click'){dir='hover';};
			switch(dir)
			{
				case 'save' : 
					$('.star.selected').removeClass('selected');
					obj.prevAll().addClass('starOn').removeClass('starOff');
					obj.nextAll().addClass('starOff').removeClass('starOn');
					obj.addClass('starOn').removeClass('starOff');
					obj.addClass('selected');
					$('.star').removeClass('hover');
					$('.star').removeClass('click');
					
					$('input[name=rating]').val(rating_val);
					$('input[name=pageID]').val(id.split('_')[2]);
					dir = 'submit';
					func = 'form';
					root.form(evt);
				break;
				
				case 'hover':
					obj.prevAll().addClass('starOn').removeClass('starOff');
					obj.nextAll().addClass('starOff').removeClass('starOn');
					obj.addClass('starOn').removeClass('starOff');
					
					if(evt.type == 'mouseout')
					{
						obj.prevAll().addClass('starOff').removeClass('starOn');
						obj.nextAll().addClass('starOff').removeClass('starOn');
						obj.addClass('starOff').removeClass('starOn');
					}
				break;
				
			}
		},
		
		reply:function(e){
			
			var i = $('.replies').index(obj);
			var replies = $('.commentReplies:eq(' + i + ')');
			
			
			switch(dir)
			{
				case 'show':
					if(replies.css('display') == 'none')
					{
						$($("ul.commentListing dl dd.replies span.view")[i]).removeClass('collapse').addClass('expand');
						replies.show();
					}
					else
					{
						dir = 'hide';
						root.reply();
					}
				break;
				
				case 'hide':
					$($("ul.commentListing dl dd.replies span.view")[i]).removeClass('expand').addClass('collapse');
					replies.hide();
				break;
			}
		},
		
		result:function(d){
			//save returned data
			data.html(d);
			
			// if we timed this response get the total time
			if (timer.start != null)
			{
				timer.end = new Date().getTime();
				timer.total = timer.end - timer.start;
			}

			// what function do we return to?
			switch(func)
			{
				case 'comment':
					$('input[name=parentID]').val(id.split('_')[2]);
					$('input[name=pageID]').val(id.split('_')[3]);
					
					root.window(evt);
				break;
				
				case 'form':
					dir = 'process';
					root.form(evt);
				break;
				
				case 'poll':							
					root.window(evt);
				break;
				
				case 'video_popup' :					
					root.window(evt);
				break;
				
				case 'window' :					
					root.window(evt);
				break;
			}
		},
		
		shadow:function(){
			var arr = $('img.shadow');
			
			for (i = 0; i < arr.length; i++) 
			{
				var obj = arr[i];
				var parent = $(obj).parent();
				var b = $('<div class="box"></div>');
				var b_outer = $('<div class="boxOuter"></div>');
				var b_inner = $('<div class="boxInner"></div>');
				var b_img = $('<div class="boxImage"></div>');
				
				b_img.append(obj);
				b_inner.append(b_img);
				b_outer.append(b_inner);
				b.append(b_outer);
				
				parent.append(b);
			}
		},
		
		textarea:function(e){
			//text area validation stuff
			var input_id	= e.currentTarget.name;
			var input_val	= e.currentTarget.value;
			
			if(e.type != 'click' && dir != 'validate')
			{
				dir = e.type;
			}
			
			switch(dir)
			{
				case 'change':
				
				break;
				
				case 'focusin' :
					
				break;
				
				case 'focusout' :
					
				break;
			}			
			
		},
		
		video_pause:function(e){     
			var movie = $('#videoplayer')[0];            
             movie.pause();
		},
		
		video_popup:function(e){
			var video_id = id.split('_')[1];
			var video_type = id.split('_')[2];
			path = base_path + 'contentID/' + video_id + '/videoType/' + video_type + '/videoPopup/'			
			/*switch(dir)
			{
				case 'show':*/
					$.get(path,root.result);
			/*	break;
			}*/
		},
		
		video_panel:function(e){
			
			var panel_id	=  id.split('_')[0];
			var panel		= $('#' + panel_id);
			var cur_pos 	= panel.scrollLeft();
			var items 		= panel.children().children().length;
			var dist 		= $(panel.children().children()[0]).width();
			var stop_pos 	= (items * dist) - dist;
			var i 	= cur_pos / dist;
			
			switch(dir)
			{
				case 'next':
					if(!animated)
					{
						if (cur_pos != stop_pos) 
						{
							animated = true;
							panel.animate({scrollLeft: cur_pos + dist},400,function(){	
							animated = false;
							$('ul.carouselCount li').removeClass('counterLED_on');
							$('ul.carouselCount li:eq(' + (i + 1) + ')').addClass('counterLED_on');});
							panel.prev().show();
						}
						
						if(cur_pos == stop_pos - dist)
						{
							obj.hide();
						}
					}
					
				break;
				
				case 'prev':
					if (!animated) 
					{
						if (cur_pos > 0) 
						{	
							animated = true;
							panel.animate({scrollLeft: cur_pos - dist},400,function(){	
							animated = false;
							$('ul.carouselCount li').removeClass('counterLED_on');
							$('ul.carouselCount li:eq(' + (i - 1) + ')').addClass('counterLED_on');});
							panel.next().show();
						}
						
						if(cur_pos == dist)
						{
							obj.hide();
						}
					}
				break;
			}
		},
		
		password:function(evt){	
		
			if(evt.type != 'click')
				{
					dir = evt;
				}
					path = base_path  + id + '/'
					switch(dir)
						{
							case 'forgot':
							$.get(path,function(result) 
								{
									$('.welcomeUser').html('<div class="cufonParis">Reset Password</div>');
									$('.ajaxReplace').html(result);
									Cufon.refresh();
								});
							break;
					
							case 'reset':
							$.get(path,function(result) {
								if(result != '')							
									{
										$('.welcomeUser').html('<div class="cufonParis">Reset Password</div>');
										$('.interactionContainer').html(result);
										Cufon.refresh();
									}
								else
									{
										//temporary message
										alert('This e-mail address does not exist.');
									}
								});
							break;
							
							case 'update':
							path = base_path  + '/updatePassword/'
								$.get(path,function(result) {
								if(result != '')							
								{
									$('.welcomeUser').html('<div class="cufonParis">Reset Password</div>');
									$('.interactionContainer').html(result);
									Cufon.refresh();
								}
								else
								{
									//temporary message
									alert('This e-mail address does not exist.');
								}
								});
							break;
							
							case 'validateReturnLink':
							path = base_path  + 'resetEmailPassword/'
								$.get(path,function(result) {
								if(result != '') 
								{
									alert('validate URL');	
								}
								});
							break;
						}
			},
		
		window:function(e){
			var win_id = id.split('_')[0];	
			var win = new $.skyWindow(win_id);								
			// remove any other windows 
			$('.uniLayer').remove(); 						
			switch(dir)// show or hide?
			{
				case 'show':
					;
					//if there is no data to populate window try to get it now
					if(!$('.' + win.id + '_content:last').html())
					{
						$.get(path,root.result);										
					}	
					else
					{			
						// create and show the window 
						win.create().position(obj).show(); //.focus(evt);	
					}
				break;	
				
				case 'hide':
					win.destroy();
				break;				
			}			
		}
		
	  //End Return Block
	  }
	}
 });(jQuery);
 
 $(document).ready(function(){$.skynet();$.skynet().init();});