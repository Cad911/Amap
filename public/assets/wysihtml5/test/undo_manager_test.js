wysihtml5.browser.supportsCommand(document,"insertHTML")&&(module("wysihtml5.UndoManager",{setup:function(){this.textareaElement=document.createElement("textarea"),this.textareaElement.value="1",document.body.appendChild(this.textareaElement)},teardown:function(){var e;while(e=document.querySelector("iframe.wysihtml5-sandbox, input[name='_wysihtml5_mode']"))e.parentNode.removeChild(e);document.body.removeChild(this.textareaElement)},triggerUndo:function(e){this.triggerKey(e,90)},triggerRedo:function(e){this.triggerKey(e,89)},triggerKey:function(e,t){var n;try{n=e.composer.sandbox.getDocument().createEvent("KeyEvents"),n.initKeyEvent("keydown",!0,!0,e.composer.sandbox.getWindow(),!0,!1,!1,!1,t,t)}catch(r){n=e.composer.sandbox.getDocument().createEvent("Events"),n.initEvent("keydown",!0,!0),n.ctrlKey=!0,n.keyCode=t}e.composer.element.dispatchEvent(n)}}),asyncTest("Basic test",function(){expect(5);var e=this,t=new wysihtml5.Editor(this.textareaElement);t.on("load",function(){t.setValue("1 2").fire("newword:composer"),t.setValue("1 2 3").fire("newword:composer"),t.setValue("1 2 3 4").fire("newword:composer"),t.setValue("1 2 3 4 5"),e.triggerUndo(t),equal(t.getValue(),"1 2 3 4"),e.triggerRedo(t),e.triggerRedo(t),equal(t.getValue(),"1 2 3 4 5"),e.triggerUndo(t),e.triggerUndo(t),equal(t.getValue(),"1 2 3"),e.triggerUndo(t),e.triggerUndo(t),equal(t.getValue(),"1"),e.triggerUndo(t),e.triggerUndo(t),equal(t.getValue(),"1"),start()})}),asyncTest("Test commands",function(){expect(3);var e=this,t=new wysihtml5.Editor(this.textareaElement);t.on("load",function(){t.setValue("<b>1</b>").fire("beforecommand:composer"),t.setValue("<i><b>1</b></i>").fire("beforecommand:composer"),e.triggerUndo(t),equal(t.getValue(),"<b>1</b>"),e.triggerRedo(t),equal(t.getValue(),"<i><b>1</b></i>"),e.triggerUndo(t),e.triggerUndo(t),equal(t.getValue(),"1"),start()})}));