# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( () ->
    
    window.statisitques = 
        user_id : $('.user_id').val()
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
                    #data_pie = [infos.CA_product_ttc,infos.CA_abonnement_ttc]
                    statisitques.create_pie(data)
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
             console.log(data)
             if data.CA_total_ttc == 0
             	h2_chiffre = $(document.createElement('h2'))
             	h2_chiffre.text('Aucun chiffre d\'affaire ce mois-ci')
             	$('#camembert').append(h2_chiffre)
             else
	             r = Raphael('camembert')
	             #AVEC CE PLUGIN VU QU IL N Y A QUE 2 INFOS, SI UNE VAUT 0 ALORS LE CAMEMBERT NE SE CONSTRUIT PAS, C'EST 
	             #POUR CA QUE JE METS UNE VALEUR TENDANT VERS 0 AFIN QUE LE CAMEMBERT SE CREER
	             if data.CA_product_ttc == 0
	             	data_pie = [1/100000,data.CA_abonnement_ttc]
	             	camembert = r.piechart(320, 240, 70, data_pie ,{legend: ["0% - 0 € (achat direct)","%% - "+data_pie[1]+" € (abonnement)"],legendpos: "est", colors: ["#59a494","#ea9d6e"]})
	             else if data.CA_abonnement_ttc == 0
	             	data_pie = [data.CA_product_ttc,1/100000]
	             	camembert = r.piechart(320, 240, 70, data_pie ,{legend: ["%% - "+data_pie[0]+" € (achat direct) ","0% - 0 € (abonnement)"],legendpos: "est", colors: ["#59a494","#ea9d6e"]})
	             else
	             	data_pie = [data.CA_product_ttc,data.CA_abonnement_ttc]
	             	data_pie = [data.CA_product_ttc,data.CA_abonnement_ttc]
	             	camembert = r.piechart(320, 240, 70, data_pie ,{legend: ["%% - "+data_pie[0]+" € ","%% - "+data_pie[1]+" €"],legendpos: "est", colors: ["#59a494","#ea9d6e"]})
	             
	             $('#camembert path').css("box-shadow", "1px 1px 1px solid black")
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
            
         
        hide:()->
        	$('#statistiques').slideUp(500)
        show:()->
        	$('#statistiques').slideDown(500)
        clear_stats: ()->
        	$('#camembert').html('')
        	$('#graph').html('')
        	
    #statisitques.init()
    





)