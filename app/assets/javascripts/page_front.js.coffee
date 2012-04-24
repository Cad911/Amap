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
           left = 150 * i
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
           left = 120 * i
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
         
    #__ NOMBRE NUAGE , TEMPS MINIMUM VOULU, TEMPS MAXIMUM VOULU
    cloud.generate_big_cloud(2,60000,70000)
    cloud.generate_little_cloud(2, 90000,100000) 

)

