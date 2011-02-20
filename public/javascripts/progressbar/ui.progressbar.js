/*
 * jQuery UI ProgressBar
 *
 * Depends:
 *	ui.core.js
 */
(function($) {
    $.widget("ui.progressbar", {
	    init: function() {
		    //  wrap the element in the required markup
		    $(this.element)
		        //  build the DIV strucutre
		        .html('<div class="progress-outer"><div class="progress-inner"><div class="progress-indicator"></div></div></div>');
    		
    		//  kick off the animation
    		if(this.options.autostart){
		        this.start();
		    }
	    },
    	
	    start: function() {
	        var o = this.options;
	        
	        //  stop the animation if it is runnin
            this.stop();	    
    	    
	        //  start the animation
            $('.progress-indicator', this.element)
                //  queue up the animation function
                .queue(function(){$.ui.progressbar.animations[o.animation](this, o);})
                //  and let it rip
                .dequeue();
	    },
    	
	    stop: function() {
	        //  stop the animation and set its width
	        //  back to zero
	        $('.progress-indicator', this.element).stop(true).width(0);
	    }
    });

    $.extend($.ui.progressbar, {
	    defaults: {
	        autostart:true,
	        speed:1500,
	        animation:'slide'
	    },
	    animations : {
	        slide: function(e, options) {
                //  set the width to zero
                $(e).width(0);	
                //  animate
                var args = arguments;
                $(e).animate({width: $(e).parent().width()}, options.speed, function(){ args.callee.call(this, e, options); } );
	        },
	        slideback: function(e, options) {
                //  set the width to zero
                $(e).width(0);	
                //  animate
                var args = arguments;
                $(e)
                    .animate({width: $(e).parent().width()}, options.speed)
                    .animate({width: 0}, options.speed, function(){ args.callee.call(this, e, options); } );
	        },
            slidethru: function(e, options) {
                //  set the position and left
                $(e).css({width: 0, position:'absolute', left:'0px'});	                 
                
                //  animate
                var args = arguments;
                $(e)
                    .animate({width: $(e).parent().width()}, options.speed)
                    .animate({left: $(e).parent().width()}, options.speed, function(){ args.callee.call(this, e, options); } );
            },
            fade: function(e, options) {
                //  set the width to zero
                $(e).css({width: 0, opacity: '1.0'});  
                            
                //  animate
                var args = arguments;
                $(e)
                    .animate({width: $(e).parent().width()}, options.speed)
                    .animate({opacity: '0.0'}, options.speed, function(){ args.callee.call(this, e, options); });
            }               	        	            	    
	    }
    });
})(jQuery);
