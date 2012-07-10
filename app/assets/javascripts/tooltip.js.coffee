jQuery.fn.tool_tip = (parametres) ->
    test = 'test'
    this.each( () ->
        if $(this).attr('title') != '' && $(this).attr('title') != undefined
        
        else
            $(this).attr('title', 'titre')
        
        offset = $(this).offset()
        
        $(this).bind('mouseover', () ->
            #create tooltip
            div_tooltip = $(document.createElement('div'))
            div_tooltip.attr('id','tool_tip')
            div_tooltip.css({
                'background':'#78624e'
                'padding':'5px'
                'position':'absolute'
                'display':'block'
                'border': '2px solid white'
                'border-radius':'10px'
                'width':'150px'
                'opacity':0.9
                'text-align':'center'
                'color':'white'
            })
            div_tooltip.text($(this).attr('title'))
            
            position_left = offset.left - (parseInt(div_tooltip.css('width')) / 2)
            position_top = offset.top - 40
            div_tooltip.css({
                'left':position_left
                'top':position_top
            })
            
            
            $('body').append(div_tooltip)
        )
        
        $(this).bind('mouseout', () ->
            $('#tool_tip').remove()
        )
        
        
    
    )