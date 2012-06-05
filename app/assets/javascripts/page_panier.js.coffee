# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
    
    show_panier_form =
        init: () ->
        
        event: () ->
            $('.add_basket_link').on('click', ()->
                    show_panier_form.sabonner($('#panier_id').val(), $('#panier_duree').val())
                            
            )
            $('.add_basket_link_revendeur').on('click', ()->
                    id_basket = ($(this).attr('id')).replace('basket_','')
                    show_panier_form.sabonner(id_basket, $(this).parent('.call_to_action').children('p>#panier_duree').val())
                            
            )
            $('.li_basket').on('hover', ()->
                    $(this).find('.pursache .call_to_action>p').css('display','block')        
            )
            $('.li_basket').on('mouseleave', ()->
                    $(this).find('.pursache .call_to_action>p').css('display','none')        
            )
        sabonner : (id_,duree_) ->
            data_= {
                panier:{
                    id: id_
                    duree : duree_
                }
            }
                
            $.ajax(
                type:"POST",
                data:data_,
                url:'/abonnements/sabonner',
                format:"json",
                success : (data) ->
                    $(location).attr('href','/process_order/resume')
            )

          


    show_panier_form.event()


)
