# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(->
    cloud =
       "generate_big_cloud" : (nombre_nuage, min_speed, max_speed) ->
         nb_nuage = nombre_nuage #Math.floor(Math.random()*14)
         i = 0
         while i < nb_nuage
           top = Math.floor(Math.random()*80)
           left = 150 * Math.floor(Math.random()*9)
           i++
           $('.big_clouds').append("<span class='cloud cloud_#{i}' style='position:absolute;top:#{top}px;left:#{left}px;'></span>")
           time_interval = cloud.random_perso(min_speed,max_speed)
           cloud.move_cloud_2(".big_clouds .cloud_#{i}",time_interval)
           #setInterval(cloud.move_cloud, time_interval, ".big_clouds .cloud_#{i}")
       "generate_little_cloud" : (nombre_nuage, min_speed, max_speed) ->
         nb_nuage = nombre_nuage #Math.floor(Math.random()*14)
         i = 0
         while i < nb_nuage
           top = Math.floor(Math.random()*80)
           left = 120 * Math.floor(Math.random()*9)
           i++
           $('.little_clouds').append("<span class='cloud cloud_#{i}' style='position:absolute;top:#{top}px;left:#{left}px;'></span>")
           time_interval = cloud.random_perso(min_speed,max_speed)
           cloud.move_cloud_2(".little_clouds .cloud_#{i}",time_interval)
           #setInterval(cloud.move_cloud, time_interval, ".little_clouds .cloud_#{i}")
       "move_cloud": (class_cloud) ->
          taille_maxi = $(window).width() - $(class_cloud).width()
          left_cloud = $(class_cloud).css('left')
          left_cloud = left_cloud.replace('px')
          if parseInt(left_cloud) < taille_maxi
            left_cloud = parseInt(left_cloud) + 1
          else
            left_cloud = 0
          $(class_cloud).css('left',left_cloud+'px')
       "move_cloud_2": (class_cloud,duree) ->
         taille_maxi = $(window).width() - $(class_cloud).width()
         $(class_cloud).animate({
           left: taille_maxi+"px"
         },{
           duration : duree,
           easing: 'linear',
           complete : ->
             $(class_cloud).css('left','-150px')
             cloud.move_cloud_2(class_cloud,duree)
         })
       "random_perso":(min,max) ->
         var_random = Math.floor(Math.random()*max)
         if var_random < min
           cloud.random_perso(min,max)
         else
           var_random
   
   
   
   
    
    slider =
       "duration_fadeout":0
       "duration_fadein":0
       "duration_between":0
       "id_active":""
       "next_id_active":""
       "init": (duration_fadeout,duration_fadein,duration_between) ->
           slider.duration_fadeout = duration_fadeout
           slider.duration_fadein = duration_fadein
           slider.duration_between = duration_between
           setTimeout(slider.move_slide,slider.duration_between)
       "move_slide" : ->
           nb_slide = $('.container_slider>.slider').length
           slider.id_active = $('.container_slider>.active').attr('id')
           numero_slider = parseInt(slider.id_active.replace('slider_',''))
           
           if numero_slider == nb_slide
             slider.next_id_active = 'slider_1'
           else
             slider.next_id_active = 'slider_'+(numero_slider+1)
           
           slider.fade_out()
           slider.slide_out()
       
       "set_inactive":  ->
           $("##{slider.id_active}").removeClass('active')
           console.log(slider.id_active)
       
       "set_active":  ->
           if $("##{slider.next_id_active}>.content").length > 0
             $("##{slider.next_id_active}>.content").css('opacity','0')
           if $("##{slider.next_id_active}>.image").length > 0
             $("##{slider.next_id_active}>.image").css('margin-left','-5000px')       
           $("##{slider.next_id_active}").addClass('active')
           
           
           if $("##{slider.next_id_active}>.content").length > 0
             console.log('test')
             slider.fade_in()
           if $("##{slider.next_id_active}>.image").length > 0
             slider.slide_in()

       "fade_out":  ->
         $("##{slider.id_active}>.content").animate({
           	 opacity: "0"
         },{
               duration:slider.duration_fadeout
         })
       "fade_in" :  ->
           $("##{slider.next_id_active}>.content>.button").css('display','none')
           $("##{slider.next_id_active}>.content").animate({
           	 opacity: "1"
           },{
             duration :slider.duration_fadein
             complete : ->
                  $("##{slider.next_id_active}>.content>.button").fadeIn(1000)     
           }) 
       "slide_in": ->
            $("##{slider.next_id_active}>.image").animate({
           		marginLeft: "0px"
            },{
                duration :slider.duration_fadein+1000
                complete : ->
                   setTimeout(slider.move_slide,slider.duration_between)  
            }) 
       "slide_out":  ->
                 $("##{slider.id_active}>.image").animate({
           		    marginLeft: "-6000px"
                 },{
                    duration: slider.duration_fadeout
                    complete : ->
                      slider.set_inactive()
                      slider.set_active()
                 })
#____________________________________________________________________________________________________________________________
#____________________________________________________________________________________________________________________________
#________________________________ FONCTION POUR LE CAGEOT ___________________________________________________________________
#____________________________________________________________________________________________________________________________
#____________________________________________________________________________________________________________________________
    cageot = 
        in_process_order: false
        init: ->
            cageot.ajax_formulaire()
            cageot.event_form_generate(".l_dock_wrapper>ul>li")
            #__ SI ON EST DANS LE PROCESS ORDER ___
            if $('.l_process_order ').length > 0
                cageot.in_process_order = true
                cageot.hide_dock()
            #______________________________________
            if $('#form_add_product').length > 0
              cageot.form_event()
            if $('.add_product_link').length > 0
              cageot.event_button_add()
        #__POUR LES LIENS AUTRE QUE DANS LA PAGE SHOW PRODUCT
        event_button_add:->
            $('.add_product_link').bind('click', ->
                id_button = $(this).attr('id')
                id_produit = id_button.replace('product_','')
                cageot.add_product_ajax(id_produit)
            )
        #__POUR LES LIENS AUTRE QUE DANS LA PAGE SHOW, BASE VENANT DE LA PAGE SHOW AGRICULTEUR, GARDER LE MEME FORMAT
        add_product_ajax: (id_produit) ->
            data_ = {
              produit_vente_libre : {
                 id:id_produit,
                 nombre_pack:1
              }
            }
            $.ajax(
               type:"POST",
               data:data_,
               url:'/cageot/ajoutProduit',
               format:"json",
               success : (data) ->
                 if $('.dock').css('display') == 'none'
                   cageot.show_dock()
                 cageot.add(data)
                 cageot.update_html_price(data['total'])
            )
        form_event:()->
            $('#form_add_product #add_product').bind('click',->
                $('#form_add_product').submit()
            )
        event_form_generate:(class_id)->
        	$(class_id+'>span.deleted_p_c').bind('click',->
                console.log($(this).parent('li').attr('id'))
                cageot.delete($(this).parent('li').attr('id'))
            )
            $(class_id+'>div>span.plus_quantite_p_c').bind('click', ->
                cageot.plus_quantite($(this).parent('div').parent('li').attr('id'))
            )
            $(class_id+'>div>span.moins_quantite_p_c').bind('click', ->
                cageot.moins_quantite($(this).parent('div').parent('li').attr('id'))
            )
        ajax_formulaire : -> 
          $('#form_add_product').bind('ajax:success', (data,response) ->
              if response.error
                 all_error = form_sinscrire.extract_error(response.error,"")
              else
                console.log($('.dock').css('display'))
                if $('.dock').css('display') == 'none'
                   cageot.show_dock()
                cageot.add(response)
                cageot.update_html_price(response['total'])
          )
          $('#form_add_product').bind('ajax:error', (data,response) ->
            console.log(data)
            console.log(response)            
            message_information.message_error("form_sinscrire","Erreur",response.responseText)
          )
        add:(response) ->
             if response['statut'] == "add"
                    cageot.add_html_product_in_cageot(response['produit']['id'],response['produit']['nombre_pack'],response['url_image'])
                    cageot.event_form_generate(".l_dock_wrapper>ul>li##{response['produit']['id']}")
                 else
                    cageot.update_html_quantite(response['produit']['id'],response['produit']['nombre_pack'])
                    console.log('update')
        plus_quantite:(id_product) ->
            $.ajax(
               type:"GET",
               url:'/cageot/ajoutQuantite/'+id_product,
               format:"json",
               success : (data) ->
                   if data['statut'] == true
                     cageot.update_html_quantite(data['produit']['id'],data['produit']['nombre_pack'])
                     cageot.update_html_price(data['total'])
                     #____ RESUME PROCESS ORDER _______
                     if cageot.in_process_order
                         event_resume_p.update_html_quantite(data)
                         event_resume_p.update_html_price(data)
                     #__________________________________
            )
        moins_quantite:(id_product) ->
            $.ajax(
               type:"GET",
               url:'/cageot/suppQuantite/'+id_product,
               format:"json",
               success : (data) ->
                  if data['statut'] == "update"
                     cageot.update_html_quantite(data['produit']['id'],data['produit']['nombre_pack'])
                     #____ RESUME PROCESS ORDER _______
                     if cageot.in_process_order
                         event_resume_p.update_html_quantite(data)
                         event_resume_p.update_html_price(data)
                     #_________________________________
                  else if data['statut'] == "delete"
                      $('li#'+id_product).remove()
                      #____ RESUME PROCESS ORDER _______
                      if cageot.in_process_order
                         event_resume_p.delete_quantity(data)
                         event_resume_p.update_html_price(0)
                      #_________________________________
                  else
                  
                  cageot.verif_if_product_present(data['total'])
            )
        delete:(id_product)->
            $.ajax(
               type:"DELETE",
               url:'/cageot/suppProduit/'+id_product,
               format:"json",
               success : (data) ->
                  if data['statut'] == true
                      $('li#'+id_product).remove()
                      cageot.verif_if_product_present(data['total'])
                  else
                      #alert(data[2])
            )
        verif_if_product_present : (total_price) ->
            if $('.dock ul>li').length == 0
                 cageot.hide_dock()
                 cageot.update_html_price(0)
             else
                 cageot.update_html_price(total_price)
        update_html_price: (price) ->
            tab_price = (price+'').split('.')
            if tab_price[1]
                if parseInt(tab_price[1]) == 0
                    price = tab_price[0]
            $('.checkout>.price').text(price+'€')
        add_html_product_in_cageot: (id_product,nb_pack,url_image) ->
            new_li = $(document.createElement('li'))
            new_li.attr('id',id_product)
            
            if url_image != null
              src_image = url_image['image']['is_small']['url']
            else
              src_image = ''
            new_image = $(document.createElement('img'))
            new_image.addClass('has_corners_shadow is_small')
            new_image.attr('src',src_image)
            
            new_nombre_pack = $(document.createElement('span'))
            new_nombre_pack.addClass("nombre_pack_p_c")
            new_nombre_pack.text(nb_pack)
            
            new_delete = $(document.createElement('span'))
            new_delete.addClass("deleted_p_c")
            
            new_div_plus_quantite = $(document.createElement('div'))
            new_div_plus_quantite.addClass('plus_btn')
            new_span_plus_quantite = $(document.createElement('span'))
            new_span_plus_quantite.addClass('plus_quantite_p_c')
            new_div_plus_quantite.append(new_span_plus_quantite)
            
            new_div_minus_quantite = $(document.createElement('div'))
            new_div_minus_quantite.addClass('minus_btn')
            new_span_minus_quantite = $(document.createElement('span'))
            new_span_minus_quantite.addClass('moins_quantite_p_c')
            new_div_minus_quantite.append(new_span_minus_quantite)
            
            new_li.append(new_image)
            new_li.append(new_nombre_pack)
            new_li.append(new_delete)
            new_li.append(new_div_plus_quantite)
            new_li.append(new_div_minus_quantite)
            
            #li_html =  '<li id="'+id_product+'"><img src="'+url_image['image']['is_small']['url']+'" class="has_corners_shadow is_small">'
            #li_html += '<span class="nombre_pack_p_c"> '+nb_pack+' </span> <span class="deleted_p_c"> deleted </span>'
            #li_html += '<span class="plus_quantite_p_c"> + </span><span class="moins_quantite_p_c"> - </span>'
            #li_html += '</li>'
            $('.l_dock_wrapper>ul').prepend(new_li)
        update_html_quantite:(id_product, nb_pack) ->
            console.log('quantite_ :'+id_product)
            $('.l_dock_wrapper>ul>li#'+id_product+'>span.nombre_pack_p_c').text(nb_pack)
        show_dock: ->
            $('.dock').slideDown(400,"swing")
        hide_dock: ->
            $('.dock').slideUp(400,'swing')
        

    #______________________________________________________________________________________________________________________________
    #______________________________________________________________________________________________________________________________
    #_____________________ ANIMATION MOVE RIGHT , MOVE LEFT .. ____________________________________________________
    #______________________________________________________________________________________________________________________________
    #______________________________________________________________________________________________________________________________
    animation_display = 
       margin_: 0
       opacity_debut: 1 
       init: (opacity_debut, margin_, au_chargement_page = true) ->
           animation_display.margin_ = margin_
           animation_display.opacity_debut = opacity_debut
           
           animation_display.init_style()
           if au_chargement_page
               animation_display.show_all()
           else
               animation_display.verif_scroll()
               animation_display.see_div()
       init_style: () ->
           #__ MOVE LEFT ____
           if $('.move_left').length > 0
               if $('.move_left').css('margin-right') == "" && $('.move_left').css('margin') == ""
                   $('.move_left').css('margin-right','0px')
               if $('.move_left').css('margin-right') == "" && $('.move_left').css('margin') != ""
                   all_margin = $('.move_left').css('margin').split(' ')
                   $('.move_left').css('margin-right',all_margin[1])
               
               actual_position = parseInt(($('.move_left').css('margin-right')).replace('px'))
               new_position = (actual_position - animation_display.margin_)+'px'
           
               $('.move_left').css('margin-right',new_position)
               $('.move_left').css('opacity',animation_display.opacity_debut)
               
               
           #__ MOVE RIGHT ____
           if $('.move_right').length > 0
             $('.move_right').each(->
               if $(this).css('margin-left') == "" && $(this).css('margin') == ""
                   $(this).css('margin-left','0px')
               if $(this).css('margin-left') == "" && $(this).css('margin') != ""
                   all_margin = $(this).css('margin').split(' ')
                   if all_margin[3]!= undefined
                       $(this).css('margin-left', all_margin[3])
                   else
                       $(this).css('margin-left', all_margin[1])
                   
               actual_position = parseInt(($(this).css('margin-left')).replace('px'))
               new_position = (actual_position - animation_display.margin_)+'px'
               console.log(new_position)
              
               $(this).css('margin-left',new_position)
               $(this).css('opacity',animation_display.opacity_debut)
             )
               
           #__ MOVE BOTTOM ____
           if $('.move_bottom').length > 0 
               if $('.move_bottom').css('margin-top') == "" && $('.move_bottom').css('margin') == ""
                   $('.move_bottom').css('margin-top','0px')
               if $('.move_bottom').css('margin-top') == "" && $('.move_bottom').css('margin') != ""
                   all_margin = $('.move_bottom').css('margin').split(' ')
                   if all_margin[3]!= undefined
                       $('.move_bottom').css('margin-top', all_margin[3])
                   else
                       $('.move_bottom').css('margin-top', all_margin[1])
                   
               actual_position = parseInt(($('.move_bottom').css('margin-top')).replace('px'))
               new_position = (actual_position - animation_display.margin_)+'px'
              
               $('.move_bottom').css('margin-top',new_position)
               $('.move_bottom').css('opacity',animation_display.opacity_debut)
               
           #__ MOVE TOP ____
           if $('.move_top').length > 0 
               if $('.move_top').css('margin-top') == "" && $('.move_top').css('margin') == ""
                   $('.move_top').css('margin-top','0px')
               if $('.move_top').css('margin-top') == "" && $('.move_top').css('margin') != ""
                   all_margin = $('.move_top').css('margin').split(' ')
                   if all_margin[3]!= undefined
                       $('.move_top').css('margin-top', all_margin[3])
                   else
                       $('.move_top').css('margin-top', all_margin[1])
                   
               actual_position = parseInt(($('.move_top').css('margin-top')).replace('px'))
               new_position = (actual_position + animation_display.margin_)+'px'
              
               $('.move_top').css('margin-top',new_position)
               $('.move_top').css('opacity',animation_display.opacity_debut)
       see_div: (margin_) ->
           $(document).scroll(->
               animation_display.verif_scroll()
           )
       verif_scroll: () ->
           $('.move_left,.move_right,.move_top,.move_bottom').each(->
                   #POSITION .MOVE PAR RAPPORT AU DOC
                   offset = $(this).offset()
                   #POSITION DU HAUT ET DU BAS DE LA DIV move
                   position_haut_div = offset.top #POSITION HAUT
                   position_bas_div = offset.top +  $(this).height() #POSITION BAS
                   #SCROLLTOP = position dans le document en haut de la fenetre, on y ajoute donc la taille de la fenetre pour avoir la position du document en bas de la fenetre
                   position_document_bas = $(document).scrollTop() + $(window).height() #POSITION Bas DOC
                   position_document_haut = $(document).scrollTop() #POSITION HAUT DOC
                   
                   #position_document_min < position_haut_div < position_document_max
                   # < position_bas_div < position_document_max
                   
                   if (position_document_bas > position_haut_div && position_haut_div > position_document_haut) && (position_document_bas > position_bas_div && position_bas_div > position_document_haut)
                     if $(this).hasClass('move_left')
                         animation_display.move_to_left(this)
                     if $(this).hasClass('move_right')
                         animation_display.move_to_right(this)
                     if $(this).hasClass('move_bottom')
                         animation_display.move_to_bottom(this)
                     if $(this).hasClass('move_top')
                         animation_display.move_to_top(this)
               )
       show_all: () ->
           $('.move_left').each(->
               animation_display.move_to_left(this)
           )
           $('.move_right').each(->
               animation_display.move_to_right(this)
           )
           $('.move_bottom').each(->
               animation_display.move_to_bottom(this)
           )
           $('.move_top').each(->
               animation_display.move_to_top(this)
           )
       move_to_left: (element = '.move_left') ->
           if !$(element).hasClass('move_done')           
               $(element).addClass('move_done')
               $(element).animate({
                  marginRight: '+='+animation_display.margin_+'px'
                  opacity:1
               },{
                  duration : 1500,
                  easing: 'swing'
               })
       move_to_right: (element = '.move_right') ->
           if !$(element).hasClass('move_done') 
               $(element).addClass('move_done')
               $(element).animate({
                   marginLeft: '+='+animation_display.margin_+'px'
                   opacity:1
               },{
                  duration : 1500,
                  easing: 'swing'
               })     
       move_to_bottom:(element = '.move_bottom') ->
           if !$(element).hasClass('move_done') 
               $(element).addClass('move_done')
               $(element).animate({
                   marginTop: '+='+animation_display.margin_+'px'
                   opacity:1
               },{
                  duration : 1500,
                  easing: 'swing'
               })    
       move_to_top:(element = '.move_top') ->
           if !$(element).hasClass('move_done') 
               $(element).addClass('move_done')
               $(element).animate({
                   marginTop: '-='+animation_display.margin_+'px'
                   opacity:1
               },{
                  duration : 1500,
                  easing: 'swing'
               })    
              
     
    #_____ EVENT PROCESS ORDER PAGE RESUME _________________________________________________________________       
    event_resume_p = 
      event : () ->
          
          $('.price>div.close_square').bind('click',->
              produit_id = ($(this).parent('div').parent('div').parent('div').attr('id')).replace('raw_','')
              event_resume_p.delete_quantity(produit_id)
          )
          $('.quantity>span.plus').bind('click', ->
              produit_id = parseInt(($(this).parent('div').parent('div').parent('div').attr('id')).replace('raw_','')) 
              event_resume_p.plus_quantity(produit_id)
          )
          $('.quantity>span.minus').bind('click', ->
              produit_id = ($(this).parent('div').parent('div').parent('div').attr('id')).replace('raw_','')              
              event_resume_p.minus_quantity(produit_id)
          )
      plus_quantity: (produit_id) ->
          cageot.plus_quantite(produit_id)
      minus_quantity: (produit_id) ->
          cageot.moins_quantite(produit_id)
      delete_quantity: (produit_id) ->
          cageot.delete(produit_id)
          $('#raw_'+produit_id).animate({
              marginLeft : '-1000px'
          },{
              duration:1000,
              complete: ->
                  $(this).remove()
                  event_resume_p.verif_si_product()
          })
      verif_si_product: () ->
          if $('.raw').length == 0
              $('.products').append('<li class="raw"> Aucun produit </li>')
      update_html_quantite: (data) ->
          $('#raw_'+data['produit']['id']+'>.l_photo_description>.quantity>.sum').text(data['produit']['nombre_pack'])
      update_html_price : (data) ->
          $('.total>p').text('Total '+data['total']+' €')
       
       
   
   #  #________________________________________ METTRE LA DIV DE LINPUT AVEC ERREUR - WARNING ______________________________
#     div_state =
#       div_success:(element,message) ->
#           div_state.remove_class(element,'warning','error')
#           element.parent().parent().addClass('success')
#           div_state.write_message(element,message)   
#       div_warning: (element,message) ->
#           div_state.remove_class(element,'success','error')
#           element.parent().parent().addClass('warning')
#           div_state.write_message(element,message)   
#       div_error :(element,message) ->
#           div_state.remove_class(element,'success','warning')
#           element.parent().parent().addClass('error')
#           div_state.write_message(element,message)
#       remove_class:(element,class1,class2) ->
#           element.parent().parent().removeClass(class1)
#           element.parent().parent().removeClass(class2)
#       write_message:(element,message) ->
#           if element.next('.help-inline').length > 0
#             element.next('.help-inline').text(message)
#           else
#             element.after('<span class="help-inline">'+message+'</span>')
#     #____________________________________________ FUNCTION POUR AFFICHAGE DES MESSAGE D'INFORMATION ________________________
#     message_information =
#       message_success: (id,titre,message) ->
#         div_message = '<div class="alert alert-success" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
#         message_information.content_message(id,titre,message,div_message)
#       message_warning: (id,titre,message) ->
#         div_message = '<div class="alert alert-warning" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
#         message_information.content_message(id,titre,message,div_message)
#       message_error: (id,titre,message) ->
#         div_message = '<div class="alert alert-error" style="display:block;"><a class="close" data-dismiss="alert">x</a>'
#         message_information.content_message(id,titre,message,div_message)
#       content_message: (id,titre,message,div_message) ->
#         if titre != ""
#            div_message += "<strong> #{titre} </strong>"
#         if message != ""
#           div_message += "#{message}"
#         div_message += "</div>"  
#         $("##{id}").after(div_message)

   
    #____________________________ EVENT SIGN_IN SIGN_UP BUTTON ______________________________
    
    #lightbox_connexion = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_connexion')
    #lightbox_inscription = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_inscription')
    #light_box_information = new Lightbox('.lightbox_information')
    
    $('.sign_up,.sign_in').bind 'click',  ->
               if !$(this).hasClass('connected') and $(this).hasClass('sign_up') #SI PAS CONNECTER ET BOUTON SIGN UP
                   lightbox_connexion.hide_sous_div()
                   lightbox_inscription.show()
                   lightbox_inscription.show_sous_div()
               if !$(this).hasClass('connected') and $(this).hasClass('sign_in')
                   lightbox_inscription.hide_sous_div()
                   lightbox_connexion.show()
                   lightbox_connexion.show_sous_div()
    
    #____________________________________________________________________________________________
   
    #___________________________ EVENT FORM INSCRIPTION/CONNEXION LIGHTBOX __________________________
    formulaire_inscription = new FormulaireSinscrire('#form_sinscrire_lightbox','#lightbox_sign_up')
    formulaire_seconnecter = new FormulaireSeConnecter('#form_se_connecter_lightbox','#lightbox_sign_in')
    #_______________________________________________________   
      
       
    
    
    #______________________ LIGHTBOX INFOS ______________
    
    #     init: () ->
#         
#         event: () ->
#             $('.close_lightbox>a').bind('click', ->
#                 light_box_information.hide($(this).parent('span').parent('div').parent('div').parent('div'))
#             )
#         show: (element) ->
#             $(element).css('display','block')
#         hide: (element) ->
#             $(element).css('display','none')
#         title_header: (texte) ->
#             $('.lightbox_information>.lightbox>.header>.title').text(texte)
#         title_content: (texte) ->
#             $('.lightbox_information>.lightbox>.content>.title').text(texte)
#         text_content:(texte) ->
#             $('.lightbox_information>.lightbox>.content>p').text(texte)
    
    #light_box_information.event()  
       
    #______ INIT ALL ____________________________________________________
    #__ NOMBRE NUAGE , TEMPS MINIMUM VOULU, TEMPS MAXIMUM VOULU
    cloud.generate_big_cloud(2,120000,140000)
    cloud.generate_little_cloud(2, 150000,180000)
    
    #__VAR : DURATION_FADEOUT, DURATION FADE IN,DURATION BETWEEN TWO SLIDE
    slider.init(1000,1000,5000)
    cageot.init()
    
    #___ OPACITY,MARGIN,AU CHARGEMENT DE LA PAGE ____
    #animation_display.see_div()
    animation_display.init(0.7,20,false)
    event_resume_p.event() 

)

