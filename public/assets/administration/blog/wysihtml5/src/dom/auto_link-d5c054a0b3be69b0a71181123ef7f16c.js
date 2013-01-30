/**
 * Find urls in descendant text nodes of an element and auto-links them
 * Inspired by http://james.padolsey.com/javascript/find-and-replace-text-with-javascript/
 *
 * @param {Element} element Container element in which to search for urls
 *
 * @example
 *    <div id="text-container">Please click here: www.google.com</div>
 *    <script>wysihtml5.dom.autoLink(document.getElementById("text-container"));</script>
 */
(function(e){function o(e){return l(e)?e:(e===e.ownerDocument.documentElement&&(e=e.ownerDocument.body),c(e))}function u(e){return e.replace(n,function(e,t){var n=(t.match(r)||[])[1]||"",o=s[n];t=t.replace(r,""),t.split(o).length>t.split(n).length&&(t+=n,n="");var u=t,a=t;return t.length>i&&(a=a.substr(0,i)+"..."),u.substr(0,4)==="www."&&(u="http://"+u),'<a href="'+u+'">'+a+"</a>"+n})}function a(e){var t=e._wysihtml5_tempElement;return t||(t=e._wysihtml5_tempElement=e.createElement("div")),t}function f(e){var t=e.parentNode,n=a(t.ownerDocument);n.innerHTML="<span></span>"+u(e.data),n.removeChild(n.firstChild);while(n.firstChild)t.insertBefore(n.firstChild,e);t.removeChild(e)}function l(e){var n;while(e.parentNode){e=e.parentNode,n=e.nodeName;if(t.contains(n))return!0;if(n==="body")return!1}return!1}function c(r){if(t.contains(r.nodeName))return;if(r.nodeType===e.TEXT_NODE&&r.data.match(n)){f(r);return}var i=e.lang.array(r.childNodes).get(),s=i.length,o=0;for(;o<s;o++)c(i[o]);return r}var t=e.lang.array(["CODE","PRE","A","SCRIPT","HEAD","TITLE","STYLE"]),n=/((https?:\/\/|www\.)[^\s<]{3,})/gi,r=/([^\w\/\-](,?))$/i,i=100,s={")":"(","]":"[","}":"{"};e.dom.autoLink=o,e.dom.autoLink.URL_REG_EXP=n})(wysihtml5);