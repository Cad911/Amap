/**
 * TODO: the following methods still need unit test coverage
 */
wysihtml5.views.View=Base.extend({constructor:function(e,t,n){this.parent=e,this.element=t,this.config=n,this._observeViewChange()},_observeViewChange:function(){var e=this;this.parent.observe("beforeload",function(){e.parent.observe("change_view",function(t){t===e.name?(e.parent.currentView=e,e.show(),setTimeout(function(){e.focus()},0)):e.hide()})})},focus:function(){if(this.element.ownerDocument.querySelector(":focus")===this.element)return;try{this.element.focus()}catch(e){}},hide:function(){this.element.style.display="none"},show:function(){this.element.style.display=""},disable:function(){this.element.setAttribute("disabled","disabled")},enable:function(){this.element.removeAttribute("disabled")}});