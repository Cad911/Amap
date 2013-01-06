module("wysihtml5.dom.resolveList",{equal:function(e,t,n){return wysihtml5.assert.htmlEqual(e,t,n)},resolveList:function(e){var t=wysihtml5.dom.getAsDom(e);document.body.appendChild(t),wysihtml5.dom.resolveList(t.firstChild);var n=t.innerHTML;return t.parentNode.removeChild(t),n}}),test("Basic tests",function(){this.equal(this.resolveList("<ul><li>foo</li></ul>"),"foo<br>"),this.equal(this.resolveList("<ul><li>foo</li><li>bar</li></ul>"),"foo<br>bar<br>"),this.equal(this.resolveList("<ol><li>foo</li><li>bar</li></ol>"),"foo<br>bar<br>"),this.equal(this.resolveList("<ol><li></li><li>bar</li></ol>"),"bar<br>"),this.equal(this.resolveList("<ol><li>foo<br></li><li>bar</li></ol>"),"foo<br>bar<br>"),this.equal(this.resolveList("<ul><li><h1>foo</h1></li><li><div>bar</div></li><li>baz</li></ul>"),"<h1>foo</h1><div>bar</div>baz<br>")});