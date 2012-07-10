// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var function_add_produit, function_modif_produit, recup_info_produit, useful_function;
    function_add_produit = {
      id_user: ($('.button-add').attr('id')).replace('user_', ''),
      init: function() {
        return this.evenement_button();
      },
      evenement_button: function() {
        return $('.button-add').bind("ajax:complete", function(et, e) {
          var verif_produit_en_vente;
          verif_produit_en_vente = recup_info_produit.all_produit_en_vente();
          if (verif_produit_en_vente['all_deja_vente'] === true) {
            if ($('.alert-error').length === 0) {
              return message_information.message_error('.button-add', 'Erreur', 'Tous les produits du stock sont déjà en vente', 2000);
            }
          } else {
            $('#light_box').html(e.responseText);
            function_add_produit.evenement_form(verif_produit_en_vente['stock_id']);
            return $('#light_box').modal('show');
          }
        });
      },
      evenement_form: function(id_stock_default) {
        var previous_id;
        $('#produit_vente_libre_stock_id').val(id_stock_default);
        recup_info_produit.info_stock(id_stock_default);
        previous_id = 0;
        $('#produit_vente_libre_stock_id').focus(function() {
          return previous_id = $(this).val();
        }).change(function() {
          var text_previous;
          text_previous = $('#produit_vente_libre_stock_id option:selected').text();
          if (recup_info_produit.produit_deja_envente($(this).val())) {
            $(this).val(previous_id);
            return message_information.message_error('#produit_vente_libre_stock_id', 'Erreur', text_previous + ' est déjà en vente', 2000);
          } else {
            return recup_info_produit.info_stock($(this).val());
          }
        });
        $('.etape_3 input').change(function() {
          var inputid;
          inputid = '#' + $(this).attr('id');
          return useful_function.verif_one_input(inputid);
        });
        $('#produit_vente_libre_quantite, #produit_vente_libre_nombre_pack').change(function() {
          return function_add_produit.verif_quantite();
        });
        $('#new_produit_vente_libre').submit(function() {
          var all_input, quantite_good;
          all_input = useful_function.verif_all_input('.etape_active', '.form-inputs');
          quantite_good = function_add_produit.verif_quantite();
          if (all_input || quantite_good) {
            return false;
          } else {
            return true;
          }
        });
        $('.form-actions .next').click(function() {
          return function_add_produit.next_step();
        });
        $('.form-actions .previous').click(function() {
          return function_add_produit.previous_step();
        });
        $('.simple_form').bind("ajax:loading", function(et, e) {
          alert(e);
          return $('#light_box').html('<div class="progress progress-striped"> <div class="bar" style="width:20%"> </div></div>');
        });
        return $('.simple_form').bind("ajax:complete", function(et, e) {
          return $('#light_box').modal('hide');
        });
      },
      verif_quantite: function() {
        var nombre_pack, quantite_mise_en_ligne, quantite_stock_v, resultat_reste;
        if (!isNaN(parseInt($('#produit_vente_libre_quantite').val())) && !isNaN(parseInt($('#produit_vente_libre_nombre_pack').val()))) {
          quantite_mise_en_ligne = parseInt($('#produit_vente_libre_quantite').val());
          nombre_pack = parseInt($('#produit_vente_libre_nombre_pack').val());
          quantite_stock_v = recup_info_produit.quantite_stock($('#produit_vente_libre_stock_id').val());
          resultat_reste = quantite_stock_v - (nombre_pack * quantite_mise_en_ligne);
          console.log(resultat_reste);
          if (resultat_reste < 0) {
            if (!$('div').hasClass('error_quantite')) {
              message_information.message_error('.alert-info', 'Erreur', 'La quantite mis en ligne excede celle du stock ', 2000, 'error_quantite');
              return true;
            }
          } else {
            if (!$('div').hasClass('info_reste_quantite')) {
              message_information.message_success('.alert-info', 'Infos', 'Il vous restera ' + resultat_reste + ' ' + $("#unite_mesure_stock").text() + ' dans votre stock ', 2000, 'info_reste_quantite');
            } else {
              message_information.message_success('.alert-info', 'Infos', 'Il vous restera ' + resultat_reste + ' ' + $("#unite_mesure_stock").text() + ' dans votre stock ', 2000, 'info_reste_quantite');
            }
            return false;
          }
        } else {
          return false;
        }
      },
      next_step: function() {
        var class_div, class_next, i, _i;
        for (i = _i = 0; _i <= 5; i = ++_i) {
          if ($('.etape_active').hasClass('etape_' + i)) {
            class_div = 'etape_' + i;
            console.log(class_div);
            if ($('.etape_formulaire').hasClass('etape_' + (i + 1))) {
              class_next = 'etape_' + (i + 1);
            }
          }
        }
        $('.' + class_div).slideUp('5000');
        $('.' + class_next).slideDown('5000');
        $('.' + class_next).addClass('etape_active');
        return $('.' + class_div).removeClass('etape_active');
      },
      previous_step: function() {
        var class_div, class_previous, i, _i;
        for (i = _i = 0; _i <= 5; i = ++_i) {
          if ($('.etape_active').hasClass('etape_' + i)) {
            class_div = 'etape_' + i;
            console.log(class_div);
            if ($('.etape_formulaire').hasClass('etape_' + (i - 1))) {
              class_previous = 'etape_' + (i - 1);
            }
          }
        }
        $('.' + class_div).slideUp('5000');
        $('.' + class_previous).slideDown('5000');
        $('.' + class_previous).addClass('etape_active');
        return $('.' + class_div).removeClass('etape_active');
      }
    };
    function_modif_produit = {
      id_user: ($('.button-add').attr('id')).replace('user_', ''),
      id_product: 0,
      id_stock: 0,
      quantity_stock: 0,
      event: function() {
        return $('.modifier_product').bind("ajax:complete", function(et, e) {
          var id_product, info_produit;
          id_product = ($(this).attr('id')).replace('produit_vente_libre_', '');
          info_produit = recup_info_produit.info_product(id_product);
          function_modif_produit.init_var(info_produit['stock']['quantite'], id_product, info_produit['stock']['id']);
          $('#light_box').html(e.responseText);
          $('#light_box').modal('show');
          return function_modif_produit.event_form();
        });
      },
      init_var: function(_quantity_stock, _id_product, _id_stock) {
        function_modif_produit.quantity_stock = _quantity_stock;
        function_modif_produit.id_product = _id_product;
        return function_modif_produit.id_stock = _id_stock;
      },
      event_form: function() {
        $('#produit_vente_libre_quantite, #produit_vente_libre_nombre_pack').change(function() {
          return function_modif_produit.verif_quantite();
        });
        $('.edit_produit_vente_libre input').bind('change', function() {
          var inputid;
          inputid = '#' + $(this).attr('id');
          return useful_function.verif_one_input(inputid);
        });
        $('.edit_produit_vente_libre .envoi_form').bind('click', function() {
          if (useful_function.verif_all_input('.edit_produit_vente_libre', '.edit_produit_vente_libre .alert-info')) {
            return false;
          } else {
            return true;
          }
        });
        return $('.edit_produit_vente_libre').bind("ajax:complete", function(et, e) {
          $('#light_box').html('');
          return $('#light_box').modal('hide');
        });
      },
      verif_quantite: function() {
        var le_message, nombre_pack, quantite_mise_en_ligne, resultat_reste;
        if (!isNaN(parseInt($('.modif_formulaire #produit_vente_libre_quantite').val())) && !isNaN(parseInt($('.modif_formulaire #produit_vente_libre_nombre_pack').val()))) {
          quantite_mise_en_ligne = parseInt($('.modif_formulaire #produit_vente_libre_quantite').val());
          nombre_pack = parseInt($('.modif_formulaire #produit_vente_libre_nombre_pack').val());
          resultat_reste = function_modif_produit.quantity_stock - (nombre_pack * quantite_mise_en_ligne);
          if (resultat_reste < 0) {
            if (!$('div').hasClass('error_quantite')) {
              message_information.message_error('.alert-info', 'Erreur', 'La quantite mis en ligne excede celle du stock ', 2000, 'error_quantite');
              return true;
            }
          } else {
            le_message = 'Il vous restera ' + resultat_reste + ' ' + $("#unite_mesure_stock").text() + ' dans votre stock ';
            message_information.message_success('.alert-info', 'Infos', le_message, 2000, 'info_reste_quantite');
          }
          return false;
        } else {
          return false;
        }
      }
    };
    useful_function = {
      verif_one_input: function(id_input) {
        var erreur_;
        erreur_ = false;
        if ($(id_input).hasClass('required')) {
          if ($(id_input).val() === "") {
            div_state.div_warning($(id_input), 'Ne peut pas être vide');
            erreur_ = true;
          }
        }
        if (erreur_ === false) {
          if ($(id_input).attr('type') === "number") {
            if (isNaN(parseInt($(id_input).val())) && $(id_input).val() !== '') {
              div_state.div_warning($(id_input), 'Ce n\'est pas un nombre');
              erreur_ = true;
            } else {
              div_state.div_success($(id_input), '');
            }
          }
        }
        return erreur_;
      },
      verif_all_input: function(id_formulaire, id_for_msg_error) {
        var erreur;
        erreur = false;
        $(id_formulaire + ' input').each(function() {
          if (useful_function.verif_one_input('#' + ($(this).attr('id'))) === true) {
            erreur = true;
          }
          if (erreur === true) {
            if (!$('div').hasClass('all_error')) {
              return message_information.message_error(id_for_msg_error, 'Erreur', 'Corrigé vos erreur', 2000, 'all_error');
            }
          }
        });
        return erreur;
      }
    };
    function_modif_produit.event();
    recup_info_produit = {
      all_produit_en_vente: function() {
        var all_exist;
        all_exist = {};
        $.ajax("/administration/users/" + function_add_produit.id_user + "/all_exist_vente", {
          type: "GET",
          async: false,
          format: "json",
          success: function(data) {
            all_exist = data;
            return true;
          }
        });
        return all_exist;
      },
      produit_deja_envente: function(id_produit) {
        var exist_deja;
        exist_deja = false;
        $.ajax("/administration/users/" + function_add_produit.id_user + "/one_exist_vente/" + id_produit, {
          type: "GET",
          async: false,
          format: "json",
          success: function(data) {
            exist_deja = data;
            return true;
          }
        });
        return exist_deja;
      },
      info_product: function(product_id) {
        var infos;
        infos = {};
        $.ajax("/administration/users/" + function_add_produit.id_user + "/produit_vente_libres/" + product_id, {
          type: "GET",
          async: false,
          format: "json",
          success: function(data) {
            return infos = data;
          }
        });
        return infos;
      },
      info_stock: function(stock_id) {
        $.ajax("/administration/users/" + function_add_produit.id_user + "/stocks/" + stock_id, {
          type: "GET",
          async: false,
          format: "json",
          success: function(data) {
            $('#produit_vente_libre_titre').val(data[0]["titre"]);
            $('#produit_vente_libre_description').val(data[0]["description"]);
            $('#quantite_stock').text(data[0]["quantite"]);
            $('#unite_mesure_stock').text(data[1]["abbreviation"]);
            return false;
          }
        });
        return true;
      },
      quantite_stock: function(stock_id) {
        var quantite_stock_return;
        quantite_stock_return = 0;
        $.ajax("/administration/users/" + id_user + "/stocks/" + stock_id, {
          type: "GET",
          async: false,
          format: "json",
          success: function(data) {
            return quantite_stock_return = parseInt(data[0]["quantite"]);
          }
        });
        return quantite_stock_return;
      }
    };
    return function_add_produit.init();
  });

}).call(this);
