module("wysihtml5.lang.object"),test("merge()",function(){var e={foo:1,bar:1},t=wysihtml5.lang.object(e).merge({bar:2,baz:3}).get();equal(t,e),deepEqual(e,{foo:1,bar:2,baz:3})}),test("clone()",function(){var e={foo:!0},t=wysihtml5.lang.object(e).clone();ok(e!=t),deepEqual(e,t)}),test("isArray()",function(){ok(wysihtml5.lang.object([]).isArray()),ok(!wysihtml5.lang.object({}).isArray()),ok(!wysihtml5.lang.object(document.body.childNodes).isArray()),ok(!wysihtml5.lang.object("1,2,3").isArray())});