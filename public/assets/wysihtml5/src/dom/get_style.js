/**
 * Get element's style for a specific css property
 *
 * @param {Element} element The element on which to retrieve the style
 * @param {String} property The CSS property to retrieve ("float", "display", "text-align", ...)
 *
 * @example
 *    wysihtml5.dom.getStyle("display").from(document.body);
 *    // => "block"
 */
wysihtml5.dom.getStyle=function(){function n(e){return e.replace(t,function(e){return e.charAt(1).toUpperCase()})}var e={"float":"styleFloat"in document.createElement("div").style?"styleFloat":"cssFloat"},t=/\-[a-z]/g;return function(t){return{from:function(r){if(r.nodeType!==wysihtml5.ELEMENT_NODE)return;var i=r.ownerDocument,s=e[t]||n(t),o=r.style,u=r.currentStyle,a=o[s];if(a)return a;if(u)try{return u[s]}catch(f){}var l=i.defaultView||i.parentWindow,c=(t==="height"||t==="width")&&r.nodeName==="TEXTAREA",h,p;if(l.getComputedStyle)return c&&(h=o.overflow,o.overflow="hidden"),p=l.getComputedStyle(r,null).getPropertyValue(t),c&&(o.overflow=h||""),p}}}}();