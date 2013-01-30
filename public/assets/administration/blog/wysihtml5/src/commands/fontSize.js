/**
 * document.execCommand("fontSize") will create either inline styles (firefox, chrome) or use font tags
 * which we don't want
 * Instead we set a css class
 */
(function(e){var t,n=/wysiwyg-font-size-[a-z\-]+/g;e.commands.fontSize={exec:function(t,r,i){return e.commands.formatInline.exec(t,r,"span","wysiwyg-font-size-"+i,n)},state:function(t,r,i){return e.commands.formatInline.state(t,r,"span","wysiwyg-font-size-"+i,n)},value:function(){return t}}})(wysihtml5);