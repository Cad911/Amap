# Informations :
# 	1 - nom de la table
# 	2 - nom du champ
# 	3 - type de balise
#       si select, alors on a les options avec 
# 	4 - class
# 	5 - text lien
# THE PROBLEME :
# On a l'id du stock et celui des produit en vente libre et il faut s'arrange pour avoir les 2.
#ET AUSSI le probleme de l'url quand on est avec l'utilisateur. Idée : créer un niveau d'url
# A FAIRE 4/08
# quand la modif est effectué, modifier le texte dans le champ (en live) -- OK --
# mieux placer la box -- OK --
# A FAIRE 15/08
# Reorganiser le code (faire une relecture)
#Pour le prix (par exemple), lors de la mise à jour la devise ne s'affiche plus -- OK --
#Probleme pour le nom et prenom, comment faire ? -- OK --
#Probleme, une mise a jour fonctionne mais 2 mis a jour sans recharger la page provoque un bug -- OK -- (Initialisation input_create pas effectué)





#_____________________________ README ______________________________________
#PLUGIN PERMETTANT DE MODIFIER DES ENTITES JUSTE EN CLIQUANT SUR L'INFO
# POUR CECI IL FAUT DONC INITIALISER CHAQUE ELEMENT DU DOM POUVANT ETRE MODIFIER PAR LE PLUGIN EN AJOUTANT DES ATTRIBUTS OBLIGATOIRES:
#  - url_get_infos => qui est un tableau et qui contiendra les entites dans lequel se trouve la derniere entité .
#     - EX : url : /administration/users/7/produit_vente_libres/1
#             le tableau sera ['user','produit_vente_libre'] et formera donc cette url
#  - url_to_update : obligatoire si l'url pour recuperer les infos est différente de l'url pour updater les infos
#  - champ : obligatoire. Doit indiquer le nom du champ à updater
#  - element.type : si rien d'indiquer ca sera un input
#  - element.options.value : les valeurs des options du select (si select il y a)
#  - element.options.text : les valeurs du text des options du select (si select il y a)
#  - button.class : class du bouton valider modification
#  - button.text_update: text du bouton pour la modification
#  - trigger d'un evenement a la fin du update pour pouvoir faire de nouvel modif. Nom event : end_form_plugin
#  - Gestion des erreurs, voici le format pour renvoyer une erreur et son message :
#                 format.js { render :json => {
#                 		  			:status => "error",
#                 		  			:error => "Quantite mis en ligne depasse la quantite du stock", 
#                 		  			:produit_vente_libre => { 
#                 			  			:id => @produit_vente_libre.id,
#                 			  			:nb_pack => @nb_pack,
#                 			  			:quantite => @quantite_produit_vente_libre,
#                 			  			:rest => @quantite_restante
#                 		  			},
#                 		  			:stock => {
#                 			  			:quantite_restante => @quantite_restante
#                 		  			}
#                 	
#                 		  		}
#                 	  		}
 


$.fn.form_plugin = (optn)->
    
    options = 
        user_id: $('input.user_id').val()
        table_get_infos : ''
        table_to_update: ''
        champ: []
        titre:optn.titre ? 'Titre'
        id_entite_get_infos: ''
        id_entite_update: ''  #ID ENTITE
        element: 
            type: optn['element']['type'] ? 'input' #input, select
            options : #si select
                value: if optn['element']['options'] != undefined then optn['element']['options']['value'] else []
                text: if optn['element']['options'] != undefined then optn['element']['options']['text'] else []
        class:'string optional'
        button:
            class: if optn['button'] != undefined then optn['button']['class'] ? 'update_element' else 'update_element'
            text_update: if optn['button'] != undefined then optn['button']['text_update'] ? 'Modifier' else 'Modifier'
        callback: optn.callback ? null
        #url_get_infos:''
        #url_to_update:''
        #the_url_get_infos:''
        #the_url_to_update:''
        #top:''
        #left:''
    
    champ_opt = optn['champ'].split(',')            
    for champ, valeur of champ_opt 
        options.champ.push($.trim(valeur))
    
    
    #__ FUNCTIONS ___
    functions = 
        input_create : []
        #_____ RECUP DES DONNEES POUR GENERER LE FORMULAIRE _____
        show_form:(donnees) ->
            
            attribut = 
                hidden_input:
                    balise:'input'
                    id: options.table_to_update+'_id' #'stock_id'
                    value:donnees[options.table_to_update]['id']
                    size:'50'
                    type_input:'hidden'
                    name:options.table+'[id]'
                                   
                link:
                    class:options.button.class
                    text:options.button.text_update
                
                input:[]
                    
            #SI IL Y A PLUSiEURS CHAMPS       
            
            for champ, valeur_champ of options.champ 
                attribut_input = 
                    balise : options['element']['type']
                    id:options.table_to_update+'_'+valeur_champ #'stock_titre'
                    value:donnees[options['table_to_update']][valeur_champ]
                    size:'50'
                    type_input:'text'
                    name:options.table_to_update+'['+valeur_champ+']'
                    class:'string optional'
                    option: []
                attribut['input'].push(attribut_input)
                
                #SI SELECT
                if attribut_input['balise'] == 'select'
                    attribut.input[champ].option = []
                    i = 0
                    data_ = []
                    while  i < options['element']['options']['value'].length
                        d = 
                            value: options['element']['options']['value'][i]
                            text: options['element']['options']['text'][i]
                        (attribut.input[champ].option).push(d) 
#                         option = $(document.createElement('option'))
#                         option.attr('value',options['element']['options']['value'][i])
#                         option.text(options['element']['options']['text'][i])
#                         if options['element']['options']['value'][i] ==   donnees[options.table_to_update][valeur_champ]     
#                             option.attr('selected','selected')
#                         (attribut.input[champ].option).push(option)
                        i++
            
            
            
            
            
            functions.generate_form(attribut)
            window.light_box_information.show()
			            

        generate_form: (attribut) ->
            window.light_box_information.html_content('')
            window.light_box_information.header_html_content('')
            #window.light_box_information.title_header(options.titre)
            #HIDDEN INPUT WITH ID
            hidden_input = $(document.createElement(attribut['hidden_input']['balise']))
            hidden_input.attr('id',attribut['hidden_input']['id'])
            hidden_input.attr('name',attribut['hidden_input']['name'])
            hidden_input.val(attribut['hidden_input']['value'])
            hidden_input.attr('type',attribut['hidden_input']['type_input'])
            hidden_input.addClass(attribut['hidden_input']['class'])
            
            functions.input_create = []
            
            form = $(document.createElement('form'))
            form.addClass('form-horizontal')
                
            #INPUT SELECT TEXTAREA
            for champ, valeur of attribut['input']
                data_ = 
                    type_element:valeur['balise']
                    label:
                        text:options.titre
                    input:
                        value: valeur['value'] #'' #tableau d'obj si select {value:'',text:''},....   , string si input
                        name: valeur['name']
                        class: valeur['class']
                        id: valeur['id']
                        other_attributes: []
                
                
                
                
                # input = $(document.createElement(valeur['balise']))
#                 input.attr('id',valeur['id'])
#                 input.attr('name',valeur['name'])
#                 input.val(valeur['value'])
#                 input.addClass(valeur['class'])  
                if valeur['balise'] == 'input'
                    data_.input.other_attributes.push(['type',valeur['type_input']])
                    data_.input.other_attributes.push(['size',valeur['size']])
                    # input.attr('type',valeur['type_input'])
#                     input.attr('size',valeur['size'])
                else if valeur['balise'] == 'textarea'
                    data_.input.other_attributes.push(['cols',valeur['size']])
                    # input.attr('cols',valeur['size'])
                else if valeur['balise'] == 'select'
                    data_.input.options = valeur.option
                        
                    #i = 0
                    #while  i < options['element']['options']['value'].length       
                        
                        # input.append(valeur.option[i])
                        #i++
                
                
                
                input = window.global_functions.standard_input(data_)
                
                form.append(input)
                (functions.input_create).push(input.find(valeur['balise']))
                
            window.light_box_information.append_content(form)
            
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
            offset_lightbox_input = $('.lightbox_wrapper.lightbox_information .form-horizontal .controls').position()
            
            margin_left = $('.lightbox_wrapper.lightbox_information').css('margin-left')
            margin_top = $('.lightbox_wrapper.lightbox_information').css('margin-top')
            
            margin_bottom_control = $('.lightbox_wrapper.lightbox_information .form-horizontal .control-group').css('margin-bottom')
            console.log(margin_bottom_control)
            
            padding_top = $('.lightbox_wrapper.lightbox_information .content').css('padding-left')
            padding_left = $('.lightbox_wrapper.lightbox_information .content').css('padding-top')
            
            options.left += offset_lightbox_input.left - parseInt(margin_left) - parseInt(padding_left) - 10
            options.top -= parseInt(margin_top) + parseInt(padding_top) - parseInt(margin_bottom_control)
            
            window.light_box_information.css({
                'margin':'Opx',
                top:options.top+'px',
                left:options.left+'px',
                position:'absolute',
                
            })
            window.light_box_information.html_footer(span_annuler)
            window.light_box_information.append_footer(span)
            span.on('click',()->
                functions.update_information(this)
            )
            
        get_information:()->
            user_id = $('input.user_id').val()
            $.ajax(
                type: 'GET'
                url:options.the_url_get_infos#'/administration/users/'+user_id+'/'+options.table_get_infos+'s/'+options.id_entite_get_infos
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    if informations['status'] == 'OK'
                        return informations
                    else
                        alert(informations['error'])
                    
            )
        
        update_information: (button)->
            user_id = $('input.user_id').val()
            value_to_show = ''
            
            for champ, valeur of functions.input_create
                tab_concerned = options.table_to_update
                id_entite = options.id_entite_update
                champ = options.champ[champ]
                val = $(valeur).val()
                
                data = {}
                data[tab_concerned] = {}
                data[tab_concerned][champ] = val
                value_to_show += ' '+val
                if val != ''
                    $.ajax(
                        type: 'PUT'
                        url:options.the_url_to_update#'/administration/users/'+user_id+'/'+tab_concerned+'s/'+id_entite
                        data:data
                        format:'json'
                        complete:(data)->
                            informations = $.parseJSON(data['responseText'])
                            if informations['status'] == 'OK'
                                if $(options.element_clicked).children('span.value').length > 0
                                    element_for_text = $(options.element_clicked).children('span.value')
                                else if $(options.element_clicked).children('span.number').length > 0
                                    element_for_text = $(options.element_clicked).children('span.number')
                                else
                                    element_for_text = options.element_clicked
                                
                                if options.element.type == 'select'
                                    $(element_for_text).text($(valeur).children("option[value='"+val+"']").text())
                                else
                                    $(element_for_text).text($.trim(value_to_show))
                                
                                window.light_box_information.hide()
                                $(options.element_clicked).trigger('end_form_plugin')
                            else
                                window.message_information.message_error('input#'+$(valeur).attr('id'),'erreur',informations['error'],5000)
                    )
                else
                    window.message_information.message_error('input#'+$(valeur).attr('id'),'erreur','le champ '+champ+' est vide' ,5000)

               



#_______ EACH ________________
    return this.each(()->
        $(this).bind('click',()->
            if $(this).hasClass('is-editing')
                #ON ENREGISTRE LELEMENT SUR LEQUEL ON A CLIQUER POUR L'UTILISER PAR LA SUITE
                options.element_clicked = this
                
                
                #offset_lightbox_input = $('.lightbox_wrapper.lightbox_information .form-horizontal .controls').position()
                #scroll_top_light = $('.lightbox_wrapper.lightbox_information').scrollTop()
                offset_lightbox_top = $(window).height() * 0.5 #parseInt(offset_lightbox.top) - scroll_top_light
                offset_lightbox_left = $(window).width() * 0.5 #parseInt(offset_lightbox.left)
                
                offset = $(this).offset()
                scroll_top = $(document).scrollTop()
                console.log(scroll_top)
                offset_top = parseInt(offset.top) - scroll_top - offset_lightbox_top
                offset_left = parseInt(offset.left) - offset_lightbox_left #- offset_lightbox_input.left
                
                options.top = offset_top
                options.left = offset_left
                #options.top += 'px'
                #options.left += 'px'
                console.log(options)
                #url level to update
                if optn.url_to_update == undefined
                    optn.url_to_update = optn.url_get_infos 
                     
                #init table
                options.table_get_infos = optn.url_get_infos[optn.url_get_infos.length - 1]
                options.table_to_update = optn.url_to_update[optn.url_to_update.length - 1]
                
                
                options.id_entite_get_infos = $(this).parents('div').prevAll('div.informations_card').children('input.id_'+options.table_get_infos).val()
                options.id_entite_update = $(this).parents('div').prevAll('div.informations_card').children('input.id_'+options.table_to_update).val()
                
                
                options.the_url_get_infos = '/administration'
                options.the_url_to_update = '/administration'
                #url level get infos
                if optn.url_get_infos != undefined
                    options.url_get_infos = {}
                    i=0
                    while i < (optn.url_get_infos).length
                        champ_lvl = 'level_'+i
                        options.url_get_infos[champ_lvl] = optn.url_get_infos[i] #/administration/users/
                        if i == 0
                            options.the_url_get_infos += '/'+optn.url_get_infos[i]+'s/'+options.user_id
                        else
                            options.the_url_get_infos += '/'+optn.url_get_infos[i]+'s/'+options.id_entite_get_infos
                        i++
                
                
                #url level to update
                options.url_to_update = {}
                i=0
                while i < (optn.url_to_update).length
                    champ_lvl = 'level_'+i
                    options.url_to_update[champ_lvl] = optn.url_to_update[i] #/administration/users/
                    if i == 0
                        options.the_url_to_update += '/'+optn.url_to_update[i]+'s/'+options.user_id
                    else
                        options.the_url_to_update += '/'+optn.url_to_update[i]+'s/'+options.id_entite_update
                    i++
                
 
                #show form
                that = this
                $.when(functions.get_information()).done((data)->
                    functions.show_form(data)
                )
                this
        )

         
            
    )