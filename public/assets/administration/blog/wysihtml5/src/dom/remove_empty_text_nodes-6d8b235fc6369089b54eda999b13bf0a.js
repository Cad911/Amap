/**
 * Checks for empty text node childs and removes them
 *
 * @param {Element} node The element in which to cleanup
 * @example
 *    wysihtml5.dom.removeEmptyTextNodes(element);
 */
wysihtml5.dom.removeEmptyTextNodes=function(e){var t,n=wysihtml5.lang.array(e.childNodes).get(),r=n.length,i=0;for(;i<r;i++)t=n[i],t.nodeType===wysihtml5.TEXT_NODE&&t.data===""&&t.parentNode.removeChild(t)};