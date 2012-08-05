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
    #SHOW INFOS USER
    $('.user_profile .content>.title').form_plugin(
        url_get_infos:['user']
        champ: 'prenom'
        element: 
            type: 'input'
        button:
            class:'update_prenom'
            text_update:'Modifier le prenom'
        
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
    # INDEX STOCK PRODUIT VENTE LIBRE 
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
    $('.card li.prix>span.value').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre'] 
        champ: 'prix_unite_ttc'
        element: 
            type: 'input'
        button:
            class:'update_prix'
            text_update:'Modifier le prix'
    )
    $('.card li.unite_mesure>span.value').form_plugin(
        url_get_infos:['user','stock']
        champ: 'unite_mesure_id'
        element: 
            type: 'select'
            options: 
                value : [1,2]
                text: ["Kilos","grammes"]
        button:
            class:'update_unite_mesure'
            text_update:'Modifier l\'unite de mesure'
    )
    
    $('.card li.quantite_lot>span.value').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre'] 
        champ: 'quantite'
        element: 
            type: 'input'
        button:
            class:'update_quantite'
            text_update:'Modifier la quantite'
        infos:
            class:'is_italic'
            table:'unite_mesure'
            champ:'nom'
    )

    $('.card li.nombre_pack>span.value').form_plugin(
        url_get_infos:['user','stock']
        url_to_update:['user','produit_vente_libre']
        champ: 'nombre_pack'
        element: 
            type: 'input'
        button:
            class:'update_nombre_pack'
            text_update:'Modifier le nombre de lot'
        
    )

    $('.card li.stock_total>span.value').form_plugin(
        url_get_infos:['user','stock']
        champ: 'quantite'
        element: 
            type: 'input'
        button:
            class:'update_quantite_stock'
            text_update:'Modifier le stock total'
    )



    
    console.log($('.card li.unite_mesure').parent('div').prevAll('div.informations_card').children('input.id_stock').val())
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
    
    
    
    
    
    card =
        event: ()->
            # $('.card h2.title').bind('click',()->
#                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('title',data, that )
#                 )
#             )
            
            # $('.card p.description').bind('click',()->
#                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('description',data, that)
#                 )
#             )
            
            # $('.card li.prix').bind('click',()->
#                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('prix',data,that)
#                 )
#                 
#                 
#             )
            
            # $('.card li.unite_mesure').bind('click',()->
#                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('unite_mesure',data,that)
#                 )
#                 
#                 
#             )
            
            # $('.card li.quantite_lot').bind('click',()->
#                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 console.log(stock_id)
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('quantite_lot',data,that)
#                 )
#                 
#                 
#             )
            
            # $('.card li.nombre_pack').bind('click',()->
#                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 console.log(stock_id)
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('nombre_pack',data,that)
#                 )
#                 
#                 
#             )
            
            # $('.card li.stock_total').bind('click',()->
#                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
#                 console.log(stock_id)
#                 that = this
#                 $.when(card.get_information(stock_id)).done((data)->
#                     card.show_form('stock_total',data,that)
#                 )
#                 
#                 
#             )
            
            
            
        show_form:(intitule,donnees,element) ->
        	attribut = {}
        	switch intitule
                when 'title'
                    window.light_box_information.title_header('Titre')
                    
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'stock_id'
                            value:donnees['stock']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'stock[id]'
                            
                        input:
                            balise : 'input'
                            id:'stock_titre'
                            value:donnees['stock']['titre']
                            size:'50'
                            type_input:'text'
                            name:'stock[titre]'
                            class:'string optional'
                                           
                        link:
                            class:'update_titre'
                            text:'Modifier le titre'
                    
                    console.log(donnees)
                    card.generate_form(attribut)
                    window.light_box_information.show()
			            
                when 'description'
                    window.light_box_information.title_header('Description')
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'stock_id'
                            value:donnees['stock']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'stock[id]'
                        input:
                            balise : 'textarea'
                            id:'stock_description'
                            value:donnees['stock']['description']
                            size:'40'
                            type_input:''
                            name:'stock[description]'
                            class:'text optional'
			            
                        link:
                            class:'update_description'
                            text:'Modifier la description'
                            
                    card.generate_form(attribut)
                    window.light_box_information.show()

                when 'prix'
                    window.light_box_information.title_header('Prix')                 
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'produit_vente_libre_id'
                            value:donnees['produit_vente_libre']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'produit_vente_libre[id]'
                            
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_prix_unite_ttc'
                            value:donnees['produit_vente_libre']['prix_unite_ttc']
                            type_input:'text'
                            name:'produit_vente_libre[prix_unite_ttc]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_prix_unite_ttc'
                            text:'Modifier le prix'
                    
                    card.generate_form(attribut)
                    window.light_box_information.show()

                when 'unite_mesure'
                    window.light_box_information.title_header('Unité de mesure')
                    $.ajax(
                        type:'POST',
                        url:'/administration/users/1/get_unite_mesure'
                        format:"json"
                        success: (data)->
                            options = []
                            for champ, value of data
                                option = $(document.createElement('option'))
                                option.attr('value',value['id'])
                                option.text(value['nom'])
                                if value['nom'] == donnees['unite_mesure']['nom']
                                    option.attr('selected','selected')
                                options.push(option)
                                
                            attribut = 
                                hidden_input:
                                    balise:'input'
                                    id:'stock_id'
                                    value:donnees['stock']['id']
                                    size:'50'
                                    type_input:'hidden'
                                    name:'stock[id]'
                                input:
                                    balise : 'select'
                                    id:'stock_unite_mesure_id'
                                    value:donnees['unite_mesure']['nom']
                                    type_input:'text'
                                    name:'stock[unite_mesure_id]'
                                    class:'numerical optional'
                                    options : options
			            
                                link:
                                    class:'update_unite_mesure'
                                    text:'Modifier l\'unite'
                                
                            card.generate_form(attribut)
                            window.light_box_information.show()
                            
                        
                    )
                
                when 'quantite_lot'
                    window.light_box_information.title_header('Quantité lot')
                    
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'produit_vente_libre_id'
                            value:donnees['produit_vente_libre']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'produit_vente_libre[id]'
                            
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_quantite'
                            value:donnees['produit_vente_libre']['quantite']
                            type_input:'text'
                            name:'produit_vente_libre[quantite]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_quantite'
                            text:'Modifier la quantité d\'un lot '
                        
                        span_infos:
                            text:'('+donnees['unite_mesure']['nom']+')'
                    
                    card.generate_form(attribut)
                    window.light_box_information.show()
                
                when 'nombre_pack'
                    window.light_box_information.title_header('Quantité lot en rayon')
                    
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'stock_id'
                            value:donnees['stock']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'stock[id]'
                            
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_nombre_pack'
                            value:donnees['produit_vente_libre']['nombre_pack']
                            type_input:'text'
                            name:'produit_vente_libre[nombre_pack]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_nombre_pack'
                            text:'Modifier le nombre de lot'
                        
                        span_infos:
                            text:'sur '+donnees['produit_vente_libre']['lot_possible_max']+' (possible)'
                    
                    card.generate_form(attribut)
                    window.light_box_information.show()


                when 'stock_total'
                    window.light_box_information.title_header('Quantité du stock')
                    
                    attribut = 
                        hidden_input:
                            balise:'input'
                            id:'stock_id'
                            value:donnees['stock']['id']
                            size:'50'
                            type_input:'hidden'
                            name:'stock[id]'
                        input:
                            balise : 'input'
                            id:'stock_quantite'
                            value:donnees['stock']['quantite']
                            type_input:'text'
                            name:'stock[quantite]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_quantite'
                            text:'Modifier la quantité du stock'
                        
                        span_infos:
                            text:'('+donnees['unite_mesure']['nom']+' '
                    
                    card.generate_form(attribut)
                    window.light_box_information.show()     
          
            
        get_information:(id_stock)->
            user_id = $('input.user_id').val()
            $.ajax(
                type: 'GET'
                url:'/administration/users/'+user_id+'/stocks/'+id_stock
                format:'json'
                success:(data)->
                    return data
            )
            
        generate_form: (attribut) ->
            #HIDDEN INPUT WITH ID
            hidden_input = $(document.createElement(attribut['hidden_input']['balise']))
            hidden_input.attr('id',attribut['hidden_input']['id'])
            hidden_input.attr('name',attribut['hidden_input']['name'])
            hidden_input.val(attribut['hidden_input']['value'])
            hidden_input.attr('type',attribut['hidden_input']['type_input'])
            hidden_input.addClass(attribut['hidden_input']['class'])
            
            #INPUT SELECT TEXTARE
            input = $(document.createElement(attribut['input']['balise']))
            input.attr('id',attribut['input']['id'])
            input.attr('name',attribut['input']['name'])
            input.val(attribut['input']['value'])
            input.addClass(attribut['input']['class'])
            
            if attribut['input']['balise'] == 'input'
                input.attr('type',attribut['input']['type_input'])
                input.attr('size',attribut['input']['size'])
            else if attribut['input']['balise'] == 'textarea'
                input.attr('cols',attribut['input']['size'])
            else if attribut['input']['balise'] == 'select'
                for champ, valeur of attribut['input']['options']
                    input.append(valeur)
            
            
            window.light_box_information.html_content(input)
            window.light_box_information.append_content(hidden_input)
            #SPAN INFOS
            if attribut['span_infos']
                span_infos = $(document.createElement('span'))
                span_infos.text(attribut['span_infos']['text'])
                window.light_box_information.append_content(span_infos)
            
            
            #BUTTON FOOTER
            span = $(document.createElement('span'))
            span.addClass('button')
            
            a = $(document.createElement('a'))
            a.addClass(attribut['link']['class'])
            a.text(attribut['link']['text'])
            
            span.append(a)                        
           
            span_annuler = window.light_box_information.create_annuler()
            
            window.light_box_information.html_footer(span_annuler)
            window.light_box_information.append_footer(span)
            span.on('click',()->
                card.update_information(this)
            )
        
        update_information: (button)->
            url = '/administration/users/7/stocks/4'
            user_id = $('input.user_id').val()
            
            tab_concerned = $(button).parent('.footer').prev('.content').children('input[type="hidden"]').attr('id').replace('_id','')
            id_entite = $(button).parent('.footer').prev('.content').children('#'+tab_concerned+'_id').val()
            champ = $(button).parent('.footer').prev('.content').children().first().attr('id').replace(tab_concerned+'_','')
            val = $(button).parent('.footer').prev('.content').children().first().val()
            data = {}
            data[tab_concerned] = {}
            data[tab_concerned][champ] = val
            console.log($(button).parent('.footer').prev('.content').children('input[type="hidden"]'))        
            $.ajax(
                type: 'PUT'
                url:'/administration/users/'+user_id+'/'+tab_concerned+'s/'+id_entite
                data:data
                format:'json'
                success:(data)->
                    return data
            )        

                    
                

    card.event()
                
    
)