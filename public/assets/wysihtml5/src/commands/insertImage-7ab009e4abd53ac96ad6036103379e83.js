(function(e){var t="IMG";e.commands.insertImage={exec:function(n,r,i){i=typeof i=="object"?i:{src:i};var s=n.doc,o=this.state(n),u,a,f;if(o){n.selection.setBefore(o),f=o.parentNode,f.removeChild(o),e.dom.removeEmptyTextNodes(f),f.nodeName==="A"&&!f.firstChild&&(n.selection.setAfter(f),f.parentNode.removeChild(f)),e.quirks.redraw(n.element);return}o=s.createElement(t);for(a in i)o[a]=i[a];n.selection.insertNode(o),e.browser.hasProblemsSettingCaretAfterImg()?(u=s.createTextNode(e.INVISIBLE_SPACE),n.selection.insertNode(u),n.selection.setAfter(u)):n.selection.setAfter(o)},state:function(n){var r=n.doc,i,s,o;return e.dom.hasElementWithTagName(r,t)?(i=n.selection.getSelectedNode(),i?i.nodeName===t?i:i.nodeType!==e.ELEMENT_NODE?!1:(s=n.selection.getText(),s=e.lang.string(s).trim(),s?!1:(o=n.selection.getNodes(e.ELEMENT_NODE,function(e){return e.nodeName==="IMG"}),o.length!==1?!1:o[0])):!1):!1},value:function(e){var t=this.state(e);return t&&t.src}}})(wysihtml5);