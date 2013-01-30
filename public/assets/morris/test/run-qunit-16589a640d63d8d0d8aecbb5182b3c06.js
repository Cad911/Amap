/**
 * Wait until the test condition is true or a timeout occurs. Useful for waiting
 * on a server response or for a ui change (fadeIn, etc.) to occur.
 *
 * @param testFx javascript condition that evaluates to a boolean,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param onReady what to do when testFx condition is fulfilled,
 * it can be passed in as a string (e.g.: "1 == 1" or "$('#bar').is(':visible')" or
 * as a callback function.
 * @param timeOutMillis the max amount of time to wait. If not specified, 3 sec is used.
 */
function waitFor(testFx,onReady,timeOutMillis){var maxtimeOutMillis=timeOutMillis?timeOutMillis:3001,start=(new Date).getTime(),condition=!1,interval=setInterval(function(){(new Date).getTime()-start<maxtimeOutMillis&&!condition?condition=typeof testFx=="string"?eval(testFx):testFx():condition?(console.log("'waitFor()' finished in "+((new Date).getTime()-start)+"ms."),typeof onReady=="string"?eval(onReady):onReady(),clearInterval(interval)):(console.log("'waitFor()' timeout"),phantom.exit(1))},100)}if(phantom.args.length===0||phantom.args.length>2)console.log("Usage: run-qunit.js URL"),phantom.exit(1);var page=require("webpage").create();page.onConsoleMessage=function(e){console.log(e)},page.open(phantom.args[0],function(e){e!=="success"?(console.log("Unable to access network"),phantom.exit(1)):waitFor(function(){return page.evaluate(function(){var e=document.getElementById("qunit-testresult");return e&&e.innerText.match("completed")?!0:!1})},function(){var e=page.evaluate(function(){var e=document.getElementById("qunit-testresult");console.log(e.innerText);try{return e.getElementsByClassName("failed")[0].innerHTML}catch(t){}return 1e4});phantom.exit(parseInt(e,10)>0?1:0)})});