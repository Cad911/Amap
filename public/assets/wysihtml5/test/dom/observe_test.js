module("wysihtml5.dom.observe",{setup:function(){this.container=document.createElement("div"),this.element=document.createElement("textarea"),this.container.appendChild(this.element),document.body.appendChild(this.container)},teardown:function(){this.container.parentNode.removeChild(this.container);var e;while(e=document.querySelector("iframe.wysihtml5-sandbox"))e.parentNode.removeChild(e)}}),test("Basic test",function(){expect(4);var e=this.element;wysihtml5.dom.observe(e,["mouseover","mouseout"],function(e){ok(!0,"'"+e.type+"' correctly fired")}),wysihtml5.dom.observe(e,"click",function(t){equal(t.target,e,"event.target or event.srcElement are set"),ok(!0,"'click' correctly fired")}),QUnit.triggerEvent(e,"mouseover"),QUnit.triggerEvent(e,"mouseout"),QUnit.triggerEvent(e,"click")}),test("Test stopPropagation and scope of event handler",function(e){expect(2);var t=this.element;wysihtml5.dom.observe(this.container,"click",function(e){ok(!1,"The event shouldn't have been bubbled!")}),wysihtml5.dom.observe(this.element,"click",function(e){e.stopPropagation(),equal(this,t,"Event handler bound to correct scope"),ok(!0,"stopPropagation correctly fired")}),QUnit.triggerEvent(this.element,"click")}),test("Test detaching events",function(){expect(0);var e=wysihtml5.dom.observe(this.element,"click",function(){ok(!1,"This should not be triggered")});e.stop(),QUnit.triggerEvent(this.element,"click")}),asyncTest("Advanced test observing within a sandboxed iframe",function(){expect(2);var e=new wysihtml5.dom.Sandbox(function(){var t=e.getDocument().createElement("div");e.getDocument().body.appendChild(t),wysihtml5.dom.observe(t,["click","mousedown"],function(e){ok(!0,"'"+e.type+"' correctly fired")}),QUnit.triggerEvent(t,"click"),QUnit.triggerEvent(t,"mousedown"),start()});e.insertInto(document.body)});