(function(){window.div_state={div_success:function(e,t){return div_state.remove_class(e,"warning","error"),e.parent().parent().addClass("success"),div_state.write_message(e,t)},div_warning:function(e,t){return div_state.remove_class(e,"success","error"),e.parent().parent().addClass("warning"),div_state.write_message(e,t)},div_error:function(e,t){return div_state.remove_class(e,"success","warning"),e.parent().parent().addClass("error"),div_state.write_message(e,t)},remove_class:function(e,t,n){return e.parent().parent().removeClass(t),e.parent().parent().removeClass(n)},write_message:function(e,t){return e.next(".help-inline").length>0?e.next(".help-inline").text(t):e.after('<span class="help-inline">'+t+"</span>")}},window.message_information={content_message:function(e,t,n,r,i,s){var o,u,a;u=$(document.createElement("div")),u.addClass("alert alert-"+s),i!==!1&&u.addClass(i),u.css("display","block"),o=$(document.createElement("a")),o.addClass("close"),o.attr("data-dismiss","alert"),o.text("x"),u.append(o),t!==""&&(t+=" ",a=$(document.createElement("strong")),a.text(t),u.append(a)),n!==""&&u.append(n),console.log($(""+e)),$(""+e).after(u);if(r!==0)return setTimeout(message_information.hide_message,r,u)},hide_message:function(e){return e.animate({opacity:0},{duration:1e3,complete:function(){return $(this).remove()}})},message_success:function(e,t,n,r,i){return r==null&&(r=0),i==null&&(i=!1),message_information.content_message(e,t,n,r,i,"success")},message_warning:function(e,t,n,r,i){return r==null&&(r=0),i==null&&(i=!1),message_information.content_message(e,t,n,r,i,"warning")},message_error:function(e,t,n,r,i){return r==null&&(r=0),i==null&&(i=!1),message_information.content_message(e,t,n,r,i,"error")}}}).call(this);