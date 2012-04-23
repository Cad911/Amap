# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(->
	
	id_user = $('#produit_vente_libre_id_user_input').val()
	exist_deja = false
	previous_id = ""
	
	#___________________ FUNCTION _______________________________________________________________________________________ 
	#_______________________________
	info_stock =  (stock_id) ->
					$.ajax("/administration/users/#{id_user}/stocks/#{stock_id}",{
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
	
	quantite_stock = (stock_id) ->
					quantite_stock_return = 0
					$.ajax("/administration/users/#{id_user}/stocks/#{stock_id}",{
					type:"GET",
					async:false,
					format : "json",
					success: (data) -> 
						quantite_stock_return = parseInt(data[0]["quantite"])		
					})
					quantite_stock_return
					
	#_________________ VERIF SI QUANTITE MIS EN LIGNE INFERIEUR A QUANTITE EN STOCK ____________________________________________________
	verif_quantite = () ->
					if !isNaN(parseInt($('#produit_vente_libre_quantite').val())) && !isNaN(parseInt($('#produit_vente_libre_nombre_pack').val()))
						quantite_mise_en_ligne = parseInt($('#produit_vente_libre_quantite').val())
						nombre_pack = parseInt($('#produit_vente_libre_nombre_pack').val())
						quantite_stock_v = quantite_stock($('#produit_vente_libre_stock_id').val())
						resultat_reste = quantite_stock_v - (nombre_pack*quantite_mise_en_ligne)
						console.log(resultat_reste)
						if resultat_reste < 0
							if !$('div').hasClass('error_quantite')
								$('.alert-info').after('<div style="display:none;" class="alert alert-error error_quantite"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> La quantite mis en ligne excede celle du stock </div>')
								$('.error_quantite').slideDown('2000')
								setTimeout(() ->
											$('.error_quantite').slideUp('2000',() ->
												$('.error_quantite').remove()
											)
								,5000)
								
								true

						else
							if !$('div').hasClass('info_reste_quantite')
								$('.alert-info').after('<div style="display:none;" class="alert alert-success info_reste_quantite"> <a class="close" data-dismiss="alert"> x </a> <strong>Infos </strong> Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock </div>')
								$('.info_reste_quantite').slideDown('2000')
							else
								$('.info_reste_quantite').html(' <a class="close" data-dismiss="alert"> x </a> <strong>Infos </strong> Il vous restera '+resultat_reste+' '+$("#unite_mesure_stock").text()+' dans votre stock ')
							false
					else
						false
						
						
								
	#_______________________________ PRODUIT DEJA EN VENTE ? _____________________________
	produit_deja_envente = 	(id_produit) ->
								$.ajax("/administration/users/#{id_user}/exist_vente/#{id_produit}",{
														type:"GET",
														async:false,
														format:"json",
														success: (data)->
															exist_deja = data
															true
														})
								return exist_deja


	#_______________________________	
	verif_all_input = () ->
						erreur = false
						erreur_quantite = false
						$('.etape_active input').each ->
							if $(this).attr('type') == "number"
									if $(this).val() == "" 
										$(this).parent().parent().addClass('error')
										$(this).next().remove()
										$(this).after('<span class="help-inline">Ne peut pas être vide</span>');
										erreur = true
									else if isNaN(parseInt($(this).val()))
										$(this).parent().parent().addClass('error')
										$(this).next().remove()
										$(this).after('<span class="help-inline"> Ce n\'est pas un nombre</span>');
										erreur = true
									else
										$(this).parent().parent().removeClass('warning')
										$(this).next().remove()
										
						if erreur == true
							if !$('div').hasClass('all_error')
								$('.form-inputs').append('<div style="display:none;" class="alert alert-error all_error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> Corrigé vos erreurs </div>')
							
							$('.all_error').slideDown('2000')
							setTimeout(() ->
									$('.all_error').slideUp('2000',() ->
										$('.all_error').remove()
									)
							,3000)

								
						return erreur
	
	#_______________________________
	verif_one_input = (id_input) -> 
								erreur_quantite = false
								if $(id_input).attr('type') == "number"
									if $(id_input).val() == ""
										$(id_input).parent().parent().removeClass('success') 
										$(id_input).parent().parent().addClass('warning')
										$(id_input).next().remove()
										$(id_input).after('<span class="help-inline">Ne peut pas être vide</span>')
									else if isNaN(parseInt($(id_input).val()))
										$(id_input).parent().parent().removeClass('success')
										$(id_input).parent().parent().addClass('warning')
										$(id_input).next().remove()
										$(id_input).after('<span class="help-inline"> Ce n\'est pas un nombre</span>')
									else
										$(id_input).parent().parent().addClass('success')
										$(id_input).parent().parent().removeClass('error')
										$(id_input).parent().parent().removeClass('warning')
										$(id_input).next().remove()
								
								
									

					
										
	
	next_step = () ->
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
	
	previous_step = () ->
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
	
	
	#_____________________ EVENT _________________________________________________________________________________________					
	#___________________ PAGE AJOUT ________________________
	text_previous = ""
	evenement_form = () -> 
						$('#produit_vente_libre_stock_id').focus ->
							previous_id = $(this).val() #QUAND ON FOCUS LE SELECT
						.change ->
							text_previous = $('#produit_vente_libre_stock_id option:selected').text() #TEXTE DU PRODUIT SELECTIONNER
							if produit_deja_envente($(this).val())
									$(this).val(previous_id)
									$(this).parent().parent().prepend('<div style="display:none;" class="alert alert-error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong>'+text_previous+' est déjà en vente </div>')
									$('.alert-error').slideDown('2000')
								else
									info_stock($(this).val()) #Affichagedesinfosduproduitautorise
						#___________ VERIF INPUT _________________________
						$('.etape_3 input').change ->
							inputid = '#'+$(this).attr('id')
							verif_one_input(inputid)
						
						#_________ VERIF INPUT QUANTITE __________
						$('#produit_vente_libre_quantite,#produit_vente_libre_nombre_pack').change ->
							verif_quantite()
						
						#________ VERIF AVANT SUBMIT ______
						$('#new_produit_vente_libre').submit ->
							all_input = verif_all_input()
							quantite_good = verif_quantite()
							if all_input || quantite_good
								false #EMPECHE LE FORMULAIRE DE SE SUBMIT
							else
								true
							
								
							
						
						#___ FONCTION POUR ALLER A LETAPE SUIVANTE
						$('.form-actions .next').click ->
							next_step()
						
						$('.form-actions .previous').click ->
							previous_step()
							
						$('.simple_form').bind "ajax:loading", (et,e) ->
								alert(e)
								$('#light_box').html('<div class="progress progress-striped"> <div class="bar" style="width:20%"> </div></div>')
						
						$('.simple_form').bind "ajax:complete", (et,e) ->
								$('#light_box').modal('hide')
			
	
										
		evenement_button = () ->
						#___________ PAGE INDEX ________________________
						$('.button-add').bind "ajax:complete", (et,e) ->
								$('#light_box').html(e.responseText)
								id_user = $('#produit_vente_libre_id_user_input').val()
								if initialisation_ajout()
									if $('.alert-error').length == 0
										$(this).after('<div style="display:none;" class="alert alert-error"> <a class="close" data-dismiss="alert"> x </a> <strong>Erreur </strong> Tous les produits du stock sont déjà en vente </div>')
										
										$('.alert-error').slideDown('2000')
										setTimeout(() ->
											$('.alert-error').slideUp('2000',() ->
												$('.alert-error').remove()
											)
										,3000)
								else
									evenement_form()
									$('#light_box').modal('show')
		
							
	#___________________________A L initialisation de la page ____________________________________________________________
	
	
	initialisation_ajout = () ->
			info_stock($('#produit_vente_libre_stock_id').val())
			#_____________________________Verif si les produits sont deja en stock _________________________________
			if produit_deja_envente($('#produit_vente_libre_stock_id').val())
				dem_produit_envente = false
				$('#produit_vente_libre_stock_id option').each ->
					value_option = $(this).attr("value")
					if !produit_deja_envente(value_option)
						dem_produit_envente = true
						$('#produit_vente_libre_stock_id').val(value_option)
						info_stock(value_option)
				
				if !dem_produit_envente
					true
					#$('#light_box').html('<div class="modal-header"> <h1> Erreur </h1> </div><div class="modal-body"> Tous les produits sont deja en vente </div><div class="modal-footer"><a class="close" data-dismiss="modal"> Retour </a></div>')
	
	evenement_button()
)