wysihtml5.lang.array=function(e){return{contains:function(t){if(e.indexOf)return e.indexOf(t)!==-1;for(var n=0,r=e.length;n<r;n++)if(e[n]===t)return!0;return!1},without:function(t){t=wysihtml5.lang.array(t);var n=[],r=0,i=e.length;for(;r<i;r++)t.contains(e[r])||n.push(e[r]);return n},get:function(){var t=0,n=e.length,r=[];for(;t<n;t++)r.push(e[t]);return r}}};