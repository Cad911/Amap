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
      content_message : (id,titre,message,time,class_to_add,type) ->
          #console.log(id)
          div = $(document.createElement('div'))
          div.addClass('alert alert-'+type)
          if class_to_add != false
              div.addClass(class_to_add)
          div.css('display','block')
          
          a = $(document.createElement('a'))
          a.addClass('close')
          a.attr('data-dismiss','alert')
          a.text('x')
          
          div.append(a)
          
          if titre != ""
              strong = $(document.createElement('strong'))
              strong.text(titre)
              div.append(strong)
          if message != ""
              div.append(message)
          console.log(div)
          $("#{id}").after(div)
          
          #__ TEMPS DEFINI POUR DISPARITION DU MESSAGE DINFO
          if time != 0
              setTimeout(message_information.hide_message,time, div)
              
      hide_message: (div) ->
          div.animate({
              opacity:0    
          },{
              duration:1000,
              complete: () ->
                  $(this).remove()
          })
                
      message_success: (id,titre,message,time = 0, class_to_add = false) ->
        message_information.content_message(id,titre,message, time, class_to_add, 'success')
      message_warning: (id,titre,message,time = 0, class_to_add = false) ->
        message_information.content_message(id,titre,message, time, class_to_add, 'warning')
      message_error: (id,titre,message,time = 0, class_to_add = false) ->
        message_information.content_message(id,titre,message, time, class_to_add, 'error')