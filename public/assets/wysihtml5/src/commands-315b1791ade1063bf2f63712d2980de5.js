/**
 * Rich Text Query/Formatting Commands
 * 
 * @example
 *    var commands = new wysihtml5.Commands(editor);
 */
wysihtml5.Commands=Base.extend({constructor:function(e){this.editor=e,this.composer=e.composer,this.doc=this.composer.doc},support:function(e){return wysihtml5.browser.supportsCommand(this.doc,e)},exec:function(e,t){var n=wysihtml5.commands[e],r=wysihtml5.lang.array(arguments).get(),i=n&&n.exec,s=null;this.editor.fire("beforecommand:composer");if(i)r.unshift(this.composer),s=i.apply(n,r);else try{s=this.doc.execCommand(e,!1,t)}catch(o){}return this.editor.fire("aftercommand:composer"),s},state:function(e,t){var n=wysihtml5.commands[e],r=wysihtml5.lang.array(arguments).get(),i=n&&n.state;if(i)return r.unshift(this.composer),i.apply(n,r);try{return this.doc.queryCommandState(e)}catch(s){return!1}},value:function(e){var t=wysihtml5.commands[e],n=t&&t.value;if(n)return n.call(t,this.composer,e);try{return this.doc.queryCommandValue(e)}catch(r){return null}}});