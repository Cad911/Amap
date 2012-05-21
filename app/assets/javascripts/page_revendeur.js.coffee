# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(->
    #A REVOIR
    filter = 
       init: ->
          filter.event()
          console.log('test')
       event: ->
          $('.filter').bind('click', ->
          	if $(this).hasClass('show_product')
          	    if !filter.already_filter('show_product')
          	       filter.show_product()
          	else if $(this).hasClass('show_basket')
          	    if !filter.already_filter('show_basket')
          	       filter.show_basket()
          )
       already_filter: (class_id) ->
          if $('.'+class_id).hasClass('filter_active')
              $('.'+class_id).removeClass('filter_active')
              filter.show_all()
              return true
          else
             $('.'+class_id).addClass('filter_active')
             return false
       hide_product: ->
           $('.li_product').css('display','none')
       hide_basket: ->
           $('.li_basket').css('display','none')
       show_product: ->
           $('li').css('display','none')
           $('.li_product').css('display','block')
       show_basket: ->
           $('li').css('display','none')
           $('.li_basket').css('display','block')
       show_all: ->
           filter.show_product
           filter.show_basket
       
       
    filter.init()
       

)