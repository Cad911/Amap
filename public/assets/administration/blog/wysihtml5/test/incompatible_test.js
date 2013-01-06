module("wysihtml5 - Incompatible",{setup:function(){this.originalSupportCheck=wysihtml5.browser.supported,wysihtml5.browser.supported=function(){return!1},this.textareaElement=document.createElement("textarea"),document.body.appendChild(this.textareaElement)},teardown:function(){wysihtml5.browser.supported=this.originalSupportCheck,this.textareaElement.parentNode.removeChild(this.textareaElement)}}),asyncTest("Basic test",function(){expect(12);var e=this,t=document.getElementsByTagName("iframe").length,n=document.getElementsByTagName("input").length,r=new wysihtml5.Editor(this.textareaElement);r.observe("load",function(){ok(!0,"'load' event correctly triggered"),ok(!wysihtml5.dom.hasClass(document.body,"wysihtml5-supported"),"<body> didn't receive the 'wysihtml5-supported' class"),ok(!r.isCompatible(),"isCompatible returns false when rich text editing is not correctly supported in the current browser"),equal(e.textareaElement.style.display,"","Textarea is visible"),ok(!r.composer,"Composer not initialized"),equal(document.getElementsByTagName("iframe").length,t,"No hidden field has been inserted into the dom"),equal(document.getElementsByTagName("input").length,n,"Composer not initialized");var i="foobar<br>";r.setValue(i),equal(e.textareaElement.value,i),equal(r.getValue(),i),r.clear(),equal(e.textareaElement.value,""),r.observe("focus",function(){ok(!0,"Generic 'focus' event fired")}),r.observe("focus:textarea",function(){ok(!0,"Specific 'focus:textarea' event fired")}),r.observe("focus:composer",function(){ok(!1,"Specific 'focus:composer' event fired, and that's wrong, there shouldn't be a composer element/view")}),QUnit.triggerEvent(e.textareaElement,wysihtml5.browser.supportsEvent("focusin")?"focusin":"focus"),start()})});