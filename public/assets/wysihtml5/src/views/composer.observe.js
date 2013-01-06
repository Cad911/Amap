/**
 * Taking care of events
 *  - Simulating 'change' event on contentEditable element
 *  - Handling drag & drop logic
 *  - Catch paste events
 *  - Dispatch proprietary newword:composer event
 *  - Keyboard shortcuts
 */
(function(e){var t=e.dom,n=e.browser,r={66:"bold",73:"italic",85:"underline"};e.views.Composer.prototype.observe=function(){var i=this,s=this.getValue(),o=this.sandbox.getIframe(),u=this.element,a=n.supportsEventsInIframeCorrectly()?u:this.sandbox.getWindow(),f=n.supportsEvent("drop")?["drop","paste"]:["dragdrop","paste"];t.observe(o,"DOMNodeRemoved",function(){clearInterval(l),i.parent.fire("destroy:composer")});var l=setInterval(function(){t.contains(document.documentElement,o)||(clearInterval(l),i.parent.fire("destroy:composer"))},250);t.observe(a,"focus",function(){i.parent.fire("focus").fire("focus:composer"),setTimeout(function(){s=i.getValue()},0)}),t.observe(a,"blur",function(){s!==i.getValue()&&i.parent.fire("change").fire("change:composer"),i.parent.fire("blur").fire("blur:composer")}),e.browser.isIos()&&t.observe(u,"blur",function(){var e=u.ownerDocument.createElement("input"),t=document.documentElement.scrollTop||document.body.scrollTop,n=document.documentElement.scrollLeft||document.body.scrollLeft;try{i.selection.insertNode(e)}catch(r){u.appendChild(e)}e.focus(),e.parentNode.removeChild(e),window.scrollTo(n,t)}),t.observe(u,"dragenter",function(){i.parent.fire("unset_placeholder")}),n.firesOnDropOnlyWhenOnDragOverIsCancelled()&&t.observe(u,["dragover","dragenter"],function(e){e.preventDefault()}),t.observe(u,f,function(e){var t=e.dataTransfer,r;t&&n.supportsDataTransfer()&&(r=t.getData("text/html")||t.getData("text/plain")),r?(u.focus(),i.commands.exec("insertHTML",r),i.parent.fire("paste").fire("paste:composer"),e.stopPropagation(),e.preventDefault()):setTimeout(function(){i.parent.fire("paste").fire("paste:composer")},0)}),t.observe(u,"keyup",function(t){var n=t.keyCode;(n===e.SPACE_KEY||n===e.ENTER_KEY)&&i.parent.fire("newword:composer")}),this.parent.observe("paste:composer",function(){setTimeout(function(){i.parent.fire("newword:composer")},0)}),n.canSelectImagesInContentEditable()||t.observe(u,"mousedown",function(e){var t=e.target;t.nodeName==="IMG"&&(i.selection.selectNode(t),e.preventDefault())}),t.observe(u,"keydown",function(e){var t=e.keyCode,n=r[t];(e.ctrlKey||e.metaKey)&&!e.altKey&&n&&(i.commands.exec(n),e.preventDefault())}),t.observe(u,"keydown",function(t){var n=i.selection.getSelectedNode(!0),r=t.keyCode,s;n&&n.nodeName==="IMG"&&(r===e.BACKSPACE_KEY||r===e.DELETE_KEY)&&(s=n.parentNode,s.removeChild(n),s.nodeName==="A"&&!s.firstChild&&s.parentNode.removeChild(s),setTimeout(function(){e.quirks.redraw(u)},0),t.preventDefault())});var c={IMG:"Image: ",A:"Link: "};t.observe(u,"mouseover",function(e){var t=e.target,n=t.nodeName,r;if(n!=="A"&&n!=="IMG")return;var i=t.hasAttribute("title");i||(r=c[n]+(t.getAttribute("href")||t.getAttribute("src")),t.setAttribute("title",r))})}})(wysihtml5);