/*
	HUMANIZED MESSAGES 1.0
	idea - http://www.humanized.com/weblog/2006/09/11/monolog_boxes_and_transparent_messages
	home - http://humanmsg.googlecode.com
*/

var humanMsg = {
	setup: function(appendTo, msgOpacity) {
		humanMsg.msgID = 'humanMsg';
		
		// appendTo is the element the msg is appended to
		if (appendTo == undefined)
			appendTo = 'body';


		// Opacity of the message
		humanMsg.msgOpacity = .8;

		if (msgOpacity != undefined) 
			humanMsg.msgOpacity = parseFloat(msgOpacity);

		// Inject the message structure
		jQuery(appendTo).append('<div id="'+humanMsg.msgID+'" class="humanMsg"><p></p></div>')
		
	},

	displayMsg: function(msg, success) {
		if (msg == '')
			return;
		
		if (success == undefined)
			 success= true;
		
		if(success)
			success_color = "green";
		else
			success_color = "red";
		
		jQuery('.humanMsg').css("background-color", success_color);

		clearTimeout(humanMsg.t2);

		// Inject message
		jQuery('#'+humanMsg.msgID+' p').html(msg)
		
		// Show message
		jQuery('#'+humanMsg.msgID+'').show().animate({ opacity: humanMsg.msgOpacity}, 200, function() {
								
		})

		// Watch for mouse & keyboard in .5s
		humanMsg.t1 = setTimeout("humanMsg.bindEvents()", 700)
		// Remove message after 5s
		humanMsg.t2 = setTimeout("humanMsg.removeMsg()", 3000)
	},

	bindEvents: function() {
	// Remove message if mouse is moved or key is pressed
		jQuery(window)			
			.click(humanMsg.removeMsg)
			.keypress(humanMsg.removeMsg)
	},

	removeMsg: function() {
		// Unbind mouse & keyboard
		jQuery(window)
			.unbind('mousemove', humanMsg.removeMsg)
			.unbind('click', humanMsg.removeMsg)
			.unbind('keypress', humanMsg.removeMsg)

		jQuery('#'+humanMsg.msgID).animate({ opacity: 0 }, 500, function() { jQuery(this).hide() })
	}
};

jQuery(document).ready(function(){
	humanMsg.setup();
})
