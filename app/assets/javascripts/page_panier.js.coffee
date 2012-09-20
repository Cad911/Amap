# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
    
    show_panier_form =
        init: () ->
        	console
        id_basket: 0
        id_user: 0
        event: () ->
            show_panier_form.id_basket = $('#panier_id').val()
            show_panier_form.id_user = $('#panier_revendeur_id').val()
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
            $('#panier_declinaison_id').on('change',()->
                show_panier_form.change_price($(this).val())
            )
        
        change_price: (id_declinaison)->
        	$.ajax(
                type:"GET",
                url:'/administration/users/'+show_panier_form.id_user+'/paniers/'+show_panier_form.id_basket+'/get_declinaison/'+id_declinaison,
                format:"json",
                success : (data) ->
                    #console.log(html_before)
                    html_before = $('.l_content_right').find('.price.is_bold').children('span')
                    console.log(html_before[0])
                    $('.l_content_right').find('.price.is_bold').html(data['declinaison_panier']['prix_panier_ttc']+' € '+html_before[0]['outerHTML'])
            )
        sabonner : (id_,duree_) ->
            data_= {
                panier:{
                    id: id_
                    duree : duree_
                    declinaison_panier_id: $('#panier_declinaison_id').val()
                }
            }
            console.log(data_)
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
