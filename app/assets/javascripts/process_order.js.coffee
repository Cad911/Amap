# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(->
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
  
  form_se_connecter = ->
      $('#form_se_connecter').bind('ajax:success', (data,response) ->
        console.log(data)
        message_information.message_success("form_se_connecter","Success","Conexion réussi")
      )
      $('#form_se_connecter').bind('ajax:error', (data,response) ->
        console.log(data)
        console.log(response)
        message_information.message_error("form_se_connecter","Erreur",response.responseText)
      )
    
  form_sinscrire =
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
        $('#form_sinscrire input#client_email').bind('change',->
          form_sinscrire.email_existant()
        )

      email_existant: ->
        #a coder
      verif_password : ->
        password = $('#form_sinscrire input#client_password').val()
        password_confirmation = $('#form_sinscrire input#client_password_confirmation').val()
        if password == password_confirmation
          message_information.message_success("form_sinscrire #client_password","","Mot de passe identique")
        else
          message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe different")
          console.log("client_password Erreur Mot de passe different")
      
      
  

  form_se_connecter()
  form_sinscrire.ajax_formulaire()
  form_sinscrire.form_event()

)