# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load(()->
    listing_tooltip = 
        listing:()->
            $('.historique,.edit,.delete').tool_tip(1000)
    listing_tooltip.listing()
)

$(document).ready( () ->
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ ADD PHOTO STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    add_photo_stock = 
        card : ''
        init: ()->
            $('.add.button.image').on('click', ()->
               stock_id = $(this).attr('id').replace('stock_id_','')
               add_photo_stock.card = $(this).parents('div').parents('li.card')
               add_photo_stock.generate_form(stock_id)
            )
        
        generate_form : (stock_id)->
            window.light_box_information.html_content('')
            input = $(document.createElement('input'))
            input.attr('name','photo_stock[image]')
            input.attr('id','photo_stock_image')
            input.attr('type','file')
            
            #BUTTON FOOTER
            span = $(document.createElement('span'))
            span.addClass('button')
            
            a = $(document.createElement('a'))
            a.addClass('test')
            a.text('Ajouter')
            
            span.append(a)                        
           
            span_annuler = window.light_box_information.create_annuler()
            
            window.light_box_information.html_footer(span_annuler)
            window.light_box_information.append_footer(span)
            window.light_box_information.title_header('Ajout photo')
            window.light_box_information.append_content(input)
            window.light_box_information.show()
            span.on('click', ()->
                add_photo_stock.upload_form(input,stock_id)
            )
            
        upload_form : (input,stock_id)->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/stocks/'+stock_id+'/add_image')
            
            form = new FormData();
            name = $(input).attr('name')
            form.append('photo_stock[first_image]','0')
            console.log(input)
            fileInput = input[0]
            console.log(input)
            console.log(fileInput)        
            form.append(name,fileInput.files[0])
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    add_photo_stock.create_photo(data['photo_stock'])
                    
                    
        create_photo: (data)->
            console.log(data)
            div = $(document.createElement('div'))
            
            nb_photo = $(add_photo_stock.card).children('.left_area').children('.picture').length
            class_div = ''
            if nb_photo%2 == 0
                class_div = "picture first_cloumn"
            else
                class_div = "picture"
            div.addClass(class_div)
            
            img = $(document.createElement('img'))
            img.attr('src',data['image']['is_small']['url'])
            
            div.append(img)
            
            $(add_photo_stock.card).children('.left_area').children('.picture').last().after(div)
            


        
    add_photo_stock.init()
        
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ FORM ADD STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    form_add_stock =
        init : ()->
            form_add_stock.form_new_stock()
            form_add_stock.event()
            
        actual_step : 1
        
        re_init_form: ()->
            form_add_stock.actual_step = 1
            $('.etape_1').css('display','block')
            $('.etape_3').css('display','none')
            $('.title_1').css('display','block')
            $('.title_3').css('display','none')
        
        upload_form : ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/stocks')
            
            form = new FormData();
            
            $('#new_stock input, #new_stock textarea, #new_stock select').each(()->
                #console.log($(this).attr('name'))
                name = $(this).attr('name')
                if data[name] == undefined && $(this).attr('type') != 'button' && $(this).attr('type') != 'file'
                    data[name] = $(this).val()
                    form.append(name,$(this).val())
                else if $(this).attr('type') == 'file'
                    fileInput = document.querySelector('#'+$(this).attr('id'))
                    form.append(name,fileInput.files[0])
                    
            )
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    form_add_stock.re_init_form()
                    window.lightbox_new_stock.hide()
                    console.log(xhr.responseText)
                    new_card = xhr.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    $('ul.cards').prepend(new_card_2)
                    supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

                    
            console.log(data)
            
        
        event:()->
            $('.buttons>li.add').on('click', ()->
                window.lightbox_new_stock.show()
            )
            
            $('#new_stock').bind "ajax:complete", (et,e) ->
                    form_add_stock.re_init_form()
                    window.lightbox_new_stock.hide()
                    new_card = e.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    $('ul.cards').prepend(new_card_2)
                    supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)
                    



            
            $('.next_step').on('click',()->
                if !form_add_stock['error_step_'+form_add_stock.actual_step]()
                    form_add_stock.next_step()
            )
            
            $('.previous_step').on('click',()->
                form_add_stock.previous_step()
            )
            $('.formulaire_add input,.formulaire_add textarea').on('change', ()->
                form_add_stock.verif_one_input(this)
            )
            
            $('#produit_vente_libre_quantite').on('change', ()->
                if form_add_stock.stock_is_depassed()
                    window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
            )
            $('#produit_vente_libre_nombre_pack').on('change', ()->
                if form_add_stock.stock_is_depassed()
                    window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
            )
        form_new_stock: ()->
            window.lightbox_new_stock = new Lightbox('.lightbox_new_stock','.lightbox_form_new_stock')
            
        stock_is_depassed: ()->
            if $('#produit_vente_libre_quantite').val() == '' || $('#produit_vente_libre_nombre_pack').val() == ''
                return false
            else
                quantite_online = parseInt($('#produit_vente_libre_quantite').val())
                nb_pack_online = parseInt($('#produit_vente_libre_nombre_pack').val())
                quantite_stock = parseInt($('#stock_quantite').val())
                
                
                quantite_restante = quantite_stock - (nb_pack_online * quantite_online)
                if quantite_restante >= 0
                    return false
                else
                    return true
        
        verif_one_input: (element)->
            error = false
            if $(element).val() == ''
                    $(element).parents('.control-group').addClass('error')
                    error = true
                else
                    $(element).parents('.control-group').removeClass('error')
            return error
        error_step_1:()->
            error = false
            $('.etape_1 input, .etape_1 textarea').each(()->
                if form_add_stock.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
        error_step_2:()->
            error = false
            $('.etape_2 input, .etape_2 textarea').each(()->
                 if form_add_stock.verif_one_input(this)
                    error = true         
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
        error_step_3:()->
            error = false
            $('.etape_3 input,  .etape_3 textarea').each(()->
                 if form_add_stock.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            
            if form_add_stock.stock_is_depassed()
                window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
                error = true
            return error
        
        next_step:()->
            if form_add_stock.actual_step == 3
                #$('#new_stock').submit()
                form_add_stock.upload_form()
            else
                $('.etape_'+form_add_stock.actual_step).slideUp(500)
                $('.title_'+form_add_stock.actual_step).css('display','none')
                form_add_stock.actual_step += 1
                $('.etape_'+form_add_stock.actual_step).slideDown(500)
                $('.title_'+form_add_stock.actual_step).css('display','block')
        previous_step: ()->
            $('.etape_'+form_add_stock.actual_step).slideUp(500)
            $('.title_'+form_add_stock.actual_step).css('display','none')
            form_add_stock.actual_step -= 1
            $('.etape_'+form_add_stock.actual_step).slideDown(500)
            $('.title_'+form_add_stock.actual_step).css('display','block')
            
    form_add_stock.init()
    
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ SUPP STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    supp_stock = 
        init:()->
            $('.buttons_card li.delete').on('click',()->
                stock_id = $(this).attr('id').replace('stock_id_','')
                user_id = $('.user_id').val()
                that = this
                supp_stock.have_confirmation(user_id, stock_id, that)
            )
        
        delete: (user_id, stock_id, element)->
            $.ajax({
                type: 'DELETE'
                url:"/administration/users/"+user_id+"/stocks/"+stock_id
                format:'json'
                complete:(data)->
                    card = $(element).parents('li.card')
                    card.animate({
                        opacity:0
                        
                    },{
                        duration:500,
                        complete:()->
                            $(this).slideUp(500,()->
                                $(this).remove()
                            )  
                    })
                    
                    
            })

        
        have_confirmation: (user_id, stock_id, element)->
            window.light_box_information.html_content('<p> Etes vous sur ? </p>')
            window.light_box_information.title_header('Confirmation')
            span_annuler = window.light_box_information.create_annuler()
            window.light_box_information.html_footer(span_annuler)
            span = $(document.createElement('span'))
            span.addClass('button')
            a = $(document.createElement('a'))
            a.text('Oui')
            
            span.append(a)      
            window.light_box_information.append_footer(span)
            window.light_box_information.show()
            
            span.on('click', ()->
                window.light_box_information.hide()
                supp_stock.delete(user_id, stock_id, element)
            )
        
        event_one_element: (button_supp)->
            $(button_supp).on('click',()->
                stock_id = $(this).attr('id').replace('stock_id_','')
                user_id = $('.user_id').val()
                that = this
                that = this
                supp_stock.have_confirmation(user_id, stock_id, that)            )
        
    
    supp_stock.init()
    #__________________________________________
    #__________________________________________
    #__________________________________________
    #__________________________________________
    #_______ GENERAL FUNCTION _______________
    #__________________________________________
    #__________________________________________
    #__________________________________________        
    functions =
        init: ()->
            functions.edit_button()
            functions.help_button()
            functions.event_close()
        
        
        heigth_help_div: '0px' 
        event_close: ()->
            $('.helper>.close').on('click',()->
                functions.close_help('.buttons>li.help')
            )   
        help_button: ()->
            if $('.buttons>li.help').length > 0
                functions.heigth_help_div = $('.helper').css('height')
                $('.buttons>li.help').on('click', ()->
                    if $(this).hasClass('button_active')
                        functions.close_help(this)
                    else
                        functions.show_help(this)
                )
                
        close_help: (help_button)->
            $(help_button).removeClass('button_active')
            $('.helper').animate({
                opacity:0
                
            },{
                duration:500,
                complete:()->
                    $(this).slideUp(500,()->
                        $(this).addClass('helper_close')
                    )  
            })
        
        show_help:(help_button)->
            $(help_button).addClass('button_active')
            $('.helper').removeClass('helper_close')
            $('.helper').slideDown(500,()->
                $(this).animate({
                    opacity:1
                },{
                    duration:500
                })
            )
            
        
        edit_button : () ->
            if $('.buttons>li.edit').length > 0
                $('.buttons>li.edit').on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        functions.remove_editing_class()
                    else
                        $(this).addClass('button_active')
                        functions.add_editing_class()
                )
            
            if $('.buttons_card').length > 0
                $('.buttons_card>.edit').on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        if $('.cards').length > 0
                            functions.remove_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.remove_editing_class($(this).parents('div.card_stack'))    
                    else
                        $(this).addClass('button_active')
                        if $('.cards').length > 0
                            functions.add_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.add_editing_class($(this).parents('div.card_stack'))
                            #console.log($(this).parents('div.card_stack'))
                )
        
        remove_editing_class:(element = 'body')->
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').removeClass('is-editing')
                $('.user_profile>.pictures>div').removeClass('is-editing')
                
            
            if $('.cards').length > 0
               $(element).children('.right_area').children('.header').children('.title').removeClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').removeClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').removeClass('is-editing')
            
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('.title').removeClass('is-editing')
                $(element).children('.packaging').children('.body').children('.description').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul').children('li').removeClass('is-editing')
        
        add_editing_class:(element = 'body')->
            #pour user profile
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').addClass('is-editing')
                $('.user_profile>.pictures>div').addClass('is-editing')
            
            #pour produit
            if $('.cards').length > 0
               console.log($(element).children('.rigth_area'))
               $(element).children('.right_area').children('.header').children('.title').addClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').addClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').addClass('is-editing')
            
            #Pour panier
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('span').children('.title').addClass('is-editing')
                $(element).children('.packaging').children('.body').children('span').children('.description').addClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul').children('li').addClass('is-editing')
    
    functions.init()
    
    
    
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # SHOW INFOS PANIER
    #-----------------------------------
    #-----------------------------------
    #----------------------------------- 
    $('div.card_stack>.packaging h2.title').form_plugin(
        champ: 'titre'
        element: 
            type: 'input'
        button:
            class:'update_titre'
            text_update:'Modifier le titre'
        url_get_infos:['user','panier']
    )

    $('div.card_stack>.packaging p.description').form_plugin(
        champ: 'description'
        element: 
            type: 'input'
        button:
            class:'update_description'
            text_update:'Modifier le description'
        url_get_infos:['user','panier']
    )
    
    $('div.card_stack>.packaging li.detail_max').form_plugin(
        champ: 'nb_pack'
        element: 
            type: 'input'
        button:
            class:'update_description'
            text_update:'Modifier le description'
        url_get_infos:['user','panier']
    )
    
    
    
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # SHOW INFOS USER
    #-----------------------------------
    #-----------------------------------
    #----------------------------------- 


    $('.user_profile .content>.title').form_plugin(
        url_get_infos:['user']
        champ: 'prenom, nom'
        titre:'Modifier le prenom et le nom'
        element: 
            type: 'input'
        button:
            class:'update_prenom'
            text_update:'Modifier'
    )
    
    $.ajax(
        type: 'GET'
        url:"/villes/index"
        format:'json'
        complete:(data)->
            informations = $.parseJSON(data['responseText'])
            id = []
            value = []
            for champ, valeur of informations['ville']
                id.push(valeur['id'])
                value.push(valeur['cp']+' - '+valeur['nom'])
            
            $('.user_profile .content>.city').form_plugin(
                url_get_infos:['user']
                champ: 'ville_id'
                element: 
                    type: 'select'
                    options: 
                        value : id
                        text: value
                button:
                    class:'update_ville'
                    text_update:'Modifier la ville'
            ).bind('end_form_plugin',()->
                    #$('.info_unite_mesure_id').text('('+$(this).text()+')')
            )       
    )
    
    $('.user_profile .content>.description').form_plugin(
        url_get_infos:['user']
        champ: 'description'
        element: 
            type: 'textarea'
        button:
            class:'update_description'
            text_update:'Modifier la description'
    )
    
    $('.user_profile .content>.address').form_plugin(
        url_get_infos:['user']
        champ: 'adresse'
        element: 
            type: 'input'
        button:
            class:'update_adresse'
            text_update:'Modifier l\'adresse'
    )
    
    $('.user_profile .content>.phone').form_plugin(
        url_get_infos:['user']
        champ: 'telephone'
        element: 
            type: 'input'
        button:
            class:'update_telephone'
            text_update:'Modifier le telephone'
    )
    
    $('.user_profile .content>.email').form_plugin(
        url_get_infos:['user']
        champ: 'email'
        element: 
            type: 'input'
        button:
            class:'update_email'
            text_update:'Modifier l\'email'
    )
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # INDEX STOCK PRODUIT VENTE LIBRE 
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------        
    $('.card h2.title').form_plugin(
        #table_get_infos: 'stock'
        champ: 'titre'
        element: 
            type: 'input'
        button:
            class:'update_titre'
            text_update:'Modifier le titre'
        url_get_infos:['user','stock']
        url_to_update: ['user','stock']
    )
    
    $('.card p.description').form_plugin(
        url_get_infos:['user','stock']
        champ: 'description'
        element: 
            type: 'textarea'
        button:
            class:'update_description'
            text_update:'Modifier la description'
    )
    $('.card li.prix').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre'] 
        champ: 'prix_unite_ttc'
        element: 
            type: 'input'
        button:
            class:'update_prix'
            text_update:'Modifier le prix'
    ).bind('end_form_plugin', ()->
        $(this).append(' €')
    )
    
    $.ajax(
        type: 'POST'
        url:"/administration/users/"+$('input.user_id').val()+"/get_unite_mesure"
        format:'json'
        complete:(data)->
            informations = $.parseJSON(data['responseText'])
            id = []
            value = []
            for champ, valeur of informations
                id.push(valeur['id'])
                value.push(valeur['nom'])
            
            $('.card li.unite_mesure').form_plugin(
                url_get_infos:['user','stock']
                champ: 'unite_mesure_id'
                element: 
                    type: 'select'
                    options: 
                        value : id
                        text: value
                button:
                    class:'update_unite_mesure'
                    text_update:'Modifier l\'unite de mesure'
            ).bind('end_form_plugin',()->
                    $('.info_unite_mesure_id').text('('+$(this).children('span.value').text()+')')
            )       
    )
    
    $('.card li.quantite_lot').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre'] 
        champ: 'quantite'
        element: 
            type: 'input'
        button:
            class:'update_quantite'
            text_update:'Modifier la quantite'
        # infos:
#             class:'is_italic'
#             table:'unite_mesure'
#             champ:'nom'
    ).bind('end_form_plugin',()->
            user_id = $('input.user_id').val()
            id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
            url = '/administration/users/'+user_id+'/stocks/'+id_stock
            that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
            this_element = this
            $.ajax(
                type: 'GET'
                url:url
                format:'json'
                success:(data)->
                    that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
                    span = $(document.createElement('span'))
                    span.addClass('is_italic info_unite_mesure_id')
                    span.text(' ('+data['unite_mesure']['nom']+')')
                    $(this_element).append(span)
                    
            )
    )#A FAIRE

    $('.card li.nombre_pack').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre']
        champ: 'nombre_pack'
        element: 
            type: 'input'
        button:
            class:'update_nombre_pack'
            text_update:'Modifier le nombre de lot'
        
    ).bind('end_form_plugin',()->
            user_id = $('input.user_id').val()
            id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
            url = '/administration/users/'+user_id+'/stocks/'+id_stock
            that = this
            $.ajax(
                type: 'GET'
                url:url
                format:'json'
                success:(data)->
                    $(that).children('span.value').append(' /'+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
            )
    )

    $('.card li.stock_total').form_plugin(
        url_get_infos:['user','stock']
        champ: 'quantite'
        element: 
            type: 'input'
        button:
            class:'update_quantite_stock'
            text_update:'Modifier le stock total'
            
    ).bind('end_form_plugin',()->
            user_id = $('input.user_id').val()
            id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
            url = '/administration/users/'+user_id+'/stocks/'+id_stock
            that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
            this_element = this
            $.ajax(
                type: 'GET'
                url:url
                format:'json'
                success:(data)->
                    that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ '( possible )')
                    span = $(document.createElement('span'))
                    span.addClass('is_italic info_unite_mesure_id')
                    span.text(' ('+data['unite_mesure']['nom']+')')
                    $(this_element).append(span)
            )
    )#A FAIRE



    
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
    
    
    
    
    
#     card =
#         event: ()->
#             # $('.card h2.title').bind('click',()->
# #                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('title',data, that )
# #                 )
# #             )
#             
#             # $('.card p.description').bind('click',()->
# #                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('description',data, that)
# #                 )
# #             )
#             
#             # $('.card li.prix').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('prix',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.unite_mesure').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('unite_mesure',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.quantite_lot').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('quantite_lot',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.nombre_pack').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('nombre_pack',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.stock_total').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('stock_total',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             
#             
#         show_form:(intitule,donnees,element) ->
#         	attribut = {}
#         	switch intitule
#                 when 'title'
#                     window.light_box_information.title_header('Titre')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'stock_titre'
#                             value:donnees['stock']['titre']
#                             size:'50'
#                             type_input:'text'
#                             name:'stock[titre]'
#                             class:'string optional'
#                                            
#                         link:
#                             class:'update_titre'
#                             text:'Modifier le titre'
#                     
#                     console.log(donnees)
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 			            
#                 when 'description'
#                     window.light_box_information.title_header('Description')
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                         input:
#                             balise : 'textarea'
#                             id:'stock_description'
#                             value:donnees['stock']['description']
#                             size:'40'
#                             type_input:''
#                             name:'stock[description]'
#                             class:'text optional'
# 			            
#                         link:
#                             class:'update_description'
#                             text:'Modifier la description'
#                             
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
#                 when 'prix'
#                     window.light_box_information.title_header('Prix')                 
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'produit_vente_libre_id'
#                             value:donnees['produit_vente_libre']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'produit_vente_libre[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_prix_unite_ttc'
#                             value:donnees['produit_vente_libre']['prix_unite_ttc']
#                             type_input:'text'
#                             name:'produit_vente_libre[prix_unite_ttc]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_prix_unite_ttc'
#                             text:'Modifier le prix'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
#                 when 'unite_mesure'
#                     window.light_box_information.title_header('Unité de mesure')
#                     $.ajax(
#                         type:'POST',
#                         url:'/administration/users/1/get_unite_mesure'
#                         format:"json"
#                         success: (data)->
#                             options = []
#                             for champ, value of data
#                                 option = $(document.createElement('option'))
#                                 option.attr('value',value['id'])
#                                 option.text(value['nom'])
#                                 if value['nom'] == donnees['unite_mesure']['nom']
#                                     option.attr('selected','selected')
#                                 options.push(option)
#                                 
#                             attribut = 
#                                 hidden_input:
#                                     balise:'input'
#                                     id:'stock_id'
#                                     value:donnees['stock']['id']
#                                     size:'50'
#                                     type_input:'hidden'
#                                     name:'stock[id]'
#                                 input:
#                                     balise : 'select'
#                                     id:'stock_unite_mesure_id'
#                                     value:donnees['unite_mesure']['nom']
#                                     type_input:'text'
#                                     name:'stock[unite_mesure_id]'
#                                     class:'numerical optional'
#                                     options : options
# 			            
#                                 link:
#                                     class:'update_unite_mesure'
#                                     text:'Modifier l\'unite'
#                                 
#                             card.generate_form(attribut)
#                             window.light_box_information.show()
#                             
#                         
#                     )
#                 
#                 when 'quantite_lot'
#                     window.light_box_information.title_header('Quantité lot')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'produit_vente_libre_id'
#                             value:donnees['produit_vente_libre']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'produit_vente_libre[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_quantite'
#                             value:donnees['produit_vente_libre']['quantite']
#                             type_input:'text'
#                             name:'produit_vente_libre[quantite]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_quantite'
#                             text:'Modifier la quantité d\'un lot '
#                         
#                         span_infos:
#                             text:'('+donnees['unite_mesure']['nom']+')'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
#                 
#                 when 'nombre_pack'
#                     window.light_box_information.title_header('Quantité lot en rayon')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_nombre_pack'
#                             value:donnees['produit_vente_libre']['nombre_pack']
#                             type_input:'text'
#                             name:'produit_vente_libre[nombre_pack]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_nombre_pack'
#                             text:'Modifier le nombre de lot'
#                         
#                         span_infos:
#                             text:'sur '+donnees['produit_vente_libre']['lot_possible_max']+' (possible)'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
# 
#                 when 'stock_total'
#                     window.light_box_information.title_header('Quantité du stock')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                         input:
#                             balise : 'input'
#                             id:'stock_quantite'
#                             value:donnees['stock']['quantite']
#                             type_input:'text'
#                             name:'stock[quantite]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_quantite'
#                             text:'Modifier la quantité du stock'
#                         
#                         span_infos:
#                             text:'('+donnees['unite_mesure']['nom']+' '
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()     
#           
#             
#         get_information:(id_stock)->
#             user_id = $('input.user_id').val()
#             $.ajax(
#                 type: 'GET'
#                 url:'/administration/users/'+user_id+'/stocks/'+id_stock
#                 format:'json'
#                 success:(data)->
#                     return data
#             )
#             
#         generate_form: (attribut) ->
#             #HIDDEN INPUT WITH ID
#             hidden_input = $(document.createElement(attribut['hidden_input']['balise']))
#             hidden_input.attr('id',attribut['hidden_input']['id'])
#             hidden_input.attr('name',attribut['hidden_input']['name'])
#             hidden_input.val(attribut['hidden_input']['value'])
#             hidden_input.attr('type',attribut['hidden_input']['type_input'])
#             hidden_input.addClass(attribut['hidden_input']['class'])
#             
#             #INPUT SELECT TEXTARE
#             input = $(document.createElement(attribut['input']['balise']))
#             input.attr('id',attribut['input']['id'])
#             input.attr('name',attribut['input']['name'])
#             input.val(attribut['input']['value'])
#             input.addClass(attribut['input']['class'])
#             
#             if attribut['input']['balise'] == 'input'
#                 input.attr('type',attribut['input']['type_input'])
#                 input.attr('size',attribut['input']['size'])
#             else if attribut['input']['balise'] == 'textarea'
#                 input.attr('cols',attribut['input']['size'])
#             else if attribut['input']['balise'] == 'select'
#                 for champ, valeur of attribut['input']['options']
#                     input.append(valeur)
#             
#             
#             window.light_box_information.html_content(input)
#             window.light_box_information.append_content(hidden_input)
#             #SPAN INFOS
#             if attribut['span_infos']
#                 span_infos = $(document.createElement('span'))
#                 span_infos.text(attribut['span_infos']['text'])
#                 window.light_box_information.append_content(span_infos)
#             
#             
#             #BUTTON FOOTER
#             span = $(document.createElement('span'))
#             span.addClass('button')
#             
#             a = $(document.createElement('a'))
#             a.addClass(attribut['link']['class'])
#             a.text(attribut['link']['text'])
#             
#             span.append(a)                        
#            
#             span_annuler = window.light_box_information.create_annuler()
#             
#             window.light_box_information.html_footer(span_annuler)
#             window.light_box_information.append_footer(span)
#             span.on('click',()->
#                 card.update_information(this)
#             )
#         
#         update_information: (button)->
#             url = '/administration/users/7/stocks/4'
#             user_id = $('input.user_id').val()
#             
#             tab_concerned = $(button).parent('.footer').prev('.content').children('input[type="hidden"]').attr('id').replace('_id','')
#             id_entite = $(button).parent('.footer').prev('.content').children('#'+tab_concerned+'_id').val()
#             champ = $(button).parent('.footer').prev('.content').children().first().attr('id').replace(tab_concerned+'_','')
#             val = $(button).parent('.footer').prev('.content').children().first().val()
#             data = {}
#             data[tab_concerned] = {}
#             data[tab_concerned][champ] = val
#             console.log($(button).parent('.footer').prev('.content').children('input[type="hidden"]'))        
#             $.ajax(
#                 type: 'PUT'
#                 url:'/administration/users/'+user_id+'/'+tab_concerned+'s/'+id_entite
#                 data:data
#                 format:'json'
#                 success:(data)->
#                     return data
#             )        

                    
                

#     card.event()
                
    
)