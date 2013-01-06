/**
 * HTML Sanitizer
 * Rewrites the HTML based on given rules
 *
 * @param {Element|String} elementOrHtml HTML String to be sanitized OR element whose content should be sanitized
 * @param {Object} [rules] List of rules for rewriting the HTML, if there's no rule for an element it will
 *    be converted to a "span". Each rule is a key/value pair where key is the tag to convert, and value the
 *    desired substitution.
 * @param {Object} context Document object in which to parse the html, needed to sandbox the parsing
 *
 * @return {Element|String} Depends on the elementOrHtml parameter. When html then the sanitized html as string elsewise the element.
 *
 * @example
 *    var userHTML = '<div id="foo" onclick="alert(1);"><p><font color="red">foo</font><script>alert(1);</script></p></div>';
 *    wysihtml5.dom.parse(userHTML, {
 *      tags {
 *        p:      "div",      // Rename p tags to div tags
 *        font:   "span"      // Rename font tags to span tags
 *        div:    true,       // Keep them, also possible (same result when passing: "div" or true)
 *        script: undefined   // Remove script elements
 *      }
 *    });
 *    // => <div><div><span>foo bar</span></div></div>
 *
 *    var userHTML = '<table><tbody><tr><td>I'm a table!</td></tr></tbody></table>';
 *    wysihtml5.dom.parse(userHTML);
 *    // => '<span><span><span><span>I'm a table!</span></span></span></span>'
 *
 *    var userHTML = '<div>foobar<br>foobar</div>';
 *    wysihtml5.dom.parse(userHTML, {
 *      tags: {
 *        div: undefined,
 *        br:  true
 *      }
 *    });
 *    // => ''
 *
 *    var userHTML = '<div class="red">foo</div><div class="pink">bar</div>';
 *    wysihtml5.dom.parse(userHTML, {
 *      classes: {
 *        red:    1,
 *        green:  1
 *      },
 *      tags: {
 *        div: {
 *          rename_tag:     "p"
 *        }
 *      }
 *    });
 *    // => '<p class="red">foo</p><p>bar</p>'
 */
wysihtml5.dom.parse=function(){function s(e,t,n,s){wysihtml5.lang.object(i).merge(r).merge(t).get(),n=n||e.ownerDocument||document;var u=n.createDocumentFragment(),a=typeof e=="string",f,l,c;a?f=wysihtml5.dom.getAsDom(e,n):f=e;while(f.firstChild)c=f.firstChild,f.removeChild(c),l=o(c,s),l&&u.appendChild(l);return f.innerHTML="",f.appendChild(u),a?wysihtml5.quirks.getCorrectInnerHTML(f):f}function o(n,r){var i=n.nodeType,s=n.childNodes,u=s.length,a,f=e[i],l=0;a=f&&f(n);if(!a)return null;for(l=0;l<u;l++)newChild=o(s[l],r),newChild&&a.appendChild(newChild);return r&&a.childNodes.length<=1&&a.nodeName.toLowerCase()===t&&!a.attributes.length?a.firstChild:a}function u(e){var n,r,s,o=i.tags,u=e.nodeName.toLowerCase(),f=e.scopeName;if(e._wysihtml5)return null;e._wysihtml5=1;if(e.className==="wysihtml5-temp")return null;f&&f!="HTML"&&(u=f+":"+u),"outerHTML"in e&&!wysihtml5.browser.autoClosesUnclosedTags()&&e.nodeName==="P"&&e.outerHTML.slice(-4).toLowerCase()!=="</p>"&&(u="div");if(u in o){n=o[u];if(!n||n.remove)return null;n=typeof n=="string"?{rename_tag:n}:n}else{if(!e.firstChild)return null;n={rename_tag:t}}return r=e.ownerDocument.createElement(n.rename_tag||u),a(e,r,n),e=null,r}function a(e,t,r){var s={},o=r.set_class,u=r.add_class,a=r.set_attributes,f=r.check_attributes,c=i.classes,h=0,v=[],m=[],g=[],y=[],b,w,E,S,x,T,N;a&&(s=wysihtml5.lang.object(a).clone());if(f)for(x in f){N=p[f[x]];if(!N)continue;T=N(l(e,x)),typeof T=="string"&&(s[x]=T)}o&&v.push(o);if(u)for(x in u){N=d[u[x]];if(!N)continue;S=N(l(e,x)),typeof S=="string"&&v.push(S)}c["_wysihtml5-temp-placeholder"]=1,y=e.getAttribute("class"),y&&(v=v.concat(y.split(n))),b=v.length;for(;h<b;h++)E=v[h],c[E]&&m.push(E);w=m.length;while(w--)E=m[w],wysihtml5.lang.array(g).contains(E)||g.unshift(E);g.length&&(s["class"]=g.join(" "));for(x in s)try{t.setAttribute(x,s[x])}catch(C){}s.src&&(typeof s.width!="undefined"&&t.setAttribute("width",s.width),typeof s.height!="undefined"&&t.setAttribute("height",s.height))}function l(e,t){t=t.toLowerCase();var n=e.nodeName;if(n=="IMG"&&t=="src"&&c(e)===!0)return e.src;if(f&&"outerHTML"in e){var r=e.outerHTML.toLowerCase(),i=r.indexOf(" "+t+"=")!=-1;return i?e.getAttribute(t):null}return e.getAttribute(t)}function c(e){try{return e.complete&&!e.mozMatchesSelector(":-moz-broken")}catch(t){if(e.complete&&e.readyState==="complete")return!0}}function h(e){return e.ownerDocument.createTextNode(e.data)}var e={1:u,3:h},t="span",n=/\s+/,r={tags:{},classes:{}},i={},f=!wysihtml5.browser.supportsGetAttributeCorrectly(),p={url:function(){var e=/^https?:\/\//i;return function(t){return!t||!t.match(e)?null:t.replace(e,function(e){return e.toLowerCase()})}}(),alt:function(){var e=/[^ a-z0-9_\-]/gi;return function(t){return t?t.replace(e,""):""}}(),numbers:function(){var e=/\D/g;return function(t){return t=(t||"").replace(e,""),t||null}}()},d={align_img:function(){var e={left:"wysiwyg-float-left",right:"wysiwyg-float-right"};return function(t){return e[String(t).toLowerCase()]}}(),align_text:function(){var e={left:"wysiwyg-text-align-left",right:"wysiwyg-text-align-right",center:"wysiwyg-text-align-center",justify:"wysiwyg-text-align-justify"};return function(t){return e[String(t).toLowerCase()]}}(),clear_br:function(){var e={left:"wysiwyg-clear-left",right:"wysiwyg-clear-right",both:"wysiwyg-clear-both",all:"wysiwyg-clear-both"};return function(t){return e[String(t).toLowerCase()]}}(),size_font:function(){var e={1:"wysiwyg-font-size-xx-small",2:"wysiwyg-font-size-small",3:"wysiwyg-font-size-medium",4:"wysiwyg-font-size-large",5:"wysiwyg-font-size-x-large",6:"wysiwyg-font-size-xx-large",7:"wysiwyg-font-size-xx-large","-":"wysiwyg-font-size-smaller","+":"wysiwyg-font-size-larger"};return function(t){return e[String(t).charAt(0)]}}()};return s}();