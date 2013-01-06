/**
 * High performant way to check whether an element with a specific class name is in the given document
 * Optimized for being heavily executed
 * Unleashes the power of live node lists
 *
 * @param {Object} doc The document object of the context where to check
 * @param {String} tagName Upper cased tag name
 * @example
 *    wysihtml5.dom.hasElementWithClassName(document, "foobar");
 */
(function(e){function r(e){return e._wysihtml5_identifier||(e._wysihtml5_identifier=n++)}var t={},n=1;e.dom.hasElementWithClassName=function(n,i){if(!e.browser.supportsNativeGetElementsByClassName())return!!n.querySelector("."+i);var s=r(n)+":"+i,o=t[s];return o||(o=t[s]=n.getElementsByClassName(i)),o.length>0}})(wysihtml5);