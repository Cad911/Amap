/**
 * Converts speech-to-text and inserts this into the editor
 * As of now (2011/03/25) this only is supported in Chrome >= 11
 *
 * Note that it sends the recorded audio to the google speech recognition api:
 * http://stackoverflow.com/questions/4361826/does-chrome-have-buil-in-speech-recognition-for-input-type-text-x-webkit-speec
 *
 * Current HTML5 draft can be found here
 * http://lists.w3.org/Archives/Public/public-xg-htmlspeech/2011Feb/att-0020/api-draft.html
 * 
 * "Accessing Google Speech API Chrome 11"
 * http://mikepultz.com/2011/03/accessing-google-speech-api-chrome-11/
 */
(function(e){var t=e.dom,n={position:"relative"},r={left:0,margin:0,opacity:0,overflow:"hidden",padding:0,position:"absolute",top:0,zIndex:1},i={cursor:"inherit",fontSize:"50px",height:"50px",marginTop:"-25px",outline:0,padding:0,position:"absolute",right:"-4px",top:"50%"},s={"x-webkit-speech":"",speech:""};e.toolbar.Speech=function(o,u){var a=document.createElement("input");if(!e.browser.supportsSpeechApiOn(a)){u.style.display="none";return}var f=document.createElement("div");e.lang.object(r).merge({width:u.offsetWidth+"px",height:u.offsetHeight+"px"}),t.insert(a).into(f),t.insert(f).into(u),t.setStyles(i).on(a),t.setAttributes(s).on(a),t.setStyles(r).on(f),t.setStyles(n).on(u);var l="onwebkitspeechchange"in a?"webkitspeechchange":"speechchange";t.observe(a,l,function(){o.execCommand("insertText",a.value),a.value=""}),t.observe(a,"click",function(e){t.hasClass(u,"wysihtml5-command-disabled")&&e.preventDefault(),e.stopPropagation()})}})(wysihtml5);