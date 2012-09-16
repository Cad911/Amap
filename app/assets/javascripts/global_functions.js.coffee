window.global_functions = 
    standard_input:(data)->
        # data = 
#             type_element:'input',
#             label:
#                 text:''
#             input:
#                 value:'' #tableau d'obj si select {value:'',text:''},....   , string si input
#                 name:''
#                 class:''
#                 id:''
                
        div = $(document.createElement('div'))
        if data['type_element'] == 'select'
            class_div = 'control-group select optional'
        else if data['type_element'] == 'input' || data['type_element'] == 'textarea'
            class_div = 'control-group string optional'
        else if data['type_element'] == 'radio'
            class_div = 'control-group string optional'
        div.addClass(class_div)
        
        label = $(document.createElement('label'))
        label.addClass('string optional control-label')
        label.text(data['label']['text'])
        
        div.append(label)
        
        sous_div = $(document.createElement('div'))
        sous_div.addClass('controls')
        
        #----- select ----------
        if data['type_element'] == 'select'
            input = $(document.createElement('select'))
            for champ, valeur of data['input']['options']
                option = $(document.createElement('option'))
                option.attr('value',valeur['value'])
                option.text(valeur['text'])
                if valeur['value'] == data['input']['value']
                    option.attr('selected','selected')
                input.append(option)
       
        #-------- input ----------
        else if data['type_element'] == 'input'
            input = $(document.createElement('input'))
            if data['input']['value']
                input.val(data['input']['value'])
        
        #---- radio -------
        else if data['type_element'] == 'radio'
            for champ, valeur of data['input']['value'] 
                span = $(document.createElement('span'))
                
                label = $(document.createElement('label'))
                label.text(valeur[1])
                
                input_ = $(document.createElement('input'))
                input_.attr('type', 'radio')
                input_.attr('value',valeur[0])
                input_.attr('name',data['input']['name'])
                if data['input']['class'] != undefined   
                    input_.addClass(data['input']['class'])
                
                span.append(input_)
                span.append(label)
                
                sous_div.append(span)
            
            
                
                
       #--------- textarea -----------
        else if data['type_element'] == 'textarea'
            input = $(document.createElement('textarea'))
            if data['input']['value']
                input.val(data['input']['value'])
        
        
        #--------- si pas bouton radio ----------
        if  data['type_element'] != 'radio'   
            input.attr('name',data['input']['name'])
            if data['input']['class'] != undefined   
                input.addClass(data['input']['class'])
            
            if data['input']['id'] != undefined
                input.attr('id', data['input']['id'])
            
            if data['input']['other_attributes'] != undefined
                for champ, valeur of data['input']['other_attributes']    
                    input.attr(valeur[0], valeur[1])
            
            sous_div.append(input)
            
            div.append(sous_div)
            return div
        else
            div.append(sous_div)
            return div
        
        
        
        
        
        # <div class="control-group string optional">
#             <label for="stock_titre" class="string optional control-label"> Titre</label>
#             <div class="controls">
#                 <input type="text" size="50" name="stock[titre]" id="stock_titre" class="string optional">
#             </div>
#         </div>

    standard_button:(data)->
        # data = 
#             link: 
#                 text:''
#                 event:[{type:'click', callback:function()]
        p = $(document.createElement('p'))
        span_add = $(document.createElement('span'))
        
        a = $(document.createElement('a'))
        a.text(data['link']['text'])
        span_add.addClass('button '+data['link']['class_span'])
        
        for champ, valeur of data['link']['event']
            a.on(valeur['type'],()->
                switch (valeur['callback'].length)
                    when 1
                        valeur['callback'][0]()
                    when 2
                        valeur['callback'][0](valeur['callback'][1])
                    when 3
                        valeur['callback'][0](valeur['callback'][1],valeur['callback'][2])
                    when 4
                        valeur['callback'][0](valeur['callback'][1],valeur['callback'][2],valeur['callback'][3])
                    when 5
                        valeur['callback'][0](valeur['callback'][1],valeur['callback'][2],valeur['callback'][3],valeur['callback'][4])
                #valeur['callback'][0]()
            )
        
        #all in div_form
        span_add.append(a)
        p.append(span_add)
        
        return p
        