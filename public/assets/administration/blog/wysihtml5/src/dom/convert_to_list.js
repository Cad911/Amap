/**
 * Converts an HTML fragment/element into a unordered/ordered list
 *
 * @param {Element} element The element which should be turned into a list
 * @param {String} listType The list type in which to convert the tree (either "ul" or "ol")
 * @return {Element} The created list
 *
 * @example
 *    <!-- Assume the following dom: -->
 *    <span id="pseudo-list">
 *      eminem<br>
 *      dr. dre
 *      <div>50 Cent</div>
 *    </span>
 *
 *    <script>
 *      wysihtml5.dom.convertToList(document.getElementById("pseudo-list"), "ul");
 *    </script>
 *
 *    <!-- Will result in: -->
 *    <ul>
 *      <li>eminem</li>
 *      <li>dr. dre</li>
 *      <li>50 Cent</li>
 *    </ul>
 */
wysihtml5.dom.convertToList=function(){function e(e,t){var n=e.createElement("li");return t.appendChild(n),n}function t(e,t){return e.createElement(t)}function n(n,r){if(n.nodeName==="UL"||n.nodeName==="OL"||n.nodeName==="MENU")return n;var i=n.ownerDocument,s=t(i,r),o=n.querySelectorAll("br"),u=o.length,a,f,l,c,h,p,d,v,m;for(m=0;m<u;m++){c=o[m];while((h=c.parentNode)&&h!==n&&h.lastChild===c){if(wysihtml5.dom.getStyle("display").from(h)==="block"){h.removeChild(c);break}wysihtml5.dom.insert(c).after(c.parentNode)}}a=wysihtml5.lang.array(n.childNodes).get(),f=a.length;for(m=0;m<f;m++){v=v||e(i,s),l=a[m],p=wysihtml5.dom.getStyle("display").from(l)==="block",d=l.nodeName==="BR";if(p){v=v.firstChild?e(i,s):v,v.appendChild(l),v=null;continue}if(d){v=v.firstChild?null:v;continue}v.appendChild(l)}return n.parentNode.replaceChild(s,n),s}return n}();