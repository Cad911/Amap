// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var animation_display, cageot, cloud, slider;
    cloud = {
      "generate_big_cloud": function(nombre_nuage, min_speed, max_speed) {
        var i, left, nb_nuage, time_interval, top, _results;
        nb_nuage = nombre_nuage;
        i = 0;
        _results = [];
        while (i < nb_nuage) {
          top = Math.floor(Math.random() * 80);
          left = 150 * Math.floor(Math.random() * 9);
          i++;
          $('.big_clouds').append("<span class='cloud cloud_" + i + "' style='position:absolute;top:" + top + "px;left:" + left + "px;'></span>");
          time_interval = cloud.random_perso(min_speed, max_speed);
          _results.push(cloud.move_cloud_2(".big_clouds .cloud_" + i, time_interval));
        }
        return _results;
      },
      "generate_little_cloud": function(nombre_nuage, min_speed, max_speed) {
        var i, left, nb_nuage, time_interval, top, _results;
        nb_nuage = nombre_nuage;
        i = 0;
        _results = [];
        while (i < nb_nuage) {
          top = Math.floor(Math.random() * 80);
          left = 120 * Math.floor(Math.random() * 9);
          i++;
          $('.little_clouds').append("<span class='cloud cloud_" + i + "' style='position:absolute;top:" + top + "px;left:" + left + "px;'></span>");
          time_interval = cloud.random_perso(min_speed, max_speed);
          _results.push(cloud.move_cloud_2(".little_clouds .cloud_" + i, time_interval));
        }
        return _results;
      },
      "move_cloud": function(class_cloud) {
        var left_cloud, taille_maxi;
        taille_maxi = $(window).width() - $(class_cloud).width();
        left_cloud = $(class_cloud).css('left');
        left_cloud = left_cloud.replace('px');
        if (parseInt(left_cloud) < taille_maxi) {
          left_cloud = parseInt(left_cloud) + 1;
        } else {
          left_cloud = 0;
        }
        return $(class_cloud).css('left', left_cloud + 'px');
      },
      "move_cloud_2": function(class_cloud, duree) {
        var taille_maxi;
        taille_maxi = $(window).width() - $(class_cloud).width();
        return $(class_cloud).animate({
          left: taille_maxi + "px"
        }, {
          duration: duree,
          easing: 'linear',
          complete: function() {
            $(class_cloud).css('left', '-150px');
            return cloud.move_cloud_2(class_cloud, duree);
          }
        });
      },
      "random_perso": function(min, max) {
        var var_random;
        var_random = Math.floor(Math.random() * max);
        if (var_random < min) {
          return cloud.random_perso(min, max);
        } else {
          return var_random;
        }
      }
    };
    slider = {
      "duration_fadeout": 0,
      "duration_fadein": 0,
      "duration_between": 0,
      "id_active": "",
      "next_id_active": "",
      "init": function(duration_fadeout, duration_fadein, duration_between) {
        slider.duration_fadeout = duration_fadeout;
        slider.duration_fadein = duration_fadein;
        slider.duration_between = duration_between;
        return setTimeout(slider.move_slide, slider.duration_between);
      },
      "move_slide": function() {
        var nb_slide, numero_slider;
        nb_slide = $('.container_slider>.slider').length;
        slider.id_active = $('.container_slider>.active').attr('id');
        numero_slider = parseInt(slider.id_active.replace('slider_', ''));
        if (numero_slider === nb_slide) {
          slider.next_id_active = 'slider_1';
        } else {
          slider.next_id_active = 'slider_' + (numero_slider + 1);
        }
        slider.fade_out();
        return slider.slide_out();
      },
      "set_inactive": function() {
        $("#" + slider.id_active).removeClass('active');
        return console.log(slider.id_active);
      },
      "set_active": function() {
        if ($("#" + slider.next_id_active + ">.content").length > 0) {
          $("#" + slider.next_id_active + ">.content").css('opacity', '0');
        }
        if ($("#" + slider.next_id_active + ">.image").length > 0) {
          $("#" + slider.next_id_active + ">.image").css('margin-left', '-5000px');
        }
        $("#" + slider.next_id_active).addClass('active');
        if ($("#" + slider.next_id_active + ">.content").length > 0) {
          console.log('test');
          slider.fade_in();
        }
        if ($("#" + slider.next_id_active + ">.image").length > 0) {
          return slider.slide_in();
        }
      },
      "fade_out": function() {
        return $("#" + slider.id_active + ">.content").animate({
          opacity: "0"
        }, {
          duration: slider.duration_fadeout
        });
      },
      "fade_in": function() {
        $("#" + slider.next_id_active + ">.content>.button").css('display', 'none');
        return $("#" + slider.next_id_active + ">.content").animate({
          opacity: "1"
        }, {
          duration: slider.duration_fadein,
          complete: function() {
            return $("#" + slider.next_id_active + ">.content>.button").fadeIn(1000);
          }
        });
      },
      "slide_in": function() {
        return $("#" + slider.next_id_active + ">.image").animate({
          marginLeft: "0px"
        }, {
          duration: slider.duration_fadein + 1000,
          complete: function() {
            return setTimeout(slider.move_slide, slider.duration_between);
          }
        });
      },
      "slide_out": function() {
        return $("#" + slider.id_active + ">.image").animate({
          marginLeft: "-6000px"
        }, {
          duration: slider.duration_fadeout,
          complete: function() {
            slider.set_inactive();
            return slider.set_active();
          }
        });
      }
    };
    cageot = {
      init: function() {
        cageot.form_event();
        return cageot.ajax_formulaire();
      },
      form_event: function() {
        $('#form_add_product #add_product').bind('click', function() {
          return $('#form_add_product').submit();
        });
        return cageot.event_form_generate(".l_dock_wrapper>ul>li");
      },
      event_form_generate: function(class_id) {
        $(class_id + '>span.deleted_p_c').bind('click', function() {
          console.log($(this).parent('li').attr('id'));
          return cageot["delete"]($(this).parent('li').attr('id'));
        });
        $(class_id + '>span.plus_quantite_p_c').bind('click', function() {
          return cageot.plus_quantite($(this).parent('li').attr('id'));
        });
        return $(class_id + '>span.moins_quantite_p_c').bind('click', function() {
          return cageot.moins_quantite($(this).parent('li').attr('id'));
        });
      },
      ajax_formulaire: function() {
        $('#form_add_product').bind('ajax:success', function(data, response) {
          var all_error;
          if (response.error) {
            return all_error = form_sinscrire.extract_error(response.error, "");
          } else {
            console.log($('.dock').css('display'));
            if ($('.dock').css('display') === 'none') cageot.show_dock();
            cageot.add(response);
            return cageot.update_html_price(response['total']);
          }
        });
        return $('#form_add_product').bind('ajax:error', function(data, response) {
          console.log(data);
          console.log(response);
          return message_information.message_error("form_sinscrire", "Erreur", response.responseText);
        });
      },
      add: function(response) {
        if (response['statut'] === "add") {
          cageot.add_html_product_in_cageot(response['produit']['id'], response['produit']['nombre_pack']);
          return cageot.event_form_generate(".l_dock_wrapper>ul>li#" + response['produit']['id']);
        } else {
          cageot.update_html_quantite(response['produit']['id'], response['produit']['nombre_pack']);
          return console.log('update');
        }
      },
      plus_quantite: function(id_product) {
        return $.ajax({
          type: "GET",
          url: '/cageot/ajoutQuantite/' + id_product,
          format: "json",
          success: function(data) {
            if (data['statut'] === true) {
              cageot.update_html_quantite(data['produit']['id'], data['produit']['nombre_pack']);
              return cageot.update_html_price(data['total']);
            }
          }
        });
      },
      moins_quantite: function(id_product) {
        return $.ajax({
          type: "GET",
          url: '/cageot/suppQuantite/' + id_product,
          format: "json",
          success: function(data) {
            if (data['statut'] === "update") {
              cageot.update_html_quantite(data['produit']['id'], data['produit']['nombre_pack']);
            } else if (data['statut'] === "delete") {
              $('li#' + id_product).remove();
            } else {

            }
            return cageot.verif_if_product_present(data['total']);
          }
        });
      },
      "delete": function(id_product) {
        return $.ajax({
          type: "DELETE",
          url: '/cageot/suppProduit/' + id_product,
          format: "json",
          success: function(data) {
            if (data['statut'] === true) {
              $('li#' + id_product).remove();
              return cageot.verif_if_product_present(data['total']);
            } else {

            }
          }
        });
      },
      verif_if_product_present: function(total_price) {
        if ($('.dock ul>li').length === 0) {
          cageot.hide_dock();
          return cageot.update_html_price(0);
        } else {
          return cageot.update_html_price(total_price);
        }
      },
      update_html_price: function(price) {
        return $('.checkout>.price').text(price + '€');
      },
      add_html_product_in_cageot: function(id_product, nb_pack) {
        var li_html;
        li_html = '<li id="' + id_product + '"><img src="" class="has_corners_shadow is_small">';
        li_html += '<span class="nombre_pack_p_c"> ' + nb_pack + ' </span> <span class="deleted_p_c"> deleted </span>';
        li_html += '<span class="plus_quantite_p_c"> + </span><span class="moins_quantite_p_c"> - </span>';
        li_html += '</li>';
        return $('.l_dock_wrapper>ul').prepend(li_html);
      },
      update_html_quantite: function(id_product, nb_pack) {
        return $('.l_dock_wrapper>ul>li#' + id_product + '>span.nombre_pack_p_c').text(nb_pack);
      },
      show_dock: function() {
        return $('.dock').slideDown(400, "swing");
      },
      hide_dock: function() {
        return $('.dock').slideUp(400, 'swing');
      }
    };
    animation_display = {
      init: function(opacity_debut, margin_, au_chargement_page) {
        if (au_chargement_page == null) au_chargement_page = true;
        animation_display.init_style(opacity_debut, margin_);
        if (au_chargement_page) {
          return animation_display.show_all(margin_);
        } else {
          animation_display.verif_scroll(margin_);
          return animation_display.see_div(margin_);
        }
      },
      see_div: function(margin_) {
        return $(document).scroll(function() {
          return animation_display.verif_scroll(margin_);
        });
      },
      verif_scroll: function(margin_) {
        return $('.move_left,.move_right').each(function() {
          var offset, position_bas_div, position_document_max, position_document_min, position_haut_div;
          offset = $(this).offset();
          position_haut_div = offset.top;
          position_bas_div = offset.top + $('.move_left').height();
          position_document_max = $(document).scrollTop() + $(window).height();
          position_document_min = $(document).scrollTop();
          if (position_document_max > position_bas_div && position_document_min < position_haut_div) {
            if ($(this).hasClass('move_left')) {
              animation_display.move_to_left(margin_, this);
            }
            if ($(this).hasClass('move_right')) {
              return animation_display.move_to_right(margin_, this);
            }
          }
        });
      },
      init_style: function(opacity_debut, margin_) {
        $('.move_left').each(function() {
          var actual_position, all_margin, new_position;
          if ($(this).css('margin-right') === "" && $(this).css('margin') === "") {
            $(this).css('margin-right', '0px');
          }
          if ($(this).css('margin-right') === "" && $(this).css('margin') !== "") {
            all_margin = $(this).css('margin').split(' ');
            $(this).css('margin-right', all_margin[1]);
          }
          actual_position = parseInt(($(this).css('margin-right')).replace('px'));
          new_position = (actual_position - margin_) + 'px';
          $(this).css('margin-right', new_position);
          return $(this).css('opacity', opacity_debut);
        });
        return $('.move_right').each(function() {
          var actual_position, all_margin, new_position;
          if ($(this).css('margin-left') === "" && $(this).css('margin') === "") {
            $(this).css('margin-left', '0px');
          }
          if ($(this).css('margin-left') === "" && $(this).css('margin') !== "") {
            all_margin = $(this).css('margin').split(' ');
            if (all_margin[3] !== void 0) {
              $(this).css('margin-left', all_margin[3]);
            } else {
              $(this).css('margin-left', all_margin[1]);
            }
          }
          actual_position = parseInt(($(this).css('margin-left')).replace('px'));
          new_position = (actual_position - margin_) + 'px';
          $(this).css('margin-left', new_position);
          return $(this).css('opacity', opacity_debut);
        });
      },
      show_all: function(margin_) {
        $('.move_left').each(function() {
          return animation_display.move_to_left(margin_, this);
        });
        return $('.move_right').each(function() {
          return animation_display.move_to_right(margin_, this);
        });
      },
      move_to_left: function(margin_, element) {
        if (element == null) element = '.move_left';
        if (!$(element).hasClass('move_done')) {
          $(element).addClass('move_done');
          return $(element).animate({
            marginRight: '+=' + margin_ + 'px',
            opacity: 1
          }, {
            duration: 1500,
            easing: 'swing'
          });
        }
      },
      move_to_right: function(margin_, element) {
        if (element == null) element = '.move_right';
        if (!$(element).hasClass('move_done')) {
          $(element).addClass('move_done');
          return $(element).animate({
            marginLeft: '+=' + margin_ + 'px',
            opacity: 1
          }, {
            duration: 1500,
            easing: 'swing'
          });
        }
      }
    };
    cloud.generate_big_cloud(2, 120000, 140000);
    cloud.generate_little_cloud(2, 150000, 180000);
    slider.init(1000, 1000, 5000);
    cageot.init();
    console.log($(document).scrollTop());
    console.log($(document).height());
    return animation_display.init(0.5, 20, false);
  });

}).call(this);
