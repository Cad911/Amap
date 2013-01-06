/**
 * WYSIHTML5 Editor
 *
 * @param {Element} textareaElement Reference to the textarea which should be turned into a rich text interface
 * @param {Object} [config] See defaultConfig object below for explanation of each individual config option
 *
 * @events
 *    load
 *    beforeload (for internal use only)
 *    focus
 *    focus:composer
 *    focus:textarea
 *    blur
 *    blur:composer
 *    blur:textarea
 *    change
 *    change:composer
 *    change:textarea
 *    paste
 *    paste:composer
 *    paste:textarea
 *    newword:composer
 *    destroy:composer
 *    undo:composer
 *    redo:composer
 *    beforecommand:composer
 *    aftercommand:composer
 *    change_view
 */
(function(e){var t,n={name:t,style:!0,toolbar:t,autoLink:!0,parserRules:{tags:{br:{},span:{},div:{},p:{}},classes:{}},parser:e.dom.parse,composerClassName:"wysihtml5-editor",bodyClassName:"wysihtml5-supported",stylesheets:[],placeholderText:t,allowObjectResizing:!0,supportTouchDevices:!0};e.Editor=e.lang.Dispatcher.extend({constructor:function(t,r){this.textareaElement=typeof t=="string"?document.getElementById(t):t,this.config=e.lang.object({}).merge(n).merge(r).get(),this.textarea=new e.views.Textarea(this,this.textareaElement,this.config),this.currentView=this.textarea,this._isCompatible=e.browser.supported();if(!this._isCompatible||!this.config.supportTouchDevices&&e.browser.isTouchDevice()){var i=this;setTimeout(function(){i.fire("beforeload").fire("load")},0);return}e.dom.addClass(document.body,this.config.bodyClassName),this.composer=new e.views.Composer(this,this.textareaElement,this.config),this.currentView=this.composer,typeof this.config.parser=="function"&&this._initParser(),this.observe("beforeload",function(){this.synchronizer=new e.views.Synchronizer(this,this.textarea,this.composer),this.config.toolbar&&(this.toolbar=new e.toolbar.Toolbar(this,this.config.toolbar))});try{console.log("Heya! This page is using wysihtml5 for rich text editing. Check out https://github.com/xing/wysihtml5")}catch(s){}},isCompatible:function(){return this._isCompatible},clear:function(){return this.currentView.clear(),this},getValue:function(e){return this.currentView.getValue(e)},setValue:function(e,t){return e?(this.currentView.setValue(e,t),this):this.clear()},focus:function(e){return this.currentView.focus(e),this},disable:function(){return this.currentView.disable(),this},enable:function(){return this.currentView.enable(),this},isEmpty:function(){return this.currentView.isEmpty()},hasPlaceholderSet:function(){return this.currentView.hasPlaceholderSet()},parse:function(t){var n=this.config.parser(t,this.config.parserRules,this.composer.sandbox.getDocument(),!0);return typeof t=="object"&&e.quirks.redraw(t),n},_initParser:function(){this.observe("paste:composer",function(){var t=!0,n=this;n.composer.selection.executeAndRestore(function(){e.quirks.cleanPastedHTML(n.composer.element),n.parse(n.composer.element)},t)}),this.observe("paste:textarea",function(){var e=this.textarea.getValue(),t;t=this.parse(e),this.textarea.setValue(t)})}})})(wysihtml5);