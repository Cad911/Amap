// Generated by CoffeeScript 1.2.1-pre
(function(){var e;e=function(){function e(e,t){this.id_lightbox=e,this.div_in_lightbox=t!=null?t:!1,console.log("lalaal"),this.event()}return e.name="Lightbox",e.prototype.event=function(){var e;return e=this,$(".annuler,.close_lightbox").bind("click",function(){e.hide();if(e.div_in_lightbox!==!1)return e.hide_sous_div()})},e.prototype.link_top=function(e){var t,n;return n=$(document.createElement("a")),n.attr("href",e.link.mes_infos),n.text("Mes infos"),t=$(document.createElement("a")),t.attr("href",e.link.deconnexion),t.text("deconnexion"),$(".login>span.sign_in").html(n),$(".login>span.sign_up").html(t)},e.prototype.title_header=function(e){return $(this.id_lightbox+">.lightbox>.header>.title").text(e)},e.prototype.title_content=function(e){return $(this.id_lightbox+">.lightbox>.content>.title").text(e)},e.prototype.text_content=function(e){return $(this.id_lightbox+">.lightbox>.content>p").text(e)},e.prototype.hide=function(){return $(this.id_lightbox).css("display","none")},e.prototype.show=function(){return $(this.id_lightbox).css("display","block")},e.prototype.hide_sous_div=function(){return $(this.div_in_lightbox).css("display","none")},e.prototype.show_sous_div=function(){return $(this.div_in_lightbox).css("display","block")},e}(),exports.Lightbox=e}).call(this);