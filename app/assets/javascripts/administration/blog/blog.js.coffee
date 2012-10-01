$(document).ready(()->
    wysiwyg_function = 
        #editorInstance:{}
        init:()->
            that = this
            # wysihtml5ParserRules =
#                 tags:
#                     "img":
#                         "check_attributes":
#                             "width":"100"
#                             "alt":"alt"
#                             "src":"src"
#                             "height":"100"
                            
            that.editorInstance = new wysihtml5.Editor("article_content",
              #toolbar: "toolbar-edit"
              parserRules: wysihtml5ParserRules
              stylesheets:"/assets/blog/admin.css"
            )
            this.event()
            console.log(that)

        event:()->
            that = this
            $('.button_insert_image').on('click',()->
                $('.lightbox_insert_image').css('display','block')
            )
            
            $('li.link').on('click',()->
                $('.lightbox_insert_link').css('display','block')
            )
            
            $('.button_add_link').on('click',()->
                (that.editorInstance).focus()
                that.editorInstance.composer.commands.exec("createLink",{ href:$('.input_link').val(), target: "_blank", rel: "nofollow" })
                $('.lightbox_insert_link').css('display','none')
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
            
            $('li.bold').on('click', ()->
                that.editorInstance.composer.commands.exec("bold")
            )
            
            $('li.italic').on('click', ()->
                that.editorInstance.composer.commands.exec("italic")
            )
            $('li.list_blog').on('click',()->
              #   that.editorInstance.composer.commands.exec("justifyCenter")
#                 $('.wysiwyg-text-align-center').css('text-align','center')
                that.editorInstance.composer.commands.exec("insertUnorderedList");
            )
            
            $('li.h1').on('click', ()->
                that.editorInstance.composer.commands.exec("formatBlock", "h1")
            )
            
            $('li.h2').on('click', ()->
                that.editorInstance.composer.commands.exec("formatBlock", "h2")
            )
            
        upload_image:()->
            that = this
            xhr = new XMLHttpRequest()
            xhr.open('POST','/administration/users/'+$('.user_id').val()+'/blog/upload_image')
            
            form = new FormData()
            fileInput = $('.input_image')[0]    
            form.append('image_blog',fileInput.files[0])
            console.log(form)  
            xhr.send(form)
            
            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    #console.log(xhr.responseText)
                    data = JSON.parse(xhr.responseText)
            
                    #$('.input_wysihtml5_image').val(data['path'])
                    
                    console.log(that.editorInstance)

                    (that.editorInstance).focus()
                    (that.editorInstance).composer.commands.exec("insertImage",{
                            src:data['path']
                            alt:'test'
                            width:100
                    })   
                    $('.lightbox_insert_image').css('display','none')              
            

    if $('#article_categorie_blog_id').length > 0
        wysiwyg_function.init()
    #editor.composer.commands.exec("insertImage", { src: "http://url.com/foo.jpg", alt: "this is an image" });
    #http://lemalesaint.fr/wp-content/uploads/2012/09/tumblr_max4nsgJXG1qbih6so1_500.jpg
)
