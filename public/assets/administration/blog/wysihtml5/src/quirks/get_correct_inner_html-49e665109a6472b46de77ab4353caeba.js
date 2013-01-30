// See https://bugzilla.mozilla.org/show_bug.cgi?id=664398
//
// In Firefox this:
//      var d = document.createElement("div");
//      d.innerHTML ='<a href="~"></a>';
//      d.innerHTML;
// will result in:
//      <a href="%7E"></a>
// which is wrong
(function(e){var t="%7E";e.quirks.getCorrectInnerHTML=function(n){var r=n.innerHTML;if(r.indexOf(t)===-1)return r;var i=n.querySelectorAll("[href*='~'], [src*='~']"),s,o,u,a;for(a=0,u=i.length;a<u;a++)s=i[a].href||i[a].src,o=e.lang.string(s).replace("~").by(t),r=e.lang.string(r).replace(o).by(s);return r}})(wysihtml5);