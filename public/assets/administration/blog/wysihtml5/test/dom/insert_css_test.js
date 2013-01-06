module("wysihtml5.dom.insertCSS",{teardown:function(){var e;while(e=document.querySelector("iframe.wysihtml5-sandbox"))e.parentNode.removeChild(e)}}),asyncTest("Basic Tests",function(){expect(3),(new wysihtml5.dom.Sandbox(function(e){var t=e.getDocument(),n=t.body,r=t.createElement("sub");n.appendChild(r),wysihtml5.dom.insertCSS(["sub  { display: block; text-align: right; }","body { text-indent: 50px; }"]).into(t),equal(wysihtml5.dom.getStyle("display").from(r),"block"),equal(wysihtml5.dom.getStyle("text-align").from(r),"right"),equal(wysihtml5.dom.getStyle("text-indent").from(r),"50px"),start()})).insertInto(document.body)});