# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(->            
    filter_ = 
          init: ->
          event: ->
              $('.filter').bind('click', ->
                  if $(this).hasClass('show_product')
                      filter_.delete_ul()
                      filter_.recup_product()
                      if filter_.already_filter('show_product')
                          filter_.recup_basket()
                      else
                          if $('.show_basket').hasClass('filter_active')
                              $('.show_basket').removeClass('filter_active')
                  if $(this).hasClass('show_basket')
                      filter_.delete_ul()
                      if filter_.already_filter('show_basket')
                          filter_.recup_product()
                      else
                          if $('.show_product').hasClass('filter_active')
                              $('.show_product').removeClass('filter_active')
                      filter_.recup_basket()
              )
          already_filter: (class_id) ->
              if $('.'+class_id).hasClass('filter_active')
                  $('.'+class_id).removeClass('filter_active')
                  return true
              else
                  $('.'+class_id).addClass('filter_active')
                  return false
          recup_product: ->
              data_ = {user_id:$('#user_id').val()}
              $.ajax(
                  type:"POST",
                  data:data_,
                  url:'/product_filter',
                  format:"json",
                  success : (data) ->
                      product = $.parseJSON(data)
                      i = 0
                      while i < product.length
                           filter_.reload_ul(filter_.create_li('product',product[i]))
                           i++
                      #console.log(all_li)
                      #filter_.reload_ul(all_li)
                      link_li.event('ul.farmers_products>li')
                      
              )
          recup_basket: ->
              data_ = {user_id:$('#user_id').val()}
              $.ajax(
                  type:"POST",
                  data:data_,
                  url:'/basket_filter',
                  format:"json",
                  success : (data) ->
                      product = $.parseJSON(data)
                      i = 0
                      while i < product.length
                           filter_.reload_ul(filter_.create_li('basket',product[i]))
                           i++
                      #console.log(all_li)
                      #filter_.reload_ul(all_li)
                      link_li.event('ul.farmers_products>li')
              )
          hide_li: ->
          show_li:->
          delete_ul: ->
             console.log('delete')
             $('.farmers_products').html('')
          reload_ul: (li) -> 
             $('ul.farmers_products').append(li)
          create_li: (category,data) ->
              li = $(document.createElement('li'))
              if category == 'product'
                  li.addClass('li_product')
              if category == 'basket'
                  li.addClass('li_basket')
              
              span_category = $(document.createElement('span'))
              span_category.addClass('category '+category)
              
              div_description = $(document.createElement('div'))
              div_description.addClass('l_photo_description is_horizontal')
              
              #IMAGE
              div_image = $(document.createElement('div'))
              div_image.addClass('image')
              
              div_issmall = $(document.createElement('div'))
              div_issmall.addClass('has_corners_shadow is_small')
              
              img = $(document.createElement('img'))
              img.attr('src',data['default_image'])
              
              div_image.append(div_issmall.append(img))
              
              #CONTENT
              div_content = $(document.createElement('div'))
              div_content.addClass('content')
              
              p_title = $(document.createElement('p'))
              p_title.addClass('title')
              p_title.text(data['titre'])
              
              p_descrption = $(document.createElement('p'))
              p_descrption.addClass('description')
              p_descrption.text(data['description'])
              
              div_content.append(p_title)
              div_content.append(p_descrption)
              
              #PURCHASE
              div_purchase = $(document.createElement('div'))
              div_purchase.addClass('purchase')
              
              span_price = $(document.createElement('span'))
              span_price.addClass('price')
              span_price.text(data['prix_unite_ttc']+' €')
              
              span_note = $(document.createElement('span'))
              span_note.addClass('note is_italic')
              if category == 'product'
                  span_note.text(' le '+data['unite_mesure'])
              if category == 'basket'
                  span_note.text(' pour '+data['nb_personne']+' personnes')
              
              div_call_toaction = $(document.createElement('div'))
              div_call_toaction.addClass('call_to_action')
              
              span_button = $(document.createElement('span'))
              span_button.addClass('button add_'+category+'_link')
              span_button.attr('id', category+'_'+data['id'])
              
              a_button = $(document.createElement('a'))
              a_button.text('ajouter au panier')
              
              div_call_toaction.append(span_button.append(a_button))
              div_purchase.append(span_price)
              div_purchase.append(span_note)
              div_purchase.append(div_call_toaction)
              
              #APPEND ALL IN DIV
              div_description.append(div_image)
              div_description.append(div_content)
              div_description.append(div_purchase)
              
              li.append(span_category)
              li.append(div_description)
              
              return li
              

              
    link_li =
        event: (li)->
            $(li).find('*').each ( () ->
                $(this).on('click', (event) ->
                    if $(this).hasClass('pursache')
                        event.stopImmediatePropagation()
                                 
                    if $(this).hasClass('pursache') or ($(this).parents('.pursache')).length > 0
                        true
                    else
                        if $(this).parents('.li_product').length > 0
                            id_product = ($(this).parents('.li_product').find('.add_product_link').attr('id')).replace('product_','')
                            user_id = $('#user_id').val()
                            $(location).attr('href','/page_produit/show/'+user_id+'/'+id_product) 
                            console.log('/page_produit/show/'+user_id+'/'+id_product)
                        if $(this).parents('.li_basket').length > 0
                            id_bakset = ($(this).parents('.li_basket').find('.add_basket_link_revendeur').attr('id')).replace('basket_','')
                            user_id = $('#user_id').val()
                            console.log('/page_panier/show/'+user_id+'/'+id_bakset)
                            $(location).attr('href','/page_panier/show/'+user_id+'/'+id_bakset)
               
                )
            )
        test:->
    
    filter_.event()
    link_li.event('ul.farmers_products>li')
       

)