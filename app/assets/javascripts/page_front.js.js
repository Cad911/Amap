// Generated by CoffeeScript 1.2.1-pre
(function() {

  $(document).ready(function() {
    var cloud, slider;
    cloud = {
      "generate_big_cloud": function(nombre_nuage, min_speed, max_speed) {
        var i, left, nb_nuage, time_interval, top, _results;
        nb_nuage = nombre_nuage;
        i = 0;
        _results = [];
        while (i < nb_nuage) {
          top = Math.floor(Math.random() * 80);
          left = 150 * i;
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
          left = 120 * i;
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
      "init": function() {}
    };
    cloud.generate_big_cloud(2, 60000, 70000);
    cloud.generate_little_cloud(2, 90000, 100000);
    return slider.init();
  });

}).call(this);
