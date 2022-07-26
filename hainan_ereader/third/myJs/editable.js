$(function(){
	$.fn.editable2=function(options){
		var defaults={
				tds:"#table tbody tr:even td",
				fontSize:"16px",
				action:"meet_updateFileSort.action"
		}
		var options=$.extend(options,defaults);
		$(options.tds).dblclick(function(){
			var td=$(this);
			if(td.children('input').length>0){
				return false;
			}
			var text=td.text();
			td.html("");
			var inputobj=$('<input>');
			var inputobj= $('<input>').css('border','none').width(td.width())
			.css("font-size",options.fontSize).height(td.height()).css('background-color',
					td.css('background-color')).val(text).appendTo(td);
			inputobj.click(function(){
				return false;
			});
			inputobj.trigger("focus").trigger("select");
			inputobj.keyup(function(event){
				var inputval=inputobj.val();
				var keyCode=event.which;
				//if(keyCode==13){
				//inputval=inputval.replace(/[ -~]/g,'')
				//td.text(inputval);
				
				//}else if(keyCode==27){
				
				//}
			});
			inputobj.blur(function(){
				var inputval=inputobj.val();
				//alert("inputval:"+inputval+","+options.action);
				var selObj=td.parent().children(":eq(4)").children();
				var idObj=td.parent().children(":eq(0)").children(":eq(0)");
				var ftype=$(selObj).val();
				var idval=$(idObj).html().replace(" ","").trim();
				//alert(idval+","+ftype+","+inputval.replace(" ","").trim()+",");
				if(isNaN(inputval.replace(" ",""))){
					alert("请输入正确序号");
					return;
				}
				$.post(options.action,{"sort":inputval,"id":idval,"ftype":ftype},
						function(data){
					var json=eval("("+data+")");
					//alert(json.state+","+text);
					if(json.state){
						td.text(inputval);
						$('#search').click();
					}else{
						alert("操作有误");
					}
				});
			});
			
		});
	}
	$.fn.editablefile2=function(options){
		var defaults={
				tds:"#table tbody tr:even td",
				fontSize:"16px",
				action:"meet_updateFileSort.action",
				cindexs:"10"//修改第10列显示的值
		}
		var options=$.extend(options,defaults);
		//alert("tarObj1:"+tarObj.html());
		//alert(options.cindexs);
		$(options.tds).each(function(){
			//alert("iseditable:"+iseditable);
			if($(this).index()==options.cindexs){
				$(this).dblclick(function(){
					var td=$(this);
					if(td.children('input').length>0){
						return false;
					}
					var text=td.text();
					td.html("");
					var inputobj=$('<input>');
					var inputobj= $('<input>').css('border','none').width(td.width())
					.css("font-size",options.fontSize).height(td.height()).css('background-color',
							td.css('background-color')).val(text).appendTo(td);
					inputobj.click(function(){
						return false;
					});
					inputobj.trigger("focus").trigger("select");
					inputobj.keyup(function(event){
						var inputval=inputobj.val();
						var keyCode=event.which;
						//if(keyCode==13){
						//inputval=inputval.replace(/[ -~]/g,'')
						//td.text(inputval);
						
						//}else if(keyCode==27){
						
						//}
					});
					inputobj.blur(function(){
						var inputval=inputobj.val();
						//alert("inputval:"+inputval+","+options.action);
						var selObj=td.parent().children(":eq(5)").children();
						var idObj=td.parent().children(":eq(0)").children(":eq(0)");
						var ftype=$(selObj).val();
						var idval=$(idObj).html().replace(" ","").trim();
						//alert(idval+","+ftype+","+inputval.replace(" ","").trim()+",");
						if(isNaN(inputval.replace(" ",""))){
							alert("请输入正确序号");
							return;
						}
						$.post(options.action,{"sort":inputval,"id":idval,"ftype":ftype},
								function(data){
							var json=eval("("+data+")");
							//alert(json.state+","+text);
							if(json.state){
								td.text(inputval);
								$('#search').click();
							}else{
								alert("操作有误");
							}
						});
					});
				});
			}
		});
	}
	$.fn.editablefile=function(options){
		var defaults={
				tds:"#table tbody tr:even td",
				fontSize:"16px",
				action:"meet_updateFileSortZD.action",
				cindexs:"10",
		}
		var options=$.extend(options,defaults);
		//alert("tarObj1:"+tarObj.html());
		$(options.tds).each(function(){
			//var iseditable=$('#iseditable').val();
			//alert("t:"+($(this).index()==options.cindexs)
			if($(this).index()==options.cindexs){
				$(this).dblclick(function(){
			var td=$(this);
			if(td.children('input').length>0){
				return false;
			}
			var text=td.text();
			td.html("");
			var inputobj=$('<input>');
			var inputobj= $('<input>').css('border','none').width(td.width())
			.css("font-size",options.fontSize).height(td.height()).css('background-color',
					td.css('background-color')).val(text).appendTo(td);
			inputobj.click(function(){
				return false;
			});
			inputobj.trigger("focus").trigger("select");
			inputobj.keyup(function(event){
				var inputval=inputobj.val();
				var keyCode=event.which;
				//if(keyCode==13){
				//inputval=inputval.replace(/[ -~]/g,'')
				//td.text(inputval);
				
				//}else if(keyCode==27){
				
				//}
			});
			inputobj.blur(function(){
				var inputval=inputobj.val();
				//alert("inputval:"+inputval+","+options.action);
				var selObj=td.parent().children(":eq(6)").children();
				var idObj=td.parent().children(":eq(0)").children(":eq(0)");
				var ftype=$(selObj).val();
				var idval=$(idObj).html().replace(" ","").trim();
				//alert(idval+","+ftype+","+inputval.replace(" ","").trim()+",");
				if(isNaN(inputval.replace(" ",""))){
					alert("请输入正确序号");
					return;
				}
				$.post(options.action,{"sort":inputval,"id":idval,"ftype":ftype},
						function(data){
					var json=eval("("+data+")");
					//alert(json.state+","+text);
					if(json.state){
						td.text(inputval);
						$('#search').click();
					}else{
						alert("操作有误");
					}
				});
			});
		});
		}
		});
	}
	$.fn.editable=function(options){
		var defaults={
				tds:"#table tbody tr:even td",
				fontSize:"16px",
				action:"meet_updateFileSortZD.action"
		}
		var options=$.extend(options,defaults);
		$(options.tds).dblclick(function(){
			var td=$(this);
			if(td.children('input').length>0){
				return false;
			}
			var text=td.text();
			td.html("");
			var inputobj=$('<input>');
			var inputobj= $('<input>').css('border','none').width(td.width())
			.css("font-size",options.fontSize).height(td.height()).css('background-color',
					td.css('background-color')).val(text).appendTo(td);
			inputobj.click(function(){
				return false;
			});
			inputobj.trigger("focus").trigger("select");
			inputobj.keyup(function(event){
				var inputval=inputobj.val();
				var keyCode=event.which;
				//if(keyCode==13){
					//inputval=inputval.replace(/[ -~]/g,'')
					//td.text(inputval);
					
				//}else if(keyCode==27){
					
				//}
			});
			inputobj.blur(function(){
				var inputval=inputobj.val();
				//alert("inputval:"+inputval+","+options.action);
				var selObj=td.parent().children(":eq(5)").children();
				var idObj=td.parent().children(":eq(0)").children(":eq(0)");
				var ftype=$(selObj).val();
				var idval=$(idObj).html().replace(" ","").trim();
				alert(idval+","+ftype+","+inputval.replace(" ","").trim()+",");
				if(isNaN(inputval.replace(" ",""))){
					alert("请输入正确序号");
					return;
				}
				$.post(options.action,{"sort":inputval,"id":idval,"ftype":ftype},
						function(data){
							var json=eval("("+data+")");
							alert(json.state+","+text);
							if(json.state){
								td.text(inputval);
								$('#search').click();
							}else{
								alert("操作有误");
							}
						});
			});
			
		});
	}
	
});