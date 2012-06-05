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
        
        title_header: (texte) ->
             $(@id_lightbox+'>.lightbox>.header>.title').text(texte)
        
        title_content: (texte) ->
             $(@id_lightbox+'>.lightbox>.content>.title').text(texte)
        
        text_content:(texte) ->
             $(@id_lightbox+'>.lightbox>.content>p').text(texte)
        
        hide: () ->
            $(@id_lightbox).css('display','none')
        show: () ->
            $(@id_lightbox).css('display','block')
            
        hide_sous_div: () ->
            $(@div_in_lightbox).css('display','none')
        show_sous_div: () ->
            $(@div_in_lightbox).css('display','block')
            
  #_________________________________________________________________________________________________
    window.lightbox_connexion = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_connexion')
    window.lightbox_inscription = new Lightbox('.lightbox_connexion_inscription','.lightbox_form_inscription')
    window.light_box_information = new Lightbox('.lightbox_information')

   # module.exports = Lightbox
)