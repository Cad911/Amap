# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(->
  #________ PAGE RESUME _______________
  #__DANS PAGE FRONT CAR EN RELATION AVECE LE CAGEOT ___
    
  #____________________________________________ FUNCTION POUR AFFICHAGE DES MESSAGE D'INFORMATION ________________________
  message_information =
      message_success: (id,titre,message) ->
        div_message = '<div class="alert alert-success" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        message_information.content_message(id,titre,message,div_message)
      message_warning: (id,titre,message) ->
        div_message = '<div class="alert alert-warning" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        message_information.content_message(id,titre,message,div_message)
      message_error: (id,titre,message) ->
        div_message = '<div class="alert alert-error" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
        message_information.content_message(id,titre,message,div_message)
      content_message: (id,titre,message,div_message) ->
        if titre != ""
           div_message += "<strong> #{titre} </strong>"
        if message != ""
          div_message += "#{message}"
        div_message += "</div>"  
        $("##{id}").after(div_message)

  #________________________________________ METTRE LA DIV DE LINPUT AVEC ERREUR - WARNING __________________
  div_state =
      div_success:(element,message) ->
          div_state.remove_class(element,'warning','error')
          element.parent().parent().addClass('success')
          div_state.write_message(element,message)   
      div_warning: (element,message) ->
          div_state.remove_class(element,'success','error')
          element.parent().parent().addClass('warning')
          div_state.write_message(element,message)   
      div_error :(element,message) ->
          div_state.remove_class(element,'success','warning')
          element.parent().parent().addClass('error')
          div_state.write_message(element,message)
      remove_class:(element,class1,class2) ->
          element.parent().parent().removeClass(class1)
          element.parent().parent().removeClass(class2)
      write_message:(element,message) ->
          if element.next('.help-inline').length > 0
            element.next('.help-inline').text(message)
          else
            element.after('<span class="help-inline">'+message+'</span>')   
  #____________________________________________ FUNCTION POUR FORM SE CONNECTER ________________________  
  form_se_connecter =
      event: ()->
          $('#b_sign_in>a').bind('click', ->
          	    $('#form_se_connecter').submit()
          )
      display : ->
          $('#l_se_connecter').fadeIn(1000)
      hide: ->
          $('#l_se_connecter').css('display','none')
      ajax_formulaire: ->
          $('#form_se_connecter').bind('ajax:success', (data,response) ->
            console.log(response)
            message_information.message_success("l_select_pr",response.message,"")
            form_se_connecter.hide()
            select_connection.hide()
            submit_next_step.add_submit()
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
      display : ->
          $('#l_sinscrire').fadeIn(1000)
      hide: ->
          $('#l_sinscrire').css('display','none')
      ajax_formulaire : -> 
          $('#form_sinscrire').bind('ajax:success', (data,response) ->
              if response.error
                 all_error = form_sinscrire.extract_error(response.error,"")
                 message_information.message_error("form_sinscrire","Erreur",all_error)
              else
                 message_information.message_success("l_select_pr","Success","Inscription réussi! Vous êtes connecté!")
                 form_sinscrire.hide()
                 select_connection.hide()
                 submit_next_step.add_submit()
          )
          $('#form_sinscrire').bind('ajax:error', (data,response) ->
            message_information.message_error("form_sinscrire","Erreur",response.responseText)
          )
      extract_error :(error,text_error) ->
          for champ, type_erreur of error 
            if typeof type_erreur == "array"
               form_sinscrire.extract_error(type_erreur,text_error)
            else
               text_error += "<br/><strong> #{champ}</strong> #{type_erreur}"
          text_error    
      form_event: ->
          $('#form_sinscrire input#client_password_confirmation').bind('keyup',->
            form_sinscrire.password_different()
          )
          $('#form_sinscrire input#client_email').bind('change', ->
            form_sinscrire.email_existant($(this).val())
          )
          $('#form_sinscrire input').bind('change', ->
            form_sinscrire.input_is_empty("##{$(this).attr('id')}")
          )
          $('#form_sinscrire #b_sign_up').bind('click',->
            erreur = false
            if form_sinscrire.verif_all_input()
              alert('Certain champ sont vide')
              erreur = true
            if form_sinscrire.email_existant($('#form_sinscrire input#client_email').val())
              erreur = true
            if form_sinscrire.password_different()
              erreur = true
            
            if erreur == false
              console.log('tout est ok')
              $('#form_sinscrire').submit()
              #form_sinscrire.hide()
          )
      email_existant: (email_adresse) -> # RENVOI TRUE SI EMAIL EXISTANT
          	erreur = false
          	$.ajax(
          	  type : "POST"
          	  async: false,
          	  url: "/clients/emailExist"
          	  data: {email : email_adresse}
          	  success: (data) ->
          	      message_info = ""
          	      if data.exist == true
          	        message_info += "existe deja. <br/>"
          	      if data.good_format == false
          	        message_info += "ce n'est pas une adresse mail."
          	      
          	      if message_info != ""
          	         div_state.div_error($('#form_sinscrire #client_email'),message_info)
          	         #message_information.message_error("form_sinscrire #client_email","titre",message_info)
          	         erreur = true
          	      else
          	         div_state.div_success($('#form_sinscrire #client_email'),message_info)
          	)             
          	erreur
      password_different : -> #RENVOI TRUE SI MDP  DIFFERENT
          password = $('#form_sinscrire input#client_password').val()
          password_confirmation = $('#form_sinscrire input#client_password_confirmation').val()
          if password == password_confirmation
            if password == ""
              div_state.div_warning($('#form_sinscrire #client_password'),"Mot de passe vide")
              #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe vide")
              true
            else if password.length < 6
              div_state.div_warning($('#form_sinscrire #client_password'),"Mot de passe trop court (plus de 6 caractere)")
              #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe trop court (plus de 6 caractere)")
              true
            else
              div_state.div_success($('#form_sinscrire #client_password'),"Mot de passe identique")
              #message_information.message_success("form_sinscrire #client_password","","Mot de passe identique")
              false
          else
            div_state.div_warning($('#form_sinscrire #client_password'),"Mot de passe different")
            #message_information.message_warning("form_sinscrire #client_password","Erreur","Mot de passe different")
            true
      verif_all_input : -> #RENVOI TRUE SI 1 CHAMP VIDE
         champ_vide = false
         $('#form_sinscrire input').each(->
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
  


    
    
    submit_next_step = 
        init: ->
        event: ->
            $('#b_next_step>a').bind('click', ->
                console.log('test')
                if $('input[type=radio]:checked').length > 0
                    $('#form_select_pr').submit()
                else
                    alert('Veuillez choisir un point relai')
            )
        add_submit: ->
           if $('#footer_confirmation>span.next_step').length == 0
              $('#footer_confirmation').append('<span class="button next_step" id="b_next_step"><a> Procéder paiement</a></span>')
              submit_next_step.event()
        remove_submit: ->
           $('#form_select_pr>.actions').html('')
    

    #_________ SELECT POINT RELAI ____________________________________     
    select_pr =
        init: () ->
            select_pr.radio_box_checked()
            select_pr.event()
        event : ->
            $('li .radio').bind('click', ->
                select_pr.is_checked(this)
            )
        is_checked: (element) ->
            one_element_check = false
            $('li .radio').each(->
                if $(this).css('background-position') == '-16px -26px' #ONE CHECK
                    one_element_check = true
                    if this == element
                        select_pr.decheck(this)
                    else
                        select_pr.decheck(this)
                        select_pr.check(element)
                        return false
            )
            
            if !one_element_check
                select_pr.check(element)
        check: (element) ->
            $(element).css('background-position','-16px -26px')
            pr_id = (($(element).parent('div').parent('div').parent('div')).attr('id')).replace('pr_','')
            $('input[name="point_relai[id]"]').val([pr_id]);
      
        decheck: (element) ->
            $(element).css('background-position','0 -26px')
        radio_box_checked : () ->
           if $('input[type=radio]:checked').length > 0
               id_pr = $('input[type=radio]:checked').val()
               select_connection.check($('#pr_'+id_pr+'>div>.image>.radio'))


    #_________ BOX SELECTION INSCRIT OU PAS _______________
    select_connection =
        init : ->
            select_connection.event()
        event : ->
            $('.choice_registered .radio').bind('click', ->
                select_connection.is_checked(this)
            )
            $('#b_next_step').bind('click', ->
                if $('input[type=radio]:checked').length > 0
                    $('.l_select_pr').submit()
                else
                    alert('Veuillez choisir un point relai')
            )
        is_checked: (element) ->
            one_element_check = false
            $('.choice_registered .radio').each(->
                if $(this).css('background-position') == '-16px -26px' #ONE CHECK
                    one_element_check = true
                    if this == element
                        select_connection.decheck(this)
                    else
                        select_connection.decheck(this)
                        select_connection.check(element)
                        return false
            )
            if !one_element_check
                select_connection.check(element)
        check: (element) ->
            $(element).css('background-position','-16px -26px')
            if $(element).parent('div').parent('div').hasClass('yes')
                form_sinscrire.hide()
                form_se_connecter.display()
            else
                form_se_connecter.hide()
                form_sinscrire.display()
               
            #pr_id = (($(element).parent('div').parent('div').parent('div')).attr('id')).replace('pr_','')
            #$('input[name="point_relai[id]"]').val([pr_id]);
        decheck: (element) ->
            $(element).css('background-position','0 -26px')
        hide: ->
            $("#l_areyouinscrit").css('display','none')
            
            
  #____________________________________________ AU CHARGEMENT DE LA PAGE ________________________
  form_se_connecter.ajax_formulaire()
  form_sinscrire.init()
  select_pr.init()
  select_connection.init()
  submit_next_step.event()
  form_se_connecter.event()

)