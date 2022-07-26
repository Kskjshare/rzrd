<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<style type="text/css">
.erjimain{
margin:0;
float:left;
height:580px;
border:none;
}
.erjileftbar{
margin:0;
float:left;
}
.td_tongyong {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	text-align: center;
}
<%
	int meetid=Integer.parseInt(request.getParameter("meetid"));
%>
.erjileftbar dl{ margin-top:15px;}
.erjileftbar dt{ margin-top:5px;}
</style>
<script type="text/javascript">
			var iseditable=true;
  	 		$(function(){
				$("#select_bimu").click(function(){
						$("#closefile").show();
						$("#yichengStep").hide();		
						// zTree.checkAllNodes(true);
				});
				$("#select_yiti").click(function(){	
						$("#closefile").hide();	
						$("#yichengStep").show();
			
				});			
				getPubtime();		
				$("#buttonupload").click(function(){
	    			$("#upload").click();
	    		});
				$("#addricchens").click(function(){
				var filetext=$("#filetext").val();
						if(filetext==''){
							$.messager.alert('提示','请选择上传的word文件',"info",function(){});
							return;
						}
	    			$('#ffff').form('submit', {    
   				 	success: function(data){    
      				  var json = eval('(' + data + ')'); 
      				 //alert(json.state);
      				// alert(data.state);
        				 if(json.state=="true"||json.state==true){
        				 		$.messager.alert('提示','录入成功',"info",function(){});
			 					$("#treeGrid").treegrid("reload");
			 					$("#treeGridSort").treegrid("reload");
						 }else{
			 					$.messager.alert('提示','录入失败',"info",function(){});
			 					//$('#treegrid').window('close');
						 } 
   					}    
				});
	    		});
	    		
	    	$("#upload").change(function(){
	    	   var a=$("#upload").val();
	           if(a.indexOf(".doc")>-1){
	    	   	$("#filetext").val(a);
	    	   }else{
	    	   	$.messager.alert('提示','请选择word文件',"info");
	    	   }
	    	});
			}); 
			
			function addW(zid)
			{
			//initFile();
					$('#ff').form('clear');
				//	$('#btnsub').linkbutton({disabled:false});
					//alert(<%=meetid%>);
					$('#ff').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								//$('#btnsub').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){

							//$('#btnsub').linkbutton({disabled:false});
							closeW();
							if(zid!=0){
								$("#dataGrid").treegrid("reload",zid);
							}else{
								$("#dataGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload");
						}
					});
					 document.getElementById('ff').action = "<%=basePath%>meet_addRichen.action?richenEntity.pyichenid="+zid+"&meetid=<%=meetid%>&rand="+Math.random();
					//document.getElementById('ff').action = "<%=basePath%>meet_addRichen.action?meetid=<%=meetid%>&richenEntity.prichenid="+zid ;
					$('#logicWindow').window('open');
			} 
			function sub()
		{
				if($('#ff').form('validate')){
					//alert(document.getElementById('ff').action);
					$('#ff').submit();
					$('#logicWindow').window('close');				
				}
		}
		function closeW()
		{
			$('#logicWindow').window('close');
		}
			function sub2()
		{
				if($('#ff2').form('validate')){
					//alert(document.getElementById('ff2').action);
					$('#ff2').submit();
					$('#logicWindow2').window('close');				
				}
		}
		function closeW2()
		{
			$('#logicWindow2').window('close');
		}
			function sub3()
		{
				if($('#ff3').form('validate')){
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			var ids = [] ;
			for(var i = 0 ; i < nodes.length ; i ++)
			{
					if(i==0){
						//alert(nodes[i].id+","+nodes[i].name+","+nodes[i].wenjianname);
					}
					ids.push(nodes[i].id);
			}
			document.getElementById('richenids').value=ids.join(",");
			//提交日程关联闭幕会文件
			var treeObj2 = $.fn.zTree.getZTreeObj("treeDemo2");
			var nodes2 = treeObj2.getCheckedNodes(true);
			var ids2 = [] ;
			for(var j = 0 ; j < nodes2.length ; j ++)
			{
					if(j==0){
						//alert(nodes[i].id+","+nodes[i].name+","+nodes[i].wenjianname);
					}
					ids2.push(nodes2[j].id);
			}
			document.getElementById('fileids').value=ids2.join(",");
			//alert(document.getElementById('richenids').value);
					$('#ff3').submit();
					$('#logicWindow3').window('close');				
				}
		}
		function closeW3()
		{
			$('#logicWindow3').window('close');
		}
		var zid;
		function addW0()
			{
			zid=0;
			//alert("id:"+zid);
			//$('#btnsub').linkbutton({disabled:false});
			//document.getElementById("tt1").innerHTML="";
			//init();
 		            var meetid = parseInt(<%=meetid%>);
 		           // alert("meetid:"+meetid);
					$('#ff').form('clear');
					$('#ff').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								//$('#btnsub').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){
							closeW();
						//alert("zid:"+zid);
							if(zid!=0){
								$("#treeGrid").treegrid("reload",zid);
							}else{
								$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload",zid);
						}
					});
		          $('#logicWindow').window('open');
		    //      $('#dataGrid').treegrid("reload");
		       document.getElementById('ff').action = "<%=basePath%>meet_addRichen.action?richenEntity.prichenid="+zid+"&meetid="+meetid+"&rand="+Math.random();
			}
		function addW3(id)
			{
			//alert("addW3");

			setCheck(-2);
			setFileCheck(-2);
			zid=id;
			//alert("id:"+zid);
		//	$('#btnsub3').linkbutton({disabled:false});
 		            var meetid = parseInt(<%=meetid%>);
 		           // alert("meetid:"+meetid);
					$('#ff3').form('clear');
					$("#select_yiti").attr("checked","checked");
					$("#closefile").hide();	
					$("#yichengStep").show();					
					$('#ff3').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								//$('#btnsub3').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){
							closeW();
							//alert("zid:"+zid);
							if(zid!=0){
								$("#treeGrid").treegrid("reload",zid);
							}else{
								$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload",zid);
						}
					});
		          $('#logicWindow3').window('open');
		    //      $('#dataGrid').treegrid("reload");
		       document.getElementById('ff3').action = "<%=basePath%>meet_addRichenYiti.action?richenYitiEntity.richenid="+zid+"&meetid="+meetid+"&rand="+Math.random();
			}
		function addW2(id)
			{
			//alert("addW2");
			zid=id;
			//alert("id:"+zid);
			//$('#btnsub2').linkbutton({disabled:false});
 		            var meetid = parseInt(<%=meetid%>);
 		           // alert("meetid:"+meetid);
					$('#ff2').form('clear');
					$('#ff2').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
							//	$('#btnsub2').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){
							closeW2();
						//	alert("zid:"+zid);
							if(zid!=0){
								$("#treeGrid").treegrid("reload",zid);
							}else{
								$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload",zid);
						}
					});
		          $('#logicWindow2').window('open');
		    //      $('#dataGrid').treegrid("reload");
		       document.getElementById('ff2').action = "<%=basePath%>meet_addRichen.action?richenEntity.prichenid="+zid+"&meetid="+meetid+"&rand="+Math.random();
			}
			function showEdit3(id,pid){
		//init();
		//alert(id+","+pid);
		//alert(id+","+pid+",showEdit3");
		//alert("showEdit3:");
		setCheck(id);
		setFileCheck(id);

		//$('#btnsub3').linkbutton({disabled:false});
		$('#ff3').form('clear');
		$("#select_id").val(0);	
		var meetid = parseInt(<%=meetid%>);
			var rows = $('#treeGrid').treegrid('getSelections');
				$('#ff3').form({
				onSubmit:function (){
					var t =  $(this).form('validate');
					if(t)
					{
						$('#btnsub3').linkbutton({disabled:true});
					}
					return t;
				},
				success:function(data){
					var json = eval("("+data+")");
					if(!json.state)
					{
						alert(json.msg);
					}else{
					//$('#btnsub3').linkbutton({disabled:false});
					closeW3();
					//nextStep();
					//var  z=$("#dataGrid").treegrid("getParent",id);
					if(pid!=0){
						var  z=$("#treeGrid").treegrid("getParent",id);
						$("#treeGrid").treegrid("reload",z.id);
					}else{
						$("#treeGrid").treegrid("reload");
						//$("#treeGrid").treegrid("reload",id);
					}
					$("#treeGridSort").treegrid("reload");
					}
				}
			});
				$("#select_id").val("");
				var now=new Date();
				var number = now.getYear().toString()+now.getMonth().toString()+now.getDate().toString()+now.getHours().toString()+now.getMinutes().toString()+now.getSeconds().toString();
				$('#ff3').form('load','<%=basePath%>meet_loadRichenYiti.action?richenyitiid='+id+'&t='+number);
				//document.getElementById("id").value=rows[0].id;
				$.ajax({
						url:"<%=basePath%>meet_getRichenBimuFlag.action?richenyitiid="+id,
						success:function (data){
							if(data.flag==1){
								$("#closefile").show();
								$("#yichengStep").hide();
							}else{
								$("#closefile").hide();	
								$("#yichengStep").show();
							}	
						}
					});
				$('#logicWindow3').window('open');
			document.getElementById('ff3').action = "<%=basePath%>meet_updateRichenYiti.action?richenYitiEntity.richenid="+pid+"&meetid="+meetid+"&richenYitiEntity.yitiid="+id+"&rand="+Math.random();
			//$("#dataGrid").treegrid("reload");
		}
			function showEdit2(id,pid){
		//init();
		//alert(id+","+pid);
		//alert(id+","+pid+",showEdit2");
	//	$('#btnsub2').linkbutton({disabled:false});
		$('#ff2').form('clear');
		var meetid = parseInt(<%=meetid%>);
			var rows = $('#treeGrid').treegrid('getSelections');
				$('#ff2').form({
				onSubmit:function (){
					var t =  $(this).form('validate');
					if(t)
					{
					//	$('#btnsub3').linkbutton({disabled:true});
					}
					return t;
				},
				success:function(data){
					var json = eval("("+data+")");
					if(!json.state)
					{
						alert(json.msg);
					}else{
					//$('#btnsub2').linkbutton({disabled:false});
					closeW2();
					//nextStep();
					//var  z=$("#dataGrid").treegrid("getParent",id);
					if(pid!=0){
						var  z=$("#treeGrid").treegrid("getParent",id);
						$("#treeGrid").treegrid("reload",z.id);
					}else{
						$("#treeGrid").treegrid("reload");
						//$("#treeGrid").treegrid("reload",id);
					}
					$("#treeGridSort").treegrid("reload");
					}
				}
			});
				var now=new Date();
				var number = now.getYear().toString()+now.getMonth().toString()+now.getDate().toString()+now.getHours().toString()+now.getMinutes().toString()+now.getSeconds().toString();
				$('#ff2').form('load','<%=basePath%>meet_loadRichen.action?richenid='+id+'&t='+number);
				//document.getElementById("id").value=rows[0].id;
				$('#logicWindow2').window('open');
			document.getElementById('ff2').action = "<%=basePath%>meet_updateRichen.action?richenEntity.prichenid="+pid+"&meetid="+meetid+"&richenid="+id+"&rand="+Math.random();
			//$("#dataGrid").treegrid("reload");
		}
			function showEdit(id,pid){
		//init();
		//alert(id+","+pid+",showEdit");
		//$('#btnsub').linkbutton({disabled:false});
		$('#ff').form('clear');
		var meetid = parseInt(<%=meetid%>);
			var rows = $('#treeGrid').treegrid('getSelections');
				$('#ff').form({
				onSubmit:function (){
					var t =  $(this).form('validate');
					if(t)
					{
						//$('#btnsub').linkbutton({disabled:true});
					}
					return t;
				},
				success:function(data){
					var json = eval("("+data+")");
					if(!json.state)
					{
						alert(json.msg);
					}else{
					//$('#btnsub').linkbutton({disabled:false});
					closeW();
					//nextStep();
					//var  z=$("#dataGrid").treegrid("getParent",id);
					if(pid!=0){
						var  z=$("#treeGrid").treegrid("getParent",id);
						$("#treeGrid").treegrid("reload",z.id);
					}else{
						$("#treeGrid").treegrid("reload");
						//$("#treeGrid").treegrid("reload",id);
					}
					$("#treeGridSort").treegrid("reload");
					}
				}
			});
				var now=new Date();
				var number = now.getYear().toString()+now.getMonth().toString()+now.getDate().toString()+now.getHours().toString()+now.getMinutes().toString()+now.getSeconds().toString();
				$('#ff').form('load','<%=basePath%>meet_loadRichen.action?richenid='+id+'&t='+number);
				//document.getElementById("id").value=rows[0].id;
				$('#logicWindow').window('open');
			document.getElementById('ff').action = "<%=basePath%>meet_updateRichen.action?richenEntity.prichenid="+pid+"&meetid="+meetid+"&richenid="+id+"&rand="+Math.random();
			//$("#dataGrid").treegrid("reload");
		}
			 
			$(function () {
			//alert("meetid:"+<%=meetid%>);
            
             $.post("<%=basePath%>meet_getCurMeetProcess.action",{"meetid":<%=meetid%>,processType:"richen"},
			 function(data){
			 	if(data.state){
			 		$('#curstate').val(data.curstate);
			 		$('#statename').val(data.statename);
			 		$('#showStateName').html("状态："+data.statename);
			 		$('#comment').val(data.comment);
			 		//alert("curstate:"+data.curstate);
			 		if(data.curstate=="2"||data.curstate=="5"||data.curstate=="0"){
			 			iseditable=false;
			 			//alert("false");
			 			$('#buttonupload').attr('disabled',"true");
			 			$('#addricchens').attr('disabled',"true");
			 			$('#addrichen').attr('disabled',"true");
			 			$('#deleteAlls').attr('disabled',"true");
			 			$('#sorts').attr('disabled',"true");
			 		}else{
			 			iseditable=true;
			 			$('#buttonupload').removeAttr("disabled");
			 			$('#addrichen').removeAttr("disabled");
			 			$('#addricchens').removeAttr("disabled");
			 			$('#deleteAlls').removeAttr("disabled");
			 			$('#sorts').removeAttr("disabled");
			 			//alert("iseditables2:"+iseditable);
			 		}
			 		//alert("editable3:"+iseditable);
			 		if(data.curstate=="2"||data.curstate=="5"){
			 			$('#backornext').show();
			 			$('#showState').show();
			 		}else{
			 			$('#backornext').hide();
			 			$('#showState').hide();
			 		}
			 		var selectaction=document.getElementById('selectState');
			 		var array=data.list;
			 		//alert(array.length);
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].action;
			 			var actionname=array[i].actionname;
			 			selectaction.options.add(new Option(actionname,action));
			 		}
			 		$('#treeGrid').treegrid({
                title: '列表',
                //width: 700,
                height: 430,
                nowrap: false,
                rownumbers: true,
                animate: true,
                collapsible: true,
                singleSelect:false,
                checkbox:true,
                checkOnSelect:false,
                selectOnCheck:true,
                fitColumns:true,
                queryParams:{"meetid":<%=meetid%>,"id":0},
                method: 'post',
                //url: '/Scripts/jquery-easyui-1.3.1/demo/treegrid_data.json', //从远程站点获取数据
                url: '<%=basePath%>meet_selectRichen.action',
                idField: 'id', //说明哪个字段是一个标识字段
                treeField: 'name',
                columns:
                [[{ field: 'name', title: '文件名称', width: 690,formatter:function(d,t){
                	if(d.length>48){
                		return '<a href="javascript:void(0);" style=color:black title="'+d.replace(" ","")+'">'+ d.substring(0,50)+'...</a>';
                	}
                	return d;
                }},
                { field: 'sort', title: '排序', width: 30},
                { field: 'filetype', width: 70, title: '文件类型',formatter:function (d,t){
    			 	var res='';
    			 	//alert(t.filetype+","+d);
    				if(t.filetype==1){
    					res='正式文件';
    				}else if(t.filetype==2){
    					res='延伸阅读';
    				}else if(t.filetype==3){
    					res='参阅文件';
    				}else if(t.filetype==8){
    					res='闭幕会文件';
    				}
    				return res;
    				}},
    			 { field: 'id1', title: '操作', width: 90,formatter:function (d,t){
    			 	var res='';
    			 	var tid=t.id;
    				if(t.filetype==5){
    					res+='&nbsp;<a href=javascript:addW2('+tid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_01.png\' ></a>';
    					res+='&nbsp;<a href=javascript:showEdit('+tid+','+t.pid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_03.png\' ></a>';
    					res+='&nbsp;<a href=javascript:deleteLogic('+tid+','+t.pid+');><img src=\'<%=basePath%>themes/default/images/caozuo_05.png\' ></a>';
    				}
    				if(t.filetype==7){
    					res+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
    					res+='&nbsp;<a href=javascript:showEdit3('+t.nid+','+t.pid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_03.png\' ></a>';
    					res+='&nbsp;<a href=javascript:deleteLogic3('+tid+','+t.pid+');><img src=\'<%=basePath%>themes/default/images/caozuo_05.png\' ></a>';
    				}
    				if(t.filetype==6){
    					res+='&nbsp;<a href=javascript:addW3('+tid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_01.png\' ></a>';
    					res+='&nbsp;<a href=javascript:showEdit2('+tid+','+t.pid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_03.png\' ></a>';
    					res+='&nbsp;<a href=javascript:deleteLogic('+tid+','+t.pid+');><img src=\'<%=basePath%>themes/default/images/caozuo_05.png\' ></a>';
    				}
    				if(iseditable){
    					return res;
    				}else{
    					return '';
    				}
    				}},
    				{ field: 'fileselect',width: 30,checkbox:true}
               ]],
               onLoadSuccess:function(node,data){
              // alert(data[0].filetype+","+node+","+data[0].rows);
              $("input[type='checkbox'][name='fileselect'][value=1],input[type='checkbox'][name='fileselect'][value=2]").each(function(i){
              		this.style.display ='none';
              });
			}
            });
			 	};
			 });
         	
});
				
		function deleteLogic3(id,pid)
		{
			//alert(id+","+pid);
			$.messager.confirm("确认", "是否删除条目及子条目", function (r) {  
       		 if (r) {  
            	$.ajax({
					url:"<%=basePath%>meet_deleteRichenYiti.action?richenyitiid="+id,
					success:function (data){
						if(pid!=0){
							var  z=$("#treeGrid").treegrid("getParent",id);
							$("#treeGrid").treegrid("reload",z.id);
							}else{
							$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload");
							}
				});
       		}  
    		});  
		//	$("#dataGrid").treegrid("reload");
		}
		function benchDelete(){
			$.messager.confirm("确认", "是否批量删除条目及子条目", function (r) {  
        if (r) {  
        var rows = $('#treeGrid').treegrid('getChecked');
        		if(rows.length >0)
			{
				var ids = []; 
				var filetypes=[];
				for (var i = 0 ; i < rows.length ; i ++)
				{
					ids.push(rows[i].id);
					filetypes.push(rows[i].filetype);
				}
				var now=new Date();
				var number = now.getYear().toString()+now.getMonth().toString()+now.getDate().toString()+now.getHours().toString()+now.getMinutes().toString()+now.getSeconds().toString();
				$.ajax({
					url:"<%=basePath%>meet_benchDelete.action?fileids="+ids.join(",")+"&filetypes="+filetypes.join(","),
					success:function (data){
						var json = eval("("+data+")");
						//alert("state:"+json.state);
						if(!json.state)
						{
							alert(json.msg);
						}else {
							$("#treeGrid").treegrid("reload");
							$("#treeGridSort").treegrid("reload");
						}
					}
				});
			}else {
				$.messager.alert('提示','请选择需要删除的数据',"info");
			}
       		}  
    	});  
		}
		function deleteLogic(id,pid)
		{
		$.messager.confirm("确认", "是否删除条目及子条目", function (r) {  
       		 if (r) {  
            	$.ajax({
					url:"<%=basePath%>meet_deleteRichen.action?deleteid="+id,
					success:function (data){
						if(pid!=0){
							var  z=$("#treeGrid").treegrid("getParent",id);
							$("#treeGrid").treegrid("reload",z.id);
							}else{
							$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload");
							}
				});
       		}  
    		});  
		//	$("#dataGrid").treegrid("reload");
		}
		
		function subPro(){
			$('#proForm').form('submit',{
				success:function(data){
					var json=eval('('+data+')');
					if(json.state){
					$.messager.alert('提示','操作成功',"info",function(){});
					$('#curstate').val(json.curstate);
			 		$('#statename').val(json.statename);
			 		$('#showStateName').html("状态："+json.statename);
			 		//$('#comment').val(json.comment);
			 		if(json.curstate=="2"||json.curstate=="5"||json.curstate=="0"){
			 			iseditable=false;
			 			$('#buttonupload').attr('disabled',"true");
			 			$('#addricchens').attr('disabled',"true");
			 			$('#addrichen').attr('disabled',"true");
			 			$('#deleteAlls').attr('disabled',"true");
			 			$('#sorts').attr('disabled',"true");
			 		}else{
			 			iseditable=true;
			 			$('#buttonupload').removeAttr("disabled");
			 			$('#addrichen').removeAttr("disabled");
			 			$('#addricchens').removeAttr("disabled");
			 			$('#deleteAlls').removeAttr("disabled");
			 			$('#sorts').removeAttr("disabled");
			 			//alert("iseditables2:"+iseditable);
			 		}
			 		$("#treeGrid").treegrid("reload",0);				
			 		if(json.curstate=="2"||json.curstate=="5"){
			 			$('#backornext').show();
			 			$('#showState').show();
			 		}else{
			 			$('#backornext').hide();
			 			$('#showState').hide();
			 		}
			 		var selectaction=document.getElementById('selectState');
			 		var array=json.list;
			 		var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		//alert(array.length);
			 		for(var i=0;i<array.length;i++){
			 			var action=array[i].action;
			 			var actionname=array[i].actionname;
			 			selectaction.options.add(new Option(actionname,action));
			 		}
					}else{
						$.messager.alert('提示','操作失败',"info",function(){});
					}
				}
			});
		}	
		
		var setting = {
				async: {
					enable: true,
					autoParam: ["id"]
				},
				check: {
					enable: true
				},
				data: {
					simpleData: {
						idKey: "id",
						pIdKey:"pid",
						enable: true
					}
				}
			};	
		var setting2 = {
				async: {
					enable: true,
				},
				check: {
					enable: true
				},
				data: {
					simpleData: {
						idKey: "id",
						enable: true
					}
				}
			};		
		function setCheck(yitiid) {
			setting.async.url = "<%=basePath%>meet_getMeetTreeYichenNoFileJson.action?meetid=<%=meetid%>&yichenidTreeid="+yitiid;
			ztreeObj = $.fn.zTree.init($("#treeDemo"), setting, null);
			ztreeObj.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
		}
		function setFileCheck(id){
			setting2.async.url = "<%=basePath%>meet_getMeetTreeCloseFileJson.action?meetid=<%=meetid%>&richenid="+id;
			var ztreeObj2 = $.fn.zTree.init($("#treeDemo2"), setting2, null);
			 ztreeObj2.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };			
		}	
		function sortInput(field,row){
			//$.messager.alert('提示',row.sort+","+row.filetype);
			if(field=='sort'){
			if(row.filetype!=2&&row.filetype!=1){
			//判断是否存在节点，存在不再进行编辑
				if($('#inn').length>0){
						
				}else{			
					$('#treeGrid').treegrid('update',{
							id: row.id,
							row: {
								sort: '<input  type="text"  id="inn" name="inn"  value="'+row.sort+'"   onblur="updatesort('+row.id+','+row.pid+','+row.filetype+','+row.sort+')"   onkeypress="img('+row.id+')">',
								iconCls: 'icon-save'
							}
						});
						$('#inn').select();
					}
				}
			}
		}
		
		function  img(t){
			document.getElementById("img"+t).src="<%=basePath%>default/default/images/bcmc2.png";
			}
		
		function  updatesort(t,pid,filetype,sort){
		var   inn=document.getElementById("inn").value;
		if(isNaN(inn)){
			document.getElementById("inn").value=sort;
			$.messager.alert('提示',"请输入数字","info",function(){});
			return;
		}
		//$.messager.alert('提示',t+","+pid+","+filetype+","+inn);
				$.ajax({
					url:'<%=basePath%>meet_updateSort.action?id='+t+'&ftype='+filetype+'&sort='+inn,
					type:'post',
					success:function  (data){
						if(pid!=0){
							var  z=$("#treeGrid").treegrid("getParent",t);
							$("#treeGrid").treegrid("reload",z.id);
							}else{
							$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload");
					}
					})
			}
			/* 原排序界面js */
		<%-- $(function(){
			$('#treeGridSort').treegrid({
				width: 962,
				height: 450,
                nowrap: false,
                rownumbers: true,
                animate: true,
                collapsible: true,
                queryParams:{"meetid":<%=meetid%>,"id":0},
                method: 'post',
                url: '<%=basePath%>meet_selectRichen.action',
                idField: 'id', //说明哪个字段是一个标识字段
                treeField: 'name',
                columns:
                [[{ field: 'name', title: '文件名称', width: 700,formatter:function(d,t){
                	if(d.length>50){
                		return '<a href="javascript:void(0);" style=color:black title="'+d.replace(" ","")+'">'+ d.substring(0,50)+'...</a>';
                	}
                	return d;
                }},
                { field: 'sort', title: '排序', width: 50},
                { field: 'filetype', width: 100, title: '文件类型',formatter:function (d,t){
    			 	var res='';
    			 	//alert(t.filetype+","+d);
    				if(t.filetype==1){
    					res='正式文件';
    				}else if(t.filetype==2){
    					res='延伸阅读';
    				}else if(t.filetype==3){
    					res='参阅文件';
    				}else if(t.filetype==8){
    					res='闭幕会文件';
    				}
    				return res;
    				}},
    			 { field: 'id1', title: '操作', width: 80,formatter:function (d,t){
    			 	var res='';
    			 	var tid=t.id;
    				if(t.filetype==5){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				if(t.filetype==7){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				if(t.filetype==6){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				return res;
    				}}
               ]]
               onLoadSuccess:function(row){
                 //启用拖动功能
                 $(this).treegrid('enableDnd', row?row.id:null);
    			}
            });
		}) --%>
		$(function(){
			$('#treeGridSort').treegrid({
				width: 962,
				height: 450,
                nowrap: false,
                rownumbers: true,
                animate: true,
                collapsible: true,
                queryParams:{"meetid":<%=meetid%>,"id":0},
                method: 'post',
                url: '<%=basePath%>meet_selectRichen.action',
                idField: 'id', //说明哪个字段是一个标识字段
                treeField: 'name',
                columns:
                [[{ field: 'name', title: '文件名称', width: 700,formatter:function(d,t){
                	if(d.length>50){
                		return '<a href="javascript:void(0);" style=color:black title="'+d.replace(" ","")+'">'+ d.substring(0,50)+'...</a>';
                	}
                	return d;
                }},
                { field: 'sort', title: '排序', width: 50},
                { field: 'filetype', width: 100, title: '文件类型',formatter:function (d,t){
    			 	var res='';
    			 	//alert(t.filetype+","+d);
    				if(t.filetype==1){
    					res='正式文件';
    				}else if(t.filetype==2){
    					res='延伸阅读';
    				}else if(t.filetype==3){
    					res='参阅文件';
    				}else if(t.filetype==8){
    					res='闭幕会文件';
    				}
    				return res;
    				}},
    				{ field: 'id1', title: '操作', width: 80,formatter:function (d,t){
    			 	var res='';
    			 	var tid=t.id;
    				if(t.filetype==5){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				if(t.filetype==7){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				if(t.filetype==6){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
						res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				return res;
    				}}
               ]],
               onLoadSuccess:function(row){
                 //启用拖动功能
                 //$(this).treegrid('enableDnd', row?row.id:null);
    			}
            });
		}) 
		function sortwindow(){
			$("#popwindow").window("open");
		}
		function up(obj,filetype){
			var tr=obj.parentNode.parentNode.parentNode;
			if (tr.rowIndex > 0) {
				var tBody = tr.parentNode;
				trnext=tr.nextSibling;
				var trid=tr.id;
				var trarray=trid.split("-");
				var id1=trarray[trarray.length-1];
				var sort1=$('#'+trid+' td[field=sort] div').text();
				var trpre=tr.previousSibling;
				var trpreid=trpre.id;
				if (trnext==null) {
					if (trpreid=="") {
						tBody.replaceChild(trpre, tr);
						tBody.insertBefore(tr, trpre);
						trpre=tr.previousSibling;
						trpreid=trpre.id;
					}
					var trprearray=trpreid.split("-");
					var id2=trprearray[trprearray.length-1];
					var sort2=$('#'+trpreid+' td[field=sort] div').text();
					var target = (tr.rowIndex < trpre.rowIndex) ? trpre.nextSibling : trpre;
					tBody.replaceChild(trpre, tr);
					tBody.insertBefore(tr, target);	
				}else{
					if (trpreid=="") {
						tBody.replaceChild(trpre, trnext);
						tBody.insertBefore(trnext, tr);
						var trppre=tr.previousSibling.previousSibling;
						tBody.replaceChild(trppre, tr);
						tBody.insertBefore(tr, trnext);
						trpre=tr.nextSibling.nextSibling;
						trpreid=trpre.id;
					}
					var trprearray=trpreid.split("-");
					var id2=trprearray[trprearray.length-1];
					var sort2=$('#'+trpreid+' td[field=sort] div').text();
					tBody.replaceChild(trpre, tr);
					tBody.insertBefore(tr, trpre);
				}
				$('#'+trpreid+' td[field=sort] div').text(sort1);
				$('#'+trid+' td[field=sort] div').text(sort2);
				$.post('<%=basePath%>meet_updateSort.action', {id:id1,ftype:filetype,sort:sort2},function(){
				$.post('<%=basePath%>meet_updateSort.action', {id:id2,ftype:filetype,sort:sort1});
				});
			}
		}
		function down(obj,filetype){
			var tr=obj.parentNode.parentNode.parentNode;
			var tBody = tr.parentNode;
			var trnext=tr.nextSibling;
			var trnnext=tr.nextSibling.nextSibling;
			var trid=tr.id;
			var trarray=trid.split("-");
			var id1=trarray[trarray.length-1];
			var sort1=$('#'+trid+' td[field=sort] div').text();
			if (trnext!=null&&((trnext.id==""&&trnnext!=null)||trnext.id!="")) {
				if (trnext.id=="") {
					var trnnnext=tr.nextSibling.nextSibling.nextSibling;
					if (trnnnext==null||trnnnext.id!="") {
						tBody.replaceChild(trnext, trnnext);
						tBody.insertBefore(tr, trnext);
						tBody.insertBefore(trnnext, tr);
						trnext=tr.previousSibling;
					}else{
						tBody.replaceChild(trnext, trnnnext);
						tBody.insertBefore(tr, trnext);
						tBody.insertBefore(trnnnext, tr);
						tBody.insertBefore(trnnext, trnnnext);
						trnext=tr.previousSibling.previousSibling;
					}
				}else{
					if (trnnext==null||trnnext.id!="") {
						tBody.replaceChild(tr, trnext);
						tBody.insertBefore(trnext, tr);
						trnext=tr.previousSibling;
					}else{
						tBody.replaceChild(tr, trnnext);
						tBody.insertBefore(trnnext, tr);
						tBody.insertBefore(trnext, trnnext);
						trnext=tr.previousSibling.previousSibling;
					}
				}
			}
			trnextid=trnext.id;
			var trnextarray=trnextid.split("-");
			var id2=trnextarray[trnextarray.length-1];
			var sort2=$('#'+trnextid+' td[field=sort] div').text();
			$('#'+trnextid+' td[field=sort] div').text(sort1);
			$('#'+trid+' td[field=sort] div').text(sort2);
			$.post('<%=basePath%>meet_updateSort.action', {id:id1,ftype:filetype,sort:sort2},function(){
				$.post('<%=basePath%>meet_updateSort.action', {id:id2,ftype:filetype,sort:sort1});
			});
			}
			  
		function closeSort(){
			window.location.href ="<%=basePath %>module/main/meet/changwh/richengmanage.jsp?meetid=<%=meetid%>";
		}
		
		function flownext(){
			var selectaction=document.getElementById('selectState');
			//alert("length:"+selectaction.length);
					var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		selectaction.options.add(new Option("正式发布",2));
			 		selectaction.options.add(new Option("退回上一级",3));
		}
		function flowback(){
			var selectaction=document.getElementById('selectState');
			//alert("length:"+selectaction.length);
					var selLength=selectaction.length;
			 		for(var i=0;i<selLength;i++){
			 			selectaction.removeChild(selectaction[0]);
			 		}
			 		selectaction.options.add(new Option("退回上一级",3));
			 		selectaction.options.add(new Option("正式发布",2));
		} 
		
		function backMeet(){
    		window.location.href="<%=basePath %>selectCurMeeting.action?type=2";
    	}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}    	
     	function saveAndP(){
			$('#meetid').val(parseInt(<%=meetid%>));
			$('#statename').val('richen');
			$('#proForm').form('submit',{
				success:function(data){
					var json=eval('('+data+')');
					if(json.state){
						$.messager.alert('提示',"发布成功！","info");
						getPubtime();
					}else{
						$.messager.alert('提示',"发布失败！","error");
					}
				}
			});
		} 
		function getPubtime(){
	 			$.ajax({
						url:"<%=basePath%>meet_selectPubtimeRichen.action?meetid="+<%=meetid%>,
						success:function (data){
							$("#pushtime").html(data.msg);
						} 			
	 			});			
		}	  	
</script>
</head>
<body>
<!--此处内容更替-->
        <div class="cwh_head">
            主页>常委会会议>日程 <!-- <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button> -->
        </div>
        <a class='easyui-linkbutton' onclick="javascript:backMeet()" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>        
        <div class="erjileftbar">
             <dl>
               <dt><a id="indexInfo" href="<%=basePath %>module/main/meet/changwh/index.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon1.png"/></a></dt>
               <dt><a id="yichengmanage" href="<%=basePath %>module/main/meet/changwh/yichengmanage.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon3.png"/></a></dt>
               <dt><a id="richengmanage"  href="<%=basePath %>module/main/meet/changwh/richengmanage.jsp?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon04.png"/></a></dt>
               <dt><a id="meetfile1"  href="<%=basePath %>meet_getMeetFile2.action?meetid=<%=meetid%>&fileown=1&filetype=&pageNo=1&pageSize=8&bindtype=0"><img src="<%=path%>/themes/default/images/icon2.png"/></a></dt>
               <dt><a id="groupInfo" href="<%=basePath %>meet_getFenzuList.action?meetid=<%=meetid%>"><img src="<%=path%>/themes/default/images/icon5.png"/></a></dt>
               <dt><a id="meetfile2"  href="<%=basePath %>meet_getMeetFile.action?meetid=<%=meetid%>&fileown=2&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon9.png"/></a></dt>
            </dl>
        </div>
        <div class="erjimain">   
          <div class="huiyi_head" style="display: none;">
           <form action="<%=basePath %>meet_submitMeetProcess.action" method="post" id="proForm">
            	  <input id="curstate" name="curstate" type="hidden"/>
            	  <input id="processType" name="processType" type="hidden" value="richen"/>
            	  <input id="statename" name="statename" type="hidden"/>
            	  <s:hidden id="meetid" name="meetid" type="hidden"> </s:hidden>
                  <p id="showStateName">
                  </p>
                   <p id="showState" style="display: none;">
                  	<img style="width: 32px;height: 32px;" src="<%=path%>/themes/default/images/lb01.gif"/>
                  </p>
                  <p id="backornext" style="display: none;">
                  	<input name="comment" type="radio" value="同意" checked="checked" onclick="flownext()"/>
                  	&nbsp;&nbsp;同意&nbsp;
                  	<input name="comment" type="radio" value="退回" onclick="flowback()"/>
                  	&nbsp;&nbsp;退回&nbsp;
                  </p>
                  <p>下一步骤：
                  <select style="width:150px; height:30px;line-height:30px;" name="action" id="selectState">  
<!--                  <s:iterator value="processList">-->
<!--                  	  <option value="<s:property value="action"/>"> <s:property value="actionname"/></option>-->
<!--                  </s:iterator>-->
              </select>
              </p>
<!--              <p style="display: none;"> 审核意见:<input style="width:200px; height:30px;line-height:30px;border:1px solid #ccc; margin-left:5px;" id="comment" name="comment" type="text"/></p>-->
               	<%boolean b=false;
               	if(usertype!=null&&usertype.equals("1")){
  					 b=true;
					}else{
					b=permission.get(2)!=null&&permission.get("2").toString().equals("2");
					} %>
				<%if(b){ %>
                <button  class="button3" name="" type="button" onclick="subPro();" style="position:absolute; right:20px;">提交</button>
				<%} %>
<!--                 <button  class="button3" name="" type="button" onclick="subPro();" style="position:absolute; right:20px;">提交</button> -->
               </form>
           </div>
           <div class="huiyi_main">
             <form action="<%=basePath %>meet_benchRichenAddByFile.action" id="ffff" method="post" enctype="multipart/form-data">
            <s:hidden name="meetid" ></s:hidden>
            <s:hidden name="type" value="2"></s:hidden>
           	 <table width=100% style="font-size:14px;color:#333;">
           	 		
           	 		<tr>
	                    <td width=27% style="font-size:14px;font-family:微软雅黑;">1.选择日程文件(只能上传word文档)：</td>
	                    <td width=15% ><input class="input" type="text" value="" id="filetext" disabled="disabled"></td>
	                    <!-- <td  align=left><button type="button" class="button3" id="buttonupload">上传</button> -->
	            	    <td  align=left> <a class='easyui-linkbutton' id="buttonupload" data-options="iconCls:'icon-upload'"  style="line-height: 25px;width: 80px;color:#a10000;" href='javascript:void(0)'>上传</a>        
	                    	<div style="display: none"><input type="file" name="file" value="" id="upload"></div>
	                    </td>
	                </tr>
<!--	                <s:hidden name="type" value="2"></s:hidden>-->
           	 		<tr>
	                    <td style="font-size:14px;font-family:微软雅黑;">2.点击生成按钮，生成日程</td>
	                    <!-- <td><button  class="button3" name="" id="addricchens" type="button" style="">生成日程</button></td> -->	    
	                    <td><a class='easyui-linkbutton' id="addricchens"  data-options="iconCls:'icon-textadd'"  style="line-height: 25px;width: 80px;color:#a10000;margin-left: 5px;" href='javascript:void(0)'>生成日程</a></td>	                                    
	                    <td align=right>
	                    <a class='easyui-linkbutton' id="sorts"  data-options="iconCls:'icon-sort'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="sortwindow();">排序</a>
	                    <a class='easyui-linkbutton' id="addrichen"  data-options="iconCls:'icon-add'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="addW0();">增加日程</a>
	                    <a class='easyui-linkbutton' id="deleteAlls" data-options="iconCls:'icon-remove'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="benchDelete();">批量删除</a>	                    
<!-- 	                     <button type="button" class="button3" id="sorts" onclick="sortwindow();">排序</button>
	                    <button type="button" class="button3" id="addrichen" onclick="addW0();">增加日程</button>
	                    <button type="button" class="button3" id="deleteAlls" onclick="benchDelete();">批量删除</button> -->
	                    </td>
	                </tr>
<!--           	 		<tr>-->
<!--	                    <td>1.选择日程文件：</td>-->
<!--	                    <td><input  class="input" type="text" value="" id="filetext" disabled="disabled"></td>-->
<!--	                    <td><button type="button" class="button3" id="buttonupload">上传</button>-->
<!--	                    	<div style="display: none"><input type="file" name="file" value="" id="upload"></div>-->
<!--	                    </td>-->
<!--	                </tr>-->
<!--           	 		<tr>-->
<!--	                    <td>2.点击生成按钮，生成日程</td>-->
<!--	                    <td><button  class="button3" name="" id="addricchen" type="button" style="">生成日程</button></td>-->
<!--	                    <td>-->
<!--	                    </td>-->
<!--	                </tr>-->
<!--           	 		<tr>-->
<!--	                    <td>3.查看及调整日程</td>-->
<!--	                    <td><button type="button" class="button3" id="modify">调整顺序</button></td>-->
<!--	                    <td><button type="button" class="button3" id="addrichen" onclick="addW0()">增加日程</button>-->
<!--	                    </td>-->
<!--	                </tr>-->
           	 </table>
           	  <table id = "treeGrid" data-options = "onDblClickCell:function (field,row){sortInput(field,row)}">
    	</table>
    	    <div region="south" border="false"style="text-align: center; padding: 5px 0;">
    		 		<span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span id="pushtime"></span></span>    	    
<!-- 					<button type="button" class="button3"  onclick="showS();" style="margin-right:80px;margin-top:10px;">保存</button>
					<button type="button" class="button3"  style="margin-top:10px;" onclick="saveAndP();">保存并发布</button> -->
	                <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" onclick="showS();">保存</a>
	                <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>					
			</div>
           	 </form>
           </div>
        </div>
<!--此处内容更替结束-->
<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="排序" style="left:60px;top:20px;width:1000px;height:570px;padding:10px;">
<div style="font-size:16px;margin-bottom:5px;">日程管理</div>
<table id = "treeGridSort" class="easyui-treegrid" data-options = "onDblClickCell:function (field,row){sortInput(field,row)}">
</table><a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-left:800px;margin-top: 5px;" onclick="closeSort();">确定</a>
</div>
    <div id="logicWindow" class="easyui-window" title="新增日程"
			iconCls="icon-save"
			style="left:500px;top:150px;width: 500px; height: 230px; padding: 5px;" closed = "true"  >
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="background: #fff; border: 1px solid #ccc;">
					<form id="ff" method="post" action="">
<!--						<input type="hidden" name="dayPlanEntity.id">-->
						<table>
							<tr>
								<td class="td_tongyong">
									会议日期：
								</td>
								<td>
								<input type="text" name="richenEntity.name" style=" line-height:20px;font-size: 14px; font-family: '微软雅黑'; border: 1px solid #ccc;"
										 class="easyui-validatebox" required="true">
<!--									<input type="text" name="richenEntity.name"-->
<!--										 class="easyui-validatebox" required="true" -->
<!--										  style=" font-size: 14px; font-family: '微软雅黑';line-height: 25px; border: 1px solid #ccc;">-->
								</td>
							</tr>
							<tr>
								<td  class="td_tongyong">
									序号：
								</td>
								<td>
									<input type="text" name="richenEntity.sort" style=" font-size: 14px; font-family: '微软雅黑';line-height: 25px; border: 1px solid #ccc;"
										 class="easyui-validatebox easyui-numberbox" required="true">
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div region="south" border="false"
					style="text-align: center; padding: 5px 0;">
					<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;margin-right: 40px;" onclick="sub();">确定</a>
					<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;" onclick="closeW();">取消</a>				
				</div>
			</div>
		</div>
    <div id="logicWindow3" class="easyui-window" title="日程议题信息"
			iconCls="icon-save"
			style="width: 1000px; height: 400px; padding: 5px;" closed = "true"  >
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="background: #fff; border: 1px solid #ccc;">
					<form id="ff3" method="post" action="">
						<input type="hidden" name="richenYitiEntity.bindyichenid" id="richenids">
						<input type="hidden" name="fileids" id="fileids">
						<input type="hidden" name="bindbimuflag" id="bindbimuflag">
						<table>
							<tr>
								<td  class="td_tongyong">
									议题名称：
								</td>
								<td>
								<input class="easyui-validatebox" name="richenYitiEntity.title" id="title" validType="length[0,1000]"
										style="width: 600px;line-height:20px;line-height:20px;font-size: 14px; font-family: '微软雅黑'; border: 1px solid #ccc;" required="true"></input>
								</td>
							</tr>
							<tr>
								<td  class="td_tongyong">
									序号：
								</td>
								<td>
								<input class="easyui-validatebox" name="richenYitiEntity.sort" id="title" validType="length[0,1000]"
										style="width: 600px;line-height:20px; font-size: 14px; font-family: '微软雅黑';border: 1px solid #ccc;" required="true"></input>
								</td>
							</tr>
							<tr >
								<td  class="td_tongyong">									
									关联闭幕会文件：							
								</td>
								<td>
<!-- 									<select name="richenYitiEntity.bindbimu" id="select_id" style="width: 600px;line-height:20px; font-size: 14px; font-family: '微软雅黑';border: 1px solid #ccc;">
										<option id="firsrselect" >否</option>
										<option  value="1">是</option>
									</select> -->
									<input type="radio" name="richenYitiEntity.bindbimu" id="select_yiti" value="0">&nbsp;&nbsp;否</input>&nbsp;&nbsp;
									<input type="radio" name="richenYitiEntity.bindbimu" id="select_bimu" value="1">&nbsp;&nbsp;是</input>
								</td>
							 </tr>								
							<tr id="yichengStep">
								<td  class="td_tongyong">									
									关联议程：							
								</td>
							
								<td style="border: 1px solid #ccc">
									<ul id="treeDemo"  class="ztree"></ul>
								</td>
							 </tr>						 
							<tr  id="closefile">
								<td  class="td_tongyong">									
									选择闭幕会文件：							
								</td>
							
								<td style="border: 1px solid #ccc">
								
									<ul id="treeDemo2"  class="ztree"></ul>
								</td>
							 </tr>
						</table>
					</form>
				</div>
				<div region="south" border="false"
					style="text-align: center; padding: 5px 0;">
					<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;margin-right: 40px;" onclick="sub3();">确定</a>
					<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;" onclick="closeW3();">取消</a>						
				</div>
			</div>
		</div>
    <div id="logicWindow2" class="easyui-window" title="新增子日程"
			iconCls="icon-save"
			style="width: 500px; height: 200px; padding: 5px;" closed = "true"  >
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="background: #fff; border: 1px solid #ccc;">
					<form id="ff2" method="post" action="">
<!--						<input type="hidden" name="dayPlanEntity.id">-->
						<table>
							<tr>
								<td  class="td_tongyong">
									子日程名称：
								</td>
								<td>
								<input class="easyui-validatebox" name="richenEntity.name" id="title" validType="length[0,1000]"
										style="width: 300px;line-height:20px;line-height:20px;font-size: 14px; font-family: '微软雅黑'; border: 1px solid #ccc;" required="true"></input>
								</td>
							</tr>
							<tr>
								<td  class="td_tongyong">
									序号：
								</td>
								<td>
									<input type="text" name="richenEntity.sort" 
										 class="easyui-numberbox" style="width: 300px;line-height:20px;font-size: 14px; font-family: '微软雅黑'; border: 1px solid #ccc;" required="true">
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div region="south" border="false"
					style="text-align: center; padding: 5px;">

					<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;margin-right: 40px;" onclick="sub2();">确定</a>
					<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top: 5px;" onclick="closeW2();">取消</a>						
				</div>
			</div>
		</div>
</body>
</html>
