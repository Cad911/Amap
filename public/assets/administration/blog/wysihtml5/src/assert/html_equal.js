var wysihtml5=wysihtml5||{};wysihtml5.assert=wysihtml5.assert||{},wysihtml5.assert.htmlEqual=function(){var e=document.createElement("div"),t=function(){var t='<img alt="foo" width=1 height="1" data-foo="1">';return e.innerHTML=t,e.innerHTML!=t}(),n=function(){var e=document.createElement("div"),t=document.createElement("a"),n=document.createElement("p");return t.appendChild(n),e.appendChild(t),e.innerHTML.toLowerCase()!="<a><p></p></a>"}(),r=function(){var t=document.createElement("img"),n,r;return t.setAttribute("alt","foo"),t.setAttribute("border","1"),t.setAttribute("src","foo.gif"),e.innerHTML="",e.appendChild(t),n=e.innerHTML,e.innerHTML='<img alt="foo" border="1" src="foo.gif">',r=e.innerHTML,r!=n}(),i=function(){var e=/\s+|\>|</;return function(t){return t.split(e).sort().join(" ")}}(),s=function(){var e=/(<pre[\^>]*>)([\S\s]*?)(<\/pre>)/mgi,t=/\s+/gm,n="___PRE_CONTENT___",r=new RegExp(n,"g");return function(i){var s=[];return i=i.replace(e,function(e,t,r,i){return s.push(r),t+n+i}),i=i.replace(t," "),i=i.replace(r,function(){return s.shift()}),i}}(),o=function(){var e=/(>)(\s*?)(<)/gm;return function(t){return wysihtml5.lang.string(t.replace(e,"$1$3")).trim()}}();return function(e,r,u,a){a=a||{},t&&(e=wysihtml5.dom.getAsDom(e).innerHTML,r=wysihtml5.dom.getAsDom(r).innerHTML);if(a.normalizeWhiteSpace||n)e=s(e),r=s(r);a.removeWhiteSpace&&(e=o(e),r=o(r)),e=i(e),r=i(r),ok(e==r,u)}}();