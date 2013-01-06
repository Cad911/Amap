/*
 * g.Raphael 0.5 - Charting library, based on Raphaël
 *
 * Copyright (c) 2009 Dmitry Baranovskiy (http://g.raphaeljs.com)
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
 */
(function(){function e(e,t,n,r,i,s){function y(e,t,n,r,i,s){var o=Math.PI/180,u=e+n*Math.cos(-r*o),a=e+n*Math.cos(-i*o),f=e+n/2*Math.cos(-(r+(i-r)/2)*o),l=t+n*Math.sin(-r*o),c=t+n*Math.sin(-i*o),h=t+n/2*Math.sin(-(r+(i-r)/2)*o),p=["M",e,t,"L",u,l,"A",n,n,0,+(Math.abs(i-r)>180),1,a,c,"z"];return p.middle={x:f,y:h},p}s=s||{};var o=this,u=[],a=e.set(),f=e.set(),l=e.set(),c=[],h=i.length,p=0,d=0,v=0,m=9,g=!0;f.covers=a;if(h==1)l.push(e.circle(t,n,r).attr({fill:o.colors[0],stroke:s.stroke||"#fff","stroke-width":s.strokewidth==null?1:s.strokewidth})),a.push(e.circle(t,n,r).attr(o.shim)),d=i[0],i[0]={value:i[0],order:0,valueOf:function(){return this.value}},l[0].middle={x:t,y:n},l[0].mangle=180;else{for(var b=0;b<h;b++)d+=i[b],i[b]={value:i[b],order:b,valueOf:function(){return this.value}};i.sort(function(e,t){return t.value-e.value});for(b=0;b<h;b++)g&&i[b]*360/d<=1.5&&(m=b,g=!1),b>m&&(g=!1,i[m].value+=i[b],i[m].others=!0,v=i[m].value);h=Math.min(m+1,i.length),v&&i.splice(h)&&(i[m].others=!0);for(b=0;b<h;b++){var w=p-360*i[b]/d/2;b||(p=90-w,w=p-360*i[b]/d/2);if(s.init)var E=y(t,n,1,p,p-360*i[b]/d).join(",");var S=y(t,n,r,p,p-=360*i[b]/d),x=e.path(s.init?E:S).attr({fill:s.colors&&s.colors[b]||o.colors[b]||"#666",stroke:s.stroke||"#fff","stroke-width":s.strokewidth==null?1:s.strokewidth,"stroke-linejoin":"round"});x.value=i[b],x.middle=S.middle,x.mangle=w,u.push(x),l.push(x),s.init&&x.animate({path:S.join(",")},+s.init-1||1e3,">")}for(b=0;b<h;b++)x=e.path(u[b].attr("path")).attr(o.shim),s.href&&s.href[b]&&x.attr({href:s.href[b]}),x.attr=function(){},a.push(x),l.push(x)}f.hover=function(e,s){s=s||function(){};var o=this;for(var u=0;u<h;u++)(function(u,a,f){var l={sector:u,cover:a,cx:t,cy:n,mx:u.middle.x,my:u.middle.y,mangle:u.mangle,r:r,value:i[f],total:d,label:o.labels&&o.labels[f]};a.mouseover(function(){e.call(l)}).mouseout(function(){s.call(l)})})(l[u],a[u],u);return this},f.each=function(e){var s=this;for(var o=0;o<h;o++)(function(o,u,a){var f={sector:o,cover:u,cx:t,cy:n,x:o.middle.x,y:o.middle.y,mangle:o.mangle,r:r,value:i[a],total:d,label:s.labels&&s.labels[a]};e.call(f)})(l[o],a[o],o);return this},f.click=function(e){var s=this;for(var o=0;o<h;o++)(function(o,u,a){var f={sector:o,cover:u,cx:t,cy:n,mx:o.middle.x,my:o.middle.y,mangle:o.mangle,r:r,value:i[a],total:d,label:s.labels&&s.labels[a]};u.click(function(){e.call(f)})})(l[o],a[o],o);return this},f.inject=function(e){e.insertBefore(a[0])};var T=function(u,c,p,v){var m=t+r+r/5,g=n,y=g+10;u=u||[],v=v&&v.toLowerCase&&v.toLowerCase()||"east",p=e[p&&p.toLowerCase()]||"circle",f.labels=e.set();for(var b=0;b<h;b++){var w=l[b].attr("fill"),E=i[b].order,S;i[b].others&&(u[E]=c||"Others"),u[E]=o.labelise(u[E],i[b],d),f.labels.push(e.set()),f.labels[b].push(e[p](m+5,y,5).attr({fill:w,stroke:"none"})),f.labels[b].push(S=e.text(m+20,y,u[E]||i[E]).attr(o.txtattr).attr({fill:s.legendcolor||"#000","text-anchor":"start"})),a[b].label=f.labels[b],y+=S.getBBox().height*1.2}var x=f.labels.getBBox(),T={east:[0,-x.height/2],west:[-x.width-2*r-20,-x.height/2],north:[-r-x.width/2,-r-x.height-10],south:[-r-x.width/2,r+10]}[v];f.labels.translate.apply(f.labels,T),f.push(f.labels)};return s.legend&&T(s.legend,s.legendothers,s.legendmark,s.legendpos),f.push(l,a),f.series=l,f.covers=a,f}var t=function(){};t.prototype=Raphael.g,e.prototype=new t,Raphael.fn.piechart=function(t,n,r,i,s){return new e(this,t,n,r,i,s)}})();