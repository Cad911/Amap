# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(->
	
	previous_id = ""
	exist_deja = false
	
	info_produit_autorise = (id_pa) ->
								@id_user = $('#stock_id_user_input').val() 
								$.ajax("/administration/users/#{@id_user}/produit_autorises/#{id_pa}",{
								type:"GET",
								async:false,
								format:"json",
								success: (data)->
									$('#stock_titre').val(data['titre'])
									$('#stock_description').val(data['description'])
									true
								})
								true
		
	produit_deja_enstock = 	(id_produit) ->
								@id_user = $('#stock_id_user_input').val()
								$.ajax("/administration/users/#{@id_user}/exist_stock/#{id_produit}",{
														type:"GET",
														async:false,
														format:"json",
														success: (data)->
															exist_deja = data
															true
														})
								return exist_deja
				
	
	#_____________________ EVENT _________________________________________________________________________________________						
	$('#stock_produit_autorise_id').click ->
		previous_id = $(this).val() #QUAND ON FOCUS LE SELECT
	.change ->
			if produit_deja_enstock($(this).val())
				alert('Deja dans le stock')
				$(this).val(previous_id)
			else
				info_produit_autorise($(this).val()) #Affichagedesinfosduproduitautorise
	
	#A L initialisation de la page ________________________________________________________________________________
	info_produit_autorise($('#stock_produit_autorise_id').val())
	
	#Verif si les produits sont deja en stock ________________________________________
	if produit_deja_enstock($('#stock_produit_autorise_id').val())
		dem_produit_enstock = false
		$('#stock_produit_autorise_id option').each ->
			value_option = $(this).attr("value")
			if !produit_deja_enstock(value_option)
				dem_produit_enstock = true
				$('#stock_produit_autorise_id').val(value_option)
				info_produit_autorise(value_option)
		
		if !dem_produit_enstock
			alert('Tous les produits autorisé sont en stock')
	
								
)					
