# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load(()->
    listing_tooltip = 
        listing:()->
            $('.historique,.add,.help,.stats,.edit,.delete').tool_tip(1000)
    listing_tooltip.listing()
)

$(document).ready( () ->
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ SUPP PHOTO STOCK - USER ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
#     supp_photo_stock
    supp_photo_function = 
        id_photo: ''
        init:()->
            $('.deleted_p_c').on('click', ()->
                supp_photo_function.id_photo = '#'+$(this).attr('id')
                if $(this).hasClass('photo_stock')
                    entite_photo = 'photo_stock'
                if $(this).hasClass('photo_user')
                    entite_photo = 'photo_user'
                
                class_photo = $(this).attr('id')
                id_photo_element = parseInt(class_photo.replace(entite_photo+'_',''))
                
                if $(this).hasClass('photo_stock')
                    id_stock = $(this).parents('.left_area').next().children('.informations_card').children('.id_stock').val()
                    supp_photo_function.supp_photo_stock(id_photo_element,id_stock)
                
                if $(this).hasClass('photo_user')
                    #id_user = $(this).parents('.left_area').next().children('.informations_card').children('.id_stock').val()
                    supp_photo_function.supp_photo_user(id_photo_element)
                
            )
            
        init_one_event:(element)->
            $(element).on('click', ()->
                class_photo = $(this).attr('id')
                console.log(class_photo)
                id_photo = parseInt(class_photo.replace('photo_stock_',''))
                id_stock = $(this).parents('.left_area').next().children('.informations_card').children('.id_stock').val()
                supp_photo_function.supp(id_photo,id_stock)
            )
        
        supp_photo_user:(id_photo)->
            xhr = new XMLHttpRequest();
            xhr.open('DELETE','/administration/users/'+$('.user_id').val()+'/delete_image/'+id_photo)
            
            #form = new FormData();
            #name = $(input).attr('name')
            #input_radio_checked = $(input_radio).attr('name')
            #form.append($(input_radio).attr('name'),$(input_radio).filter(':checked').val())
            #console.log(input)
            #fileInput = input[0]
            #console.log(input)
            #console.log(fileInput)        
            #form.append(name,fileInput.files[0])
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    supp_photo_function.animation_supp(id_photo)
            


        supp_photo_stock:(id_photo,stock_id)->
            xhr = new XMLHttpRequest();
            xhr.open('DELETE','/administration/users/'+$('.user_id').val()+'/stocks/'+stock_id+'/delete_image/'+id_photo)
            
            #form = new FormData();
            #name = $(input).attr('name')
            #input_radio_checked = $(input_radio).attr('name')
            #form.append($(input_radio).attr('name'),$(input_radio).filter(':checked').val())
            #console.log(input)
            #fileInput = input[0]
            #console.log(input)
            #console.log(fileInput)        
            #form.append(name,fileInput.files[0])
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    supp_photo_function.animation_supp()
            
        animation_supp:()->
            if $(supp_photo_function.id_photo).hasClass('photo_stock')
                left_area = $(supp_photo_function.id_photo).parents('.picture').parents('div.left_area')
                $(supp_photo_function.id_photo).parents('.picture').remove()
                supp_photo_function.regenerate_class(left_area)
            
            if $(supp_photo_function.id_photo).hasClass('photo_user')
                $(supp_photo_function.id_photo).parents('.is_small.has_corners_shadow').parents('li').remove()
        
        regenerate_class: (element)->
            #element = left_area
            i = 0
            console.log(element)
            $(element).children('.picture').each(()->
                class_ = ''
                if $(this).hasClass('is-editing')
                    class_ = 'is-editing '
                 
                $(this).removeClass($(this).attr('class'))
                #console.log(i)
                
                if i%2 == 0
                    class_ += 'picture first_cloumn'
                else
                    class_ += 'picture'
                
                #console.log(class_)
                $(this).addClass(class_)
                i++
            )
        
    if $('.photo_stock').length > 0 || $('.photo_user').length > 0
        supp_photo_function.init()
    
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ ADD PHOTO USER ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    add_photo_user = 
        card : ''
        init: ()->
            $('.add.button.image.add_user_image').on('click', ()->
               user_id = $(this).attr('id').replace('user_id_','')
               add_photo_user.card = $(this).parents('li').parents('ul')
               console.log(add_photo_user.card)
               add_photo_user.generate_form(user_id)
            )
        
        init_one_element:(button)->
            $(button).on('click', ()->
               user_id = $(this).attr('id').replace('user_id_','')
               add_photo_user.card = $(this).parents('li').parents('ul')
               add_photo_user.generate_form(user_id)
            )
            
        generate_form : (user_id)->
            window.light_box_information.html_content('')
            # input = $(document.createElement('input'))
#             input.attr('name','photo_stock[image]')
#             input.attr('id','photo_stock_image')
#             input.attr('type','file')
            
            form = $(document.createElement('form'))
            form.addClass('form-horizontal')
            data_ = 
                    type_element:'input'
                    label:
                        text:'Nouvelle photo'
                    input:
                        value: '' #'' #tableau d'obj si select {value:'',text:''},....   , string si input
                        name:'photo_user[image]'
                        class: ''
                        id: 'photo_user_image'
                        other_attributes: [['type','file']]

            div_input = window.global_functions.standard_input(data_)
            
            data_radio = 
                    type_element:'radio'
                    label:
                        text:'First image'
                    input:
                        value: [[1,'Oui'],[0,'Non']] #'' #tableau d'obj si select {value:'',text:''},....   , string si input
                        name:'photo_user[first_image]'
                        class: 'photo_user_first_image'
                        id: 'photo_user_first_image_1'
                        other_attributes: [['type','radio']]

            div_input_radio = window.global_functions.standard_input(data_radio)
            
            
            
            
            
            #BUTTON FOOTER
            span = $(document.createElement('span'))
            span.addClass('button')
            
            a = $(document.createElement('a'))
            a.addClass('test')
            a.text('Ajouter')
            
            span.append(a)                        
           
            span_annuler = window.light_box_information.create_annuler()
            
            form.append(div_input)
            form.append(div_input_radio)
            
            window.light_box_information.html_footer(span_annuler)
            window.light_box_information.append_footer(span)
            window.light_box_information.header_html_content('')
            window.light_box_information.append_content(form)
            window.light_box_information.show()
            
            input = $(div_input).find('input')
            input_radio = $(div_input_radio).find('input.photo_user_first_image')
            
            span.on('click', ()->
                add_photo_user.upload_form(input,input_radio,user_id)
            )
            
        upload_form : (input,input_radio,user_id)->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+user_id+'/add_image')
            
            form = new FormData();
            name = $(input).attr('name')
            #input_radio_checked = $(input_radio).attr('name')
            form.append($(input_radio).attr('name'),$(input_radio).filter(':checked').val())
            console.log(input)
            fileInput = input[0]
            console.log(input)
            console.log(fileInput)        
            form.append(name,fileInput.files[0])
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    add_photo_user.create_photo(data['photo_user'])
                    
                    
        create_photo: (data)->
            # <li>
#                 <div class="is_small has_corners_shadow">
#                     <span id="photo_user_19" class="deleted_p_c photo_user"></span>
#                     <img src="/uploads/photo_user/image/19/is_small_Capture_d_e_cran_2012-04-20_a__20.11.47.png" alt="Is_small_capture_d_e_cran_2012-04-20_a__20.11.47">
#                 </div>
#             </li>
            
            li = $(document.createElement('li'))
            div = $(document.createElement('div'))
            div.addClass('is_small has_corners_shadow')
            
            
            img = $(document.createElement('img'))
            img.attr('src',data['image']['is_small']['url'])
            
            span_deleted = $(document.createElement('span'))
            span_deleted.addClass('deleted_p_c')
            span_deleted.attr('id','photo_user_'+data['id'])
            
            supp_photo_function.init_one_event(span_deleted)
            div.append(span_deleted)
            div.append(img)
            li.append(div)
            
            console.log(li)
            $(add_photo_user.card).children('li').last().before(li)
            
        
            if data['first_image'] == 1
                new_image = $(add_photo_user.card).children('li').last().prev().children('div')
                first_image = $(add_photo_user.card).parents('.pictures').children('div.has_corners_shadow.is_medium')
                #console.log($(add_photo_user.card))
                setTimeout(add_photo_user.animation_first_image, 200, first_image, new_image, data)
        
        animation_first_image: (actual_first_image, new_image, data)->
            position_first_image = $(actual_first_image).position() 
            position_new_image = $(new_image).position()
            
            class_new_image = $(new_image).attr('class')
            width_new_image = parseInt($(new_image).css('width'))
            height_new_image = parseInt($(new_image).css('height'))
            margin_left_new_image = parseInt($(new_image).css('margin-left'))
            margin_bottom_new_image = parseInt($(new_image).css('margin-bottom'))
            padding_new_image = parseInt($(new_image).css('padding-top'))
            
            class_actual_first = $(actual_first_image).attr('class')
            width_actual_first = parseInt($(actual_first_image).css('width'))
            height_actual_first = parseInt($(actual_first_image).css('height'))
            margin_top_first_image = parseInt($(actual_first_image).css('margin-top'))
            padding_first_image = parseInt($(actual_first_image).css('padding-top'))
            
            position_first_image.top += margin_top_first_image
        
            console.log(position_new_image)
            
            position_first_image.top += 4
            position_first_image.left -= 3
            
            div_wait = $(document.createElement('div'))
            div_wait.addClass(class_new_image)
            
            console.log(width_actual_first)
            $(new_image).css('position','absolute')
            $(new_image).css('top',position_new_image.top)
            $(new_image).css('left',position_new_image.left)
            $(new_image).css('z-index','10000')
            $(new_image).after(div_wait)
            console.log(data)
            $(new_image).children('img').attr('src',data['image']['is_medium']['url'])
            #$(new_image).addClass('has_corners_shadow')
            $(new_image).animate(
                top: position_first_image.top+'px'
                left: position_first_image.left+'px'
                width: width_actual_first+'px'
                height:height_actual_first+'px'
                border: '1px solid #DCDCDC'
            ,{
                duration:2000,
                complete:()->
                    $(this).removeClass($(this).attr('class'))
                    $(this).addClass(class_actual_first)
                    $(this).css('position','relative')
                    $(this).css('top','0px')
                    $(this).css('left','0px')
                    
                    #On place l'element en premier (apres l'anim)
                    $(actual_first_image).before(this)
                    $(this).remove
                    
                    $(actual_first_image).css('position','absolute')
                    $(actual_first_image).removeClass('has_corners_shadow')
                    $(actual_first_image).css('margin-top','Opx')
                    $(actual_first_image).css('padding','Opx')
                    $(actual_first_image).css('margin-left',margin_left_new_image+'px')
                    $(actual_first_image).css('margin-bottom',margin_bottom_new_image+'px')
                    $(actual_first_image).css('z-index','10000')
                    #$(actual_first_image).css('border','3px solid #FFFFFF')
                    $(actual_first_image).animate(
                        top: position_new_image.top+'px'
                        left: position_new_image.left+'px'
                        width: width_new_image+'px'
                        height:height_new_image+'px'
                        padding:padding_new_image+'px'
                    ,{
                        duration:2000,
                        complete:()->
                            $(this).removeClass($(this).attr('class'))
                            $(this).addClass(class_new_image)
                            $(this).css('position','relative')
                            $(this).css('top','0px')
                            $(this).css('left','0px')
                            
                            #console.log($(add_photo_stock.card).children('.left_area').children('div').last())
                            console.log(div_wait)
                            div_wait.remove()
                            $(add_photo_user.card).children('li').last().prev().append(this)
                            $(this).remove
                            
                    })
                    
            })
        
    add_photo_user.init()
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ ADD PHOTO STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________

    
    add_photo_stock = 
        card : ''
        init: ()->
            $('.add.button.image.add_stock_image').on('click', ()->
               stock_id = $(this).attr('id').replace('stock_id_','')
               add_photo_stock.card = $(this).parents('div').parents('li.card')
               add_photo_stock.generate_form(stock_id)
            )
        
        init_one_element:(button)->
            $(button).on('click', ()->
               stock_id = $(this).attr('id').replace('stock_id_','')
               add_photo_stock.card = $(this).parents('div').parents('li.card')
               add_photo_stock.generate_form(stock_id)
            )
        generate_form : (stock_id)->
            window.light_box_information.html_content('')
            # input = $(document.createElement('input'))
#             input.attr('name','photo_stock[image]')
#             input.attr('id','photo_stock_image')
#             input.attr('type','file')
            
            form = $(document.createElement('form'))
            form.addClass('form-horizontal')
            data_ = 
                    type_element:'input'
                    label:
                        text:'Nouvelle photo'
                    input:
                        value: '' #'' #tableau d'obj si select {value:'',text:''},....   , string si input
                        name:'photo_stock[image]'
                        class: ''
                        id: 'photo_stock_image'
                        other_attributes: [['type','file']]

            div_input = window.global_functions.standard_input(data_)
            
            data_radio = 
                    type_element:'radio'
                    label:
                        text:'First image'
                    input:
                        value: [[1,'Oui'],[0,'Non']] #'' #tableau d'obj si select {value:'',text:''},....   , string si input
                        name:'photo_stock[first_image]'
                        class: 'photo_stock_first_image'
                        id: 'photo_stock_first_image_1'
                        other_attributes: [['type','radio']]

            div_input_radio = window.global_functions.standard_input(data_radio)
            
            
            
            
            
            #BUTTON FOOTER
            span = $(document.createElement('span'))
            span.addClass('button')
            
            a = $(document.createElement('a'))
            a.addClass('test')
            a.text('Ajouter')
            
            span.append(a)                        
           
            span_annuler = window.light_box_information.create_annuler()
            
            form.append(div_input)
            form.append(div_input_radio)
            
            window.light_box_information.html_footer(span_annuler)
            window.light_box_information.append_footer(span)
            window.light_box_information.header_html_content('')
            window.light_box_information.append_content(form)
            window.light_box_information.show()
            
            input = $(div_input).find('input')
            input_radio = $(div_input_radio).find('input.photo_stock_first_image')
            
            span.on('click', ()->
                add_photo_stock.upload_form(input,input_radio,stock_id)
            )
            
        upload_form : (input,input_radio,stock_id)->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/stocks/'+stock_id+'/add_image')
            
            form = new FormData();
            name = $(input).attr('name')
            #input_radio_checked = $(input_radio).attr('name')
            form.append($(input_radio).attr('name'),$(input_radio).filter(':checked').val())
            console.log(input)
            fileInput = input[0]
            console.log(input)
            console.log(fileInput)        
            form.append(name,fileInput.files[0])
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    add_photo_stock.create_photo(data['photo_stock'])
                    
                    
        create_photo: (data)->
            console.log(data)
            div = $(document.createElement('div'))
            
            nb_photo = $(add_photo_stock.card).children('.left_area').children('.picture').length
            class_div = ''
            if nb_photo%2 == 0
                class_div = "picture first_cloumn"
            else
                class_div = "picture"
            div.addClass(class_div)
            
            img = $(document.createElement('img'))
            img.attr('src',data['image']['is_small']['url'])
            
            span_deleted = $(document.createElement('span'))
            span_deleted.addClass('deleted_p_c')
            span_deleted.attr('id','photo_stock_'+data['id'])
            
            supp_photo_function.init_one_event(span_deleted)
            div.append(span_deleted)
            div.append(img)
            
            
            if $(add_photo_stock.card).children('.left_area').children('.picture').length > 0
                $(add_photo_stock.card).children('.left_area').children('.picture').last().after(div)
            else
                $(add_photo_stock.card).children('.left_area').children('.is_small.has_corners_shadow').after(div)
            
						
            if data['first_image'] == 1
                new_image = $(add_photo_stock.card).children('.left_area').children('div').last()
                #console.log(new_image)
                setTimeout(add_photo_stock.animation_first_image, 200, $(add_photo_stock.card).children('.left_area').children('.is_small.has_corners_shadow'), new_image)
        
        animation_first_image: (actual_first_image, new_image)->
            position_first_image = $(actual_first_image).position() 
            position_new_image = $(new_image).position()
            
            class_new_image = $(new_image).attr('class')
            width_new_image = parseInt($(new_image).css('width'))
            height_new_image = parseInt($(new_image).css('height'))
            margin_left_new_image = parseInt($(new_image).css('margin-left'))
            margin_bottom_new_image = parseInt($(new_image).css('margin-bottom'))
            padding_new_image = parseInt($(new_image).css('padding-top'))
            
            width_actual_first = parseInt($(actual_first_image).css('width'))
            height_actual_first = parseInt($(actual_first_image).css('height'))
            margin_top_first_image = parseInt($(actual_first_image).css('margin-top'))
            padding_first_image = parseInt($(actual_first_image).css('padding-top'))
            
            position_first_image.top += margin_top_first_image
        
            console.log(position_new_image)
            if $(new_image).hasClass('first_cloumn')
                position_first_image.top += 4 #le "+4" c'est pour le padding
                position_first_image.left += 3 #le "-4" c'est pour le padding - 1 px de border
            else
                position_first_image.top += 4
                position_first_image.left -= 3
            div_wait = $(document.createElement('div'))
            div_wait.addClass(class_new_image)
            
            $(new_image).css('position','absolute')
            $(new_image).css('top',position_new_image.top)
            $(new_image).css('left',position_new_image.left)
            $(new_image).css('z-index','10000')
            $(new_image).after(div_wait)
            #$(new_image).addClass('has_corners_shadow')
            $(new_image).animate(
                top: position_first_image.top+'px'
                left: position_first_image.left+'px'
                width: width_actual_first+'px'
                height:height_actual_first+'px'
                border: '1px solid #DCDCDC'
            ,{
                duration:2000,
                complete:()->
                    $(this).removeClass($(this).attr('class'))
                    $(this).addClass('is_small has_corners_shadow')
                    $(this).css('position','relative')
                    $(this).css('top','0px')
                    $(this).css('left','0px')
                    
                    #On place l'element en premier (apres l'anim)
                    $(actual_first_image).before(this)
                    $(this).remove
                    
                    $(actual_first_image).css('position','absolute')
                    $(actual_first_image).removeClass('has_corners_shadow')
                    $(actual_first_image).css('margin-top','Opx')
                    $(actual_first_image).css('padding','Opx')
                    $(actual_first_image).css('margin-left',margin_left_new_image+'px')
                    $(actual_first_image).css('margin-bottom',margin_bottom_new_image+'px')
                    $(actual_first_image).css('z-index','10000')
                    $(actual_first_image).css('border','3px solid #FFFFFF')
                    $(actual_first_image).animate(
                        top: position_new_image.top+'px'
                        left: position_new_image.left+'px'
                        width: width_new_image+'px'
                        height:height_new_image+'px'
                        padding:padding_new_image+'px'
                    ,{
                        duration:2000,
                        complete:()->
                            $(this).removeClass($(this).attr('class'))
                            $(this).addClass(class_new_image)
                            $(this).css('position','relative')
                            $(this).css('top','0px')
                            $(this).css('left','0px')
                            
                            #console.log($(add_photo_stock.card).children('.left_area').children('div').last())
                            console.log(div_wait)
                            div_wait.remove()
                            $(add_photo_stock.card).children('.left_area').children('span').last().before(this)
                            $(this).remove
                            
                    })
                    
            })
        
        
        
    add_photo_stock.init()
       
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ FORM ADD PANIER ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    form_add_basket = 
        actual_step: 1
        init: ()->  
            form_add_basket.form_new_basket()
            form_add_basket.event()
            form_add_basket.info_panier_autorise($('#panier_panier_autorise_id').val())
        re_init_form: ()->
            form_add_basket.actual_step = 1
            $('.etape_1').css('display','block')
            $('.etape_3').css('display','none')
            $('.title_1').css('display','block')
            $('.title_3').css('display','none')
        
        #INFO DU PANIER AUTORISE
        info_panier_autorise: (id_pa) ->
                id_user = $('.user_id').val()
                $.ajax("/administration/users/#{id_user}/panier_autorises/#{id_pa}",{
                    type:"GET",
                    async:false,
                    format:"json",
                    success: (data)->
                        $('#panier_titre').val(data['titre'])
                        $('#panier_description').val(data['description'])
                        true
                })
                true
        
        upload_form: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/paniers')
            
            form = new FormData();
            
            $('#new_panier input, #new_panier textarea, #new_panier select').each(()->
                #console.log($(this).attr('name'))
                name = $(this).attr('name')
                if data[name] == undefined && $(this).attr('type') != 'button' && $(this).attr('type') != 'file'
                    data[name] = $(this).val()
                    form.append(name,$(this).val())
                else if $(this).attr('type') == 'file'
                    fileInput = document.querySelector('#'+$(this).attr('id'))
                    form.append(name,fileInput.files[0])
                    
            )

            xhr.send(form)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    form_add_basket.re_init_form()
                    window.lightbox_new_basket.hide()
                    console.log(xhr.responseText)
                    new_card = xhr.responseText
                    new_card_2 = $($(new_card)[0])
                    console.log(new_card_2)
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    console.log($('.card_stack:first-child'))
                    $($('.card_stack')[0]).before(new_card_2)
                    #event sur les bouton
                    #supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    #add_photo_stock.init_one_element(new_card_2.find('.add.button.image'))
                    #functions.one_edit_button(new_card_2.find('.buttons_card>.edit'))
                    #form_plugin_element.init_one_card(new_card_2)
                    
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

            
                    


        event:()->
            $('li.add.button').on('click',()->
                window.lightbox_new_basket.show()
            )
            
            $('.next_step').on('click',()->
                if !form_add_basket['error_step_'+form_add_stock.actual_step]()
                    form_add_basket.next_step()
            )

            $('.previous_step').on('click',()->
                form_add_basket.previous_step()
            )
            
            $('#panier_panier_autorise_id').on('change',()->
                form_add_basket.info_panier_autorise($(this).val())
            )

        
        form_new_basket: ()->
            window.lightbox_new_basket = new Lightbox('.lightbox_new_basket','.lightbox_form_new_basket')
        
        verif_one_input: (element)->
            error = false
            if $(element).val() == ''
                    $(element).parents('.control-group').addClass('error')
                    error = true
                else
                    $(element).parents('.control-group').removeClass('error')
            return error
            
        error_step_1:()->
            error = false
            $('.etape_1 input, .etape_1 textarea').each(()->
                if form_add_basket.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
            
        error_step_2:()->
            error = false
            $('.etape_2 input, .etape_2 textarea').each(()->
                 if form_add_basket.verif_one_input(this)
                    error = true         
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
            
        error_step_3:()->
            error = false
            $('.etape_3 input,  .etape_3 textarea').each(()->
                 if form_add_basket.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            
            if form_add_basket.stock_is_depassed()
                window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
                error = true
            return error
        
        next_step:()->
            if form_add_basket.actual_step == 3
                #$('#new_stock').submit()
                form_add_basket.upload_form()
            else
                $('.etape_'+form_add_basket.actual_step).slideUp(500)
                $('.title_'+form_add_basket.actual_step).css('display','none')
                form_add_basket.actual_step += 1
                $('.etape_'+form_add_basket.actual_step).slideDown(500)
                $('.title_'+form_add_basket.actual_step).css('display','block')
                #POUR MENU GAUCHE
                next_current = $('.navigation>li>.current').parents('li').next().children('span')
                $('.navigation>li>.current').removeClass('current')
                console.log(next_current)
                next_current.addClass('current')
        previous_step: ()->
            $('.etape_'+form_add_basket.actual_step).slideUp(500)
            $('.title_'+form_add_basket.actual_step).css('display','none')
            form_add_basket.actual_step -= 1
            $('.etape_'+form_add_basket.actual_step).slideDown(500)
            $('.title_'+form_add_basket.actual_step).css('display','block')
            #POUR MENU GAUCHE
            previous_current = $('.navigation>li>.current').parents('li').prev().children('span')
            $('.navigation>li>.current').removeClass('current')
            console.log(previous_current)
            previous_current.addClass('current')

    
    if $('.card_stack').length > 0
            form_add_basket.init()
    
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ FORM ADD STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    form_add_stock =
        previous_id: ""
        exist_deja: false
        actual_step: 1
        init: ()-> 
            
            form_add_stock.init_select_stock()
            form_add_stock.form_new_stock()
            form_add_stock.event()
        
        re_init_form: ()->
            form_add_stock.actual_step = 1
            $('.etape_1').css('display','block')
            $('.etape_3').css('display','none')
            $('.title_1').css('display','block')
            $('.title_3').css('display','none')
        
        #ON PLACE LE SELECT SUR UN PRODUIT PAS DEJA MIS EN STOCK
        init_select_stock: ()->
            if form_add_stock.produit_deja_enstock($('#stock_produit_autorise_id').val())
                dem_produit_enstock = false
                $('#stock_produit_autorise_id option').each(()->
                    value_option = $(this).attr("value")
                    if !form_add_stock.produit_deja_enstock(value_option)
                        dem_produit_enstock = true
                        $('#stock_produit_autorise_id').val(value_option)
                        form_add_stock.info_produit_autorise(value_option)
                )
                if !dem_produit_enstock
                   alert('Tous les produits autorisé sont en stock')

        upload_form: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/stocks')
            
            form = new FormData();
            
            $('#new_stock input, #new_stock textarea, #new_stock select').each(()->
                #console.log($(this).attr('name'))
                name = $(this).attr('name')
                if data[name] == undefined && $(this).attr('type') != 'button' && $(this).attr('type') != 'file'
                    data[name] = $(this).val()
                    form.append(name,$(this).val())
                else if $(this).attr('type') == 'file'
                    fileInput = document.querySelector('#'+$(this).attr('id'))
                    form.append(name,fileInput.files[0])
                    
            )

            xhr.send(form)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    form_add_stock.re_init_form()
                    window.lightbox_new_stock.hide()
                    console.log(xhr.responseText)
                    new_card = xhr.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    $('ul.cards').prepend(new_card_2)
                    #event sur les bouton
                    supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    add_photo_stock.init_one_element(new_card_2.find('.add.button.image'))
                    functions.one_edit_button(new_card_2.find('.buttons_card>.edit'))
                    form_plugin_element.init_one_card(new_card_2)
                    
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

            
            console.log(data)        
        event: ()->
            $('.buttons>li.add').on('click', ()->
                window.lightbox_new_stock.show()
            )

            $('#new_stock').bind "ajax:complete", (et,e) ->
                    form_add_stock.re_init_form()
                    window.lightbox_new_stock.hide()
                    new_card = e.responseText
                    new_card_2 = $($(new_card)[0])
                    new_card_2.css({
                        opacity:0,
                        top: '-250px'
                    });
                    
                    #console.log(new_card_2.find('.buttons_card li.delete'))
                    $('ul.cards').prepend(new_card_2)
                    supp_stock.event_one_element(new_card_2.find('.buttons_card li.delete'))
                    new_card_2.animate({
                        opacity:1,
                        top:'0px'
                    },500)

            $('.next_step').on('click',()->
                if !form_add_stock['error_step_'+form_add_stock.actual_step]()
                    form_add_stock.next_step()
            )

            $('.previous_step').on('click',()->
                form_add_stock.previous_step()
            )
            $('.formulaire_add input,.formulaire_add textarea').on('change', ()->
                form_add_stock.verif_one_input(this)
            )

            $('#produit_vente_libre_quantite').on('change', ()->
                if form_add_stock.stock_is_depassed()
                    window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
            )
            $('#produit_vente_libre_nombre_pack').on('change', ()->
                if form_add_stock.stock_is_depassed()
                    window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
            )
            
            #CHANGE PRODUIT AUTORISE
            $('#stock_produit_autorise_id').on('click',() ->
                    form_add_stock.previous_id = $(this).val() #QUAND ON FOCUS LE SELECT
            )
            $('#stock_produit_autorise_id').on('change', ()->
                    if form_add_stock.produit_deja_enstock($(this).val())
                        alert('Deja dans le stock')
                        $(this).val(form_add_stock.previous_id)
                    else
                        form_add_stock.info_produit_autorise($(this).val()) #Affichagedesinfosduproduitautorise
            )
        
        #INFO DU PRODUIT AUTORISE
        info_produit_autorise: (id_pa) ->
                id_user = $('.user_id').val()
                $.ajax("/administration/users/#{id_user}/produit_autorises/#{id_pa}",{
                    type:"GET",
                    async:false,
                    format:"json",
                    success: (data)->
                        $('#stock_titre').val(data['titre'])
                        $('#stock_description').val(data['description'])
                        true
                })
                true

        #PRODUIT DEJA EN STOCK (VERIF)
        produit_deja_enstock: (id_produit) ->
                id_user = $('.user_id').val()
                $.ajax("/administration/users/#{id_user}/exist_stock/#{id_produit}",{
                    type:"GET",
                    async:false,
                    format:"json",
                    success: (data)->
                       form_add_stock.exist_deja = data
                       true
                })
                form_add_stock.exist_deja
                 
        form_new_stock: ()->
            window.lightbox_new_stock = new Lightbox('.lightbox_new_stock','.lightbox_form_new_stock')
 
        stock_is_depassed: ()->
            if $('#produit_vente_libre_quantite').val() == '' || $('#produit_vente_libre_nombre_pack').val() == ''
                return false
            else
                quantite_online = parseInt($('#produit_vente_libre_quantite').val())
                nb_pack_online = parseInt($('#produit_vente_libre_nombre_pack').val())
                quantite_stock = parseInt($('#stock_quantite').val())
                
                
                quantite_restante = quantite_stock - (nb_pack_online * quantite_online)
                if quantite_restante >= 0
                    return false
                else
                    return true
        
        verif_one_input: (element)->
            error = false
            if $(element).val() == ''
                    $(element).parents('.control-group').addClass('error')
                    error = true
                else
                    $(element).parents('.control-group').removeClass('error')
            return error
        error_step_1:()->
            error = false
            $('.etape_1 input, .etape_1 textarea').each(()->
                if form_add_stock.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
        error_step_2:()->
            error = false
            $('.etape_2 input, .etape_2 textarea').each(()->
                 if form_add_stock.verif_one_input(this)
                    error = true         
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            return error
        error_step_3:()->
            error = false
            $('.etape_3 input,  .etape_3 textarea').each(()->
                 if form_add_stock.verif_one_input(this)
                    error = true
            )
            if error
                window.message_information.message_error('.title_3','erreur','Certain champ sont vides',2000)
            
            if form_add_stock.stock_is_depassed()
                window.message_information.message_error('.title_3','erreur','Quantite en ligne excede celle du stock',2000)
                error = true
            return error
        
        next_step:()->
            if form_add_stock.actual_step == 3
                #$('#new_stock').submit()
                form_add_stock.upload_form()
            else
                $('.etape_'+form_add_stock.actual_step).slideUp(500)
                $('.title_'+form_add_stock.actual_step).css('display','none')
                form_add_stock.actual_step += 1
                $('.etape_'+form_add_stock.actual_step).slideDown(500)
                $('.title_'+form_add_stock.actual_step).css('display','block')
                #POUR MENU GAUCHE
                next_current = $('.navigation>li>.current').parents('li').next().children('span')
                $('.navigation>li>.current').removeClass('current')
                console.log(next_current)
                next_current.addClass('current')
        previous_step: ()->
            $('.etape_'+form_add_stock.actual_step).slideUp(500)
            $('.title_'+form_add_stock.actual_step).css('display','none')
            form_add_stock.actual_step -= 1
            $('.etape_'+form_add_stock.actual_step).slideDown(500)
            $('.title_'+form_add_stock.actual_step).css('display','block')
            #POUR MENU GAUCHE
            previous_current = $('.navigation>li>.current').parents('li').prev().children('span')
            $('.navigation>li>.current').removeClass('current')
            console.log(previous_current)
            previous_current.addClass('current')
    console.log($('.cards'))
    if $('ul.cards').length > 0       
        form_add_stock.init()
    
    
    
    #___________________________________________
    #___________________________________________
    #___________________________________________
    #__________ SUPP STOCK ________________
    #___________________________________________
    #___________________________________________
    #___________________________________________
    supp_stock = 
        init:()->
            $('.buttons_card li.delete').on('click',()->
                stock_id = $(this).attr('id').replace('stock_id_','')
                user_id = $('.user_id').val()
                that = this
                supp_stock.have_confirmation(user_id, stock_id, that)
            )
        
        delete: (user_id, stock_id, element)->
            $.ajax({
                type: 'DELETE'
                url:"/administration/users/"+user_id+"/stocks/"+stock_id
                format:'json'
                complete:(data)->
                    card = $(element).parents('li.card')
                    card.removeClass('in')
                    card.css('top','0px')
                    #card.addClass('out')
                    card.animate(
                        opacity:0
                        top:'-270px'
                    ,{
                        duration:500
                        complete:()->
                            $(this).remove()
                    })
                    # setTimeout(()-> 
#                         card.remove()
#                     , 300)
                    # card.animate({
#                         
#                     },{
#                         duration:300,
#                         complete:()->
#                             #$(this).slideUp(500,()->
#                                 $(this).remove()
#                             #)  
#                     })
                    
                    
            })

        
        have_confirmation: (user_id, stock_id, element)->
            window.light_box_information.html_content('<p> Etes vous sur ? </p>')
            window.light_box_information.title_header('Confirmation')
            span_annuler = window.light_box_information.create_annuler()
            window.light_box_information.html_footer(span_annuler)
            span = $(document.createElement('span'))
            span.addClass('button')
            a = $(document.createElement('a'))
            a.text('Oui')
            
            span.append(a)      
            window.light_box_information.append_footer(span)
            window.light_box_information.show()
            
            span.on('click', ()->
                window.light_box_information.hide()
                supp_stock.delete(user_id, stock_id, element)
            )
        
        event_one_element: (button_supp)->
            $(button_supp).on('click',()->
                stock_id = $(this).attr('id').replace('stock_id_','')
                user_id = $('.user_id').val()
                that = this
                that = this
                supp_stock.have_confirmation(user_id, stock_id, that)            )
        
    
    supp_stock.init()
    #__________________________________________
    #__________________________________________
    #__________________________________________
    #__________________________________________
    #_______ GENERAL FUNCTION _______________
    #__________________________________________
    #__________________________________________
    #__________________________________________        
    functions =
        init: ()->
            functions.edit_button()
            functions.help_button()
            functions.event_close()
            functions.stats_button()
        
        
        heigth_help_div: '0px' 
        event_close: ()->
            $('.helper>.close').on('click',()->
                functions.close_help('.buttons>li.help')
            ) 
        
        stats_button: ()->
            if $('.buttons>li.stats').length > 0
                $('.buttons>li.stats').on('click', ()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        window.statisitques.hide()
                        window.statisitques.clear_stats()
                                                
                    else
                        $(this).addClass('button_active')
                        window.statisitques.show()
                        window.statisitques.init()
                )  
        help_button: ()->
            if $('.buttons>li.help').length > 0
                functions.heigth_help_div = $('.helper').css('height')
                $('.buttons>li.help').on('click', ()->
                    if $(this).hasClass('button_active')
                        functions.close_help(this)
                    else
                        functions.show_help(this)
                )
                
        close_help: (help_button)->
            $(help_button).removeClass('button_active')
            $('.helper').animate({
                opacity:0
                
            },{
                duration:500,
                complete:()->
                    $(this).slideUp(500,()->
                        $(this).addClass('helper_close')
                    )  
            })
        
        show_help:(help_button)->
            $(help_button).addClass('button_active')
            $('.helper').removeClass('helper_close')
            $('.helper').slideDown(500,()->
                $(this).animate({
                    opacity:1
                },{
                    duration:500
                })
            )
            
        one_edit_button: (button)->
            if $('.buttons>li.edit').length > 0
                $('.buttons>li.edit').on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        functions.remove_editing_class()
                    else
                        $(this).addClass('button_active')
                        functions.add_editing_class()
                )
            
            if $('.buttons_card').length > 0
                $(button).on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        if $('.cards').length > 0
                            functions.remove_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.remove_editing_class($(this).parents('div.card_stack'))    
                    else
                        $(this).addClass('button_active')
                        if $('.cards').length > 0
                            functions.add_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.add_editing_class($(this).parents('div.card_stack'))
                            #console.log($(this).parents('div.card_stack'))
                )
        edit_button : () ->
            if $('.buttons>li.edit').length > 0
                $('.buttons>li.edit').on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        functions.remove_editing_class()
                    else
                        $(this).addClass('button_active')
                        functions.add_editing_class()
                )
            
            if $('.buttons_card').length > 0
                $('.buttons_card>.edit').on('click',()->
                    if $(this).hasClass('button_active')
                        $(this).removeClass('button_active')
                        if $('.cards').length > 0
                            functions.remove_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.remove_editing_class($(this).parents('div.card_stack'))    
                    else
                        $(this).addClass('button_active')
                        if $('.cards').length > 0
                            functions.add_editing_class($(this).parents('li.card'))
                        if $('.card_stack').length > 0
                            functions.add_editing_class($(this).parents('div.card_stack'))
                            #console.log($(this).parents('div.card_stack'))
                )
        
        remove_editing_class:(element = 'body')->
            #element = li.card
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').removeClass('is-editing')
                $('.user_profile>.pictures>div').removeClass('is-editing')
                
            
            if $('.cards').length > 0
               $(element).children('.right_area').children('.header').children('.title').removeClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').removeClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').removeClass('is-editing')
               $(element).children('.left_area').children('.has_corners_shadow').removeClass('is-editing')
               $(element).children('.left_area').children('.picture').removeClass('is-editing')
            
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('.title').removeClass('is-editing')
                $(element).children('.packaging').children('.body').children('.description').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.details').removeClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.main-informations').children('li').removeClass('is-editing')
        
        add_editing_class:(element = 'body')->
            #pour user profile
            if $('.user_profile').length > 0
                $('.user_profile>.content>p').addClass('is-editing')
                $('.user_profile>.pictures>ul>li>div.is_small').addClass('is-editing')
            
            #pour produit
            if $('.cards').length > 0
               console.log($(element).children('.rigth_area'))
               $(element).children('.right_area').children('.header').children('.title').addClass('is-editing')
               $(element).children('.right_area').children('.body').children('.description').addClass('is-editing')
               $(element).children('.right_area').children('.footer').children('ul').children('li').addClass('is-editing')
               $(element).children('.left_area').children('.has_corners_shadow').addClass('is-editing')
               $(element).children('.left_area').children('.picture').addClass('is-editing')
            
            #Pour panier
            if $('.card_stack').length > 0
                $(element).children('.packaging').children('.header').children('span').children('.title').addClass('is-editing')
                $(element).children('.packaging').children('.body').children('span').children('.description').addClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.details').addClass('is-editing')
                $(element).children('.packaging').children('.footer').children('ul.main-informations').children('li').addClass('is-editing')
    
    functions.init()
    
    
    
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # SHOW INFOS PANIER
    #-----------------------------------
    #-----------------------------------
    #----------------------------------- 
    $('div.card_stack>.packaging h2.title').form_plugin(
        champ: 'titre'
        element: 
            type: 'input'
        button:
            class:'update_titre'
            text_update:'Modifier le titre'
        url_get_infos:['user','panier']
    )

    $('div.card_stack>.packaging p.description').form_plugin(
        champ: 'description'
        element: 
            type: 'input'
        button:
            class:'update_description'
            text_update:'Modifier le description'
        url_get_infos:['user','panier']
    )
    
    # $('div.card_stack>.packaging li.detail_max').form_plugin(
#         champ: 'nb_pack'
#         element: 
#             type: 'input'
#         button:
#             class:'update_description'
#             text_update:'Modifier le description'
#         url_get_infos:['user','panier']
#     )

    #--------------------------------------------
    #--------------------------------------------
    #-------------------------------------------
    #FUNCTIONS POUR AJOUTER DES DECLINAISON
    #------------------------------------------
    #------------------------------------------
    
    change_infos_panier = 
        panier_id: 0
        actual_ul_details: $('')
        div_list:$('')
        div_form: $('')
        div_sous_content:$('')
        nombre_declinaison_actuel: 0
        init:()->
            $('div.card_stack>.packaging ul.details').on( 'click', ()->
                if ($(this).hasClass('is-editing'))
                     change_infos_panier.actual_ul_details = this
                     #generate box
                     change_infos_panier.generate_box()
                     change_infos_panier.add_select()
                     #change_infos_panier.div_form.css('display','none')
                     change_infos_panier.panier_id = $(this).parents('div.footer').prevAll('div.informations_card').children('.id_panier').val()
                     change_infos_panier.get_panier()

            )
        
        get_panier: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/paniers/'+change_infos_panier.panier_id)
            xhr.setRequestHeader('Accept','application/json')
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    
                    data = JSON.parse(xhr.responseText)
                    console.log(data)
                    nombre_declinaison = data['panier']['nb_pack_total']
                    for champ, valeur of data['declinaison_panier']
                        change_infos_panier.div_list.append(change_infos_panier.create_fiche_declinaison(valeur))
                        #nombre_declinaison += valeur['nb_pack']
                        #window.light_box_information.append_content(change_infos_panier.create_fiche_declinaison(valeur))
                    change_infos_panier.nombre_declinaison_actuel = nombre_declinaison
                    $('.header-list>p   ').text(nombre_declinaison+' declinaisons')

            
        li_detail:(data)->
            li_max = $(document.createElement('li'))
            li_max.addClass('detail')
            
            span_label = $(document.createElement('span'))
            span_label.addClass('label')
            span_label.text(data['label'])
            
            if (data['value']['element'] == 'span')
                 element_number = $(document.createElement('span'))
                 element_number.addClass('number')
                 element_number.text(data['value']['value'])
                 
            if (data['value']['element'] == 'ul')
                element_number = $(document.createElement('ul'))
                element_number.addClass('number')
                for champ, valeur of data['value']['value']
                    li_number = $(document.createElement('li'))
                    if valeur == data['value']['check']
                        li_number.addClass('check')
                    li_number.text(valeur)
                    element_number.append(li_number)
            
            li_max.append(span_label)
            li_max.append(element_number)
            
            return li_max
                    
        create_fiche_declinaison: (declinaison_panier)->
#             
#              <div class="raw">
#                 <ul class="details">
#                     <li class="detail detail_max">
#                         <span class="label">Max</span>
#                         <span class="number">100</span>
#                     </li>
#                     <li class="detail">
#                         <span class="label">Format</span>
#                         <ul class="number">
#                             <li> 2 </li>
#                             <li> 4 </li>
#                             <li> 6 </li>
#     
#                         </ul>
#                     </li>
#                     <li class="detail">
#                         <span class="label">Durée</span>
#                         <ul class="number">
#                             <li> 3 </li>
#                             <li> 6 </li>
#                             <li> 9 </li>
#                         </ul>
#                     </li>
#                     <li class="detail">
#                         <span class="label">Prix</span>
#                         <span class="number">5€</span>
#                     </li>
#                 </ul>
#                 <div class="clear"></div>
#                 <div class="close_square"></div>
#             </div>
#         
        
            div_raw = $(document.createElement('div'))
            div_raw.addClass('raw')
            
            ul_details = $(document.createElement('ul'))
            ul_details.addClass('details')
            
            li_max = change_infos_panier.li_detail({
                label:'Max'
                value:
                    element:'span'
                    value:declinaison_panier['nb_pack']  
            })
            
            li_format = change_infos_panier.li_detail({
                label:'Format'
                value:
                    element:'ul'
                    value:[2,4,6]
                    check:parseInt(declinaison_panier['nombre_personne'])
            })
            
            li_duree = change_infos_panier.li_detail({
                label:'Duree'
                value:
                    element:'ul'
                    value:[3,6,9]
                    check:parseInt(declinaison_panier['duree'])
            })
            
            li_prix = change_infos_panier.li_detail({
                label:'Prix'
                value:
                    element:'span'
                    value:declinaison_panier['prix_panier_ht']
            })
            
            ul_details.append(li_max)
            ul_details.append(li_format)
            ul_details.append(li_duree)
            ul_details.append(li_prix)
            
            div_close = $(document.createElement('div'))
            div_close.addClass('close_square declinaison_panier_'+declinaison_panier['id'])
            
            div_close.on('click',()->
                change_infos_panier.supp_declinaison(declinaison_panier,div_raw)
            )
            
            div_clear = $(document.createElement('div'))
            div_clear.addClass('clear')

            div_raw.append(ul_details)
            div_raw.append(div_close)
            div_raw.append(div_clear)
            return div_raw
        
        #GENERE LES ATTRIBUTS HTML DE LA BOX A SON INITIALISATION                         
        generate_box: ()->
            window.light_box_information.html_content('')
            change_infos_panier.div_sous_content = $(document.createElement('div'))
            change_infos_panier.div_sous_content.addClass('sous_content')
            
            change_infos_panier.div_sous_content.append(change_infos_panier.header_list())
            
            change_infos_panier.div_list = $(document.createElement('div'))
            change_infos_panier.div_list.addClass('embosed-list basket-details')
            
            change_infos_panier.div_sous_content.append(change_infos_panier.div_list)
            window.light_box_information.append_content(change_infos_panier.div_sous_content)
            
            window.light_box_information.title_header('titre')
            span_annuler = window.light_box_information.create_annuler()
            window.light_box_information.html_footer(span_annuler)
            #change_infos_panier.add_select()
            window.light_box_information.show()
        
        header_list:()->
#             <div class="header-list">
#                 <p>17 déclinaisons</p>
#                 <span class="button new-declinaision"><a href="">nouvelle</a></span>
#                 <div class="clear"></div>
#             </div>
        
        
            div_header = $(document.createElement('div'))
            div_header.addClass('header-list')
            
            nombre_decli = $(document.createElement('p'))
            nombre_decli.text('18 déclinaisons')
            
            span_new = $(document.createElement('span'))
            span_new.addClass('button new-declinaision button_declinaion')
            
            a  = $(document.createElement('a'))
            a.text('nouvelle')
            span_new.append(a)
            a.on('click', ()->
                   change_infos_panier.animate_for_form(1000)
            )
            
            span_retour = $(document.createElement('span'))
            span_retour.addClass('back-declinaison button_declinaion')
            span_retour.text('retour')
            
            span_retour.on('click', ()->
                   change_infos_panier.animate_for_tab(1000)
            )
            
            div_clear = $(document.createElement('div'))
            div_clear.addClass('clear')
            
            div_header.append(nombre_decli)
            div_header.append(span_new)
            div_header.append(span_retour)
            div_header.append(div_clear)
            
            return div_header
        
        # button_add_select: ()->
#             span = $(document.createElement('span'))
#             a = $(document.createElement('a'))
#             a.text('Ajoutez declinaison')
#             span.addClass('button')
#             
#             a.on('click',()->
#                 change_infos_panier.div_form.slideDown(1000)
#             )
#             
#             span.append(a)
#             
#             return span 
#       
        animate_for_tab: (time)->
            change_infos_panier.div_sous_content.animate(
                'margin-left': '0px'
            ,time)

        animate_for_form: (time)->
            change_infos_panier.div_sous_content.animate(
                'margin-left': '-600px'
            ,time)
        
        #GENERATION DU FORMULAIRE HTML POUR AJOUTER DES DECLNAISON
        add_select:()->
            div_form = $(document.createElement('div'))
            div_form.addClass('form_add_decli')
            div_form.css('float','right')
            div_form.css('display','block')
            #div_card.addClass('card_stack')
            
            #max
            p_max = $(document.createElement('p'))
            label_max = $(document.createElement('label'))
            label_max.text('Nombre mis en ligne : ')
            input_max = $(document.createElement('input'))
            input_max.attr('name','declinaison_panier[nb_pack]')
            p_max.append(label_max)
            p_max.append(input_max)
            
            #format
            p_format = $(document.createElement('p'))
            label_format = $(document.createElement('label'))
            label_format.text('Nombre de personne : ')
            select_format = $(document.createElement('select'))
            select_format.attr('name','declinaison_panier[nombre_personne]')
            options_format = [2,4,6]
            i = 0
            while(options_format.length > i)
                option = $(document.createElement('option'))
                option.val(options_format[i])
                option.text(options_format[i])
                select_format.append(option)
                i++
            p_format.append(label_format)
            p_format.append(select_format)
            
            #duree
            p_duree = $(document.createElement('p'))
            label_duree = $(document.createElement('label'))
            label_duree.text('Duree (mois) : ')    
            select_duree = $(document.createElement('select'))
            select_duree.attr('name','declinaison_panier[duree]')
            options_duree = [3,6,9]
            i = 0
            while(options_duree.length > i)
                option = $(document.createElement('option'))
                option.val(options_duree[i])
                option.text(options_duree[i])
                select_duree.append(option)
                i++
            
            p_duree.append(label_duree)
            p_duree.append(select_duree)
            
            #prix_unite_ttc et ht
            p_ht = $(document.createElement('p'))
            label_ht = $(document.createElement('label'))
            label_ht.text('Prix unite ht: ')
            input_ht = $(document.createElement('input'))
            input_ht.attr('name','declinaison_panier[prix_panier_ht]')
            p_ht.append(label_ht)
            p_ht.append(input_ht)
            
            p_ttc = $(document.createElement('p'))
            label_ttc = $(document.createElement('label'))
            label_ttc.text('Prix unite ttc: ')
            input_ttc = $(document.createElement('input'))
            input_ttc.attr('name','declinaison_panier[prix_panier_ttc]')
            p_ttc.append(label_ttc)
            p_ttc.append(input_ttc)
            
            
            #clear div
            clear_div = $(document.createElement('div'))
            clear_div.addClass('clear')
            
            #button add
            span_add = $(document.createElement('span'))
            a = $(document.createElement('a'))
            a.text('Ajoutez')
            span_add.addClass('button')
            
            a.on('click',()->
                data = 
                    nb_pack: input_max.val()
                    nombre_personne: select_format.val()
                    duree: select_duree.val()
                    prix_panier_ht: input_ht.val()
                    prix_panier_ttc: input_ttc.val()
                change_infos_panier.add_declinaison(data)
            )
            
            #all in div_form
            span_add.append(a)
            div_form.append(p_format)
            div_form.append(p_duree)
            div_form.append(p_max)
            div_form.append(p_ht)
            div_form.append(p_ttc)
            div_form.append(span_add)
            
            
            change_infos_panier.div_form = div_form
            change_infos_panier.div_sous_content.prepend(div_form)
            #div_form.after(clear_div)
            #window.light_box_information.append_content(div_form)
            
            
        #AJOUT DE DECLINAISON - AJAX
        add_declinaison: (data_)->
            #data = {}
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/paniers/create_declinaison')
            xhr.setRequestHeader('Accept','application/json')
            
            form = new FormData();
            form.append('panier[id]', change_infos_panier.panier_id)
            form.append('declinaison_panier[nb_pack]', data_.nb_pack)
            form.append('declinaison_panier[nombre_personne]', data_.nombre_personne)
            form.append('declinaison_panier[duree]', data_.duree)
            form.append('declinaison_panier[prix_panier_ht]', data_.prix_panier_ht)
            form.append('declinaison_panier[prix_panier_ttc]', data_.prix_panier_ttc)
            
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    #window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                    else
                       #change_infos_panier.div_form.slideUp(1000)
                       change_infos_panier.nombre_declinaison_actuel += data_.nb_pack
                       $('.header-list>p   ').text(change_infos_panier.nombre_declinaison_actuel+' declinaisons')
                       change_infos_panier.animate_for_tab(1000)
                       change_infos_panier.div_list.append(change_infos_panier.create_fiche_declinaison(data['declinaison_panier']))
                       change_infos_panier.modify_card()
                    #add_photo_stock.create_photo(data['photo_stock'])
        
        
        have_confirmation: (declinaison,div_raw)->
            light_box_confirmation = new window.Lightbox('.lightbox_confirmation')
            light_box_confirmation.html_content('<p> Etes vous sur ? </p>')
            light_box_confirmation.title_header('Confirmation')
            span_annuler = light_box_confirmation.create_annuler()
            light_box_confirmation.html_footer(span_annuler)
            span = $(document.createElement('span'))
            span.addClass('button')
            a = $(document.createElement('a'))
            a.text('Oui')
            
            span.append(a)      
            light_box_confirmation.append_footer(span)
            light_box_confirmation.show()
            
            span.on('click', ()->
                light_box_confirmation.hide()
                change_infos_panier.supp_declinaison(declinaison,div_raw)
            )
            
        #SUPPRESSION DECLINAISON
        supp_declinaison:(declinaison,div_raw)->
            console.log(declinaison)
            xhr = new XMLHttpRequest();
            xhr.open('DELETE','/administration/users/'+$('.user_id').val()+'/paniers/supp_declinaison/'+declinaison.id)
            xhr.setRequestHeader('Accept','application/json')
            
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                    else
                       #change_infos_panier.div_form.slideUp(1000)
                       change_infos_panier.nombre_declinaison_actuel -= declinaison.nb_pack
                       $('.header-list>p   ').text(change_infos_panier.nombre_declinaison_actuel+' declinaisons')
                       div_raw.animate({
                            left:'500px'
                       },{
                        duration:500
                        complete:()->
                            $(this).remove()
                            change_infos_panier.modify_card()
                       })
            
            
        
        modify_card: ()->
            data = {}
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/paniers/'+change_infos_panier.panier_id)
            xhr.setRequestHeader('Accept','application/json')
            
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    
                    data = JSON.parse(xhr.responseText)
                    console.log(data)
                    $(change_infos_panier.actual_ul_details).children('.detail_max').children('.number').text(data['panier']['nb_pack_total'])
                    $(change_infos_panier.actual_ul_details).children('.detail_format').children('.number').children('li').removeClass('check')
                    $(change_infos_panier.actual_ul_details).children('.detail_duree').children('.number').children('li').removeClass('check')
                    for champ, valeur of data['declinaison_panier']
                        $(change_infos_panier.actual_ul_details).children('.detail_format').children('.number').children('li').each(()->
                            if parseInt(valeur['nombre_personne']) == parseInt($(this).text())
                                $(this).addClass('check')
                        )
                        $(change_infos_panier.actual_ul_details).children('.detail_duree').children('.number').children('li').each(()->
                            if parseInt(valeur['duree']) == parseInt($(this).text())
                                $(this).addClass('check')
                        )
            
    change_infos_panier.init()
    
    
    
    #--------------------------------------------------------
    #--------------------------------------------------------
    #--------------------------------------------------------
    #FUNCTIONS POUR AJOUTER DES PRODUITS DANS LE PANIER------
    #--------------------------------------------------------
    #--------------------------------------------------------
    #--------------------------------------------------------
    function_product_in_basket = 
        panier_id: ''
        div_sous_content: $('')
        div_list:$('')
        ul_listing_produit: $('')
        value_id_actual_stock: 0
        init: ()->
            $('div.card_stack>.packaging ul.main-informations>.product_number').on( 'click', ()->
                if ($(this).hasClass('is-editing'))
                     #generate box
                     function_product_in_basket.panier_id = $(this).parents('div.footer').prevAll('div.informations_card').children('.id_panier').val()
                     function_product_in_basket.generate_box()
                     function_product_in_basket.all_product()
                     function_product_in_basket.get_own_stock()
                     

            )
        #REGARDER ICIIIIII
        generate_box: ()->
            window.light_box_information.html_content('')
            function_product_in_basket.div_sous_content = $(document.createElement('div'))
            function_product_in_basket.div_sous_content.addClass('sous_content')
            
            function_product_in_basket.div_sous_content.append(function_product_in_basket.header_list())
            
            function_product_in_basket.div_list = $(document.createElement('div'))
            function_product_in_basket.div_list.addClass('')
            
            function_product_in_basket.div_sous_content.append(function_product_in_basket.div_list)
            window.light_box_information.append_content(function_product_in_basket.div_sous_content)
            
            window.light_box_information.title_header('titre')
            span_annuler = window.light_box_information.create_annuler()
            window.light_box_information.html_footer(span_annuler)
            #change_infos_panier.add_select()
            window.light_box_information.show()
        

         header_list:()->
#             <div class="header-list">
#                 <p>17 déclinaisons</p>
#                 <span class="button new-declinaision"><a href="">nouvelle</a></span>
#                 <div class="clear"></div>
#             </div>
        
        
            div_header = $(document.createElement('div'))
            div_header.addClass('header-list')
            
            nombre_decli = $(document.createElement('p'))
            nombre_decli.text('2 produits dans le panier')
            
            span_new = $(document.createElement('span'))
            span_new.addClass('button new-declinaision button_declinaion')
            
            a  = $(document.createElement('a'))
            a.text('nouvelle')
            span_new.append(a)
            
            a.on('click', ()->
                   function_product_in_basket.animate_for_form(1000)
            )
            
            span_retour = $(document.createElement('span'))
            span_retour.addClass('back-declinaison button_declinaion')
            span_retour.text('retour')
            
            span_retour.on('click', ()->
                   function_product_in_basket.animate_for_tab(1000)
            )
            
            div_clear = $(document.createElement('div'))
            div_clear.addClass('clear')
            
            div_header.append(nombre_decli)
            div_header.append(span_new)
            div_header.append(span_retour)
            div_header.append(div_clear)
            
            return div_header
            
        animate_for_tab: (time)->
            function_product_in_basket.div_sous_content.animate(
                'margin-left': '0px'
            ,time)

        animate_for_form: (time)->
            function_product_in_basket.div_sous_content.animate(
                'margin-left': '-600px'
            ,time)
        

        all_product: ()->
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/paniers/'+function_product_in_basket.panier_id+'/get_all_product')
            #xhr.setRequestHeader('Accept','application/json')
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log(xhr.responseText)
                    data = xhr.responseText
                    window.light_box_information.title_header('Produits du panier')
                    #window.light_box_information.html_content('')
                    function_product_in_basket.div_sous_content.append(data)
                    function_product_in_basket.ul_listing_produit = $(data).find('.other_products').children('ul')
                    #function_product_in_basket.button_add_product()
                    window.light_box_information.show()
                    
        button_add_product:()->
            button = window.global_functions.standard_button( 
                link: 
                    text:'Ajouter un produit'
                    event:[{type:'click', callback:[function_product_in_basket.get_own_stock]}]
            )
            window.light_box_information.append_content(button)
            
        form_add_product:(stocks)->
            #AJOUTER DES ACTIONS SUR LES BOUTONS (ex: quand on selectionne un stock, il ne faut pas qu'il soit deja choisi)
            value_option = []
            for champ, valeur of stocks
                data_ = 
                    value: valeur['id']
                    text: valeur['titre']
                
                value_option.push(data_)                

            element_produit = window.global_functions.standard_input( 
                type_element:'select',
                label:
                    text:'Produit'
                input:
                    value: '' #obj si select, string si input
                    options:value_option
                    name:''
                    class:''
                    id:''
            )
            element_produit.find('select').on('mouseenter',()->
                function_product_in_basket.value_id_actual_stock = $(this).val()
                console.log(function_product_in_basket.value_id_actual_stock)
            )
            
            element_produit.find('select').on('change',()->
                function_product_in_basket.verif_stock($(this).val(),this)
            )
            
            element_quantite = window.global_functions.standard_input( 
                type_element:'input',
                label:
                    text:'Quantite'
                input:
                    value: '' #obj si select, string si input
                    name:''
                    class:''
                    id:''
            )
            
            button = window.global_functions.standard_button( 
                link: 
                    text:'Ajoutez nouveau produit'
                    #event:[{type:'click', callback:[function_product_in_basket.get_own_stock]}]
            )
            
            button.on('click',()->
                function_product_in_basket.add_product({
                    stock_id: element_produit.find('select').val()
                    quantite: element_quantite.find('input').val()
                })
            )
            div_form = $(document.createElement('div'))
            div_form.addClass('form_add_product')
            div_form.css('float','right')
            div_form.css('display','block')
            
            div_form.append(element_produit)
            div_form.append(element_quantite)
            div_form.append(button)
            
            function_product_in_basket.div_sous_content.prepend(div_form)
            #window.light_box_information.append_content(form)
        
        verif_stock: (id_stock,select)-> 
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/paniers/'+function_product_in_basket.panier_id+'/produit_stock_already_in')
            xhr.setRequestHeader('Accept','application/json')
            form = new FormData();
            form.append('stock_id', id_stock)
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                        $(select).val(function_product_in_basket.value_id_actual_stock)
                        
            
        get_own_stock:()->
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/stocks/')
            xhr.setRequestHeader('Accept','application/json')
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'OK'
                        console.log(xhr.responseText)
                        function_product_in_basket.form_add_product(data['stock'])
                    # window.light_box_information.title_header('Produits du panier')
#                     window.light_box_information.html_content('')
#                     window.light_box_information.append_content(data)
#                     window.light_box_information.show()
        
        add_product: (data_)->
            xhr = new XMLHttpRequest();
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/paniers/'+function_product_in_basket.panier_id+'/produit_paniers')
            xhr.setRequestHeader('Accept','application/json')
            console.log(data_)
            form = new FormData();
            form.append('produit_panier[stock_id]', data_.stock_id)
            form.append('produit_panier[quantite]', data_.quantite)            
            
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    #window.light_box_information.hide()
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    if data['status'] == 'error'
                        window.message_information.message_error('.lightbox_wrapper .header','erreur',data['error'],5000)
                    else
                        function_product_in_basket.fiche_product(data)
                        #function_product_in_basket.ul_listing_produit.append(data)
                    #add_photo_stock.create_photo(data['photo_stock'])

        
        
        fiche_product: (produit_panier)->
            xhr = new XMLHttpRequest();
            xhr.open('GET','/administration/users/'+$('.user_id').val()+'/paniers/'+function_product_in_basket.panier_id+'/get_one_product/'+produit_panier.id)
            #xhr.setRequestHeader('Accept','application/json')
            xhr.send(null)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log(xhr.responseText)
                    data = xhr.responseText
                    function_product_in_basket.ul_listing_produit.append(data)
                    function_product_in_basket.animate_for_tab(1000)
    function_product_in_basket.init()
    


    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # SHOW INFOS USER
    #-----------------------------------
    #-----------------------------------
    #----------------------------------- 


    $('.user_profile .content>.title').form_plugin(
        url_get_infos:['user']
        champ: 'prenom, nom'
        titre:'Modifier le prenom et le nom'
        element: 
            type: 'input'
        button:
            class:'update_prenom'
            text_update:'Modifier'
    )
    
    $.ajax(
        type: 'GET'
        url:"/villes/index"
        format:'json'
        complete:(data)->
            informations = $.parseJSON(data['responseText'])
            id = []
            value = []
            for champ, valeur of informations['ville']
                id.push(valeur['id'])
                value.push(valeur['cp']+' - '+valeur['nom'])
            
            $('.user_profile .content>.city').form_plugin(
                url_get_infos:['user']
                champ: 'ville_id'
                titre:'La ville'
                element: 
                    type: 'select'
                    options: 
                        value : id
                        text: value
                button:
                    class:'update_ville'
                    text_update:'Modifier la ville'
            ).bind('end_form_plugin',()->
                    #$('.info_unite_mesure_id').text('('+$(this).text()+')')
            )       
    )
    
    $('.user_profile .content>.description').form_plugin(
        url_get_infos:['user']
        champ: 'description'
        titre:'La description'
        element: 
            type: 'textarea'
        button:
            class:'update_description'
            text_update:'Modifier la description'
    )
    
    $('.user_profile .content>.address').form_plugin(
        url_get_infos:['user']
        champ: 'adresse'
        titre:'L\'adresse'    
        element: 
            type: 'input'
        button:
            class:'update_adresse'
            text_update:'Modifier l\'adresse'
    )
    
    $('.user_profile .content>.phone').form_plugin(
        url_get_infos:['user']
        champ: 'telephone'
        titre:'Le telephone'
        element: 
            type: 'input'
        button:
            class:'update_telephone'
            text_update:'Modifier le telephone'
    )
    
    $('.user_profile .content>.email').form_plugin(
        url_get_infos:['user']
        champ: 'email'
        titre:'L\'email'
        element: 
            type: 'input'
        button:
            class:'update_email'
            text_update:'Modifier l\'email'
    )
    
    
    
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------
    # INDEX STOCK PRODUIT VENTE LIBRE 
    #-----------------------------------
    #-----------------------------------
    #-----------------------------------        
    
    form_plugin_element = 
        init:()->
            $('.card h2.title').form_plugin(
                #table_get_infos: 'stock'
                champ: 'titre'
                titre:'Le titre'        
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','stock']
                url_to_update: ['user','stock']
            )
            
            $('.card p.description').form_plugin(
                url_get_infos:['user','stock']
                champ: 'description'
                titre:'La description'
                element: 
                    type: 'textarea'
                button:
                    class:'update_description'
                    text_update:'Modifier la description'
            )
            $('.card li.prix').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre'] 
                champ: 'prix_unite_ttc'
                titre:'Le prix'
                element: 
                    type: 'input'
                button:
                    class:'update_prix'
                    text_update:'Modifier le prix'
            ).bind('end_form_plugin', ()->
                $(this).append(' €')
            )
            
            $.ajax(
                type: 'POST'
                url:"/administration/users/"+$('input.user_id').val()+"/get_unite_mesure"
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    id = []
                    value = []
                    for champ, valeur of informations
                        id.push(valeur['id'])
                        value.push(valeur['nom'])
                    
                    $('.card li.unite_mesure').form_plugin(
                        url_get_infos:['user','stock']
                        champ: 'unite_mesure_id'
                        titre:'L\'unite de mesure'
                        element: 
                            type: 'select'
                            options: 
                                value : id
                                text: value
                        button:
                            class:'update_unite_mesure'
                            text_update:'Modifier l\'unite de mesure'
                    ).bind('end_form_plugin',()->
                            $('.info_unite_mesure_id').text('('+$(this).children('span.value').text()+')')
                    )       
            )
            
            $('.card li.quantite_lot').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre'] 
                titre:'quantite d\'un lot'
                champ: 'quantite'
                element: 
                    type: 'input'
                button:
                    class:'update_quantite'
                    text_update:'Modifier la quantite'
                # infos:
        #             class:'is_italic'
        #             table:'unite_mesure'
        #             champ:'nom'
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
                    this_element = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
                            span = $(document.createElement('span'))
                            span.addClass('is_italic info_unite_mesure_id')
                            span.text(' ('+data['unite_mesure']['nom']+')')
                            $(this_element).append(span)
                            
                    )
            )#A FAIRE
        
            $('.card li.nombre_pack').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre']
                titre:'nombre de lot'
                champ: 'nombre_pack'
                element: 
                    type: 'input'
                button:
                    class:'update_nombre_pack'
                    text_update:'Modifier le nombre de lot'
                
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            $(that).children('span.value').append(' /'+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
                    )
            )
        
            $('.card li.stock_total').form_plugin(
                url_get_infos:['user','stock']
                champ: 'quantite'
                titre:'Le stock total'
                element: 
                    type: 'input'
                button:
                    class:'update_quantite_stock'
                    text_update:'Modifier le stock total'
                    
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
                    this_element = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ '( possible )')
                            span = $(document.createElement('span'))
                            span.addClass('is_italic info_unite_mesure_id')
                            span.text(' ('+data['unite_mesure']['nom']+')')
                            $(this_element).append(span)
                    )
            )#A FAIRE
            
            
        init_one_card:(card)->
            $(card).find('h2.title').form_plugin(
                #table_get_infos: 'stock'
                champ: 'titre'
                titre:'Le titre'        
                element: 
                    type: 'input'
                button:
                    class:'update_titre'
                    text_update:'Modifier le titre'
                url_get_infos:['user','stock']
                url_to_update: ['user','stock']
            )
            
            $(card).find('p.description').form_plugin(
                url_get_infos:['user','stock']
                champ: 'description'
                titre:'La description'
                element: 
                    type: 'textarea'
                button:
                    class:'update_description'
                    text_update:'Modifier la description'
            )
            $(card).find('li.prix').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre'] 
                champ: 'prix_unite_ttc'
                titre:'Le prix'
                element: 
                    type: 'input'
                button:
                    class:'update_prix'
                    text_update:'Modifier le prix'
            ).bind('end_form_plugin', ()->
                $(this).append(' €')
            )
            
            $.ajax(
                type: 'POST'
                url:"/administration/users/"+$('input.user_id').val()+"/get_unite_mesure"
                format:'json'
                complete:(data)->
                    informations = $.parseJSON(data['responseText'])
                    id = []
                    value = []
                    for champ, valeur of informations
                        id.push(valeur['id'])
                        value.push(valeur['nom'])
                    
                    $(card).find('li.unite_mesure').form_plugin(
                        url_get_infos:['user','stock']
                        champ: 'unite_mesure_id'
                        titre:'L\'unite de mesure'
                        element: 
                            type: 'select'
                            options: 
                                value : id
                                text: value
                        button:
                            class:'update_unite_mesure'
                            text_update:'Modifier l\'unite de mesure'
                    ).bind('end_form_plugin',()->
                            $('.info_unite_mesure_id').text('('+$(this).children('span.value').text()+')')
                    )       
            )
            
            $(card).find('li.quantite_lot').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre'] 
                titre:'quantite d\'un lot'
                champ: 'quantite'
                element: 
                    type: 'input'
                button:
                    class:'update_quantite'
                    text_update:'Modifier la quantite'
                # infos:
        #             class:'is_italic'
        #             table:'unite_mesure'
        #             champ:'nom'
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
                    this_element = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
                            span = $(document.createElement('span'))
                            span.addClass('is_italic info_unite_mesure_id')
                            span.text(' ('+data['unite_mesure']['nom']+')')
                            $(this_element).append(span)
                            
                    )
            )#A FAIRE
        
            $(card).find('li.nombre_pack').form_plugin(
                url_get_infos:['user','stock']
                url_to_update:['user','produit_vente_libre']
                titre:'nombre de lot'
                champ: 'nombre_pack'
                element: 
                    type: 'input'
                button:
                    class:'update_nombre_pack'
                    text_update:'Modifier le nombre de lot'
                
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            $(that).children('span.value').append(' /'+data['produit_vente_libre']['lot_possible_max']+ ' ( possible )')
                    )
            )
        
            $(card).find('li.stock_total').form_plugin(
                url_get_infos:['user','stock']
                champ: 'quantite'
                titre:'Le stock total'
                element: 
                    type: 'input'
                button:
                    class:'update_quantite_stock'
                    text_update:'Modifier le stock total'
                    
            ).bind('end_form_plugin',()->
                    user_id = $('input.user_id').val()
                    id_stock = $(this).parents('div').prevAll('div.informations_card').children('input.id_stock').val()
                    url = '/administration/users/'+user_id+'/stocks/'+id_stock
                    that = $(this).parents('ul').children('li.nombre_pack').children('span.value')
                    this_element = this
                    $.ajax(
                        type: 'GET'
                        url:url
                        format:'json'
                        success:(data)->
                            that.text(data['produit_vente_libre']['nombre_pack']+' / '+data['produit_vente_libre']['lot_possible_max']+ '( possible )')
                            span = $(document.createElement('span'))
                            span.addClass('is_italic info_unite_mesure_id')
                            span.text(' ('+data['unite_mesure']['nom']+')')
                            $(this_element).append(span)
                    )
            )#A FAIRE

    form_plugin_element.init()


    
#FOR THE MENU
    menu = 
        hover_action: () ->
            $('.subnav').each(()->
                if !$(this).hasClass('subnav_isopen')
                   $(this).css({
                       'margin-top':'-105px',
                       'position':'relative',
                       'opacity':0
                       'z-index':1
                   })
            )
            $('.pannels>li').css({
                'position':'relative',
                'z-index':2
                
            })
            
            $('li.stock').bind('click', ()->
            	if $('.subnav').hasClass('subnav_isopen')
            		$('.subnav').animate({
            	        'marginTop':'-105px',
            	        'opacity':0,
            	    },1000)
            	    $('.subnav').removeClass('subnav_isopen')
            	else
            	    $('.subnav').animate({
            	        'marginTop':'0px',
            	        'opacity':1,
            	    },1000)
            	    $('.subnav').addClass('subnav_isopen')
            )
            
    menu.hover_action()
    
    
    
    
    
#     card =
#         event: ()->
#             # $('.card h2.title').bind('click',()->
# #                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('title',data, that )
# #                 )
# #             )
#             
#             # $('.card p.description').bind('click',()->
# #                 stock_id = $(this).parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('description',data, that)
# #                 )
# #             )
#             
#             # $('.card li.prix').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('prix',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.unite_mesure').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('unite_mesure',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.quantite_lot').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('quantite_lot',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.nombre_pack').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('nombre_pack',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             # $('.card li.stock_total').bind('click',()->
# #                 stock_id = $(this).parent('ul').parent('div').prevAll('div.informations_card').children('input.id_stock').val()
# #                 console.log(stock_id)
# #                 that = this
# #                 $.when(card.get_information(stock_id)).done((data)->
# #                     card.show_form('stock_total',data,that)
# #                 )
# #                 
# #                 
# #             )
#             
#             
#             
#         show_form:(intitule,donnees,element) ->
#         	attribut = {}
#         	switch intitule
#                 when 'title'
#                     window.light_box_information.title_header('Titre')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'stock_titre'
#                             value:donnees['stock']['titre']
#                             size:'50'
#                             type_input:'text'
#                             name:'stock[titre]'
#                             class:'string optional'
#                                            
#                         link:
#                             class:'update_titre'
#                             text:'Modifier le titre'
#                     
#                     console.log(donnees)
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 			            
#                 when 'description'
#                     window.light_box_information.title_header('Description')
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                         input:
#                             balise : 'textarea'
#                             id:'stock_description'
#                             value:donnees['stock']['description']
#                             size:'40'
#                             type_input:''
#                             name:'stock[description]'
#                             class:'text optional'
# 			            
#                         link:
#                             class:'update_description'
#                             text:'Modifier la description'
#                             
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
#                 when 'prix'
#                     window.light_box_information.title_header('Prix')                 
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'produit_vente_libre_id'
#                             value:donnees['produit_vente_libre']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'produit_vente_libre[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_prix_unite_ttc'
#                             value:donnees['produit_vente_libre']['prix_unite_ttc']
#                             type_input:'text'
#                             name:'produit_vente_libre[prix_unite_ttc]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_prix_unite_ttc'
#                             text:'Modifier le prix'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
#                 when 'unite_mesure'
#                     window.light_box_information.title_header('Unité de mesure')
#                     $.ajax(
#                         type:'POST',
#                         url:'/administration/users/1/get_unite_mesure'
#                         format:"json"
#                         success: (data)->
#                             options = []
#                             for champ, value of data
#                                 option = $(document.createElement('option'))
#                                 option.attr('value',value['id'])
#                                 option.text(value['nom'])
#                                 if value['nom'] == donnees['unite_mesure']['nom']
#                                     option.attr('selected','selected')
#                                 options.push(option)
#                                 
#                             attribut = 
#                                 hidden_input:
#                                     balise:'input'
#                                     id:'stock_id'
#                                     value:donnees['stock']['id']
#                                     size:'50'
#                                     type_input:'hidden'
#                                     name:'stock[id]'
#                                 input:
#                                     balise : 'select'
#                                     id:'stock_unite_mesure_id'
#                                     value:donnees['unite_mesure']['nom']
#                                     type_input:'text'
#                                     name:'stock[unite_mesure_id]'
#                                     class:'numerical optional'
#                                     options : options
# 			            
#                                 link:
#                                     class:'update_unite_mesure'
#                                     text:'Modifier l\'unite'
#                                 
#                             card.generate_form(attribut)
#                             window.light_box_information.show()
#                             
#                         
#                     )
#                 
#                 when 'quantite_lot'
#                     window.light_box_information.title_header('Quantité lot')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'produit_vente_libre_id'
#                             value:donnees['produit_vente_libre']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'produit_vente_libre[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_quantite'
#                             value:donnees['produit_vente_libre']['quantite']
#                             type_input:'text'
#                             name:'produit_vente_libre[quantite]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_quantite'
#                             text:'Modifier la quantité d\'un lot '
#                         
#                         span_infos:
#                             text:'('+donnees['unite_mesure']['nom']+')'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
#                 
#                 when 'nombre_pack'
#                     window.light_box_information.title_header('Quantité lot en rayon')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                             
#                         input:
#                             balise : 'input'
#                             id:'produit_vente_libre_nombre_pack'
#                             value:donnees['produit_vente_libre']['nombre_pack']
#                             type_input:'text'
#                             name:'produit_vente_libre[nombre_pack]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_nombre_pack'
#                             text:'Modifier le nombre de lot'
#                         
#                         span_infos:
#                             text:'sur '+donnees['produit_vente_libre']['lot_possible_max']+' (possible)'
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()
# 
# 
#                 when 'stock_total'
#                     window.light_box_information.title_header('Quantité du stock')
#                     
#                     attribut = 
#                         hidden_input:
#                             balise:'input'
#                             id:'stock_id'
#                             value:donnees['stock']['id']
#                             size:'50'
#                             type_input:'hidden'
#                             name:'stock[id]'
#                         input:
#                             balise : 'input'
#                             id:'stock_quantite'
#                             value:donnees['stock']['quantite']
#                             type_input:'text'
#                             name:'stock[quantite]'
#                             class:'numerical optional'
# 			            
#                         link:
#                             class:'update_quantite'
#                             text:'Modifier la quantité du stock'
#                         
#                         span_infos:
#                             text:'('+donnees['unite_mesure']['nom']+' '
#                     
#                     card.generate_form(attribut)
#                     window.light_box_information.show()     
#           
#             
#         get_information:(id_stock)->
#             user_id = $('input.user_id').val()
#             $.ajax(
#                 type: 'GET'
#                 url:'/administration/users/'+user_id+'/stocks/'+id_stock
#                 format:'json'
#                 success:(data)->
#                     return data
#             )
#             
#         generate_form: (attribut) ->
#             #HIDDEN INPUT WITH ID
#             hidden_input = $(document.createElement(attribut['hidden_input']['balise']))
#             hidden_input.attr('id',attribut['hidden_input']['id'])
#             hidden_input.attr('name',attribut['hidden_input']['name'])
#             hidden_input.val(attribut['hidden_input']['value'])
#             hidden_input.attr('type',attribut['hidden_input']['type_input'])
#             hidden_input.addClass(attribut['hidden_input']['class'])
#             
#             #INPUT SELECT TEXTARE
#             input = $(document.createElement(attribut['input']['balise']))
#             input.attr('id',attribut['input']['id'])
#             input.attr('name',attribut['input']['name'])
#             input.val(attribut['input']['value'])
#             input.addClass(attribut['input']['class'])
#             
#             if attribut['input']['balise'] == 'input'
#                 input.attr('type',attribut['input']['type_input'])
#                 input.attr('size',attribut['input']['size'])
#             else if attribut['input']['balise'] == 'textarea'
#                 input.attr('cols',attribut['input']['size'])
#             else if attribut['input']['balise'] == 'select'
#                 for champ, valeur of attribut['input']['options']
#                     input.append(valeur)
#             
#             
#             window.light_box_information.html_content(input)
#             window.light_box_information.append_content(hidden_input)
#             #SPAN INFOS
#             if attribut['span_infos']
#                 span_infos = $(document.createElement('span'))
#                 span_infos.text(attribut['span_infos']['text'])
#                 window.light_box_information.append_content(span_infos)
#             
#             
#             #BUTTON FOOTER
#             span = $(document.createElement('span'))
#             span.addClass('button')
#             
#             a = $(document.createElement('a'))
#             a.addClass(attribut['link']['class'])
#             a.text(attribut['link']['text'])
#             
#             span.append(a)                        
#            
#             span_annuler = window.light_box_information.create_annuler()
#             
#             window.light_box_information.html_footer(span_annuler)
#             window.light_box_information.append_footer(span)
#             span.on('click',()->
#                 card.update_information(this)
#             )
#         
#         update_information: (button)->
#             url = '/administration/users/7/stocks/4'
#             user_id = $('input.user_id').val()
#             
#             tab_concerned = $(button).parent('.footer').prev('.content').children('input[type="hidden"]').attr('id').replace('_id','')
#             id_entite = $(button).parent('.footer').prev('.content').children('#'+tab_concerned+'_id').val()
#             champ = $(button).parent('.footer').prev('.content').children().first().attr('id').replace(tab_concerned+'_','')
#             val = $(button).parent('.footer').prev('.content').children().first().val()
#             data = {}
#             data[tab_concerned] = {}
#             data[tab_concerned][champ] = val
#             console.log($(button).parent('.footer').prev('.content').children('input[type="hidden"]'))        
#             $.ajax(
#                 type: 'PUT'
#                 url:'/administration/users/'+user_id+'/'+tab_concerned+'s/'+id_entite
#                 data:data
#                 format:'json'
#                 success:(data)->
#                     return data
#             )        

                    
                

#     card.event()
                
    
)