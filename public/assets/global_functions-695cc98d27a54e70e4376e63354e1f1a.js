(function(){window.global_functions={standard_input:function(e){var t,n,r,i,s,o,u,a,f,l,c,h,p;r=$(document.createElement("div")),e.type_element==="select"?n="control-group select optional":e.type_element==="input"||e.type_element==="textarea"?n="control-group string optional":e.type_element==="radio"&&(n="control-group string optional"),r.addClass(n),o=$(document.createElement("label")),o.addClass("string optional control-label"),o.text(e.label.text),r.append(o),a=$(document.createElement("div")),a.addClass("controls");if(e.type_element==="select"){i=$(document.createElement("select")),c=e.input.options;for(t in c)l=c[t],u=$(document.createElement("option")),u.attr("value",l.value),u.text(l.text),l.value===e.input.value&&u.attr("selected","selected"),i.append(u)}else if(e.type_element==="input")i=$(document.createElement("input")),e.input.value&&i.val(e.input.value);else if(e.type_element==="radio"){h=e.input.value;for(t in h)l=h[t],f=$(document.createElement("span")),o=$(document.createElement("label")),o.text(l[1]),s=$(document.createElement("input")),s.attr("type","radio"),s.attr("value",l[0]),s.attr("name",e.input.name),e.input["class"]!==void 0&&s.addClass(e.input["class"]),f.append(s),f.append(o),a.append(f)}else e.type_element==="textarea"&&(i=$(document.createElement("textarea")),e.input.value&&i.val(e.input.value));if(e.type_element!=="radio"){i.attr("name",e.input.name),e.input["class"]!==void 0&&i.addClass(e.input["class"]),e.input.id!==void 0&&i.attr("id",e.input.id);if(e.input.other_attributes!==void 0){p=e.input.other_attributes;for(t in p)l=p[t],i.attr(l[0],l[1])}return a.append(i),r.append(a),r}return r.append(a),r},standard_button:function(e){var t,n,r,i,s,o;r=$(document.createElement("p")),i=$(document.createElement("span")),t=$(document.createElement("a")),t.text(e.link.text),i.addClass("button "+e.link.class_span),o=e.link.event;for(n in o)s=o[n],t.on(s.type,function(){switch(s.callback.length){case 1:return s.callback[0]();case 2:return s.callback[0](s.callback[1]);case 3:return s.callback[0](s.callback[1],s.callback[2]);case 4:return s.callback[0](s.callback[1],s.callback[2],s.callback[3]);case 5:return s.callback[0](s.callback[1],s.callback[2],s.callback[3],s.callback[4])}});return i.append(t),r.append(i),r}}}).call(this);