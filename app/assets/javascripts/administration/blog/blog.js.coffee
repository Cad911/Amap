$(document).ready(()->
    wysiwyg_function = 
        init:()->
            wysihtml5ParserRules =
                tags:
                    "img":
                        "check_attributes":
                            "width":200
                            "alt":"alt"
                            "src":"src"
                            "height":""
                            
            editor = new wysihtml5.Editor("user_nom",{
              toolbar: "toolbar-edit"
              parserRules: wysihtml5ParserRules
            })
            this.event()

        event:()->
            that = this
            $('.button_insert_image').on('click',()->
                $('.lightbox_insert_image').css('display','block')
            )
            
            $('.input_image').bind('change',()->
                file = this.files[0]; 				
                if ( window.FileReader )  
                    reader = new FileReader();
                    total = 0;
                    reader.onloadend  = (evt)->
                        $('.apercu_image').attr("src",evt.target.result);
                    
                    # reader.onloadstart = (evt)->
    #                     total = evt.total;
    #                     $('#progress_modif_img').css('display','block');
    #                 
    #                 reader.onprogress = (evt)->
    #                     var width = evt.loaded*100/total;
    #                     $('#progress_modif_img div').css('width',width+'%');
                    
                    reader.readAsDataURL(file)
                
            )
            $('.button_add_image').on('click',()->
                that.upload_image()
            )
        upload_image:()->
            xhr = XMLHttpRequest()
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/blog/upload_image')
            
            form = new FormData()
            fileInput = $('.input_image')[0]    
            form.append('image_blog',fileInput.files[0])
            console.log(form)  
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
                    $('.input_wysihtml5_image').val(data['path'])
                    $('.button_wysihtml5_save_image').trigger('click')
            

      
    wysiwyg_function.init()
    #editor.composer.commands.exec("insertImage", { src: "http://url.com/foo.jpg", alt: "this is an image" });
    #http://lemalesaint.fr/wp-content/uploads/2012/09/tumblr_max4nsgJXG1qbih6so1_500.jpg
)
