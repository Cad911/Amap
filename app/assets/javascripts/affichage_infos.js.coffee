 #________________________________________ METTRE LA DIV DE LINPUT AVEC ERREUR - WARNING ______________________________
    window.div_state =
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
    #____________________________________________ FUNCTION POUR AFFICHAGE DES MESSAGE D'INFORMATION ________________________
    window.message_information =
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
        $("#{id}").after(div_message)
