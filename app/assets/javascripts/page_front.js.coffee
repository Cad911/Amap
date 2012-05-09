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


           
         
    #__ NOMBRE NUAGE , TEMPS MINIMUM VOULU, TEMPS MAXIMUM VOULU
    cloud.generate_big_cloud(2,120000,140000)
    cloud.generate_little_cloud(2, 150000,180000)
    #__VAR : DURATION_FADEOUT, DURATION FADE IN,DURATION BETWEEN TWO SLIDE
    slider.init(1000,1000,5000) 

)

