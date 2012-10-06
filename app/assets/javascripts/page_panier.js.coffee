# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
    
    show_panier_form =
        init: () ->
        	console
        id_basket: 0
        id_user: 0
        event: () ->
            show_panier_form.id_basket = $('#panier_id').val()
            show_panier_form.id_user = $('#panier_revendeur_id').val()
            $('.add_basket_link').on('click', ()->
                show_panier_form.sabonner($('#panier_id').val(), $('#panier_duree').val())            
            )
            $('.add_basket_link_revendeur').on('click', ()->
                    id_basket = ($(this).attr('id')).replace('basket_','')
                    show_panier_form.sabonner(id_basket, $(this).parent('.call_to_action').children('p>#panier_duree').val())
                            
            )
            $('.li_basket').on('hover', ()->
                    $(this).find('.pursache .call_to_action>p').css('display','block')        
            )
            $('.li_basket').on('mouseleave', ()->
                    $(this).find('.pursache .call_to_action>p').css('display','none')        
            )
            $('#panier_declinaison_id').on('change',()->
                show_panier_form.change_price($(this).val())
            )
        
        change_price: (id_declinaison)->
        	$.ajax(
                type:"GET",
                url:'/administration/users/'+show_panier_form.id_user+'/paniers/'+show_panier_form.id_basket+'/get_declinaison/'+id_declinaison,
                format:"json",
                success : (data) ->
                    #console.log(html_before)
                    html_before = $('.l_content_right').find('.price.is_bold').children('span')
                    console.log(html_before[0])
                    $('.l_content_right').find('.price.is_bold').html(data['declinaison_panier']['prix_panier_ttc']+' € '+html_before[0]['outerHTML'])
            )
        sabonner : (id_,duree_) ->
            data_= {
                panier:{
                    id: id_
                    duree : duree_
                    declinaison_panier_id: $('#panier_declinaison_id').val()
                }
            }
            console.log(data_)
            $.ajax(
                type:"POST",
                data:data_,
                url:'/abonnements/sabonner',
                format:"json",
                success : (data) ->
                    $(location).attr('href','/process_order/resume')
            )

          
    show_panier_form.event()
    
    
    
    
    
    #-------------------------------------------------------
    #-------------------------------------------------------
    #-------------------------------------------------------
    function_filter_basket =
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
                    all_agriculteur = that.get_agriculteur_clicked()
                    order_by = that.get_order_by()
                    that.get_produit_filter(all_categorie,all_agriculteur,order_by)
                )
            )
            that.function_move_button_active()
            
            #ON CLICK TRIER PAR POUR ORDER BY
            $('.filters>ul.dropdown-menu>li').on('click',()->
                $('.filters>ul>li').removeClass('is_click')
                $(this).addClass('is_click')
                $('.filter>span').text($(this).children('a').text())
                all_categorie = that.get_categorie_clicked()
                all_agriculteur = that.get_agriculteur_clicked()
                order_by = that.get_order_by()
                that.get_produit_filter(all_categorie,all_agriculteur,order_by)
                console.log($(this).parents('ul').parents('.filters'))
                $(this).parents('ul').parents('.filters').removeClass('open')
            )
             
        function_move_button_active : ()->
            that = this

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
                    $('.filter_bg').slideDown(1000)
                    toggle_switch.removeClass('is_off')
                    toggle_switch.addClass('is_on')
                    
                    
                else if toggle_switch.hasClass('is_on')
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
                     $('.filter_bg').slideUp(1000)
                     
                     toggle_switch.removeClass('is_on')
                     toggle_switch.addClass('is_off')
                     that.reset_categorie()
                     that.reset_agriculteur()
                     order_by = that.get_order_by()
                     that.get_produit_filter(null,null,order_by)
            )

        
        reset_categorie: ()->
            $('.filter_zone>ul>li').each(()->
                $(this).removeClass('is_click')
            )
            this.get_categorie_clicked([])
        
        reset_agriculteur:()->
            $('.filter_zone>ul.filter_agriculteur>li').each(()->
                $(this).removeClass('is_click')    
            )
            this.get_agriculteur_clicked()
            
        get_categorie_clicked:()->
            categorie_id = []
            $('.filter_zone>ul.filter_categorie>li').each(()->
                if $(this).hasClass('is_click')
                    categorie_id.push($(this).attr('data-id'))
            )

            categorie_id
        
        
        get_agriculteur_clicked:()->
            agriculteur_id = []
            $('.filter_zone>ul.filter_agriculteur>li').each(()->
                if $(this).hasClass('is_click')
                    agriculteur_id.push($(this).attr('data-id'))
            )

            agriculteur_id
        
        get_order_by:()->
            order_by = []
            $('.filters>ul>li').each(()->
                if $(this).hasClass('is_click')
                    order_by = $(this).attr('data-order')
            )

            order_by
            
        
        get_produit_filter:(categorie_id=null,agriculteur_id=null,order_by=null)->
            xhr = new XMLHttpRequest()
            xhr.open('POST','/page_panier/index_by_filter')
            xhr.setRequestHeader('Accept','application/json')

            form = new FormData()
            if categorie_id != null
                if categorie_id.length > 0
                    for champ, valeur of categorie_id
                        form.append('filter[categorie_id][value][]',valeur)
                
            if agriculteur_id != null
                if agriculteur_id.length > 0
                    for champ, valeur of agriculteur_id
                        form.append('filter[revendeur_id][value][]',valeur)
                
            if order_by !=null
                form.append('order_by',order_by)

            xhr.send(form)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log('test')
                    console.log(xhr.responseText)
                    ancienne_list = $('.l_product_list')
                    div_after = $('.basket_list>h1')
                    div_after.after(xhr.responseText)
                    ancienne_list.remove()
                    

    if $('.basket_list').length > 0
        function_filter_basket.init()





)
