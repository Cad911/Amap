/**
 * Walks the dom tree from the given node up until it finds a match
 * Designed for optimal performance.
 *
 * @param {Element} node The from which to check the parent nodes
 * @param {Object} matchingSet Object to match against (possible properties: nodeName, className, classRegExp)
 * @param {Number} [levels] How many parents should the function check up from the current node (defaults to 50)
 * @return {null|Element} Returns the first element that matched the desiredNodeName(s)
 * @example
 *    var listElement = wysihtml5.dom.getParentElement(document.querySelector("li"), { nodeName: ["MENU", "UL", "OL"] });
 *    // ... or ...
 *    var unorderedListElement = wysihtml5.dom.getParentElement(document.querySelector("li"), { nodeName: "UL" });
 *    // ... or ...
 *    var coloredElement = wysihtml5.dom.getParentElement(myTextNode, { nodeName: "SPAN", className: "wysiwyg-color-red", classRegExp: /wysiwyg-color-[a-z]/g });
 */
wysihtml5.dom.getParentElement=function(){function e(e,t){return!t||!t.length?!0:typeof t=="string"?e===t:wysihtml5.lang.array(t).contains(e)}function t(e){return e.nodeType===wysihtml5.ELEMENT_NODE}function n(e,t,n){var r=(e.className||"").match(n)||[];return t?r[r.length-1]===t:!!r.length}function r(t,n,r){while(r--&&t&&t.nodeName!=="BODY"){if(e(t.nodeName,n))return t;t=t.parentNode}return null}function i(r,i,s,o,u){while(u--&&r&&r.nodeName!=="BODY"){if(t(r)&&e(r.nodeName,i)&&n(r,s,o))return r;r=r.parentNode}return null}return function(e,t,n){return n=n||50,t.className||t.classRegExp?i(e,t.nodeName,t.className,t.classRegExp,n):r(e,t.nodeName,n)}}();