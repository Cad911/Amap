 #__________________________________________________ CLASS LIGHTBOX _______________________________________
$(document).ready(->

    class window.Lightbox
        constructor : (@id_lightbox, @div_in_lightbox = false) ->
            @event()
        
        event: () ->
           that = this
           $('.annuler, .close_lightbox').bind('click',() ->
              that.hide()
              if that.div_in_lightbox != false
                  that.hide_sous_div()
           )
        
        css: (attribut)->
        	for champ, valeur of attribut
        		$(@id_lightbox+'>.lightbox').css(champ, valeur)
        link_top: (data) ->
           a_infos = $(document.createElement('a'))
           a_infos.attr('href',data['link']['mes_infos'])
           a_infos.text('Mes infos')
           
           a_deconnexion = $(document.createElement('a'))
           a_deconnexion.attr('href',data['link']['deconnexion'])
           a_deconnexion.attr('rel','nofollow')
           a_deconnexion.attr('data-method','delete')
           a_deconnexion.text('deconnexion')
           
           $('.login>span.sign_in, .login>span.sign_up').addClass('connected')
           
           $('.login>span.sign_in').html(a_infos)
           $('.login>span.sign_up').html(a_deconnexion)
        
        create_annuler: () ->
            span_annuler = $(document.createElement('span'))
            span_annuler.addClass('annuler close_lightbox')
            span_annuler.text('annuler')
            span_annuler.bind('click', ()->
                window.light_box_information.hide()
            )
            return span_annuler
        title_header: (texte) ->
             $(@id_lightbox+'>.lightbox>.header>.title').text(texte)
        
        title_content: (texte) ->
             $(@id_lightbox+'>.lightbox>.content>.title').text(texte)
        
        text_content:(texte) ->
             $(@id_lightbox+'>.lightbox>.content>p').text(texte)
        
        hide: () ->
            $(@id_lightbox).css('display','none')
            $('.overall_shadow').css('position','relative')
            window.light_box_information.css({
                'margin':'Opx',
                top:'0px',
                left:'0px',
                position:'relative',
                
            })
            
        show: () ->
            $(@id_lightbox).css('display','block')
            $('.overall_shadow').css('position','fixed')
            
        hide_sous_div: () ->
            $(@div_in_lightbox).css('display','none')
        show_sous_div: () ->
            $(@div_in_lightbox).css('display','block')
        
        append_content: (data)->
            $(@id_lightbox+'>.lightbox>.content').append(data)
        
        prepend_content: (data)->
            $(@id_lightbox+'>.lightbox>.content').prepend(data)
            
        html_content:(data)->
            $(@id_lightbox+'>.lightbox>.content').html(data)
        html_footer: (data)->
            $(@id_lightbox+'>.lightbox>.footer').html(data)
        append_footer: (data)->
            $(@id_lightbox+'>.lightbox>.footer').append(data)
            
        
            
  #_________________________________________________________________________________________________
    window.lightbox_connexion = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_connexion')
    window.lightbox_inscription = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_inscription')
    window.light_box_information = new Lightbox('.lightbox_information')

   # module.exports = Lightbox
)