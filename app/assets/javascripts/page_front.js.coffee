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
        init: ->
            cageot.form_event()
            cageot.ajax_formulaire()
        form_event:()->
            $('#form_add_product #add_product').bind('click',->
                $('#form_add_product').submit()
            )
            cageot.event_form_generate(".l_dock_wrapper>ul>li")
        event_form_generate:(class_id)->
        	$(class_id+'>span.deleted_p_c').bind('click',->
                console.log($(this).parent('li').attr('id'))
                cageot.delete($(this).parent('li').attr('id'))
            )
            $(class_id+'>span.plus_quantite_p_c').bind('click', ->
                cageot.plus_quantite($(this).parent('li').attr('id'))
            )
            $(class_id+'>span.moins_quantite_p_c').bind('click', ->
                cageot.moins_quantite($(this).parent('li').attr('id'))
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
                    cageot.add_html_product_in_cageot(response['produit']['id'],response['produit']['nombre_pack'])
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
            )
        moins_quantite:(id_product) ->
            $.ajax(
               type:"GET",
               url:'/cageot/suppQuantite/'+id_product,
               format:"json",
               success : (data) ->
                  if data['statut'] == "update"
                     cageot.update_html_quantite(data['produit']['id'],data['produit']['nombre_pack'])
                  else if data['statut'] == "delete"
                      $('li#'+id_product).remove()
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
            $('.checkout>.price').text(price+'€')
        add_html_product_in_cageot: (id_product,nb_pack) ->
            li_html =  '<li id="'+id_product+'"><img src="" class="has_corners_shadow is_small">'
            li_html += '<span class="nombre_pack_p_c"> '+nb_pack+' </span> <span class="deleted_p_c"> deleted </span>'
            li_html += '<span class="plus_quantite_p_c"> + </span><span class="moins_quantite_p_c"> - </span>'
            li_html += '</li>'
            $('.l_dock_wrapper>ul').prepend(li_html)
        update_html_quantite:(id_product, nb_pack) ->
            $('.l_dock_wrapper>ul>li#'+id_product+'>span.nombre_pack_p_c').text(nb_pack)
        show_dock: ->
            $('.dock').slideDown(400,"swing")
        hide_dock: ->
            $('.dock').slideUp(400,'swing')
        



    
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
               if $('.move_right').css('margin-left') == "" && $('.move_right').css('margin') == ""
                   $('.move_right').css('margin-left','0px')
               if $('.move_right').css('margin-left') == "" && $('.move_right').css('margin') != ""
                   all_margin = $('.move_right').css('margin').split(' ')
                   if all_margin[3]!= undefined
                       $('.move_right').css('margin-left', all_margin[3])
                   else
                       $('.move_right').css('margin-left', all_margin[1])
                   
               actual_position = parseInt(($('.move_right').css('margin-left')).replace('px'))
               new_position = (actual_position - animation_display.margin_)+'px'
              
               $('.move_right').css('margin-left',new_position)
               $('.move_right').css('opacity',animation_display.opacity_debut)
               
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
              
     
           
         
    #__ NOMBRE NUAGE , TEMPS MINIMUM VOULU, TEMPS MAXIMUM VOULU
    cloud.generate_big_cloud(2,120000,140000)
    cloud.generate_little_cloud(2, 150000,180000)
    
    #__VAR : DURATION_FADEOUT, DURATION FADE IN,DURATION BETWEEN TWO SLIDE
    slider.init(1000,1000,5000)
    cageot.init()
    
    #___ OPACITY,MARGIN,AU CHARGEMENT DE LA PAGE ____
    #animation_display.see_div()
    animation_display.init(0.5,20,false)

)

