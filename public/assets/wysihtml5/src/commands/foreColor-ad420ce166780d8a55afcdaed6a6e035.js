/**
 * document.execCommand("foreColor") will create either inline styles (firefox, chrome) or use font tags
 * which we don't want
 * Instead we set a css class
 */
(function(e){var t,n=/wysiwyg-color-[a-z]+/g;e.commands.foreColor={exec:function(t,r,i){return e.commands.formatInline.exec(t,r,"span","wysiwyg-color-"+i,n)},state:function(t,r,i){return e.commands.formatInline.state(t,r,"span","wysiwyg-color-"+i,n)},value:function(){return t}}})(wysihtml5);