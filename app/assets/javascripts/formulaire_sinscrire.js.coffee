#____________________________________________ FORMULAIRE S INSCRIRE _______________________________
$(document).ready(->
    class window.FormulaireSinscrire
        constructor: (@id_form,@id_button_submit, @info_by_lightbox = true) ->
            @erreur = false
            @ajax_formulaire()
            @event_form()
        ajax_formulaire : () ->
            $(@id_form).bind('ajax:success', (data,response) ->
                console.log('sinscrire')
                console.log(response)
                lightbox_inscription.link_top(response)
                lightbox_inscription.hide()
               
                if @info_by_lightbox
                    light_box_information.title_header('Success')
                    light_box_information.title_content('Connexion reussi')
                    light_box_information.text_content('Bonjour '+response['user']['prenom'])
                    light_box_information.show('.lightbox_information')
            )
          
            $(@id_form).bind('ajax:error', (data,response) ->
                console.log(data)
                console.log(response)
                console.log('test-erreur-sinscrire')
            )
            
        extract_error :(error,text_error) ->
            for champ, type_erreur of error 
              if typeof type_erreur == "array"
                 #light_box_form_inscription.extract_error(type_erreur,text_error)
              else
                 text_error += "<br/><strong> #{champ}</strong> #{type_erreur}"
            text_error   

        event_form: () ->
            that = this
            #___ SUBMIT FORM ___
            $(@id_button_submit).bind('click', () ->
                that.verif_all_valid()
                if that.erreur == false
                  console.log('tout est ok')
                  $(that.id_form).submit()
                  #form_sinscrire.hide()
                  
            )
            
            $(@id_form+' input#client_password_confirmation').bind('keyup',->
                that.password_different()
            )
            $(@id_form+' input#client_email').bind('change', ->
                that.email_existant()
            )
            $(@id_form+' input').bind('change', ->
                that.input_is_empty("##{$(this).attr('id')}")
            )
            
        verif_all_valid: () ->
            @erreur = false
            if @verif_all_input()
                alert('Certain champ sont vide')
                @erreur = true

            if @password_different()
                @erreur = true
            
            @email_existant()            
            #return erreur
            
        email_existant: () -> # RENVOI TRUE SI EMAIL EXISTANT
          	that = this
          	@erreur = false
          	$.ajax(
          	  type : "POST"
          	  async: false,
          	  url: "/clients/emailExist"
          	  data: {email : $(@id_form+' input#client_email').val()}
          	  success: (data) ->
          	      message_info = ""
          	      if data.exist == true
          	        message_info += "existe deja"
          	      if data.good_format == false
          	        message_info += "ce n'est pas une adresse mail."
          	      
          	      
          	      if message_info != ""
          	         div_state.div_error($(that.id_form+' #client_email'),message_info)
          	         #message_information.message_error(that.id_form+" #client_email","titre",message_info)
          	         that.erreur = true
          	         console.log(that.id_form)
          	      else
          	         div_state.div_success($(that.id_form+' #client_email'),message_info)
          	)             
          	@erreur
          	
        password_different : -> #RENVOI TRUE SI MDP  DIFFERENT
          password = $(@id_form+' input#client_password').val()
          password_confirmation = $(@id_form+' input#client_password_confirmation').val()
          if password == password_confirmation
            if password == ""
              div_state.div_warning($(@id_form+' #client_password'),"Mot de passe vide")
              #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe vide")
              true
            else if password.length < 6
              div_state.div_warning($(@id_form+' #client_password'),"Mot de passe trop court (plus de 6 caractere)")
              #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe trop court (plus de 6 caractere)")
              true
            else
              div_state.div_success($(@id_form+' #client_password'),"Mot de passe identique")
              #message_information.message_success("form_sinscrire #client_password","","Mot de passe identique")
              false
          else
            div_state.div_warning($(@id_form+' #client_password'),"Mot de passe different")
            #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe different")
            true
            
        verif_all_input : -> #RENVOI TRUE SI 1 CHAMP VIDE
          champ_vide = false
          $(@id_form+' input').each(->
              if ($(this).val() == "")
                 $(this).css('border','1px solid red')
                 champ_vide = true
                 console.log("1");
          )
          champ_vide
         
        input_is_empty : (id_input) ->
          if $(id_input).val() == ""
            $(id_input).css('border','1px solid red')
            true
          else
            $(id_input).css('border','1px solid #CCCCCC')
            false


        show: ()->
            $(@id_form).css('display','block')
        hide: ()->
            $(@id_form).css('display','none')
   #______________________________________________________________________________________________   
   # module.exports = FormulaireSinscrire
)
