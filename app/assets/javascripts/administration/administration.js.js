// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var card, listing_tooltip, menu;
    menu = {
      hover_action: function() {
        $('.subnav').each(function() {
          if (!$(this).hasClass('subnav_isopen')) {
            return $(this).css({
              'margin-top': '-105px',
              'position': 'relative',
              'opacity': 0,
              'z-index': 1
            });
          }
        });
        $('.pannels>li').css({
          'position': 'relative',
          'z-index': 2
        });
        return $('li.stock').bind('click', function() {
          if ($('.subnav').hasClass('subnav_isopen')) {
            $('.subnav').animate({
              'marginTop': '-105px',
              'opacity': 0
            }, 1000);
            return $('.subnav').removeClass('subnav_isopen');
          } else {
            $('.subnav').animate({
              'marginTop': '0px',
              'opacity': 1
            }, 1000);
            return $('.subnav').addClass('subnav_isopen');
          }
        });
      }
    };
    menu.hover_action();
    listing_tooltip = {
      listing: function() {
        return $('.historique,.edit,.delete').tool_tip(1000);
      }
    };
    listing_tooltip.listing();
    card = {
      event: function() {
        return $('.card h2.title').bind('click', function() {
          return card.show_form('title', $(this).text());
        });
      },
      show_form: function(intitule, value) {
        if (intitule === 'title') {
          window.light_box_information.title_header('Titre');
        }
        card.generate_form(intitule, value);
        return window.light_box_information.show();
      },
      generate_form: function(intitule, value) {
        var input;
        if (intitule === 'title') {
          input = $(document.createElement('input'));
          input.attr('id', 'stock_titre');
          input.attr('type', 'text');
          input.attr('size', '50');
          input.attr('name', 'stock[titre]');
          input.val(value);
          input.addClass("string optional");
          return window.light_box_information.html_content(input);
        }
      }
    };
    return card.event();
  });

}).call(this);
