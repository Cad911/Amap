# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(->
    cloud =
       "generate_big_cloud" : (nombre_nuage) ->
         nb_nuage = nombre_nuage #Math.floor(Math.random()*14)
         i = 0
         while i < nb_nuage
           top = Math.floor(Math.random()*80)
           left = 150 * i
           i++
           $('.big_clouds').append("<span class='cloud cloud_#{i}' style='position:absolute;top:#{top}px;left:#{left}px;'></span>")
           time_interval = cloud.random_perso(100,250)
           setInterval(cloud.move_cloud, time_interval, ".big_clouds .cloud_#{i}")
       "generate_little_cloud" : (nombre_nuage) ->
         nb_nuage = nombre_nuage #Math.floor(Math.random()*14)
         i = 0
         while i < nb_nuage
           top = Math.floor(Math.random()*80)
           left = 120 * i
           i++
           $('.little_clouds').append("<span class='cloud cloud_#{i}' style='position:absolute;top:#{top}px;left:#{left}px;'></span>")
           time_interval = cloud.random_perso(500,700)
           setInterval(cloud.move_cloud, time_interval, ".little_clouds .cloud_#{i}")
       "move_cloud": (class_cloud) ->
          taille_maxi = $(window).width()
          left_cloud = $(class_cloud).css('left')
          left_cloud = left_cloud.replace('px')
          if parseInt(left_cloud) < taille_maxi
            left_cloud = parseInt(left_cloud) + 1
          else
            left_cloud = 0
          $(class_cloud).css('left',left_cloud+'px')
       "random_perso":(min,max) ->
         var_random = Math.floor(Math.random()*max)
         if var_random < min
           cloud.random_perso(min,max)
         else
           var_random
         
         
    cloud.generate_big_cloud(2)
    cloud.generate_little_cloud(2) 
)

