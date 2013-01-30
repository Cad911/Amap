/**
 * Simulate HTML5 placeholder attribute
 *
 * Needed since
 *    - div[contentEditable] elements don't support it
 *    - older browsers (such as IE8 and Firefox 3.6) don't support it at all
 *
 * @param {Object} parent Instance of main wysihtml5.Editor class
 * @param {Element} view Instance of wysihtml5.views.* class
 * @param {String} placeholderText
 *
 * @example
 *    wysihtml.dom.simulatePlaceholder(this, composer, "Foobar");
 */
(function(e){e.simulatePlaceholder=function(t,n,r){var i="placeholder",s=function(){n.hasPlaceholderSet()&&n.clear(),e.removeClass(n.element,i)},o=function(){n.isEmpty()&&(n.setValue(r),e.addClass(n.element,i))};t.observe("set_placeholder",o).observe("unset_placeholder",s).observe("focus:composer",s).observe("paste:composer",s).observe("blur:composer",o),o()}})(wysihtml5.dom);