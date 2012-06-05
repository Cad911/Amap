#_________________________________________ FORMULAIRE SE CONNECTER _______________________________
$(document).ready(->
    class window.FormulaireSeConnecter
        constructor: (@id_form,@id_button_submit,@info_by_lightbox = true ) ->
            @ajax_formulaire()
            @event_form()
            
        ajax_formulaire : () ->
            that = this
            $(@id_form).bind('ajax:success', (data,response) ->
                #console.log(response)
                lightbox_connexion.link_top(response)
                lightbox_connexion.hide()
                
                if @info_by_lightbox     
                    light_box_information.title_header('Success')
                    light_box_information.title_content('Connexion reussi')
                    light_box_information.text_content('Bonjour '+response['user']['prenom'])
                    light_box_information.show()
                
            )
          
            $(@id_form).bind('ajax:error', (data,response) ->
                console.log('test-erreur-seconnecter')
                message_information.message_error(that.id_form,"Erreur",response.responseText)
            )
        extract_error :(error,text_error) ->
            for champ, type_erreur of error 
              if typeof type_erreur == "array"
                 light_box_form_inscription.extract_error(type_erreur,text_error)
              else
                 text_error += "<br/><strong> #{champ}</strong> #{type_erreur}"
            text_error   
        
        event_form: () ->
            that = this
            #___ SUBMIT FORM ___
            $(@id_button_submit).bind('click', () ->
                    $(that.id_form).submit()
            )
            
            $(@id_form+' input#client_email').change(->
                that.format_email()
            )
            
        format_email: () -> # RENVOI TRUE SI EMAIL EXISTANT
          	that = this
          	@erreur = false
          	$.ajax(
          	  type : "POST"
          	  async: false,
          	  url: "/clients/emailExist"
          	  data: {email : $(@id_form+' input#client_email').val()}
          	  success: (data) ->
          	      message_info = ""
          	      if data.good_format == false
          	        message_info += "ce n'est pas une adresse mail."
          	      else if data.exist == false
          	        message_info += "Email n'existe pas dans notre base"
          	      
          	      
          	      if message_info != ""
          	         div_state.div_error($(that.id_form+' #client_email'),message_info)
          	         #message_information.message_error(that.id_form+" #client_email","titre",message_info)
          	         @erreur = true
          	         console.log(that.id_form)
          	      else
          	         div_state.div_success($(that.id_form+' #client_email'),message_info)
          	)             
          	@erreur

        show: ()->
            $(@id_form).css('display','block')
        hide: ()->
            $(@id_form).css('display','none')
   #_________________________________________________________________________
)