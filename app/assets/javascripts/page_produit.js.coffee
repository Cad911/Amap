$(document).ready(()->
    function_filter_produit =
        init:()->
            this.event()
        event:()->
            that = this
            $('.filter_zone>ul>li').each(()->
                $(this).on('click',()->
                    if $(this).hasClass('is_click')
                        $(this).removeClass('is_click')
                    else
                        $(this).addClass('is_click')
                    all_categorie = that.get_categorie_clicked()
                    that.get_categorie(all_categorie)
                )
            )
            that.function_move_button_active()
            
        function_move_button_active : ()->
            that = this
#             mouse_is_down = false
#             
#             toggle_on_off = ''
#             toggles = ''
#             toggle_width = ''
#             offset_toggle = ''
#             width_switch = ''
#             offset_switch = ''
#             max_position = ''
#             min_position = ''
#             middle_position = ''
#             position_x = ''
#             max_position_in_toggle = ''
#             min_position_in_toggle = ''
            $('.switch').on('click',(e)->
                toggle_switch = $(this).parents('.toggle_switch')
                toggle_on_off = $(this).parents('.toggle_switch').children('.toggles').children('.toggle_on_off')
                toggles = $(this).parents('.toggle_switch').children('.toggles')
                
                toggle_width = toggles.innerWidth()
                width_switch = $(this).innerWidth()
                
                max_position_in_toggle = toggle_width - width_switch + 9
                min_position_in_toggle = -2
                
                #MAXPOSITION
                if toggle_switch.hasClass('is_off')
                    $(this).animate(
                        left: max_position_in_toggle+'px'
                    ,{
                        duration: 200
                        queue: false
                    })
                    $(toggle_on_off).animate(
                        left: '-2px'
                    ,{
                        duration: 200
                        queue: false
                    })
                    $('.filter_bg').slideDown(1000)
                    toggle_switch.removeClass('is_off')
                    toggle_switch.addClass('is_on')
                    
                else if toggle_switch.hasClass('is_on')
                     $(this).animate(
                        left: min_position_in_toggle+'px'
                     ,{
                        duration: 200
                        queue: false
                     })
                     $(toggle_on_off).animate(
                        left: '-35px'
                     ,{
                        duration: 200
                        queue: false
                     })
                     $('.filter_bg').slideUp(1000)
                     toggle_switch.removeClass('is_on')
                     toggle_switch.addClass('is_off')
            )

        
        animation_switch:()->
        
        animation_filter_bar:()->
        get_categorie_clicked:()->
            categorie_id = []
            $('.filter_zone>ul>li').each(()->
                if $(this).hasClass('is_click')
                    categorie_id.push($(this).attr('data-id'))
            )

            categorie_id
        get_categorie:(categorie_id)->
            xhr = new XMLHttpRequest()
            xhr.open('POST','/page_produit/index/categorie')
            xhr.setRequestHeader('Accept','application/json')

            form = new FormData()

            for champ, valeur of categorie_id
                form.append('categorie_id[]',valeur)

            xhr.send(form)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log('test')
                    console.log(xhr.responseText)
                    ancienne_list = $('.l_product_list')
                    ancienne_list.before(xhr.responseText)
                    ancienne_list.remove()
                    

    function_filter_produit.init()

)
