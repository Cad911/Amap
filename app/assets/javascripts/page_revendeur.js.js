// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var filter_, link_li;
    filter_ = {
      init: function() {},
      event: function() {
        return $('.filter').bind('click', function() {
          if ($(this).hasClass('show_product')) {
            filter_.delete_ul();
            filter_.recup_product();
            if (filter_.already_filter('show_product')) {
              filter_.recup_basket();
            } else {
              if ($('.show_basket').hasClass('filter_active')) {
                $('.show_basket').removeClass('filter_active');
              }
            }
          }
          if ($(this).hasClass('show_basket')) {
            filter_.delete_ul();
            if (filter_.already_filter('show_basket')) {
              filter_.recup_product();
            } else {
              if ($('.show_product').hasClass('filter_active')) {
                $('.show_product').removeClass('filter_active');
              }
            }
            return filter_.recup_basket();
          }
        });
      },
      already_filter: function(class_id) {
        if ($('.' + class_id).hasClass('filter_active')) {
          $('.' + class_id).removeClass('filter_active');
          return true;
        } else {
          $('.' + class_id).addClass('filter_active');
          return false;
        }
      },
      recup_product: function() {
        var data_;
        data_ = {
          user_id: $('#user_id').val()
        };
        return $.ajax({
          type: "POST",
          data: data_,
          url: '/product_filter',
          format: "json",
          success: function(data) {
            var i, product;
            product = $.parseJSON(data);
            i = 0;
            while (i < product.length) {
              filter_.reload_ul(filter_.create_li('product', product[i]));
              i++;
            }
            return link_li.event('ul.farmers_products>li');
          }
        });
      },
      recup_basket: function() {
        var data_;
        data_ = {
          user_id: $('#user_id').val()
        };
        return $.ajax({
          type: "POST",
          data: data_,
          url: '/basket_filter',
          format: "json",
          success: function(data) {
            var i, product;
            product = $.parseJSON(data);
            i = 0;
            while (i < product.length) {
              filter_.reload_ul(filter_.create_li('basket', product[i]));
              i++;
            }
            return link_li.event('ul.farmers_products>li');
          }
        });
      },
      hide_li: function() {},
      show_li: function() {},
      delete_ul: function() {
        console.log('delete');
        return $('.farmers_products').html('');
      },
      reload_ul: function(li) {
        return $('ul.farmers_products').append(li);
      },
      create_li: function(category, data) {
        var a_button, div_call_toaction, div_content, div_description, div_image, div_issmall, div_purchase, img, li, p_descrption, p_title, span_button, span_category, span_note, span_price;
        li = $(document.createElement('li'));
        if (category === 'product') li.addClass('li_product');
        if (category === 'basket') li.addClass('li_basket');
        span_category = $(document.createElement('span'));
        span_category.addClass('category ' + category);
        div_description = $(document.createElement('div'));
        div_description.addClass('l_photo_description is_horizontal');
        div_image = $(document.createElement('div'));
        div_image.addClass('image');
        div_issmall = $(document.createElement('div'));
        div_issmall.addClass('has_corners_shadow is_small');
        img = $(document.createElement('img'));
        img.attr('src', data['default_image']);
        div_image.append(div_issmall.append(img));
        div_content = $(document.createElement('div'));
        div_content.addClass('content');
        p_title = $(document.createElement('p'));
        p_title.addClass('title');
        p_title.text(data['titre']);
        p_descrption = $(document.createElement('p'));
        p_descrption.addClass('description');
        p_descrption.text(data['description']);
        div_content.append(p_title);
        div_content.append(p_descrption);
        div_purchase = $(document.createElement('div'));
        div_purchase.addClass('purchase');
        span_price = $(document.createElement('span'));
        span_price.addClass('price');
        span_price.text(data['prix_unite_ttc'] + ' €');
        span_note = $(document.createElement('span'));
        span_note.addClass('note is_italic');
        if (category === 'product') span_note.text(' le ' + data['unite_mesure']);
        if (category === 'basket') {
          span_note.text(' pour ' + data['nb_personne'] + ' personnes');
        }
        div_call_toaction = $(document.createElement('div'));
        div_call_toaction.addClass('call_to_action');
        span_button = $(document.createElement('span'));
        span_button.addClass('button add_' + category + '_link');
        span_button.attr('id', category + '_' + data['id']);
        a_button = $(document.createElement('a'));
        a_button.text('ajouter au panier');
        div_call_toaction.append(span_button.append(a_button));
        div_purchase.append(span_price);
        div_purchase.append(span_note);
        div_purchase.append(div_call_toaction);
        div_description.append(div_image);
        div_description.append(div_content);
        div_description.append(div_purchase);
        li.append(span_category);
        li.append(div_description);
        return li;
      }
    };
    link_li = {
      event: function(li) {
        return $(li).bind('click', function() {
          var id_bakset, id_product, user_id;
          if ($(this).hasClass('li_product')) {
            id_product = ($(this).find('.add_product_link').attr('id')).replace('product_', '');
            user_id = $('#user_id').val();
            $(location).attr('href', '/page_produit/show/' + user_id + '/' + id_product);
            console.log('/page_produit/show/' + user_id + '/' + id_product);
          }
          if ($(this).hasClass('li_basket')) {
            id_bakset = ($(this).find('.add_basket_link').attr('id')).replace('basket_', '');
            user_id = $('#user_id').val();
            console.log('/page_panier/show/' + user_id + '/' + id_bakset);
            return $(location).attr('href', '/page_panier/show/' + user_id + '/' + id_bakset);
          }
        });
      },
      test: function() {}
    };
    filter_.event();
    return link_li.event('ul.farmers_products>li');
  });

}).call(this);
