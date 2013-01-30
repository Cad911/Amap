/**
 * Force rerendering of a given element
 * Needed to fix display misbehaviors of IE
 *
 * @param {Element} element The element object which needs to be rerendered
 * @example
 *    wysihtml5.quirks.redraw(document.body);
 */
(function(e){var t="wysihtml5-quirks-redraw";e.quirks.redraw=function(n){e.dom.addClass(n,t),e.dom.removeClass(n,t);try{var r=n.ownerDocument;r.execCommand("italic",!1,null),r.execCommand("italic",!1,null)}catch(i){}}})(wysihtml5);