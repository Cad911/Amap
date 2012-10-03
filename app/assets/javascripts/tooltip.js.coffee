#$(document).ready(()->
	jQuery.fn.tool_tip = (timeout = 0) ->
	    test = 'test'
	    this.each( () ->
	        if $(this).attr('tool_tip') != '' && $(this).attr('tool_tip') != undefined
	        
	        else
	            $(this).attr('tool_tip', 'tool_tip')
	        
	        
	        
	        $(this).on('mouseover', () ->
	            #create tooltip
	            # my_tooltip = $(document.createElement('div'))
# 	            my_tooltip.addClass('my_tooltip')
# 	            
# 	            tooltip_body = $(document.createElement('div'))
# 	            tooltip_body.addClass('tooltip_body')
# 	            
# 	            tooltip_fleche = $(document.createElement('div'))
# 	            tooltip_fleche.addClass('tooltip_fleche')
# 	            
# 	            my_tooltip.append(tooltip_body)
# 	            my_tooltip.append(tooltip_fleche)
# 	            
# 	            tooltip_body.text($(this).attr('tool_tip'))
	            
	            if timeout == 0
	                tooltip.generate(this)
	            else
	               tooltip.generate_latence(this,timeout)
	            
	            
	            
	        )
	        
	        $(this).on('mouseout', () ->
	            if tooltip.the_timeout
	                clearTimeout(tooltip.the_timeout)
	            $('.my_tooltip').remove()
	        )
	        
	        
	    
	    )
	    
	    
	    tooltip =
	        the_timeout : false
	        generate_latence: (element,timeout)->
	            tooltip.the_timeout = setTimeout(tooltip.generate,timeout,element)
	        generate : (element)->
	            my_tooltip = $(document.createElement('div'))
	            my_tooltip.addClass('my_tooltip')
	            
	            tooltip_body = $(document.createElement('div'))
	            tooltip_body.addClass('tooltip_body')
	            tooltip_body.text($(element).attr('tool_tip'))
	            
	            tooltip_fleche = $(document.createElement('div'))
	            tooltip_fleche.addClass('tooltip_fleche')
	            
	            my_tooltip.append(tooltip_body)
	            my_tooltip.append(tooltip_fleche)
	            
	            
	            
	            $('body').append(my_tooltip)
	           
	            offset = $(element).offset()
	            offset.top -= 20 #A CAUSE DE LA MARGE SUR L.wrapper
	            console.log($(element)[0].localName)
	            if $(element)[0].localName == "circle"
	            	outer_width_element = parseInt($(element).attr('r')) + 5
	            else
	            	outer_width_element = $(element).outerWidth()
	            position_left = offset.left - parseInt(my_tooltip.outerWidth() / 2) + outer_width_element / 2 #POSITION DE LELEMENT HOVER - TAILLE / 2 DU TOOLTIP + TAILLE / 2 ELEMENT HOVER
	            position_wait_top = offset.top - my_tooltip.outerHeight()  - 10
	            position_top = offset.top - my_tooltip.outerHeight() - 2
	            console.log(outer_width_element)
	            #console.log((($(element).outerHeight() - my_tooltip.outerHeight()) - 30)+' '+offset.top)
	            my_tooltip.css({
	               'left':position_left
	               'top':position_wait_top
	               'opacity':0
	            })
	            
	            my_tooltip.animate({
	                'opacity':1
	                'top':position_top
	            },500)
#)