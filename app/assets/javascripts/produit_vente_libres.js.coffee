# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(->
	
# 	id_user = $('#produit_vente_libre_id_user_input').val()
# 	exist_deja = false
# 	previous_id = ""
# 	
# 	#___________________ FUNCTION _______________________________________________________________________________________ 
# 	#_______________________________
# 	info_stock =  (stock_id) ->
# 					$.ajax("/administration/users/#{id_user}/stocks/#{stock_id}",{
# 					type:"GET",
# 					async:false,
# 					format : "json",
# 					success: (data) -> 
# 						$('#produit_vente_libre_titre').val(data[0]["titre"])
# 						$('#produit_vente_libre_description').val(data[0]["description"])
# 						$('#quantite_stock').text(data[0]["quantite"])
# 						$('#unite_mesure_stock').text(data[1]["abbreviation"])
# 
# 						false		
# 					})
# 					true
# 	
# 	quantite_stock = (stock_id) ->
# 					quantite_stock_return = 0
# 					$.ajax("/administration/users/#{id_user}/stocks/#{stock_id}",{
# 					type:"GET",
# 					async:false,
# 					format : "json",
# 					success: (data) -> 
# 						quantite_stock_return = parseInt(data[0]["quantite"])		
# 					})
# 					quantite_stock_return
# 					
# 	#_________________ VERIF SI QUANTITE MIS EN LIGNE INFERIEUR A QUANTITE EN STOCK ____________________________________________________
# 	verif_quantite = () ->
# 					if !isNaN(parseInt($('#produit_vente_libre_quantite').val())) && !isNaN(parseInt($('#produit_vente_libre_nombre_pack').val()))
# 						quantite_mise_en_ligne = parseInt($('#produit_vente_libre_quantite').val())
# 						nombre_pack = parseInt($('#produit_vente_libre_nombre_pack').val())
# 						quantite_stock_v = quantite_stock($('#produit_vente_libre_stock_id').val())
# 						resultat_reste = quantite_stock_v - (nombre_pack*quantite_mise_en_ligne)
# 						console.log(resultat_reste)
# 						if resultat_reste < 0
# 							if !$('div').hasClass('error_quantite')
# 								$('.alert-info').after('<div style="display:none;" class="alert alert-error error_quantite"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> La quantite mis en ligne excede celle du stock </div>')
# 								$('.error_quantite').slideDown('2000')
# 								setTimeout(() ->
# 											$('.error_quantite').slideUp('2000',() ->
# 												$('.error_quantite').remove()
# 											)
# 								,5000)
# 								
# 								true
# 
# 						else
# 							if !$('div').hasClass('info_reste_quantite')
# 								$('.alert-info').after('<div style="display:none;" class="alert alert-success info_reste_quantite"> <a class="close" data-dismiss="alert"> x </a> <strong>Infos </strong> Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock </div>')
# 								$('.info_reste_quantite').slideDown('2000')
# 							else
# 								$('.info_reste_quantite').html(' <a class="close" data-dismiss="alert"> x </a> <strong>Infos </strong> Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock ')
# 							false
# 					else
# 						false
# 						
# 						
# 								
# 	#_______________________________ PRODUIT DEJA EN VENTE ? _____________________________
# 	produit_deja_envente = 	(id_produit) ->
# 								$.ajax("/administration/users/#{id_user}/one_exist_vente/#{id_produit}",{
# 														type:"GET",
# 														async:false,
# 														format:"json",
# 														success: (data)->
# 															exist_deja = data
# 															true
# 														})
# 								return exist_deja
# 
# 
# 	#_______________________________	
# 	verif_all_input = () ->
# 						erreur = false
# 						erreur_quantite = false
# 						$('.etape_active input').each ->
# 							if $(this).attr('type') == "number"
# 									if $(this).val() == "" 
# 										$(this).parent().parent().addClass('error')
# 										$(this).next().remove()
# 										$(this).after('<span class="help-inline">Ne peut pas être vide</span>');
# 										erreur = true
# 									else if isNaN(parseInt($(this).val()))
# 										$(this).parent().parent().addClass('error')
# 										$(this).next().remove()
# 										$(this).after('<span class="help-inline"> Ce n\'est pas un nombre</span>');
# 										erreur = true
# 									else
# 										$(this).parent().parent().removeClass('warning')
# 										$(this).next().remove()
# 										
# 						if erreur == true
# 							if !$('div').hasClass('all_error')
# 								$('.form-inputs').append('<div style="display:none;" class="alert alert-error all_error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> Corrigé vos erreurs </div>')
# 							
# 							$('.all_error').slideDown('2000')
# 							setTimeout(() ->
# 									$('.all_error').slideUp('2000',() ->
# 										$('.all_error').remove()
# 									)
# 							,3000)
# 
# 								
# 						return erreur
# 	
# 	#_______________________________
# 	verif_one_input = (id_input) -> 
# 								erreur_quantite = false
# 								if $(id_input).attr('type') == "number"
# 									if $(id_input).val() == ""
# 										$(id_input).parent().parent().removeClass('success') 
# 										$(id_input).parent().parent().addClass('warning')
# 										$(id_input).next().remove()
# 										$(id_input).after('<span class="help-inline">Ne peut pas être vide</span>')
# 									else if isNaN(parseInt($(id_input).val()))
# 										$(id_input).parent().parent().removeClass('success')
# 										$(id_input).parent().parent().addClass('warning')
# 										$(id_input).next().remove()
# 										$(id_input).after('<span class="help-inline"> Ce n\'est pas un nombre</span>')
# 									else
# 										$(id_input).parent().parent().addClass('success')
# 										$(id_input).parent().parent().removeClass('error')
# 										$(id_input).parent().parent().removeClass('warning')
# 										$(id_input).next().remove()
# 								
# 								
# 									
# 
# 					
# 										
# 	
# 	next_step = () ->
# 					for i in [0..5]
# 						if $('.etape_active').hasClass('etape_'+i)
# 							class_div = 'etape_'+i
# 							console.log(class_div)
# 							if $('.etape_formulaire').hasClass('etape_'+(i+1))
# 								class_next = 'etape_'+(i+1)
# 					$('.'+class_div).slideUp('5000')
# 					$('.'+class_next).slideDown('5000')
# 					$('.'+class_next).addClass('etape_active')
# 					$('.'+class_div).removeClass('etape_active')
# 	
# 	previous_step = () ->
# 					for i in [0..5]
# 						if $('.etape_active').hasClass('etape_'+i)
# 							class_div = 'etape_'+i
# 							console.log(class_div)
# 							if $('.etape_formulaire').hasClass('etape_'+(i-1))
# 								class_previous = 'etape_'+(i-1)
# 					$('.'+class_div).slideUp('5000')
# 					$('.'+class_previous).slideDown('5000')
# 					$('.'+class_previous).addClass('etape_active')
# 					$('.'+class_div).removeClass('etape_active')
# 	
# 	
# 	#_____________________ EVENT _________________________________________________________________________________________					
# 	#___________________ PAGE AJOUT ________________________
# 	text_previous = ""
# 	evenement_form = () -> 
# 						$('#produit_vente_libre_stock_id').focus ->
# 							previous_id = $(this).val() #QUAND ON FOCUS LE SELECT
# 						.change ->
# 							text_previous = $('#produit_vente_libre_stock_id option:selected').text() #TEXTE DU PRODUIT SELECTIONNER
# 							if produit_deja_envente($(this).val())
#                                     $(this).val(previous_id)
#                                     message_information.message_error(this,'Erreur',text_previous+' est déjà en vente',2000)
# 									#$(this).parent().parent().prepend('<div style="display:none;" class="alert alert-error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong>'+text_previous+' est déjà en vente </div>')
#                                     $('.alert-error').slideDown('2000')
#                             else
# 									info_stock($(this).val()) #Affichagedesinfosduproduitautorise
# 						#___________ VERIF INPUT _________________________
# 						$('.etape_3 input').change ->
# 							inputid = '#'+$(this).attr('id')
# 							verif_one_input(inputid)
# 						
# 						#_________ VERIF INPUT QUANTITE __________
# 						$('#produit_vente_libre_quantite,#produit_vente_libre_nombre_pack').change ->
# 							verif_quantite()
# 						
# 						#________ VERIF AVANT SUBMIT ______
# 						$('#new_produit_vente_libre').submit ->
# 							all_input = verif_all_input()
# 							quantite_good = verif_quantite()
# 							if all_input || quantite_good
# 								false #EMPECHE LE FORMULAIRE DE SE SUBMIT
# 							else
# 								true
# 							
# 								
# 							
# 						
# 						#___ FONCTION POUR ALLER A LETAPE SUIVANTE
# 						$('.form-actions .next').click ->
# 							next_step()
# 						
# 						$('.form-actions .previous').click ->
# 							previous_step()
# 							
# 						$('.simple_form').bind "ajax:loading", (et,e) ->
# 								alert(e)
# 								$('#light_box').html('<div class="progress progress-striped"> <div class="bar" style="width:20%"> </div></div>')
# 						
# 						$('.simple_form').bind "ajax:complete", (et,e) ->
# 								$('#light_box').modal('hide')
# 			
# 	
# 										
# 		evenement_button = () ->
# 						#___________ PAGE INDEX ________________________
# 						$('.button-add').bind "ajax:complete", (et,e) ->
# 								$('#light_box').html(e.responseText)
# 								id_user = $('#produit_vente_libre_id_user_input').val()
# 								if initialisation_ajout()
# 									if $('.alert-error').length == 0
# 										$(this).after('<div style="display:none;" class="alert alert-error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> Tous les produits du stock sont déjà en vente </div>')
# 										
# 										$('.alert-error').slideDown('2000')
# 										setTimeout(() ->
# 											$('.alert-error').slideUp('2000',() ->
# 												$('.alert-error').remove()
# 											)
# 										,3000)
# 								else
# 									evenement_form()
# 									$('#light_box').modal('show')
# 		
							
	#___________________________A L initialisation de la page ____________________________________________________________
	
	
	
	#__________________________________________________________________________________
	#__________________________________________________________________________________
	#___________________________________________________________________
	#_____________________________________________________________________________
	#__________ FUNCTION ADD PRODUIT ___________________________________________________
    function_add_produit =
	    id_user:  ($('.button-add').attr('id')).replace('user_','')
	    init : () ->
	        this.evenement_button()
	    #____________________________________________ DIFFERENTS EVENTS ________________________________________________________________________
	    evenement_button : () ->
            #___________ PAGE INDEX ________________________
            $('.button-add').bind "ajax:complete", (et,e) ->
                verif_produit_en_vente = recup_info_produit.all_produit_en_vente()
                if verif_produit_en_vente['all_deja_vente'] == true
                    if $('.alert-error').length == 0
                        message_information.message_error('.button-add','Erreur','Tous les produits du stock sont déjà en vente',2000)
                else
                    $('#light_box').html(e.responseText)
                    function_add_produit.evenement_form(verif_produit_en_vente['stock_id'])
                    $('#light_box').modal('show')

        evenement_form : (id_stock_default) ->
            $('#produit_vente_libre_stock_id').val(id_stock_default)
            recup_info_produit.info_stock(id_stock_default)
            
            previous_id = 0 
            $('#produit_vente_libre_stock_id').focus ->
                previous_id = $(this).val() #QUAND ON FOCUS LE SELECT
            .change ->
                text_previous = $('#produit_vente_libre_stock_id option:selected').text() #TEXTE DU PRODUIT SELECTIONNER
                if recup_info_produit.produit_deja_envente($(this).val())
                    $(this).val(previous_id)
                    message_information.message_error('#produit_vente_libre_stock_id','Erreur',text_previous+' est déjà en vente',2000)
                else
                    recup_info_produit.info_stock($(this).val()) #Affichagedesinfosduproduitautorise
						
            #___________ VERIF INPUT _________________________
            $('.etape_3 input').change ->
                inputid = '#'+$(this).attr('id')
                useful_function.verif_one_input(inputid)

            #_________ VERIF INPUT QUANTITE __________
            $('#produit_vente_libre_quantite, #produit_vente_libre_nombre_pack').change ->
                function_add_produit.verif_quantite()
						
            #________ VERIF AVANT SUBMIT ______
            $('#new_produit_vente_libre').submit ->
                all_input = useful_function.verif_all_input('.etape_active','.form-inputs')
                quantite_good = function_add_produit.verif_quantite()                
                if all_input || quantite_good
                    false #EMPECHE LE FORMULAIRE DE SE SUBMIT
                else
                    true
							
								
							
						
            #___ FONCTION POUR ALLER A LETAPE SUIVANTE
            $('.form-actions .next').click ->
                function_add_produit.next_step()
						
            $('.form-actions .previous').click ->
                function_add_produit.previous_step()
			
			
			#__ AJAX POUR LE FORM DAJOUT DE NOUVEAU PRODUIT 			
            $('.simple_form').bind "ajax:loading", (et,e) ->
                alert(e)
                $('#light_box').html('<div class="progress progress-striped"> <div class="bar" style="width:20%"> </div></div>')
						
            $('.simple_form').bind "ajax:complete", (et,e) ->
                $('#light_box').modal('hide')
                
        
        #_____________________________________________ VERIFICATIONS ___________________________________________________________
        # verif_one_input : (id_input) -> 
#             erreur_ = false
#             
#             if $(id_input).hasClass('required')
#                 if $(id_input).val() == ""
#                     div_state.div_warning($(id_input), 'Ne peut pas être vide')
#                     erreur_ = true
#             
#             if erreur_ == false
#                 if $(id_input).attr('type') == "number"
#                     if isNaN(parseInt($(id_input).val())) and $(id_input).val() != ''
#                         div_state.div_warning($(id_input), 'Ce n\'est pas un nombre')
#                         erreur_ = true
#                     else
#                         div_state.div_success($(id_input), '')
#             
#             return erreur_
#                            
#         verif_all_input : () ->
#             erreur = false
# 
#             $('.etape_active input').each ->
#                 if function_add_produit.verif_one_input('#'+($(this).attr('id'))) == true
#                     erreur = true
#       
#                 if erreur == true
#                     if !$('div').hasClass('all_error')
#                         message_information.message_error('.form-inputs','Erreur','Corrigé vos erreur',2000, 'all_error')
# 		
#             return erreur
	

        #_________________ VERIF SI QUANTITE MIS EN LIGNE INFERIEUR A QUANTITE EN STOCK ____________________________________________________
        verif_quantite : () ->
            if !isNaN(parseInt($('#produit_vente_libre_quantite').val())) && !isNaN(parseInt($('#produit_vente_libre_nombre_pack').val()))
                quantite_mise_en_ligne = parseInt($('#produit_vente_libre_quantite').val())
                nombre_pack = parseInt($('#produit_vente_libre_nombre_pack').val())
                quantite_stock_v = recup_info_produit.quantite_stock($('#produit_vente_libre_stock_id').val())
                resultat_reste = quantite_stock_v - (nombre_pack*quantite_mise_en_ligne)
                console.log(resultat_reste)
                if resultat_reste < 0
                    if !$('div').hasClass('error_quantite')
                         message_information.message_error('.alert-info','Erreur','La quantite mis en ligne excede celle du stock ',2000, 'error_quantite')
                         return true

                else
                    if !$('div').hasClass('info_reste_quantite')
                        message_information.message_success('.alert-info','Infos','Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock ',2000, 'info_reste_quantite')
                    else
                        message_information.message_success('.alert-info','Infos','Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock ',2000, 'info_reste_quantite')
                    return false
            else
                return false
       
        #_____________________________________ ACTION POUR PASSER LES DIFFERENTES ETAPES _____________________________________________________ 
        next_step : () ->
            for i in [0..5]
                if $('.etape_active').hasClass('etape_'+i)
                    class_div = 'etape_'+i
                    console.log(class_div)
                    if $('.etape_formulaire').hasClass('etape_'+(i+1))
                        class_next = 'etape_'+(i+1)
            $('.'+class_div).slideUp('5000')
            $('.'+class_next).slideDown('5000')
            $('.'+class_next).addClass('etape_active')
            $('.'+class_div).removeClass('etape_active')

        previous_step : () ->
            for i in [0..5]
                if $('.etape_active').hasClass('etape_'+i)
                    class_div = 'etape_'+i
                    console.log(class_div)
                    if $('.etape_formulaire').hasClass('etape_'+(i-1))
                        class_previous = 'etape_'+(i-1)
            $('.'+class_div).slideUp('5000')
            $('.'+class_previous).slideDown('5000')
            $('.'+class_previous).addClass('etape_active')
            $('.'+class_div).removeClass('etape_active')

    
    
    #_______________________________________________________________________________________
    #__________ FUNCTION MODIF PRODUIT ___________________________________________________
    #_________________________________________________________________________________________________
    #_________________________________________________________________________________________________
    function_modif_produit = 
        id_user:  ($('.button-add').attr('id')).replace('user_','')
        id_product: 0
        id_stock : 0
        quantity_stock: 0
        event : () ->
            $('.modifier_product').bind "ajax:complete", (et,e) ->
                    id_product = ($(this).attr('id')).replace('produit_vente_libre_','')
                    info_produit = recup_info_produit.info_product(id_product)
                    
                    function_modif_produit.init_var(info_produit['stock']['quantite'], id_product, info_produit['stock']['id'])

                    $('#light_box').html(e.responseText)
                    $('#light_box').modal('show')
                    function_modif_produit.event_form()

       
        init_var: (_quantity_stock , _id_product , _id_stock) ->
            function_modif_produit.quantity_stock = _quantity_stock
            function_modif_produit.id_product = _id_product
            function_modif_produit.id_stock = _id_stock
            
        event_form : () ->
            #_________ VERIF INPUT QUANTITE __________
            $('#produit_vente_libre_quantite, #produit_vente_libre_nombre_pack').change ->
                function_modif_produit.verif_quantite()
            
            #___________ VERIF INPUT _________________________
            $('.edit_produit_vente_libre input').bind( 'change', () ->
                inputid = '#'+$(this).attr('id')
                useful_function.verif_one_input(inputid)
            )
            
            #__VERIF BEFORE SUBMIT _____
            $('.edit_produit_vente_libre .envoi_form').bind('click', () ->
                if useful_function.verif_all_input('.edit_produit_vente_libre', '.edit_produit_vente_libre .alert-info')
                    false
                else
                    true
            )
            
            #___ EVENT AJAX FORM MODIF _______
            $('.edit_produit_vente_libre').bind("ajax:complete", (et,e) ->
               $('#light_box').html('')
               $('#light_box').modal('hide')
            )
                
        verif_quantite : () ->
            if !isNaN(parseInt($('.modif_formulaire #produit_vente_libre_quantite').val())) && !isNaN(parseInt($('.modif_formulaire #produit_vente_libre_nombre_pack').val()))
                quantite_mise_en_ligne = parseInt($('.modif_formulaire #produit_vente_libre_quantite').val())
                nombre_pack = parseInt($('.modif_formulaire #produit_vente_libre_nombre_pack').val())
                resultat_reste = function_modif_produit.quantity_stock - (nombre_pack * quantite_mise_en_ligne)

                if resultat_reste < 0
                    if !$('div').hasClass('error_quantite')
                         message_information.message_error('.alert-info','Erreur ','La quantite mis en ligne excede celle du stock ',2000, 'error_quantite')
                         return true

                else
                        le_message = 'Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock '
                        message_information.message_success('.alert-info','Infos',le_message ,2000, 'info_reste_quantite')
                    return false
            else
                return false
        
        # verif_one_input : (id_input) -> 
#             erreur_ = false
#             
#             if $(id_input).hasClass('required')
#                 if $(id_input).val() == ""
#                     div_state.div_warning($(id_input), 'Ne peut pas être vide')
#                     erreur_ = true
#             
#             if erreur_ == false
#                 if $(id_input).attr('type') == "number"
#                     if isNaN(parseInt($(id_input).val())) and $(id_input).val() != ''
#                         div_state.div_warning($(id_input), 'Ce n\'est pas un nombre')
#                         erreur_ = true
#                     else
#                         div_state.div_success($(id_input), '')
#             
#             return erreur_
#                            
#         verif_all_input : () ->
#             erreur = false
# 
#             $('.modif_formulaire input').each ->
#                 if useful_function.verif_one_input('#'+($(this).attr('id'))) == true
#                     erreur = true
#       
#                 if erreur == true
#                     if !$('div').hasClass('all_error')
#                         message_information.message_error('.form-inputs','Erreur','Corrigé vos erreur',2000, 'all_error')
# 		
#             return erreur

       
#________________________________________________________________________
    #________________________________________________________________________
    #________________________________________________________________________
    #_____________________________ USEFUL FUNCTION _____________________________
    #________________________________________________________________________
    useful_function = 
        verif_one_input : (id_input) -> 
            erreur_ = false
            
            if $(id_input).hasClass('required')
                if $(id_input).val() == ""
                    div_state.div_warning($(id_input), 'Ne peut pas être vide')
                    erreur_ = true
            
            if erreur_ == false
                if $(id_input).attr('type') == "number"
                    if isNaN(parseInt($(id_input).val())) and $(id_input).val() != ''
                        div_state.div_warning($(id_input), 'Ce n\'est pas un nombre')
                        erreur_ = true
                    else
                        div_state.div_success($(id_input), '')
            
            return erreur_
                           
        verif_all_input : (id_formulaire, id_for_msg_error) ->
            erreur = false

            $(id_formulaire+' input').each ->
                if useful_function.verif_one_input('#'+($(this).attr('id'))) == true
                    erreur = true
      
                if erreur == true
                    if !$('div').hasClass('all_error')
                        message_information.message_error(id_for_msg_error,'Erreur ','Corrigé vos erreur',2000, 'all_error')
		
            return erreur
    
    function_modif_produit.event()


    #________________________________________________________________________
    #________________________________________________________________________
    #________________________________________________________________________
    #_____________________________ RECUP INFORMATIONS _____________________________
    #________________________________________________________________________
    recup_info_produit =
        all_produit_en_vente: () ->
            all_exist = {}
            $.ajax("/administration/users/#{function_add_produit.id_user}/all_exist_vente",{
                type:"GET",
                async:false,
                format:"json",
                success: (data)-> 
                    all_exist = data
                    true
            })
            all_exist
                         
        produit_deja_envente : 	(id_produit) ->
            exist_deja = false
            $.ajax("/administration/users/#{function_add_produit.id_user}/one_exist_vente/#{id_produit}",{
                type:"GET",
                async:false,
                format:"json",
                success: (data)->
              
                    exist_deja = data
                    true
            })
            return exist_deja
        
        info_product: (product_id) ->
            infos = {}
            $.ajax("/administration/users/#{function_add_produit.id_user}/produit_vente_libres/#{product_id}",{
                type:"GET",
                async:false,
                format : "json",
                success: (data) -> 
                    infos = data		
            })
            return infos
        info_stock :  (stock_id) ->
            $.ajax("/administration/users/#{function_add_produit.id_user}/stocks/#{stock_id}",{
                type:"GET",
                async:false,
                format : "json",
                success: (data) -> 
                    $('#produit_vente_libre_titre').val(data[0]["titre"])
                    $('#produit_vente_libre_description').val(data[0]["description"])
                    $('#quantite_stock').text(data[0]["quantite"])
                    $('#unite_mesure_stock').text(data[1]["abbreviation"])
                    false		
            })
            true
            
        quantite_stock : (stock_id) ->
                    quantite_stock_return = 0
                    $.ajax("/administration/users/#{id_user}/stocks/#{stock_id}",{
                        type:"GET",
                        async:false,
                        format : "json",
                        success: (data) -> 
                            quantite_stock_return = parseInt(data[0]["quantite"])		
                    })
                    quantite_stock_return
       

    


    #function_add_produit.init()
	
# 	initialisation_ajout = () ->
# 			info_stock($('#produit_vente_libre_stock_id').val())
# 			#_____________________________Verif si les produits sont deja en stock _________________________________
# 			if produit_deja_envente($('#produit_vente_libre_stock_id').val())
# 				dem_produit_envente = false
# 				$('#produit_vente_libre_stock_id option').each ->
# 					value_option = $(this).attr("value")
# 					if !produit_deja_envente(value_option)
# 						dem_produit_envente = true
# 						$('#produit_vente_libre_stock_id').val(value_option)
# 						info_stock(value_option)
# 				
# 				if !dem_produit_envente
# 					true
					#$('#light_box').html('<div class="modal-header"> <h1> Erreur </h1> </div><div class="modal-body"> Tous les produits sont deja en vente </div><div class="modal-footer"><a class="close" data-dismiss="modal"> Retour </a></div>')
	
	#evenement_button()
)