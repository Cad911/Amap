(function(e){var t,n="<br>"+(e.browser.needsSpaceAfterLineBreak()?" ":"");e.commands.insertLineBreak={exec:function(t,r){t.commands.support(r)?(t.doc.execCommand(r,!1,null),e.browser.autoScrollsToCaret()||t.selection.scrollIntoView()):t.commands.exec("insertHTML",n)},state:function(){return!1},value:function(){return t}}})(wysihtml5);