/**
 * Event Delegation
 *
 * @example
 *    wysihtml5.dom.delegate(document.body, "a", "click", function() {
 *      // foo
 *    });
 */
(function(e){e.dom.delegate=function(t,n,r,i){return e.dom.observe(t,r,function(r){var s=r.target,o=e.lang.array(t.querySelectorAll(n));while(s&&s!==t){if(o.contains(s)){i.call(s,r);break}s=s.parentNode}})}})(wysihtml5);