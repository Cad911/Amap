# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
    
    statisitques = 
        user_id : $('#id_user_stats').val()
        init: () ->
            $('.page-header').tooltip({'trigger': 'hover', 'placement': 'left'})
            statisitques.data_month()
            statisitques.data_year()
        data_month : () ->
            $.ajax(
                type:"POST",
                url: "/administration/users/#{statisitques.user_id}/ca_by_month"
                async:false,
                format : "json",
                success: (data) -> 
                    infos = data	
                    data_pie = [infos.CA_product_ttc,infos.CA_abonnement_ttc]
                    statisitques.create_pie(data_pie)
            )
        data_year : () ->
            $.ajax(
                type:"POST",
                url: "/administration/users/#{statisitques.user_id}/ca_by_year"
                async:false,
                format : "json",
                success: (data) -> 
                    infos = data	

                    
                    nb_month = 1
                    data_graph = []

                    while(nb_month<=12)
                        if nb_month < 10
                            nb_month_format = '0'+nb_month
                        else
                            nb_month_format = nb_month
                        data_graph.push({q: '2012-'+nb_month_format, a: infos['CA_increment'][nb_month]['CA_product_ttc'], b: infos['CA_increment'][nb_month]['CA_abonnement_ttc']})
                        nb_month++
                        
                    
                    statisitques.create_graph(data_graph)
                    
            )
        create_pie: (data) ->
             r = Raphael('camembert')
             camembert = r.piechart(320, 240, 100, data ,{legend: ["%%.%% - "+data[0]+" €","%%.%% - "+data[1]+" €"],legendpos: "est", colors: ["#59a494","#ea9d6e"]})
             $('#camembert path').css("box-shadow", "1px 1px 1px solid black")
             r.text(320, 100, "Chiffre d'affaire du mois").attr({ font: "20px sans-serif" });
             camembert.hover( () ->
                this.sector.stop();
                this.sector.scale(1.1, 1.1, this.cx, this.cy);

                if (this.label) 
                    this.label[0].stop();
                    this.label[0].attr({ r: 7.5 });
                    this.label[1].attr({ "font-weight": 800 });
             ,  
             () ->
                this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");

                if (this.label) 
                    this.label[0].animate({ r: 5 }, 500, "bounce");
                    this.label[1].attr({ "font-weight": 400 });
                
             )
          
        create_graph: (data_) ->  
            console.log(data_)
            Morris.Line(
                element: 'graph',
                data: data_,
                xkey: 'q',
                ykeys: ['a', 'b'],
                labels: ['CA produit', 'CA abonnement'],
                lineColors: ['#59a494','#ea9d6e'],
                lineWidth: 2,
                smooth:false,
                pointSize:3,
                hideHover:true,
                xLabels:"month",
                xLabelFormat:(x)->
                    switch x.getMonth()
                       when 0 then 'Jan.'
                       when 1 then 'Fév.'
                       when 2 then 'Ma.'
                       when 3 then 'Av.'
                       when 4 then 'Mai'
                       when 5 then 'Juin'
                       when 6 then 'Juil.'
                       when 7 then 'Aout'
                       when 8 then 'Sep.'
                       when 9 then 'Oct.'
                       when 10 then 'Nov.'
                       when 11 then 'Déc.'
            )
            
         


    statisitques.init()
    





)