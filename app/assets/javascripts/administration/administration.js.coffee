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
    
    
    
    card =
        event: ()->
            $('.card h2.title').bind('click',()->
                stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('title',data, that )
                )
            )
            
            $('.card p.description').bind('click',()->
                stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('description',data, that)
                )
            )
            
            $('.card li.prix').bind('click',()->
                stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('prix',data,that)
                )
                
                
            )
            
            $('.card li.unite_mesure').bind('click',()->
                stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('unite_mesure',data,that)
                )
                
                
            )
            
            $('.card li.quantite_lot').bind('click',()->
                stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                console.log(stock_id)
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('quantite_lot',data,that)
                )
                
                
            )
            
            $('.card li.nombre_pack').bind('click',()->
                stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                console.log(stock_id)
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('nombre_pack',data,that)
                )
                
                
            )
            
            $('.card li.stock_total').bind('click',()->
                stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
                console.log(stock_id)
                that = this
                $.when(card.get_information(stock_id)).done((data)->
                    card.show_form('stock_total',data,that)
                )
                
                
            )
            
            
            
        show_form:(intitule,donnees,element) ->
        	attribut = {}
        	switch intitule
                when 'title'
                    window.light_box_information.title_header('Titre')
                    
                    attribut = 
                        input:
                            balise : 'input'
                            id:'stock_titre'
                            size:'50'
                            type_input:'text'
                            name:'stock[titre]'
                            class:'string optional'
                                           
                        link:
                            class:'update_titre'
                            text:'Modifier le titre'
                    
                    console.log(donnees)
                    card.generate_form(donnees['stock']['titre'],attribut)
                    window.light_box_information.show()
			            
                when 'description'
                    window.light_box_information.title_header('Description')
                    attribut = 
                        input:
                            balise : 'textarea'
                            id:'stock_description'
                            size:'40'
                            type_input:''
                            name:'stock[description]'
                            class:'text optional'
			            
                        link:
                            class:'update_description'
                            text:'Modifier la description'
                            
                    card.generate_form(donnees['stock']['description'],attribut)
                    window.light_box_information.show()

                when 'prix'
                    window.light_box_information.title_header('Prix')                 
                    attribut = 
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_prix_unite_ttc'
                            type_input:'text'
                            name:'produit_vente_libre[prix_unite_ttc]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_prix_unite_ttc'
                            text:'Modifier le prix'
                    
                    card.generate_form(donnees['produit_vente_libre']['prix_unite_ttc'],attribut)
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
                                input:
                                    balise : 'select'
                                    id:'stock_unite_mesure'
                                    type_input:'text'
                                    name:'stock[unite_mesure]'
                                    class:'numerical optional'
                                    options : options
			            
                                link:
                                    class:'update_unite_mesure'
                                    text:'Modifier l\'unite'
                                
                            card.generate_form(donnees['unite_mesure']['nom'],attribut)
                            window.light_box_information.show()
                            
                        
                    )
                
                when 'quantite_lot'
                    window.light_box_information.title_header('Quantité lot')
                    
                    attribut = 
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_quantite'
                            type_input:'text'
                            name:'produit_vente_libre[quantite]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_quantite'
                            text:'Modifier la quantité d\'un lot '
                        
                        span_infos:
                            text:'('+donnees['unite_mesure']['nom']+')'
                    
                    card.generate_form(donnees['produit_vente_libre']['quantite'],attribut)
                    window.light_box_information.show()
                
                when 'nombre_pack'
                    window.light_box_information.title_header('Quantité lot en rayon')
                    
                    attribut = 
                        input:
                            balise : 'input'
                            id:'produit_vente_libre_nombre_pack'
                            type_input:'text'
                            name:'produit_vente_libre[nombre_pack]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_nombre_pack'
                            text:'Modifier le nombre de lot'
                        
                        span_infos:
                            text:'sur '+donnees['produit_vente_libre']['lot_possible_max']+' (possible)'
                    
                    card.generate_form(donnees['produit_vente_libre']['nombre_pack'],attribut)
                    window.light_box_information.show()


                when 'stock_total'
                    window.light_box_information.title_header('Quantité du stock')
                    
                    attribut = 
                        input:
                            balise : 'input'
                            id:'stock_quantite'
                            type_input:'text'
                            name:'stock[quantite]'
                            class:'numerical optional'
			            
                        link:
                            class:'update_quantite'
                            text:'Modifier la quantité du stock'
                        
                        span_infos:
                            text:'('+donnees['unite_mesure']['nom']+' '
                    
                    card.generate_form(donnees['stock']['quantite'],attribut)
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
        generate_form: (value,attribut) ->
            #INPUT SELECT TEXTARE
            input = $(document.createElement(attribut['input']['balise']))
            input.attr('id',attribut['input']['id'])
            input.attr('name',attribut['input']['name'])
            input.val(value)
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

                    
                

    card.event()
                
    
)