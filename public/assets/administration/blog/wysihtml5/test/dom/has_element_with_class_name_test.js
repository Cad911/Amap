if("querySelector"in document||wysihtml5.browser.supportsNativeGetElementsByClassName())module("wysihtml5.dom.hasElementWithClassName",{teardown:function(){var e;while(e=document.querySelector("iframe.wysihtml5-sandbox"))e.parentNode.removeChild(e)}}),asyncTest("Basic test",function(){expect(3),(new wysihtml5.dom.Sandbox(function(e){var t=e.getDocument(),n=t.createElement("i");n.className="wysiwyg-color-aqua",ok(!wysihtml5.dom.hasElementWithClassName(t,"wysiwyg-color-aqua")),t.body.appendChild(n),ok(wysihtml5.dom.hasElementWithClassName(t,"wysiwyg-color-aqua")),n.parentNode.removeChild(n),ok(!wysihtml5.dom.hasElementWithClassName(t,"wysiwyg-color-aqua")),start()})).insertInto(document.body)});