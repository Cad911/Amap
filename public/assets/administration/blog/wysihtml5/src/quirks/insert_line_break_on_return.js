/**
 * Some browsers don't insert line breaks when hitting return in a contentEditable element
 *    - Opera & IE insert new <p> on return
 *    - Chrome & Safari insert new <div> on return
 *    - Firefox inserts <br> on return (yippie!)
 *
 * @param {Element} element
 *
 * @example
 *    wysihtml5.quirks.insertLineBreakOnReturn(element);
 */
(function(e){var t=e.dom,n=["LI","P","H1","H2","H3","H4","H5","H6"],r=["UL","OL","MENU"];e.quirks.insertLineBreakOnReturn=function(i){function s(n){var r=t.getParentElement(n,{nodeName:["P","DIV"]},2);if(!r)return;var s=document.createTextNode(e.INVISIBLE_SPACE);t.insert(s).before(r),t.replaceWithChildNodes(r),i.selection.selectNode(s)}function o(o){var u=o.keyCode;if(o.shiftKey||u!==e.ENTER_KEY&&u!==e.BACKSPACE_KEY)return;var a=o.target,f=i.selection.getSelectedNode(),l=t.getParentElement(f,{nodeName:n},4);if(l){l.nodeName!=="LI"||u!==e.ENTER_KEY&&u!==e.BACKSPACE_KEY?l.nodeName.match(/H[1-6]/)&&u===e.ENTER_KEY&&setTimeout(function(){s(i.selection.getSelectedNode())},0):setTimeout(function(){var e=i.selection.getSelectedNode(),n,o;if(!e)return;n=t.getParentElement(e,{nodeName:r},2);if(n)return;s(e)},0);return}u===e.ENTER_KEY&&!e.browser.insertsLineBreaksOnReturn()&&(i.commands.exec("insertLineBreak"),o.preventDefault())}t.observe(i.element.ownerDocument,"keydown",o)}})(wysihtml5);