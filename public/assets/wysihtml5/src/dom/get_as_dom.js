/**
 * Returns the given html wrapped in a div element
 *
 * Fixing IE's inability to treat unknown elements (HTML5 section, article, ...) correctly
 * when inserted via innerHTML
 * 
 * @param {String} html The html which should be wrapped in a dom element
 * @param {Obejct} [context] Document object of the context the html belongs to
 *
 * @example
 *    wysihtml5.dom.getAsDom("<article>foo</article>");
 */
wysihtml5.dom.getAsDom=function(){var e=function(e,t){var n=t.createElement("div");n.style.display="none",t.body.appendChild(n);try{n.innerHTML=e}catch(r){}return t.body.removeChild(n),n},t=function(e){if(e._wysihtml5_supportsHTML5Tags)return;for(var t=0,r=n.length;t<r;t++)e.createElement(n[t]);e._wysihtml5_supportsHTML5Tags=!0},n=["abbr","article","aside","audio","bdi","canvas","command","datalist","details","figcaption","figure","footer","header","hgroup","keygen","mark","meter","nav","output","progress","rp","rt","ruby","svg","section","source","summary","time","track","video","wbr"];return function(n,r){r=r||document;var i;return typeof n=="object"&&n.nodeType?(i=r.createElement("div"),i.appendChild(n)):wysihtml5.browser.supportsHTML5Tags(r)?(i=r.createElement("div"),i.innerHTML=n):(t(r),i=e(n,r)),i}}();