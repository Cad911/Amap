# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(->
  #____________________________________________ FUNCTION POUR AFFICHAGE DES MESSAGE D'INFORMATION ________________________
  message_information =
      message_success: (id,titre,message) ->
        div_message = '<div class="alert alert-success" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        if titre != ""
           div_message += "<h4> #{titre} </h4>"
        if message != ""
          div_message += "<p> #{message} </p>"
        div_message += "</div>"  
        $("##{id}").after(div_message)
      message_warning: (id,titre,message) ->
        div_message = '<div class="alert alert-warning" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        if titre != ""
           div_message += "<h4> #{titre} </h4>"
        if message != ""
          div_message += "<p> #{message} </p>"
        div_message += "</div>"  
        $("##{id}").after(div_message)
      message_error: (id,titre,message) ->
        div_message = '<div class="alert alert-error" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        if titre != ""
           div_message += "<h4> #{titre} </h4>"
        if message != ""
          div_message += "<p> #{message} </p>"
        div_message += "</div>"  
        $("##{id}").after(div_message)

  #____________________________________________ FUNCTION POUR FORM SE CONNECTER ________________________  
  form_se_connecter =
      display : ->
          $('#l_se_connecter').fadeIn(1000)
      hide: ->
          $('#l_se_connecter').css('display','none')
      ajax_formulaire: ->
          $('#form_se_connecter').bind('ajax:success', (data,response) ->
            console.log(response)
            message_information.message_success("form_se_connecter","Success",response.message)
          )
          $('#form_se_connecter').bind('ajax:error', (data,response) ->
            console.log(data)
            console.log(response)
            message_information.message_error("form_se_connecter","Erreur",response.responseText)
          )
   
  #____________________________________________ FUNCTION POUR FORM S'INSCRIRE ________________________ 
  form_sinscrire =
      init: ->
        form_sinscrire.ajax_formulaire()
        form_sinscrire.form_event()
        form_sinscrire.email_existant()
      display : ->
          $('#l_sinscrire').fadeIn(1000)
      hide: ->
          $('#l_sinscrire').css('display','none')
      ajax_formulaire : -> 
          $('#form_sinscrire').bind('ajax:success', (data,response) ->
              console.log(data)
              message_information.message_success("form_sinscrire","Success","Inscription réussi! Veuillez vous connectez maintenant")
          )
          $('#form_sinscrire').bind('ajax:error', (data,response) ->
            console.log(data)
            console.log(response)
            message_information.message_error("form_sinscrire","Erreur",response.responseText)
          )
      form_event: ->
          $('#form_sinscrire input#client_password_confirmation').bind('change',->
            form_sinscrire.verif_password()
          )  

      email_existant: ->
          $('#form_sinscrire input#client_email').bind('change', ->
          	$.ajax(
          	  type : "POST"
          	  url: "/clients/emailExist"
          	  data: {email : $(this).val()}
          	  success: (data) ->
          	      console.log(data)
          	      message_info = ""
          	      if data.exist == true
          	        message_info += "existe deja. <br/>"
          	      if data.good_format == false
          	        message_info += "ce n'est pas une adresse mail."
          	      if message_info != ""
          	       message_information.message_error("form_sinscrire #client_email","titre",message_info)  
          	)
          )
      verif_password : ->
          password = $('#form_sinscrire input#client_password').val()
          password_confirmation = $('#form_sinscrire input#client_password_confirmation').val()
          if password == password_confirmation
            message_information.message_success("form_sinscrire #client_password","","Mot de passe identique")
          else
            message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe different")
            console.log("client_password Erreur Mot de passe different")
      
  
  #__________________________ FUNCTION POUR FORM CHOIX SI INSCRIT OU PAS ________________________________________    
  form_areyouinscrit =
      init: ->
        form_areyouinscrit.change()
        if $('.is_inscrit:checked').val() != undefined
          form_areyouinscrit.event($('.is_inscrit:checked').val())
      change: ->
           $('.is_inscrit').bind('change', ->
               form_areyouinscrit.event($(this).val())
           )
      event: (val) ->
         	if val == "non"
         	  form_se_connecter.hide() 
         	  form_sinscrire.display() 
         	else if val == "oui"
         	  form_sinscrire.hide()
         	  form_se_connecter.display()
       
  #____________________________________________ AU CHARGEMENT DE LA PAGE ________________________
  form_se_connecter.ajax_formulaire()
  form_sinscrire.init()
  form_areyouinscrit.init()
  

)