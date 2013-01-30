/**
 * IE and Opera leave an empty paragraph in the contentEditable element after clearing it
 *
 * @param {Object} contentEditableElement The contentEditable element to observe for clearing events
 * @exaple
 *    wysihtml5.quirks.ensureProperClearing(myContentEditableElement);
 */
(function(e){var t=e.dom;e.quirks.ensureProperClearing=function(){var e=function(e){var t=this;setTimeout(function(){var e=t.innerHTML.toLowerCase();if(e=="<p>&nbsp;</p>"||e=="<p>&nbsp;</p><p>&nbsp;</p>")t.innerHTML=""},0)};return function(n){t.observe(n.element,["cut","keydown"],e)}}(),e.quirks.ensureProperClearingOfLists=function(){var n=["OL","UL","MENU"],r=function(r,i){if(!i.firstChild||!e.lang.array(n).contains(i.firstChild.nodeName))return;var s=t.getParentElement(r,{nodeName:n});if(!s)return;var o=s==i.firstChild;if(!o)return;var u=s.childNodes.length<=1;if(!u)return;var a=s.firstChild?s.firstChild.innerHTML==="":!0;if(!a)return;s.parentNode.removeChild(s)};return function(n){t.observe(n.element,"keydown",function(t){if(t.keyCode!==e.BACKSPACE_KEY)return;var i=n.selection.getSelectedNode();r(i,n.element)})}}()})(wysihtml5);