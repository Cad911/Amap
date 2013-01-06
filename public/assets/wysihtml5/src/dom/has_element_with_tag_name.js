/**
 * High performant way to check whether an element with a specific tag name is in the given document
 * Optimized for being heavily executed
 * Unleashes the power of live node lists
 *
 * @param {Object} doc The document object of the context where to check
 * @param {String} tagName Upper cased tag name
 * @example
 *    wysihtml5.dom.hasElementWithTagName(document, "IMG");
 */
wysihtml5.dom.hasElementWithTagName=function(){function n(e){return e._wysihtml5_identifier||(e._wysihtml5_identifier=t++)}var e={},t=1;return function(t,r){var i=n(t)+":"+r,s=e[i];return s||(s=e[i]=t.getElementsByTagName(r)),s.length>0}}();