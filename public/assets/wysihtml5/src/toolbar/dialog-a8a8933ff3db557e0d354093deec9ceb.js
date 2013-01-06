/**
 * Toolbar Dialog
 *
 * @param {Element} link The toolbar link which causes the dialog to show up
 * @param {Element} container The dialog container
 *
 * @example
 *    <!-- Toolbar link -->
 *    <a data-wysihtml5-command="insertImage">insert an image</a>
 *
 *    <!-- Dialog -->
 *    <div data-wysihtml5-dialog="insertImage" style="display: none;">
 *      <label>
 *        URL: <input data-wysihtml5-dialog-field="src" value="http://">
 *      </label>
 *      <label>
 *        Alternative text: <input data-wysihtml5-dialog-field="alt" value="">
 *      </label>
 *    </div>
 *
 *    <script>
 *      var dialog = new wysihtml5.toolbar.Dialog(
 *        document.querySelector("[data-wysihtml5-command='insertImage']"),
 *        document.querySelector("[data-wysihtml5-dialog='insertImage']")
 *      );
 *      dialog.observe("save", function(attributes) {
 *        // do something
 *      });
 *    </script>
 */
(function(e){var t=e.dom,n="wysihtml5-command-dialog-opened",r="input, select, textarea",i="[data-wysihtml5-dialog-field]",s="data-wysihtml5-dialog-field";e.toolbar.Dialog=e.lang.Dispatcher.extend({constructor:function(e,t){this.link=e,this.container=t},_observe:function(){if(this._observed)return;var i=this,s=function(e){var t=i._serialize();t==i.elementToChange?i.fire("edit",t):i.fire("save",t),i.hide(),e.preventDefault(),e.stopPropagation()};t.observe(i.link,"click",function(e){t.hasClass(i.link,n)&&setTimeout(function(){i.hide()},0)}),t.observe(this.container,"keydown",function(t){var n=t.keyCode;n===e.ENTER_KEY&&s(t),n===e.ESCAPE_KEY&&i.hide()}),t.delegate(this.container,"[data-wysihtml5-dialog-action=save]","click",s),t.delegate(this.container,"[data-wysihtml5-dialog-action=cancel]","click",function(e){i.fire("cancel"),i.hide(),e.preventDefault(),e.stopPropagation()});var o=this.container.querySelectorAll(r),u=0,a=o.length,f=function(){clearInterval(i.interval)};for(;u<a;u++)t.observe(o[u],"change",f);this._observed=!0},_serialize:function(){var e=this.elementToChange||{},t=this.container.querySelectorAll(i),n=t.length,r=0;for(;r<n;r++)e[t[r].getAttribute(s)]=t[r].value;return e},_interpolate:function(e){var t,n,r,o=document.querySelector(":focus"),u=this.container.querySelectorAll(i),a=u.length,f=0;for(;f<a;f++){t=u[f];if(t===o)continue;if(e&&t.type==="hidden")continue;n=t.getAttribute(s),r=this.elementToChange?this.elementToChange[n]||"":t.defaultValue,t.value=r}},show:function(e){var i=this,s=this.container.querySelector(r);this.elementToChange=e,this._observe(),this._interpolate(),e&&(this.interval=setInterval(function(){i._interpolate(!0)},500)),t.addClass(this.link,n),this.container.style.display="",this.fire("show");if(s&&!e)try{s.focus()}catch(o){}},hide:function(){clearInterval(this.interval),this.elementToChange=null,t.removeClass(this.link,n),this.container.style.display="none",this.fire("hide")}})})(wysihtml5);