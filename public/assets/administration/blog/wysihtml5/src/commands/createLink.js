(function(e){function i(e,t){var n=t.length,i=0,s,o,u;for(;i<n;i++)s=t[i],o=r.getParentElement(s,{nodeName:"code"}),u=r.getTextContent(s),u.match(r.autoLink.URL_REG_EXP)&&!o?o=r.renameElement(s,"code"):r.replaceWithChildNodes(s)}function s(i,s){var o=i.doc,u="_wysihtml5-temp-"+ +(new Date),a=/non-matching-class/g,f=0,l,c,h,p,d,v,m,g,y;e.commands.formatInline.exec(i,t,n,u,a),c=o.querySelectorAll(n+"."+u),l=c.length;for(;f<l;f++){h=c[f],h.removeAttribute("class");for(y in s)h.setAttribute(y,s[y])}v=h,l===1&&(m=r.getTextContent(h),p=!!h.querySelector("*"),d=m===""||m===e.INVISIBLE_SPACE,!p&&d&&(r.setTextContent(h,s.text||h.href),g=o.createTextNode(" "),i.selection.setAfter(h),i.selection.insertNode(g),v=g)),i.selection.setAfter(v)}var t,n="A",r=e.dom;e.commands.createLink={exec:function(e,t,n){var r=this.state(e,t);r?e.selection.executeAndRestore(function(){i(e,r)}):(n=typeof n=="object"?n:{href:n},s(e,n))},state:function(t,n){return e.commands.formatInline.state(t,n,"A")},value:function(){return t}}})(wysihtml5);