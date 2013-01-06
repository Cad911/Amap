/**
 * Copy a set of styles from one element to another
 * Please note that this only works properly across browsers when the element from which to copy the styles
 * is in the dom
 *
 * Interesting article on how to copy styles
 *
 * @param {Array} stylesToCopy List of styles which should be copied
 * @return {Object} Returns an object which offers the "from" method which can be invoked with the element where to
 *    copy the styles from., this again returns an object which provides a method named "to" which can be invoked 
 *    with the element where to copy the styles to (see example)
 *
 * @example
 *    var textarea    = document.querySelector("textarea"),
 *        div         = document.querySelector("div[contenteditable=true]"),
 *        anotherDiv  = document.querySelector("div.preview");
 *    wysihtml5.dom.copyStyles(["overflow-y", "width", "height"]).from(textarea).to(div).andTo(anotherDiv);
 *
 */
(function(e){var t=["-webkit-box-sizing","-moz-box-sizing","-ms-box-sizing","box-sizing"],n=function(t){return r(t)?parseInt(e.getStyle("width").from(t),10)<t.offsetWidth:!1},r=function(n){var r=0,i=t.length;for(;r<i;r++)if(e.getStyle(t[r]).from(n)==="border-box")return t[r]};e.copyStyles=function(r){return{from:function(i){n(i)&&(r=wysihtml5.lang.array(r).without(t));var s="",o=r.length,u=0,a;for(;u<o;u++)a=r[u],s+=a+":"+e.getStyle(a).from(i)+";";return{to:function(t){return e.setStyles(s).on(t),{andTo:arguments.callee}}}}}}})(wysihtml5.dom);