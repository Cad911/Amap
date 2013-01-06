/**
 * Fix most common html formatting misbehaviors of browsers implementation when inserting
 * content via copy & paste contentEditable
 *
 * @author Christopher Blum
 */
wysihtml5.quirks.cleanPastedHTML=function(){function t(t,n,r){n=n||e,r=r||t.ownerDocument||document;var i,s=typeof t=="string",o,u,a,f,l=0;s?i=wysihtml5.dom.getAsDom(t,r):i=t;for(f in n){u=i.querySelectorAll(f),o=n[f],a=u.length;for(;l<a;l++)o(u[l])}return u=t=n=null,s?i.innerHTML:i}var e={"a u":wysihtml5.dom.replaceWithChildNodes};return t}();