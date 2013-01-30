/**
 * Sandbox for executing javascript, parsing css styles and doing dom operations in a secure way
 *
 * Browser Compatibility:
 *  - Secure in MSIE 6+, but only when the user hasn't made changes to his security level "restricted"
 *  - Partially secure in other browsers (Firefox, Opera, Safari, Chrome, ...)
 *
 * Please note that this class can't benefit from the HTML5 sandbox attribute for the following reasons:
 *    - sandboxing doesn't work correctly with inlined content (src="javascript:'<html>...</html>'")
 *    - sandboxing of physical documents causes that the dom isn't accessible anymore from the outside (iframe.contentWindow, ...)
 *    - setting the "allow-same-origin" flag would fix that, but then still javascript and dom events refuse to fire
 *    - therefore the "allow-scripts" flag is needed, which then would deactivate any security, as the js executed inside the iframe
 *      can do anything as if the sandbox attribute wasn't set
 *
 * @param {Function} [readyCallback] Method that gets invoked when the sandbox is ready
 * @param {Object} [config] Optional parameters
 *
 * @example
 *    new wysihtml5.dom.Sandbox(function(sandbox) {
 *      sandbox.getWindow().document.body.innerHTML = '<img src=foo.gif onerror="alert(document.cookie)">';
 *    });
 */
(function(e){var t=document,n=["parent","top","opener","frameElement","frames","localStorage","globalStorage","sessionStorage","indexedDB"],r=["open","close","openDialog","showModalDialog","alert","confirm","prompt","openDatabase","postMessage","XMLHttpRequest","XDomainRequest"],i=["referrer","write","open","close"];e.dom.Sandbox=Base.extend({constructor:function(t,n){this.callback=t||e.EMPTY_FUNCTION,this.config=e.lang.object({}).merge(n).get(),this.iframe=this._createIframe()},insertInto:function(e){typeof e=="string"&&(e=t.getElementById(e)),e.appendChild(this.iframe)},getIframe:function(){return this.iframe},getWindow:function(){this._readyError()},getDocument:function(){this._readyError()},destroy:function(){var e=this.getIframe();e.parentNode.removeChild(e)},_readyError:function(){throw new Error("wysihtml5.Sandbox: Sandbox iframe isn't loaded yet")},_createIframe:function(){var n=this,r=t.createElement("iframe");return r.className="wysihtml5-sandbox",e.dom.setAttributes({security:"restricted",allowtransparency:"true",frameborder:0,width:0,height:0,marginwidth:0,marginheight:0}).on(r),e.browser.throwsMixedContentWarningWhenIframeSrcIsEmpty()&&(r.src="javascript:'<html></html>'"),r.onload=function(){r.onreadystatechange=r.onload=null,n._onLoadIframe(r)},r.onreadystatechange=function(){/loaded|complete/.test(r.readyState)&&(r.onreadystatechange=r.onload=null,n._onLoadIframe(r))},r},_onLoadIframe:function(s){if(!e.dom.contains(t.documentElement,s))return;var o=this,u=s.contentWindow,a=s.contentWindow.document,f=t.characterSet||t.charset||"utf-8",l=this._getHtml({charset:f,stylesheets:this.config.stylesheets});a.open("text/html","replace"),a.write(l),a.close(),this.getWindow=function(){return s.contentWindow},this.getDocument=function(){return s.contentWindow.document},u.onerror=function(e,t,n){throw new Error("wysihtml5.Sandbox: "+e,t,n)};if(!e.browser.supportsSandboxedIframes()){var c,h;for(c=0,h=n.length;c<h;c++)this._unset(u,n[c]);for(c=0,h=r.length;c<h;c++)this._unset(u,r[c],e.EMPTY_FUNCTION);for(c=0,h=i.length;c<h;c++)this._unset(a,i[c]);this._unset(a,"cookie","",!0)}this.loaded=!0,setTimeout(function(){o.callback(o)},0)},_getHtml:function(t){var n=t.stylesheets,r="",i=0,s;n=typeof n=="string"?[n]:n;if(n){s=n.length;for(;i<s;i++)r+='<link rel="stylesheet" href="'+n[i]+'">'}return t.stylesheets=r,e.lang.string('<!DOCTYPE html><html><head><meta charset="#{charset}">#{stylesheets}</head><body></body></html>').interpolate(t)},_unset:function(t,n,r,i){try{t[n]=r}catch(s){}try{t.__defineGetter__(n,function(){return r})}catch(s){}if(i)try{t.__defineSetter__(n,function(){})}catch(s){}if(!e.browser.crashesWhenDefineProperty(n))try{var o={get:function(){return r}};i&&(o.set=function(){}),Object.defineProperty(t,n,o)}catch(s){}}})})(wysihtml5);