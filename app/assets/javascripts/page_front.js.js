// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var cloud;
    cloud = {
      "generate_big_cloud": function() {
        var i, left, nb_nuage, time_interval, top, _results;
        nb_nuage = 11;
        i = 0;
        _results = [];
        while (i < nb_nuage) {
          top = Math.floor(Math.random() * 80);
          left = 150 * i;
          i++;
          $('.big_clouds').append("<span class='cloud cloud_" + i + "' style='position:absolute;top:" + top + "px;left:" + left + "px;'></span>");
          time_interval = cloud.random_perso(150, 200);
          _results.push(setInterval(cloud.move_cloud, time_interval, ".big_clouds .cloud_" + i));
        }
        return _results;
      },
      "generate_little_cloud": function() {
        var i, left, nb_nuage, time_interval, top, _results;
        nb_nuage = 15;
        i = 0;
        _results = [];
        while (i < nb_nuage) {
          top = Math.floor(Math.random() * 80);
          left = 120 * i;
          i++;
          $('.little_clouds').append("<span class='cloud cloud_" + i + "' style='position:absolute;top:" + top + "px;left:" + left + "px;'></span>");
          time_interval = cloud.random_perso(100, 150);
          _results.push(setInterval(cloud.move_cloud, time_interval, ".little_clouds .cloud_" + i));
        }
        return _results;
      },
      "move_cloud": function(class_cloud) {
        var left_cloud, taille_maxi;
        taille_maxi = $(window).width();
        left_cloud = $(class_cloud).css('left');
        left_cloud = left_cloud.replace('px');
        if (parseInt(left_cloud) < taille_maxi) {
          left_cloud = parseInt(left_cloud) + 1;
        } else {
          left_cloud = 0;
        }
        return $(class_cloud).css('left', left_cloud + 'px');
      },
      "random_perso": function(debut, fin) {
        var var_random;
        var_random = Math.floor(Math.random() * fin);
        if (var_random < debut) {
          return cloud.random_perso(debut, fin);
        } else {
          return var_random;
        }
      }
    };
    cloud.generate_big_cloud();
    return cloud.generate_little_cloud();
  });

}).call(this);
