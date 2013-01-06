/**
 * formatInline scenarios for tag "B" (| = caret, |foo| = selected text)
 *
 *   #1 caret in unformatted text:
 *      abcdefg|
 *   output:
 *      abcdefg<b>|</b>
 *   
 *   #2 unformatted text selected:
 *      abc|deg|h
 *   output:
 *      abc<b>|deg|</b>h
 *   
 *   #3 unformatted text selected across boundaries:
 *      ab|c <span>defg|h</span>
 *   output:
 *      ab<b>|c </b><span><b>defg</b>|h</span>
 *
 *   #4 formatted text entirely selected
 *      <b>|abc|</b>
 *   output:
 *      |abc|
 *
 *   #5 formatted text partially selected
 *      <b>ab|c|</b>
 *   output:
 *      <b>ab</b>|c|
 *
 *   #6 formatted text selected across boundaries
 *      <span>ab|c</span> <b>de|fgh</b>
 *   output:
 *      <span>ab|c</span> de|<b>fgh</b>
 */
(function(e){function i(e){var t=n[e];return t?[e.toLowerCase(),t.toLowerCase()]:[e.toLowerCase()]}function s(t,n,s){var o=t+":"+n;return r[o]||(r[o]=new e.selection.HTMLApplier(i(t),n,s,!0)),r[o]}var t,n={strong:"b",em:"i",b:"strong",i:"em"},r={};e.commands.formatInline={exec:function(e,t,n,r,i){var o=e.selection.getRange();if(!o)return!1;s(n,r,i).toggleRange(o),e.selection.setSelection(o)},state:function(t,r,i,o,u){var a=t.doc,f=n[i]||i,l;return!e.dom.hasElementWithTagName(a,i)&&!e.dom.hasElementWithTagName(a,f)?!1:o&&!e.dom.hasElementWithClassName(a,o)?!1:(l=t.selection.getRange(),l?s(i,o,u).isAppliedToRange(l):!1)},value:function(){return t}}})(wysihtml5);