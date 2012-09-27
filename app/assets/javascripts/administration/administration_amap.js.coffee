$(document).ready(()->
    listing_tooltip = 
        listing:()->
            $('.historique,.add,.help,.stats,.edit,.delete').tool_tip(1000)
        listing_one_tooltip:(element)->
               element.tool_tip(1000)
    listing_tooltip.listing()
    
    
    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    #------------------- Fonction pour produit autorise -------------------------------------------
    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    form_plugin_produit_autorise = 
        init:()->
            $('.card h2.title').form_plugin(
                #table_get_infos: 'stock'
                champ: 'titre'
                titre:'Le titre'        
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','produit_autorise']
                url_to_update: ['user','produit_autorise']
            )
            
            $('.card p.description').form_plugin(
                url_get_infos:['user','produit_autorise']
                champ: 'description'
                titre:'La description'
                element: 
                    type: 'textarea'
                button:
                    class:'update_description'
                    text_update:'Modifier la description'
            )
            
            $.ajax(
                type: 'POST'
                url:"/administration/users/"+$('input.user_id').val()+"/get_all_categorie"
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    id = []
                    value = []
                    for champ, valeur of informations
                        id.push(valeur['id'])
                        value.push(valeur['nom'])
                    
                    $('.card li.categorie').form_plugin(
                        url_get_infos:['user','produit_autorise']
                        champ: 'categorie_id'
                        titre:'Catégorie'
                        element: 
                            type: 'select'
                            options: 
                                value : id
                                text: value
                        button:
                            class:'update_categorie'
                            text_update:'Modifier la catégorie'
                    )      
            )
        init_one_card:(card)->
            $(card).find('h2.title').form_plugin(
                #table_get_infos: 'stock'
                champ: 'titre'
                titre:'Le titre'        
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','produit_autorise']
                url_to_update: ['user','produit_autorise']
            )
            
            $(card).find('p.description').form_plugin(
                url_get_infos:['user','produit_autorise']
                champ: 'description'
                titre:'La description'
                element: 
                    type: 'textarea'
                button:
                    class:'update_description'
                    text_update:'Modifier la description'
            )
            
            $.ajax(
                type: 'POST'
                url:"/administration/users/"+$('input.user_id').val()+"/get_all_categorie"
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    id = []
                    value = []
                    for champ, valeur of informations
                        id.push(valeur['id'])
                        value.push(valeur['nom'])
                    
                    $(card).find('li.categorie').form_plugin(
                        url_get_infos:['user','produit_autorise']
                        champ: 'categorie_id'
                        titre:'Catégorie'
                        element: 
                            type: 'select'
                            options: 
                                value : id
                                text: value
                        button:
                            class:'update_categorie'
                            text_update:'Modifier la catégorie'
                    )      
            )
        
        
    form_plugin_produit_autorise.init()
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ SUPP PRODUIT AUTORISES _________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    supp_produit_autorise = 
        init:()->
            $('.buttons_card li.delete').on('click',()->
                produit_autorise_id = $(this).attr('id').replace('produit_autorise_id_','')
                user_id = $('.user_id').val()
                that = this
                supp_produit_autorise.have_confirmation(user_id, produit_autorise_id, that)
            )
        
        delete: (user_id, produit_autorise_id, element)->
            $.ajax({
                type: 'DELETE'
                url:"/administration/users/"+user_id+"/produit_autorises/"+produit_autorise_id
                format:'json'
                complete:(data)->
                    card = $(element).parents('li.card')
                    card.removeClass('in')
                    card.css('top','0px')
                    #card.addClass('out')
                    card.animate(
                        opacity:0
                        top:'-270px'
                    ,{
                        duration:500
                        complete:()->
                            $(this).remove()
                    })
                    # setTimeout(()-> 
#                         card.remove()
#                     , 300)
                    # card.animate({
#                         
#                     },{
#                         duration:300,
#                         complete:()->
#                             #$(this).slideUp(500,()->
#                                 $(this).remove()
#                             #)  
#                     })
                    
                    
            })

        
        have_confirmation: (user_id, produit_autorise_id, element)->
            window.light_box_declinaison.html_content('<p> Etes vous sur ? </p>')
            window.light_box_declinaison.title_header('Confirmation')
            span_annuler = window.light_box_declinaison.create_annuler()
            window.light_box_declinaison.html_footer(span_annuler)
            span = $(document.createElement('span'))
            span.addClass('button')
            a = $(document.createElement('a'))
            a.text('Oui')
            
            span.append(a)      
            window.light_box_declinaison.append_footer(span)
            window.light_box_declinaison.show()
            
            span.on('click', ()->
                window.light_box_declinaison.hide()
                supp_produit_autorise.delete(user_id, produit_autorise_id, element)
            )
        
        event_one_element: (button_supp)->
            $(button_supp).on('click',()->
                produit_autorise_id = $(this).attr('id').replace('produit_autorise_id_','')
                user_id = $('.user_id').val()
                that = this
                that = this
                supp_produit_autorise.have_confirmation(user_id, produit_autorise_id, that)            )
        
    
    supp_produit_autorise.init()
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ FORM PRODUIT AUTORISE  ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    form_add_produit_autorise =
        previous_id: ""
        exist_deja: false
        actual_step: 1
        init: ()-> 
            
            window.lightbox_new_produit_autorise = new window.Lightbox('.new_produit_autorise')
            #window.lightbox_new_produit_autorise.remove_footer()
            form_add_produit_autorise.form_new_produit_panier()
            
        
        
            
        form_new_produit_panier:()->
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/produit_autorises/new')
            xhr.setRequestHeader('Accept','application/json')
            xhr.send(null)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    #console.log(xhr.responseText)
                    footer_next_step = $(xhr.responseText).find('.next_step')
                    window.lightbox_new_produit_autorise.html_footer(footer_next_step)
                    form = $(xhr.responseText)
                    console.log(form.children('.modal-footer.form-actions').remove())
                    window.lightbox_new_produit_autorise.append_content(form)
                    window.lightbox_new_produit_autorise.css_lightbox({'top':'20%'})
                    form_add_produit_autorise.event()
                
        
        upload_form: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/produit_autorises')
            xhr.setRequestHeader('Accept','application/json')
            form = new FormData();
            
            $('#new_produit_autorise input, #new_produit_autorise textarea, #new_produit_autorise select').each(()->
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
                    #form_add_stock.re_init_form()
                    window.lightbox_new_produit_autorise.hide()
                    console.log(xhr.responseText)
                    new_card = xhr.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    $('ul.cards').prepend(new_card_2)
                    #---- event sur les bouton ---
                    supp_produit_autorise.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    #add_photo_stock.init_one_element(new_card_2.find('.add.button.image'))
                    functions.one_edit_button(new_card_2.find('.buttons_card>.edit'))
                    form_plugin_produit_autorise.init_one_card(new_card_2)
                    
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

            
            console.log(data)        
        event: ()->
            $('.buttons>li.add').on('click', ()->
                window.lightbox_new_produit_autorise.show()
            )

            $('#new_produit_autorise').bind "ajax:complete", (et,e) ->
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


            $('.formulaire_add input,.formulaire_add textarea').on('change', ()->
                form_add_produit_autorise.verif_one_input(this)
            )
            
            $('.next_step').on('click',()->
                if !form_add_produit_autorise['error_step_'+form_add_produit_autorise.actual_step]()
                    form_add_produit_autorise.upload_form()
            )


            
        

                 
 
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
                if form_add_produit_autorise.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
        

    if $('ul.cards').length > 0       
        form_add_produit_autorise.init()




    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    #------------------- Fonction pour panier autorise -------------------------------------------
    #---------------------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------------------
    
    
    
     #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ FORM ADD PANIER ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    form_add_panier_autorise = 
        actual_step: 1
        init: ()->  
            form_add_panier_autorise.form_new_basket()
            form_add_panier_autorise.event()

        re_init_form: ()->
            form_add_panier_autorise.actual_step = 1
            $('.etape_1').css('display','block')

        

        upload_form: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/panier_autorises')
            
            form = new FormData();
            
            $('#new_panier_autorise input, #new_panier_autorise textarea, #new_panier_autorise select').each(()->
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
                    form_add_panier_autorise.re_init_form()
                    window.lightbox_new_panier_autorise.hide()
                    console.log(xhr.responseText)
                    new_card = xhr.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    functions.one_edit_button(new_card_2.find('.buttons_card>.edit'))
                    listing_tooltip.listing_one_tooltip(new_card_2.find('.buttons_card>.edit'))
                    listing_tooltip.listing_one_tooltip(new_card_2.find('.buttons_card>.delete'))
                    change_infos_panier_autorise.init_one_card(new_card_2)
                    #function_product_in_basket.init_one_card(new_card_2)
                    $($('.card_stack')[0]).before(new_card_2)
                    form_add_panier_autorise.anim_for_decli_and_product($($('.card_stack')[0]))
                    #event sur les bouton
                    #supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    #add_photo_stock.init_one_element(new_card_2.find('.add.button.image'))
                    #functions.one_edit_button(new_card_2.find('.buttons_card>.edit'))
                    #form_plugin_element.init_one_card(new_card_2)
                    
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

            
                    

        anim_for_decli_and_product:(card_stack)->
            edit_button = card_stack.children('.packaging').children('.header').children('.buttons_card').children('li.edit.button')
            number_product_li = $('')
            declinaison_div = $('')
            console.log(declinaison_div)
            edit_button.trigger('mouseover')
            setTimeout( ()->
                edit_button.trigger('mouseout')
                edit_button.trigger('click')
                setTimeout( ()->
                    number_product_li = card_stack.children('.packaging').children('.footer').children('.main-informations').children('li.product_number')
                    declinaison_div = card_stack.children('.packaging').children('.footer').children('.details')
                    number_product_li.tool_tip(200)
                    declinaison_div.tool_tip(200)
                    number_product_li.trigger('mouseover')
                    declinaison_div.trigger('mouseover')
                    number_product_li.toggleClass('is-editing-over')
                    declinaison_div.toggleClass('is-editing-over')
                    console.log(declinaison_div)
                    
                    setTimeout(()->
                        number_product_li.removeClass('is-editing-over')
                        declinaison_div.removeClass('is-editing-over')
                        number_product_li.trigger('mouseout')
                        declinaison_div.trigger('mouseout')
                    ,3000)
                    
                , 2000)
            , 2000)
            
            
             
            
           #  setTimeout( ()->
#                 number_product_li.trigger('mouseout')
#                 declinaison_div.trigger('mouseout')
#             , 7000) 
            
        event:()->
            $('li.add.button').on('click',()->
                window.lightbox_new_panier_autorise.show()
            )
            
            $('.next_step').on('click',()->
                if !form_add_panier_autorise['error_step_'+form_add_panier_autorise.actual_step]()
                    form_add_panier_autorise.next_step()
            )

            $('.previous_step').on('click',()->
                form_add_panier_autorise.previous_step()
            )
            

        
        form_new_basket: ()->
             window.lightbox_new_panier_autorise = new window.Lightbox('.new_panier_autorise')
        
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
                if form_add_panier_autorise.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error

        next_step:()->
            if form_add_panier_autorise.actual_step == 1
                #$('#new_stock').submit()
                form_add_panier_autorise.upload_form()
            else
                $('.etape_'+form_add_panier_autorise.actual_step).slideUp(500)
                $('.title_'+form_add_panier_autorise.actual_step).css('display','none')
                form_add_basket.actual_step += 1
                $('.etape_'+form_add_panier_autorise.actual_step).slideDown(500)
                $('.title_'+form_add_panier_autorise.actual_step).css('display','block')
                #POUR MENU GAUCHE
                next_current = $('.navigation>li>.current').parents('li').next().children('span')
                $('.navigation>li>.current').removeClass('current')
                console.log(next_current)
                next_current.addClass('current')
        previous_step: ()->
            $('.etape_'+form_add_panier_autorise.actual_step).slideUp(500)
            $('.title_'+form_add_panier_autorise.actual_step).css('display','none')
            form_add_basket.actual_step -= 1
            $('.etape_'+form_add_panier_autorise.actual_step).slideDown(500)
            $('.title_'+form_add_panier_autorise.actual_step).css('display','block')
            #POUR MENU GAUCHE
            previous_current = $('.navigation>li>.current').parents('li').prev().children('span')
            $('.navigation>li>.current').removeClass('current')
            console.log(previous_current)
            previous_current.addClass('current')

    
    if $('.card_stack').length > 0
            form_add_panier_autorise.init()


    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # SHOW INFOS PANIER Autorises
    #-----------------------------------
    #-----------------------------------
    #----------------------------------- 
    form_plugin_panier_autorise = 
        init:()->
            $('div.card_stack>.packaging h2.title').form_plugin(
                champ: 'titre'
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','panier_autorise']
            )
        
            $('div.card_stack>.packaging p.description').form_plugin(
                champ: 'description'
                element: 
                    type: 'input'
                button:
                    class:'update_description'
                    text_update:'Modifier le description'
                url_get_infos:['user','panier_autorise']
            )
            
            $.ajax(
                type: 'POST'
                url:"/administration/users/"+$('input.user_id').val()+"/get_all_categorie"
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    id = []
                    value = []
                    for champ, valeur of informations
                        id.push(valeur['id'])
                        value.push(valeur['nom'])
                    
                    $('div.card_stack>.packaging ul.main-informations>li').form_plugin(
                        url_get_infos:['user','panier_autorise']
                        champ: 'categorie_id'
                        titre:'Catégorie'
                        element: 
                            type: 'select'
                            options: 
                                value : id
                                text: value
                        button:
                            class:'update_categorie'
                            text_update:'Modifier la catégorie'
                    )
            )    
    
    init_one_card:(card_stack)->
        $(card_stack).children('.packaging').find('h2.title').form_plugin(
                champ: 'titre'
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','panier_autorise']
            )
        
            $(card_stack).children('.packaging').find('p.description').form_plugin(
                champ: 'description'
                element: 
                    type: 'input'
                button:
                    class:'update_description'
                    text_update:'Modifier le description'
                url_get_infos:['user','panier_autorise']
            )
    form_plugin_panier_autorise.init()
    
    
    
    
    #--------------------------------------------
    #--------------------------------------------
    #-------------------------------------------
    #FUNCTIONS POUR AJOUTER DES DECLINAISON
    #------------------------------------------
    #------------------------------------------
    
    change_infos_panier_autorise = 
        panier_id: 0
        actual_ul_details: $('')
        div_list:$('')
        div_form: $('')
        div_sous_content:$('')
        nombre_declinaison_actuel: 0
        init:()->
            $('div.card_stack>.packaging ul.details').on( 'click', ()->
                if ($(this).hasClass('is-editing'))
                     change_infos_panier_autorise.actual_ul_details = this
                     #generate box
                     change_infos_panier_autorise.generate_box()
                     change_infos_panier_autorise.add_select()
                     #change_infos_panier.div_form.css('display','none')
                     change_infos_panier_autorise.panier_id = $(this).parents('div.footer').prevAll('div.informations_card').children('.id_panier_autorise').val()
                     change_infos_panier_autorise.get_panier()

            )
        
        init_one_card: (card_stack)->
            $(card_stack).children('.packaging').find('ul.details').on( 'click', ()->
                if ($(this).hasClass('is-editing'))
                     change_infos_panier_autorise.actual_ul_details = this
                     #generate box
                     change_infos_panier_autorise.generate_box()
                     change_infos_panier_autorise.add_select()
                     #change_infos_panier.div_form.css('display','none')
                     change_infos_panier_autorise.panier_id = $(this).parents('div.footer').prevAll('div.informations_card').children('.id_panier').val()
                     change_infos_panier_autorise.get_panier()

            )

        
        get_panier: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/panier_autorises/'+change_infos_panier_autorise.panier_id)
            xhr.setRequestHeader('Accept','application/json')
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    
                    data = JSON.parse(xhr.responseText)
                    console.log(data)
                    nombre_declinaison = data['declinaison_panier_autorise'].length
                    for champ, valeur of data['declinaison_panier_autorise']
                        change_infos_panier_autorise.div_list.append(change_infos_panier_autorise.create_fiche_declinaison(valeur))
                        #nombre_declinaison += valeur['nb_pack']
                        #window.light_box_information.append_content(change_infos_panier.create_fiche_declinaison(valeur))
                    change_infos_panier_autorise.nombre_declinaison_actuel = nombre_declinaison
                    $('.header-list>p   ').text(nombre_declinaison+' paniers en ligne')

            
        li_detail:(data)->
            li_max = $(document.createElement('li'))
            li_max.addClass('detail')
            
            span_label = $(document.createElement('span'))
            span_label.addClass('label')
            span_label.text(data['label'])
            
            if (data['value']['element'] == 'span')
                 element_number = $(document.createElement('span'))
                 element_number.addClass('number')
                 element_number.text(data['value']['value'])
                 
            if (data['value']['element'] == 'ul')
                element_number = $(document.createElement('ul'))
                element_number.addClass('number')
                for champ, valeur of data['value']['value']
                    li_number = $(document.createElement('li'))
                    if valeur == data['value']['check']
                        li_number.addClass('check')
                    li_number.text(valeur)
                    element_number.append(li_number)
            
            li_max.append(span_label)
            li_max.append(element_number)
            li_max.css('width','128px')
            
            return li_max
                    
        create_fiche_declinaison: (declinaison_panier)->
        
            div_raw = $(document.createElement('div'))
            div_raw.addClass('raw')
            
            ul_details = $(document.createElement('ul'))
            ul_details.addClass('details')
            
#             li_max = change_infos_panier_autorise.li_detail({
#                 label:'Max'
#                 value:
#                     element:'span'
#                     value:declinaison_panier['nb_pack']  
#             })
            
            li_format = change_infos_panier_autorise.li_detail({
                label:'Format'
                value:
                    element:'ul'
                    value:[2,4,6]
                    check:parseInt(declinaison_panier['nombre_personne'])
            })
            
            li_duree = change_infos_panier_autorise.li_detail({
                label:'Duree'
                value:
                    element:'ul'
                    value:[3,6,9]
                    check:parseInt(declinaison_panier['duree'])
            })
            
            li_prix = change_infos_panier_autorise.li_detail({
                label:'Prix'
                value:
                    element:'span'
                    value:declinaison_panier['prix_panier_ht']
            })
            
            #ul_details.append(li_max)
            ul_details.append(li_format)
            ul_details.append(li_duree)
            ul_details.append(li_prix)
            
            div_close = $(document.createElement('div'))
            div_close.addClass('close_square declinaison_panier_'+declinaison_panier['id'])
            
            div_close.on('click',()->
                change_infos_panier_autorise.supp_declinaison(declinaison_panier,div_raw)
            )
            
            div_clear = $(document.createElement('div'))
            div_clear.addClass('clear')

            div_raw.append(ul_details)
            div_raw.append(div_close)
            div_raw.append(div_clear)
            return div_raw
        
        #GENERE LES ATTRIBUTS HTML DE LA BOX A SON INITIALISATION                         
        generate_box: ()->
            window.light_box_declinaison = new window.Lightbox('.lightbox_declinaison')
            window.light_box_declinaison.html_content('')
            change_infos_panier_autorise.div_sous_content = $(document.createElement('div'))
            change_infos_panier_autorise.div_sous_content.addClass('sous_content')
            
            change_infos_panier_autorise.div_sous_content.append(change_infos_panier_autorise.header_list())
            
            change_infos_panier_autorise.div_list = $(document.createElement('div'))
            change_infos_panier_autorise.div_list.addClass('embosed-list basket-details')
            
            change_infos_panier_autorise.div_sous_content.append(change_infos_panier_autorise.div_list)
            window.light_box_declinaison.append_content(change_infos_panier_autorise.div_sous_content)
            
            window.light_box_declinaison.title_header('titre')
            span_annuler = window.light_box_declinaison.create_annuler()
            window.light_box_declinaison.html_footer(span_annuler)
            #change_infos_panier.add_select()
            window.light_box_declinaison.show()
        
        header_list:()->
#             <div class="header-list">
#                 <p>17 déclinaisons</p>
#                 <span class="button new-declinaision"><a href="">nouvelle</a></span>
#                 <div class="clear"></div>
#             </div>
        
        
            div_header = $(document.createElement('div'))
            div_header.addClass('header-list')
            
            nombre_decli = $(document.createElement('p'))
            nombre_decli.text('18 déclinaisons')
            
            span_new = $(document.createElement('span'))
            span_new.addClass('button new-declinaision button_declinaion')
            
            a  = $(document.createElement('a'))
            a.text('nouvelle déclinaison')
            span_new.append(a)
            a.on('click', ()->
                   change_infos_panier_autorise.animate_for_form(1000)
            )
            
            span_retour = $(document.createElement('span'))
            span_retour.addClass('back-declinaison button_declinaion')
            span_retour.text('retour')
            
            span_retour.on('click', ()->
                   change_infos_panier_autorise.animate_for_tab(1000)
            )
            
            div_clear = $(document.createElement('div'))
            div_clear.addClass('clear')
            
            div_header.append(nombre_decli)
            div_header.append(span_new)
            div_header.append(span_retour)
            div_header.append(div_clear)
            
            return div_header
        
        # button_add_select: ()->
#             span = $(document.createElement('span'))
#             a = $(document.createElement('a'))
#             a.text('Ajoutez declinaison')
#             span.addClass('button')
#             
#             a.on('click',()->
#                 change_infos_panier.div_form.slideDown(1000)
#             )
#             
#             span.append(a)
#             
#             return span 
#       
        animate_for_tab: (time)->
            change_infos_panier_autorise.div_sous_content.animate(
                'margin-left': '0px'
            ,time)

        animate_for_form: (time)->
            change_infos_panier_autorise.div_sous_content.animate(
                'margin-left': '-600px'
            ,time)
        
        #GENERATION DU FORMULAIRE HTML POUR AJOUTER DES DECLNAISON
        add_select:()->
            div_form = $(document.createElement('div'))
            div_form.addClass('form_add_decli')
            div_form.css('float','right')
            div_form.css('display','block')
            #div_card.addClass('card_stack')
            
            #max
            # p_max = $(document.createElement('p'))
#             label_max = $(document.createElement('label'))
#             label_max.text('Nombre mis en ligne : ')
#             input_max = $(document.createElement('input'))
#             input_max.attr('name','declinaison_panier_autorise[nb_pack]')
#             p_max.append(label_max)
#             p_max.append(input_max)
            
            #format
            p_format = $(document.createElement('p'))
            label_format = $(document.createElement('label'))
            label_format.text('Nombre de personne : ')
            select_format = $(document.createElement('select'))
            select_format.attr('name','declinaison_panier_autorise[nombre_personne]')
            options_format = [2,4,6]
            i = 0
            while(options_format.length > i)
                option = $(document.createElement('option'))
                option.val(options_format[i])
                option.text(options_format[i])
                select_format.append(option)
                i++
            p_format.append(label_format)
            p_format.append(select_format)
            
            #duree
            p_duree = $(document.createElement('p'))
            label_duree = $(document.createElement('label'))
            label_duree.text('Duree (mois) : ')    
            select_duree = $(document.createElement('select'))
            select_duree.attr('name','declinaison_panier[duree]')
            options_duree = [3,6,9]
            i = 0
            while(options_duree.length > i)
                option = $(document.createElement('option'))
                option.val(options_duree[i])
                option.text(options_duree[i])
                select_duree.append(option)
                i++
            
            p_duree.append(label_duree)
            p_duree.append(select_duree)
            
            #prix_unite_ttc et ht
            p_ht = $(document.createElement('p'))
            label_ht = $(document.createElement('label'))
            label_ht.text('Prix unite ht: ')
            input_ht = $(document.createElement('input'))
            input_ht.attr('name','declinaison_panier[prix_panier_ht]')
            p_ht.append(label_ht)
            p_ht.append(input_ht)
            
            p_ttc = $(document.createElement('p'))
            label_ttc = $(document.createElement('label'))
            label_ttc.text('Prix unite ttc: ')
            input_ttc = $(document.createElement('input'))
            input_ttc.attr('name','declinaison_panier[prix_panier_ttc]')
            p_ttc.append(label_ttc)
            p_ttc.append(input_ttc)
            
            
            #clear div
            clear_div = $(document.createElement('div'))
            clear_div.addClass('clear')
            
            #button add
            span_add = $(document.createElement('span'))
            a = $(document.createElement('a'))
            a.text('Ajoutez')
            span_add.addClass('button')
            
            a.on('click',()->
                data = 
    #                 nb_pack: input_max.val()
                    nombre_personne: select_format.val()
                    duree: select_duree.val()
                    prix_panier_ht: input_ht.val()
                    prix_panier_ttc: input_ttc.val()
                change_infos_panier_autorise.add_declinaison(data)
            )
            
            #all in div_form
            span_add.append(a)
            div_form.append(p_format)
            div_form.append(p_duree)
#             div_form.append(p_max)
            div_form.append(p_ht)
            div_form.append(p_ttc)
            div_form.append(span_add)
            
            
            change_infos_panier_autorise.div_form = div_form
            change_infos_panier_autorise.div_sous_content.prepend(div_form)
            #div_form.after(clear_div)
            #window.light_box_information.append_content(div_form)
            
            
        #AJOUT DE DECLINAISON - AJAX
        add_declinaison: (data_)->
            #data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/panier_autorises/create_declinaison')
            xhr.setRequestHeader('Accept','application/json')
            
            form = new FormData();
            form.append('panier[id]', change_infos_panier_autorise.panier_id)
            form.append('declinaison_panier_autorise[nombre_personne]', data_.nombre_personne)
            form.append('declinaison_panier_autorise[duree]', data_.duree)
            form.append('declinaison_panier_autorise[prix_panier_ht]', data_.prix_panier_ht)
            form.append('declinaison_panier_autorise[prix_panier_ttc]', data_.prix_panier_ttc)
            
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    #window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                    else
                       #change_infos_panier.div_form.slideUp(1000)
                       #change_infos_panier.nombre_declinaison_actuel += data_.nb_pack
                       $('.header-list>p   ').text(change_infos_panier_autorise.nombre_declinaison_actuel+' declinaisons')
                       change_infos_panier_autorise.animate_for_tab(1000)
                       change_infos_panier_autorise.div_list.append(change_infos_panier_autorise.create_fiche_declinaison(data['declinaison_panier_autorise']))
                       change_infos_panier_autorise.modify_card()
                    #add_photo_stock.create_photo(data['photo_stock'])
        
        
        have_confirmation: (declinaison,div_raw)->
            light_box_confirmation = new window.Lightbox('.lightbox_confirmation')
            light_box_confirmation.html_content('<p> Etes vous sur ? </p>')
            light_box_confirmation.title_header('Confirmation')
            span_annuler = light_box_confirmation.create_annuler()
            light_box_confirmation.html_footer(span_annuler)
            span = $(document.createElement('span'))
            span.addClass('button')
            a = $(document.createElement('a'))
            a.text('Oui')
            
            span.append(a)      
            light_box_confirmation.append_footer(span)
            light_box_confirmation.show()
            
            span.on('click', ()->
                light_box_confirmation.hide()
                change_infos_panier_autorise.supp_declinaison(declinaison,div_raw)
            )
            
        #SUPPRESSION DECLINAISON
        supp_declinaison:(declinaison,div_raw)->
            console.log(declinaison)
            xhr = new XMLHttpRequest();
            xhr.open('DELETE','/administration/users/'+$('.user_id').val()+'/panier_autorises/supp_declinaison/'+declinaison.id)
            xhr.setRequestHeader('Accept','application/json')
            
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                    else
                       #change_infos_panier.div_form.slideUp(1000)
                       change_infos_panier_autorise.nombre_declinaison_actuel -= declinaison.nb_pack
                       $('.header-list>p   ').text(change_infos_panier_autorise.nombre_declinaison_actuel+' declinaisons')
                       div_raw.animate({
                            left:'500px'
                       },{
                        duration:500
                        complete:()->
                            $(this).remove()
                            change_infos_panier_autorise.modify_card()
                       })
            
            
        
        modify_card: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/panier_autorises/'+change_infos_panier_autorise.panier_id)
            xhr.setRequestHeader('Accept','application/json')
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    
                    data = JSON.parse(xhr.responseText)
                    console.log(data)
                    #$(change_infos_panier_autorise.actual_ul_details).children('.detail_max').children('.number').text(data['panier']['nb_pack_total'])
                    $(change_infos_panier_autorise.actual_ul_details).children('.detail_format').children('.number').children('li').removeClass('check')
                    $(change_infos_panier_autorise.actual_ul_details).children('.detail_duree').children('.number').children('li').removeClass('check')
                    for champ, valeur of data['declinaison_panier_autorise']
                        $(change_infos_panier_autorise.actual_ul_details).children('.detail_format').children('.number').children('li').each(()->
                            if parseInt(valeur['nombre_personne']) == parseInt($(this).text())
                                $(this).addClass('check')
                        )
                        $(change_infos_panier_autorise.actual_ul_details).children('.detail_duree').children('.number').children('li').each(()->
                            if parseInt(valeur['duree']) == parseInt($(this).text())
                                $(this).addClass('check')
                        )
            
    change_infos_panier_autorise.init()

    
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
            #functions.stats_button()
        
        
        heigth_help_div: '0px' 
        event_close: ()->
            $('.helper>.close').on('click',()->
                functions.close_help('.buttons>li.help')
            ) 
        
        stats_button: ()->
            if $('.buttons>li.stats').length > 0
                $('.buttons>li.stats').on('click', ()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        window.statisitques.hide()
                        window.statisitques.clear_stats()
                                                
                    else
                        $(this).addClass('button_active')
                        window.statisitques.show()
                        window.statisitques.init()
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
            
        one_edit_button: (button)->
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
                $(button).on('click',()->
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
            #element = li.card
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').removeClass('is-editing')
                $('.user_profile>.pictures>div').removeClass('is-editing')
                
            
            if $('.cards').length > 0
               $(element).children('.right_area').children('.header').children('.title').removeClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').removeClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').removeClass('is-editing')
               $(element).children('.left_area').children('.has_corners_shadow').removeClass('is-editing')
               $(element).children('.left_area').children('.picture').removeClass('is-editing')
            
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('.title').removeClass('is-editing')
                $(element).children('.packaging').children('.body').children('.description').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.details').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.main-informations').children('li').removeClass('is-editing')
        
        add_editing_class:(element = 'body')->
            #pour user profile
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').addClass('is-editing')
                $('.user_profile>.pictures>ul>li>div.is_small').addClass('is-editing')
            
            #pour produit
            if $('.cards').length > 0
               console.log($(element).children('.rigth_area'))
               $(element).children('.right_area').children('.header').children('.title').addClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').addClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').addClass('is-editing')
               $(element).children('.left_area').children('.has_corners_shadow').addClass('is-editing')
               $(element).children('.left_area').children('.picture').addClass('is-editing')
            
            #Pour panier
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('span').children('.title').addClass('is-editing')
                $(element).children('.packaging').children('.body').children('span').children('.description').addClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.details').addClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.main-informations').children('li').addClass('is-editing')
    
    functions.init()


)