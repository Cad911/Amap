/**
 * Unwraps an unordered/ordered list
 *
 * @param {Element} element The list element which should be unwrapped
 *
 * @example
 *    <!-- Assume the following dom: -->
 *    <ul id="list">
 *      <li>eminem</li>
 *      <li>dr. dre</li>
 *      <li>50 Cent</li>
 *    </ul>
 *
 *    <script>
 *      wysihtml5.dom.resolveList(document.getElementById("list"));
 *    </script>
 *
 *    <!-- Will result in: -->
 *    eminem<br>
 *    dr. dre<br>
 *    50 Cent<br>
 */
(function(e){function t(t){return e.getStyle("display").from(t)==="block"}function n(e){return e.nodeName==="BR"}function r(e){var t=e.ownerDocument.createElement("br");e.appendChild(t)}function i(e){if(e.nodeName!=="MENU"&&e.nodeName!=="UL"&&e.nodeName!=="OL")return;var i=e.ownerDocument,s=i.createDocumentFragment(),o=e.previousElementSibling||e.previousSibling,u,a,f,l,c;o&&!t(o)&&r(s);while(c=e.firstChild){a=c.lastChild;while(u=c.firstChild)f=u===a,l=f&&!t(u)&&!n(u),s.appendChild(u),l&&r(s);c.parentNode.removeChild(c)}e.parentNode.replaceChild(s,e)}e.resolveList=i})(wysihtml5.dom);