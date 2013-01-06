/**
 * Method to set dom events
 *
 * @example
 *    wysihtml5.dom.observe(iframe.contentWindow.document.body, ["focus", "blur"], function() { ... });
 */
wysihtml5.dom.observe=function(e,t,n){t=typeof t=="string"?[t]:t;var r,i,s=0,o=t.length;for(;s<o;s++)i=t[s],e.addEventListener?e.addEventListener(i,n,!1):(r=function(t){"target"in t||(t.target=t.srcElement),t.preventDefault=t.preventDefault||function(){this.returnValue=!1},t.stopPropagation=t.stopPropagation||function(){this.cancelBubble=!0},n.call(e,t)},e.attachEvent("on"+i,r));return{stop:function(){var i,s=0,o=t.length;for(;s<o;s++)i=t[s],e.removeEventListener?e.removeEventListener(i,n,!1):e.detachEvent("on"+i,r)}}};