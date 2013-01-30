/**
 * Takes an element, removes it and replaces it with it's childs
 * 
 * @param {Object} node The node which to replace with it's child nodes
 * @example
 *    <div id="foo">
 *      <span>hello</span>
 *    </div>
 *    <script>
 *      // Remove #foo and replace with it's children
 *      wysihtml5.dom.replaceWithChildNodes(document.getElementById("foo"));
 *    </script>
 */
wysihtml5.dom.replaceWithChildNodes=function(e){if(!e.parentNode)return;if(!e.firstChild){e.parentNode.removeChild(e);return}var t=e.ownerDocument.createDocumentFragment();while(e.firstChild)t.appendChild(e.firstChild);e.parentNode.replaceChild(t,e),e=t=null};