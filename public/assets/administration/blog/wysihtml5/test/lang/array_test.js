module("wysihtml5.lang.array"),test("contains()",function(){var e=[1,"2","foo"];ok(wysihtml5.lang.array(e).contains(1)),ok(!wysihtml5.lang.array(e).contains(2)),ok(wysihtml5.lang.array(e).contains("2")),ok(wysihtml5.lang.array(e).contains("foo"))}),test("without()",function(){var e=[1,2,3];deepEqual(wysihtml5.lang.array(e).without([1]),[2,3]),deepEqual(wysihtml5.lang.array(e).without([4]),[1,2,3])}),test("get()",function(){var e=document.getElementsByTagName("*"),t=wysihtml5.lang.array(e).get();equal(t.length,e.length),ok(t instanceof Array)});