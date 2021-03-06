// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var dem_produit_enstock, exist_deja, info_produit_autorise, previous_id, produit_deja_enstock;
    previous_id = "";
    exist_deja = false;
    info_produit_autorise = function(id_pa) {
      this.id_user = $('#stock_id_user_input').val();
      $.ajax("/administration/users/" + this.id_user + "/produit_autorises/" + id_pa, {
        type: "GET",
        async: false,
        format: "json",
        success: function(data) {
          $('#stock_titre').val(data['titre']);
          $('#stock_description').val(data['description']);
          return true;
        }
      });
      return true;
    };
    produit_deja_enstock = function(id_produit) {
      this.id_user = $('#stock_id_user_input').val();
      $.ajax("/administration/users/" + this.id_user + "/exist_stock/" + id_produit, {
        type: "GET",
        async: false,
        format: "json",
        success: function(data) {
          exist_deja = data;
          return true;
        }
      });
      return exist_deja;
    };
    $('#stock_produit_autorise_id').click(function() {
      return previous_id = $(this).val();
    }).change(function() {
      if (produit_deja_enstock($(this).val())) {
        alert('Deja dans le stock');
        return $(this).val(previous_id);
      } else {
        return info_produit_autorise($(this).val());
      }
    });
    info_produit_autorise($('#stock_produit_autorise_id').val());
    if (produit_deja_enstock($('#stock_produit_autorise_id').val())) {
      dem_produit_enstock = false;
      $('#stock_produit_autorise_id option').each(function() {
        var value_option;
        value_option = $(this).attr("value");
        if (!produit_deja_enstock(value_option)) {
          dem_produit_enstock = true;
          $('#stock_produit_autorise_id').val(value_option);
          return info_produit_autorise(value_option);
        }
      });
      if (!dem_produit_enstock) {
        return alert('Tous les produits autorisé sont en stock');
      }
    }
  });

}).call(this);
