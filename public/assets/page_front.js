(function(){$(document).ready(function(){var e,t,n,r,i,s,o;return n={generate_big_cloud:function(e,t,r){var i,s,o,u,a,f;o=e,i=0,f=[];while(i<o)a=Math.floor(Math.random()*80),s=150*Math.floor(Math.random()*9),i++,$(".big_clouds").append("<span class='cloud cloud_"+i+"' style='position:absolute;top:"+a+"px;left:"+s+"px;'></span>"),u=n.random_perso(t,r),f.push(n.move_cloud_2(".big_clouds .cloud_"+i,u));return f},generate_little_cloud:function(e,t,r){var i,s,o,u,a,f;o=e,i=0,f=[];while(i<o)a=Math.floor(Math.random()*80),s=120*Math.floor(Math.random()*9),i++,$(".little_clouds").append("<span class='cloud cloud_"+i+"' style='position:absolute;top:"+a+"px;left:"+s+"px;'></span>"),u=n.random_perso(t,r),f.push(n.move_cloud_2(".little_clouds .cloud_"+i,u));return f},move_cloud:function(e){var t,n;return n=$(window).width()-$(e).width(),t=$(e).css("left"),t=t.replace("px"),parseInt(t)<n?t=parseInt(t)+1:t=0,$(e).css("left",t+"px")},move_cloud_2:function(e,t){var r;return r=$(window).width()-$(e).width(),$(e).animate({left:r+"px"},{duration:t,easing:"linear",complete:function(){return $(e).css("left","-150px"),n.move_cloud_2(e,t)}})},random_perso:function(e,t){var r;return r=Math.floor(Math.random()*t),r<e?n.random_perso(e,t):r}},o={duration_fadeout:0,duration_fadein:0,duration_between:0,id_active:"",next_id_active:"",init:function(e,t,n){return o.duration_fadeout=e,o.duration_fadein=t,o.duration_between=n,setTimeout(o.move_slide,o.duration_between)},move_slide:function(){var e,t;return e=$(".container_slider>.slider").length,o.id_active=$(".container_slider>.active").attr("id"),t=parseInt(o.id_active.replace("slider_","")),t===e?o.next_id_active="slider_1":o.next_id_active="slider_"+(t+1),o.fade_out(),o.slide_out()},set_inactive:function(){return $("#"+o.id_active).removeClass("active"),console.log(o.id_active)},set_active:function(){$("#"+o.next_id_active+">.content").length>0&&$("#"+o.next_id_active+">.content").css("opacity","0"),$("#"+o.next_id_active+">.image").length>0&&$("#"+o.next_id_active+">.image").css("margin-left","-5000px"),$("#"+o.next_id_active).addClass("active"),$("#"+o.next_id_active+">.content").length>0&&(console.log("test"),o.fade_in());if($("#"+o.next_id_active+">.image").length>0)return o.slide_in()},fade_out:function(){return $("#"+o.id_active+">.content").animate({opacity:"0"},{duration:o.duration_fadeout})},fade_in:function(){return $("#"+o.next_id_active+">.content>.button").css("display","none"),$("#"+o.next_id_active+">.content").animate({opacity:"1"},{duration:o.duration_fadein,complete:function(){return $("#"+o.next_id_active+">.content>.button").fadeIn(1e3)}})},slide_in:function(){return $("#"+o.next_id_active+">.image").animate({marginLeft:"0px"},{duration:o.duration_fadein+1e3,complete:function(){return setTimeout(o.move_slide,o.duration_between)}})},slide_out:function(){return $("#"+o.id_active+">.image").animate({marginLeft:"-6000px"},{duration:o.duration_fadeout,complete:function(){return o.set_inactive(),o.set_active()}})}},t={in_process_order:!1,init:function(){t.ajax_formulaire(),t.event_form_generate(".l_dock_wrapper>ul>li"),$(".l_process_order ").length>0&&(t.in_process_order=!0,t.hide_dock()),$("#form_add_product").length>0&&t.form_event();if($(".add_product_link").length>0)return t.event_button_add()},event_button_add:function(){return $(".add_product_link").bind("click",function(){var e,n;return e=$(this).attr("id"),n=e.replace("product_",""),t.add_product_ajax(n)})},add_product_ajax:function(e){var n;return n={produit_vente_libre:{id:e,nombre_pack:1}},$.ajax({type:"POST",data:n,url:"/cageot/ajoutProduit",format:"json",success:function(e){return $(".dock").css("display")==="none"&&t.show_dock(),t.add(e),t.update_html_price(e.total)}})},form_event:function(){return $("#form_add_product #add_product").bind("click",function(){return $("#form_add_product").submit()})},event_form_generate:function(e){return $(e+">span.deleted_p_c").bind("click",function(){return console.log($(this).parent("li").attr("id")),t["delete"]($(this).parent("li").attr("id"))}),$(e+">div>span.plus_quantite_p_c").bind("click",function(){return t.plus_quantite($(this).parent("div").parent("li").attr("id"))}),$(e+">div>span.moins_quantite_p_c").bind("click",function(){return t.moins_quantite($(this).parent("div").parent("li").attr("id"))})},ajax_formulaire:function(){return $("#form_add_product").bind("ajax:success",function(e,n){var r;return n.error?r=form_sinscrire.extract_error(n.error,""):(console.log($(".dock").css("display")),$(".dock").css("display")==="none"&&t.show_dock(),t.add(n),t.update_html_price(n.total))}),$("#form_add_product").bind("ajax:error",function(e,t){return console.log(e),console.log(t),message_information.message_error("form_sinscrire","Erreur",t.responseText)})},add:function(e){return e.statut==="add"?(t.add_html_product_in_cageot(e.produit.id,e.produit.nombre_pack,e.url_image),t.event_form_generate(".l_dock_wrapper>ul>li#"+e.produit.id)):(t.update_html_quantite(e.produit.id,e.produit.nombre_pack),console.log("update"))},plus_quantite:function(e){return $.ajax({type:"GET",url:"/cageot/ajoutQuantite/"+e,format:"json",success:function(e){if(e.statut===!0){t.update_html_quantite(e.produit.id,e.produit.nombre_pack),t.update_html_price(e.total);if(t.in_process_order)return r.update_html_quantite(e),r.update_html_price(e)}}})},moins_quantite:function(e){return $.ajax({type:"GET",url:"/cageot/suppQuantite/"+e,format:"json",success:function(n){return n.statut==="update"?(t.update_html_quantite(n.produit.id,n.produit.nombre_pack),t.in_process_order&&(r.update_html_quantite(n),r.update_html_price(n))):n.statut==="delete"&&($("li#"+e).remove(),t.in_process_order&&(r.delete_quantity(n),r.update_html_price(0))),t.verif_if_product_present(n.total)}})},"delete":function(e){return $.ajax({type:"DELETE",url:"/cageot/suppProduit/"+e,format:"json",success:function(n){if(n.statut===!0)return $("li#"+e).remove(),t.verif_if_product_present(n.total),r.update_html_price(n)}})},verif_if_product_present:function(e){return $(".dock ul>li").length===0?(t.hide_dock(),t.update_html_price(0)):t.update_html_price(e)},update_html_price:function(e){var t;return t=(e+"").split("."),t[1]&&parseInt(t[1])===0&&(e=t[0]),$(".checkout>.price").text(e+"€")},add_html_product_in_cageot:function(e,t,n){var r,i,s,o,u,a,f,l,c;return u=$(document.createElement("li")),u.attr("id",e),n!==null?c=n.image.is_small.url:c="",o=$(document.createElement("img")),o.addClass("has_corners_shadow is_small"),o.attr("src",c),a=$(document.createElement("span")),a.addClass("nombre_pack_p_c"),a.text(t),r=$(document.createElement("span")),r.addClass("deleted_p_c"),s=$(document.createElement("div")),s.addClass("plus_btn"),l=$(document.createElement("span")),l.addClass("plus_quantite_p_c"),s.append(l),i=$(document.createElement("div")),i.addClass("minus_btn"),f=$(document.createElement("span")),f.addClass("moins_quantite_p_c"),i.append(f),u.append(o),u.append(a),u.append(r),u.append(s),u.append(i),$(".l_dock_wrapper>ul").prepend(u)},update_html_quantite:function(e,t){return console.log("quantite_ :"+e),$(".l_dock_wrapper>ul>li#"+e+">span.nombre_pack_p_c").text(t)},show_dock:function(){return $(".dock").slideDown(400,"swing")},hide_dock:function(){return $(".dock").slideUp(400,"swing")}},e={margin_:0,opacity_debut:1,init:function(t,n,r){return r==null&&(r=!0),e.margin_=n,e.opacity_debut=t,e.init_style(),r?e.show_all():(e.verif_scroll(),e.see_div())},init_style:function(){var t,n,r;$(".move_left").length>0&&($(".move_left").css("margin-right")===""&&$(".move_left").css("margin")===""&&$(".move_left").css("margin-right","0px"),$(".move_left").css("margin-right")===""&&$(".move_left").css("margin")!==""&&(n=$(".move_left").css("margin").split(" "),$(".move_left").css("margin-right",n[1])),t=parseInt($(".move_left").css("margin-right").replace("px")),r=t-e.margin_+"px",$(".move_left").css("margin-right",r),$(".move_left").css("opacity",e.opacity_debut)),$(".move_right").length>0&&$(".move_right").each(function(){return $(this).css("margin-left")===""&&$(this).css("margin")===""&&$(this).css("margin-left","0px"),$(this).css("margin-left")===""&&$(this).css("margin")!==""&&(n=$(this).css("margin").split(" "),n[3]!==void 0?$(this).css("margin-left",n[3]):$(this).css("margin-left",n[1])),t=parseInt($(this).css("margin-left").replace("px")),r=t-e.margin_+"px",console.log(r),$(this).css("margin-left",r),$(this).css("opacity",e.opacity_debut)}),$(".move_bottom").length>0&&($(".move_bottom").css("margin-top")===""&&$(".move_bottom").css("margin")===""&&$(".move_bottom").css("margin-top","0px"),$(".move_bottom").css("margin-top")===""&&$(".move_bottom").css("margin")!==""&&(n=$(".move_bottom").css("margin").split(" "),n[3]!==void 0?$(".move_bottom").css("margin-top",n[3]):$(".move_bottom").css("margin-top",n[1])),t=parseInt($(".move_bottom").css("margin-top").replace("px")),r=t-e.margin_+"px",$(".move_bottom").css("margin-top",r),$(".move_bottom").css("opacity",e.opacity_debut));if($(".move_top").length>0)return $(".move_top").css("margin-top")===""&&$(".move_top").css("margin")===""&&$(".move_top").css("margin-top","0px"),$(".move_top").css("margin-top")===""&&$(".move_top").css("margin")!==""&&(n=$(".move_top").css("margin").split(" "),n[3]!==void 0?$(".move_top").css("margin-top",n[3]):$(".move_top").css("margin-top",n[1])),t=parseInt($(".move_top").css("margin-top").replace("px")),r=t+e.margin_+"px",$(".move_top").css("margin-top",r),$(".move_top").css("opacity",e.opacity_debut)},see_div:function(t){return $(document).scroll(function(){return e.verif_scroll()})},verif_scroll:function(){return $(".move_left,.move_right,.move_top,.move_bottom").each(function(){var t,n,r,i,s;t=$(this).offset(),s=t.top,n=t.top+$(this).height(),r=$(document).scrollTop()+$(window).height(),i=$(document).scrollTop();if(r>s&&s>i&&r>n&&n>i){$(this).hasClass("move_left")&&e.move_to_left(this),$(this).hasClass("move_right")&&e.move_to_right(this),$(this).hasClass("move_bottom")&&e.move_to_bottom(this);if($(this).hasClass("move_top"))return e.move_to_top(this)}})},show_all:function(){return $(".move_left").each(function(){return e.move_to_left(this)}),$(".move_right").each(function(){return e.move_to_right(this)}),$(".move_bottom").each(function(){return e.move_to_bottom(this)}),$(".move_top").each(function(){return e.move_to_top(this)})},move_to_left:function(t){t==null&&(t=".move_left");if(!$(t).hasClass("move_done"))return $(t).addClass("move_done"),$(t).animate({marginRight:"+="+e.margin_+"px",opacity:1},{duration:1500,easing:"swing"})},move_to_right:function(t){t==null&&(t=".move_right");if(!$(t).hasClass("move_done"))return $(t).addClass("move_done"),$(t).animate({marginLeft:"+="+e.margin_+"px",opacity:1},{duration:1500,easing:"swing"})},move_to_bottom:function(t){t==null&&(t=".move_bottom");if(!$(t).hasClass("move_done"))return $(t).addClass("move_done"),$(t).animate({marginTop:"+="+e.margin_+"px",opacity:1},{duration:1500,easing:"swing"})},move_to_top:function(t){t==null&&(t=".move_top");if(!$(t).hasClass("move_done"))return $(t).addClass("move_done"),$(t).animate({marginTop:"-="+e.margin_+"px",opacity:1},{duration:1500,easing:"swing"})}},r={event:function(){if($(".raw_produit").length>0)return $(".price>div.close_square").bind("click",function(){var e;return e=$(this).parent("div").parent("div").parent("div").attr("id").replace("raw_",""),r.delete_quantity(e)}),$(".quantity>span.plus").bind("click",function(){var e;return e=parseInt($(this).parent("div").parent("div").parent("div").attr("id").replace("raw_","")),r.plus_quantity(e)}),$(".quantity>span.minus").bind("click",function(){var e;return e=$(this).parent("div").parent("div").parent("div").attr("id").replace("raw_",""),r.minus_quantity(e)})},plus_quantity:function(e){return t.plus_quantite(e)},minus_quantity:function(e){return t.moins_quantite(e)},delete_quantity:function(e){return t["delete"](e),$("#raw_"+e).animate({marginLeft:"-1000px"},{duration:1e3,complete:function(){return $(this).remove(),r.verif_si_product()}})},verif_si_product:function(){if($(".raw").length===0)return $(".products").append('<li class="raw"> Aucun produit </li>')},update_html_quantite:function(e){return $("#raw_"+e.produit.id+">.l_photo_description>.quantity>.sum").text(e.produit.nombre_pack)},update_html_price:function(e){return $(".total>p").text("Total "+e.total+" €")}},$(".sign_up,.sign_in").bind("click",function(){!$(this).hasClass("connected")&&$(this).hasClass("sign_up")&&(lightbox_connexion.hide_sous_div(),lightbox_inscription.show(),lightbox_inscription.show_sous_div());if(!$(this).hasClass("connected")&&$(this).hasClass("sign_in"))return lightbox_inscription.hide_sous_div(),lightbox_connexion.show(),lightbox_connexion.show_sous_div()}),i=new FormulaireSinscrire("#form_sinscrire_lightbox","#lightbox_sign_up"),s=new FormulaireSeConnecter("#form_se_connecter_lightbox","#lightbox_sign_in"),n.generate_big_cloud(2,12e4,14e4),n.generate_little_cloud(2,15e4,18e4),o.init(1e3,1e3,5e3),t.init(),e.init(.7,20,!1),r.event()})}).call(this);