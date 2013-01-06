wysihtml5.views.Textarea=wysihtml5.views.View.extend({name:"textarea",constructor:function(e,t,n){this.base(e,t,n),this._observe()},clear:function(){this.element.value=""},getValue:function(e){var t=this.isEmpty()?"":this.element.value;return e&&(t=this.parent.parse(t)),t},setValue:function(e,t){t&&(e=this.parent.parse(e)),this.element.value=e},hasPlaceholderSet:function(){var e=wysihtml5.browser.supportsPlaceholderAttributeOn(this.element),t=this.element.getAttribute("placeholder")||null,n=this.element.value,r=!n;return e&&r||n===t},isEmpty:function(){return!wysihtml5.lang.string(this.element.value).trim()||this.hasPlaceholderSet()},_observe:function(){var e=this.element,t=this.parent,n={focusin:"focus",focusout:"blur"},r=wysihtml5.browser.supportsEvent("focusin")?["focusin","focusout","change"]:["focus","blur","change"];t.observe("beforeload",function(){wysihtml5.dom.observe(e,r,function(e){var r=n[e.type]||e.type;t.fire(r).fire(r+":textarea")}),wysihtml5.dom.observe(e,["paste","drop"],function(){setTimeout(function(){t.fire("paste").fire("paste:textarea")},0)})})}});