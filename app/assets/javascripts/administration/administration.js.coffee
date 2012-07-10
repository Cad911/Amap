# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
#FOR THE MENU
    menu = 
        hover_action: () ->
            $('.subnav').each(()->
                if !$(this).hasClass('subnav_isopen')
                   $(this).css({
                       'margin-top':'-105px',
                       'position':'relative',
                       'opacity':0
                       'z-index':1
                   })
            )
            $('.pannels>li').css({
                'position':'relative',
                'z-index':2
                
            })
            
            $('li.stock').bind('click', ()->
            	if $('.subnav').hasClass('subnav_isopen')
            		$('.subnav').animate({
            	        'marginTop':'-105px',
            	        'opacity':0,
            	    },1000)
            	    $('.subnav').removeClass('subnav_isopen')
            	else
            	    $('.subnav').animate({
            	        'marginTop':'0px',
            	        'opacity':1,
            	    },1000)
            	    $('.subnav').addClass('subnav_isopen')
            )
    menu.hover_action()
    
    listing_tooltip = 
        listing:()->
            $('.historique,.edit,.delete').tool_tip(1000)
    listing_tooltip.listing()
)