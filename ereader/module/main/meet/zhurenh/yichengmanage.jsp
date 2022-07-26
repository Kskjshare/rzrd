<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_主任会议</title>
<%
String meetid=request.getParameter("meetid");
System.out.println("types3:"+request.getParameter("type"));
int type=Integer.parseInt(request.getParameter("type"));
System.out.println("types:"+type);
 %>
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
.erjileftbar dt{ margin-top:15px;}
</style>

<script type="text/javascript">
		//   --------------文件-----------------
		
		
         function addfile1(id)
			{
		          $('#logicWindow1').window('open');
			      //document.getElementById('fff').action = "<%=basePath%>meeting/subMeetingAction!meetingfileadd.action?submeetingid="+id+"&rand="+Math.random();
			}
			
			function openWin(){
				$('#logicWindow1').window('open');
			}
			$(function(){
				$("#buttonupload").click(function(){
				//alert("OK");
	    			$("#upload").click();
	    		});
				$("#addyicheng").click(function(){
					var filetext=$("#filetext").val();
						if(filetext==''){
							$.messager.alert('提示','请选择上传的word文件',"info",function(){});
							return;
						}
					//alert("OK");
	    			$('#ffff').form('submit', {    
   				 	success: function(data){    
      				  var json = eval('(' + data + ')'); 
      				 //alert(json.state);
      				// alert(data.state);
        				 if(json.state=="true"||json.state==true){
        				 		$.messager.alert('提示','录入成功',"info");
			 					$("#treeGrid").treegrid("reload");
			 					$("#treeGridSort").treegrid("reload");
						 }else{
			 					$.messager.alert('提示','录入失败',"info");
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
			var zid;
			function addW2(){
			setCheck(-2);
			zid=0;
			$('#btnsub').linkbutton({disabled:false});
			document.getElementById("tt1").innerHTML="";
			//init();
 		            var meetid = parseInt(<%=meetid%>);
 		           // alert("meetid:"+meetid);
					$('#ff').form('clear');
					$('#ff').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								$('#btnsub').linkbutton({disabled:true});
							}
							return t;
						},
						success:function(data){
							closeW();
							//alert("zid0:"+zid);
							if(zid!=0){
								$("#treeGrid").treegrid("reload",zid);
							}else{
								$("#treeGrid").treegrid("reload");
							}
							$("#treeGridSort").treegrid("reload",zid);
						}
					});
		          //alert(document.getElementById('ff').action);
		          $('#logicWindow').window('open');
		          //alert("<%=basePath%>meet_addYiti.action?yitiEntity.pyichenid="+zid+"&meetid="+meetid+"&rand="+Math.random());
					 document.getElementById('ff').action = "<%=basePath%>meet_addYiti.action?yitiEntity.pyichenid="+zid+"&meetid="+meetid+"&rand="+Math.random();
		    //      $('#dataGrid').treegrid("reload");
		  //  alert(document.getElementById('ff').action);
			}
			function addW1(id)
			{
			setCheck(-2);
			zid=id;
			//alert("addW1:"+zid);
			$('#btnsub').linkbutton({disabled:false});
			document.getElementById("tt1").innerHTML="";
			//init();
 		            var meetid = parseInt(<%=meetid%>);
 		           // alert("meetid:"+meetid);
					$('#ff').form('clear');
					$('#ff').form({
						onSubmit:function (){
							var t =  $(this).form('validate');
							if(t)
							{
								$('#btnsub').linkbutton({disabled:true});
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
					
		          //alert(document.getElementById('ff').action);
		          $('#logicWindow').window('open');
		          //alert("<%=basePath%>meet_addYiti.action?yitiEntity.pyichenid="+zid+"&meetid="+meetid+"&rand="+Math.random());
					 document.getElementById('ff').action = "<%=basePath%>meet_addYiti.action?yitiEntity.pyichenid="+zid+"&meetid="+meetid+"&rand="+Math.random();
		    //      $('#dataGrid').treegrid("reload");
		  //  alert(document.getElementById('ff').action);
		      
			}
			
			function closeW()
		{
		//init();
			$('#logicWindow').window('close');
		}
		
		
		function showEdit(id,pid){
		//init();
		//alert(id+","+pid);
		setCheck(id);
		zid=pid;
		$('#btnsub').linkbutton({disabled:false});
		$('#ff').form('clear');
		var meetid = parseInt(<%=meetid%>);
				$('#ff').form({
				onSubmit:function (){
					var t =  $(this).form('validate');
					if(t)
					{
						$('#btnsub').linkbutton({disabled:true});
					}
					return t;
				},
				success:function(data){
					var json = eval("("+data+")");
					if(!json.state)
					{
						alert(json.msg);
					}else{
					$('#btnsub').linkbutton({disabled:false});
					closeW();
					//nextStep();
					//var  z=$("#dataGrid").treegrid("getParent",id);
					if(zid!=0){
						//var  z=$("#treeGrid").treegrid("getParent",id);
						$("#treeGrid").treegrid("reload",zid);
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
				$('#ff').form('load','<%=basePath%>meet_loadYichen.action?yichenid='+id+'&t='+number);
				//document.getElementById("id").value=rows[0].id;
				$('#logicWindow').window('open');
			document.getElementById('ff').action = "<%=basePath%>meet_updateYiti.action?yitiEntity.pyichenid="+pid+"&meetid="+meetid+"&yichenid="+id+"&rand="+Math.random();
			//$("#dataGrid").treegrid("reload");
		}
		
		function shiyan(obj){
			var reg = /^[0-9]*$/; 
			var  tt1=document.getElementById("tt1");
				if(reg.test(obj.value)&&obj.value!=""){
					tt1.style="color:green";
					tt1.innerHTML="通过!";
					$('#btnsub').linkbutton({disabled:false});
					}else{
						tt1.style="color:red";
						tt1.innerHTML="请输入数字!";
						$('#btnsub').linkbutton({disabled:true});
						}
			}
			function sub(){
				if($('#ff').form('validate')){
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
			document.getElementById('fileids').value=ids.join(",");
					$('#ff').submit();	
			//		$("#dataGrid").treegrid("reload");		
				$('#logicWindow').window('close');	
			}
		}
 			$(function () {
			$('#treeGrid').treegrid({
                title: '列表',
                //width: 700,
                height: 450,
                nowrap: false,
                rownumbers:true,
                animate:true,
                collapsible:true,
                singleSelect:false,
                checkbox:true,
                checkOnSelect:false,
                selectOnCheck:true,
                fitColumns:true,                
                queryParams:{"meetid":<%=meetid%>,"id":0},
                method: 'post',
                //url: '/Scripts/jquery-easyui-1.3.1/demo/treegrid_data.json', //从远程站点获取数据
                url: '<%=basePath%>meet_selectYichen.action',
                idField: 'id', //说明哪个字段是一个标识字段
                treeField: 'name',
                columns:
                [[{ field: 'name', title: '名称', width: 705,formatter:function (d,t){
                	if(d.length>50){
                		return '<a href="javascript:void(0);" style="color:black" title="'+d+'">'+d.substring(0,50)+'...</a>';
                	}
                	return d;
                }},
                
                { field: 'sort', title: '序号', width: 30},
                { field: 'filetype', width: 60, title: '文件类型',formatter:function (d,t){
    			 	var res='';
    			 	//alert(t.filetype+","+d);
    				if(t.filetype==1){
    					res='正式文件';
    				}else if(t.filetype==2){
    					res='延伸阅读';
    				}else if(t.filetype==3){
    					res='参阅文件';
    				}
    				return res;
    				}},
    			 { field: 'id1', title: '操作', width: 90,formatter:function (d,t){
    			 	var res='';
    			 	var tid=t.id;
    				if(t.filetype==0){
    				res+='<a href=javascript:addW1('+tid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_01.png\' ></a>';
    				res+='&nbsp;<a href=javascript:showEdit('+tid+','+t.pid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_03.png\' ></a>';
    				res+='&nbsp;<a href=javascript:deleteLogic('+tid+','+t.pid+');><img src=\'<%=basePath%>themes/default/images/caozuo_05.png\' ></a>';
    				}
    				if(t.filetype==4){
    				res+='';
    				res+='&nbsp;<a style=margin-left:25px; href=javascript:showEdit('+tid+','+t.pid+'); ><img src=\'<%=basePath%>themes/default/images/caozuo_03.png\' ></a>';
    				res+='&nbsp;<a href=javascript:deleteLogic('+tid+','+t.pid+');><img src=\'<%=basePath%>themes/default/images/caozuo_05.png\' ></a>';
    				}
    				return res;
    				}},
    				 { field: 'fileselect',width: 20,checkbox:true}
               ]],
               onLoadSuccess:function(node,data){
              // alert(data[0].filetype+","+node+","+data[0].rows);
              $("input[type='checkbox'][name='fileselect'][value=1],input[type='checkbox'][name='fileselect'][value=2]").each(function(i){
              		this.style.display ='none';
              });
			}
            });
            
});

		function selAlls(){
			$('#treeGrid').treegrid('clearChecked');
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
						}
						$("#treeGridSort").treegrid("reload");
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
					url:"<%=basePath%>meet_deleteYichen.action?deleteid="+id,
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
		
		function setCheck(yichenid) {
			$.fn.zTree.destroy("treeDemo");
			setting.async.url = "<%=basePath%>meet_selectALLMeetFileByMeetid.action?meetid=<%=meetid%>&fileown=1&filetype=1&yichenidTreeid="+yichenid;
			ztreeObj = $.fn.zTree.init($("#treeDemo"), setting, null);
			ztreeObj.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
		}
		$(function(){
			document.getElementById('type').value=<%=type%>;
		})
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
			document.getElementById("img"+t).src="<%=basePath%>themes/default/images/bcmc2.png";
			}
		
		function  updatesort(t,pid,filetype,sort){
		var   inn=document.getElementById("inn").value;
		if(isNaN(inn)){
			document.getElementById("inn").value=sort;
			$.messager.alert('提示',"请输入数字"+inn,"info",function(){});
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
		$(function(){
			getPubtime();
			$('#treeGridSort').treegrid({
				width: 962,
                height: 420,
                nowrap: false,
                rownumbers:true,
                animate:true,
                collapsible:true,
                singleSelect:false,
                checkbox:true,
                checkOnSelect:true,
                selectOnCheck:true,
                queryParams:{"meetid":<%=meetid%>,"id":0},
                method: 'post',
                //url: '/Scripts/jquery-easyui-1.3.1/demo/treegrid_data.json', //从远程站点获取数据
                url: '<%=basePath%>meet_selectYichen.action',
                idField: 'id', //说明哪个字段是一个标识字段
                treeField: 'name',
                columns:
                [[{ field: 'name', title: '名称', width: 700,formatter:function (d,t){
                	if(d.length>50){
                		return '<a href="javascript:void(0);" style="color:black" title="'+d+'">'+d.substring(0,50)+'...</a>';
                	}
                	return d;
                }},
                
                { field: 'sort', title: '序号', width: 50},
                { field: 'filetype', width: 100, title: '文件类型',formatter:function (d,t){
    			 	var res='';
    			 	//alert(t.filetype+","+d);
    				if(t.filetype==1){
    					res='正式文件';
    				}else if(t.filetype==2){
    					res='延伸阅读';
    				}else if(t.filetype==3){
    					res='参阅文件';
    				}
    				return res;
    				}},
    			 { field: 'id1', title: '操作', width: 80,formatter:function (d,t){
    			 	var res='';
    			 	var tid=t.id;
    				if(t.filetype==0){
    					res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
	    				res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				if(t.filetype==4){
    				res+='';
    				res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=up(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/up.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				res+='&nbsp;&nbsp;&nbsp;<a href=javascript:void(0) onclick=down(this,'+t.filetype+'); ><img width=15px height=25px style="vertical-align:middle;" src=\'<%=basePath%>themes/default/images/down.png\' ></a>&nbsp;&nbsp;&nbsp;';
    				}
    				return res;
    				}}
               ]]
            });
		});
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
			window.location.href ="<%=basePath%>module/main/meet/zhurenh/yichengmanage.jsp?meetid=<%=meetid%>&type=<%=type%>";
		}
		function backMeet(){
    			window.location.href="<%=basePath %>selectCurMeeting.action?type=<%=type%>";
    		}
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
			$('#meetid').val(parseInt(<%=meetid%>));
			$('#statename').val('yichen');
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
						url:"<%=basePath%>meet_selectPubtimeYichen.action?meetid="+<%=meetid%>,
						success:function (data){
							$("#pushtime").html(data.msg);
						} 			
	 			});			
		}			   		
</script>
</head>

<body class="easyui-layout" >
<!--此处内容更替-->
        <div class="cwh_head">
           <%if(type==1){ %>
        		 主页 >主任会议>议程管理
        	<%}else if(type==3){ %>
        		主页 >法制委员会会议>议程管理
        	<%}else if(type==4){ %>
        		主页 >财政经济委员会会议>议程管理
        	<%}else if(type==5){ %>
        		主页 >其他会议>议程管理
        	<%} %><!-- <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button> -->
        </div>
        <a class='easyui-linkbutton' onclick="javascript:backMeet()" id="backMeet" data-options="iconCls:'icon-Undo'" style="right:20px;position:absolute;margin-top:10px;z-index: 9px;top:5px;" >返回</a>        
        <div class="erjileftbar">
            <dl>
              <dt><a href="<%=basePath %>getMeetingInfo.action?meetid=<%=meetid%>&type=<%=type %>"><img src="<%=path%>/themes/default/images/1_03.png"/></a></dt>
              <%-- <%if(type==1){ %> --%>
              		<dt><a href="<%=basePath %>module/main/meet/zhurenh/yichengmanage.jsp?meetid=<%=meetid%>&type=<%=type %>"><img src="<%=path%>/themes/default/images/huiyi_05.png"/></a></dt>
              <%-- <%}%> --%>
               <dt><a href="<%=basePath %>meet_getMeetFile2.action?meetid=<%=meetid%>&fileown=1&bindtype=0&filetype=&pageNo=1&pageSize=8&type=<%=type %>"><img src="<%=path%>/themes/default/images/1_07.png"/></a></dt>
            </dl>
        </div>
         <div class="erjimain">   
           <div class="huiyi_main">
            <form action="<%=basePath %>meet_benchAddByFile.action" id="ffff" method="post" enctype="multipart/form-data">
            <s:hidden name="meetid" id="meetid"></s:hidden>
           	 <table width=100% style="font-size:14px;color:#333;">
           	 		<tr>
	                    <td width=27% style="font-size: 14px;font-family: 微软雅黑；">1.选择议程文件(只能上传word文档)：</td>
	                    <td width=15% ><input class="input" type="text" value="" id="filetext" disabled="disabled"></td>
<!-- 	                    <td  align=left><button type="button" class="button3" id="buttonupload">上传</button>
 -->	                    <td  align=left> <a class='easyui-linkbutton' data-options="iconCls:'icon-upload'" id="buttonupload"  style="line-height: 25px;width: 80px;color:#a10000;" href='javascript:void(0)'>上传</a>
	                    	<div style="display: none"><input type="file" name="file" value="" id="upload"></div>
	                    </td>
	                </tr>
	                <s:hidden name="type" id="type"></s:hidden>
           	 		<tr>
	                    <td style="font-size: 14px;font-family: 微软雅黑；">2.点击生成按钮，生成议程</td>
<!-- 	                    <td><button  class="button3" name="" id="addyicheng" type="button" style="">生成议程</button></td>	  
 -->	                <td> <a class='easyui-linkbutton' id="addyicheng" data-options="iconCls:'icon-textadd'" style="line-height: 25px;width: 80px;color:#a10000;" href='javascript:void(0)'>生成议程</a></td>	                                      
	                    <td align=right>
	                    <a class='easyui-linkbutton' id="sorts"  data-options="iconCls:'icon-sort'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="sortwindow();">排序</a>
	                    <a class='easyui-linkbutton' id="addyiti"  data-options="iconCls:'icon-add'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="addW2();">增加议题</a>
	                    <a class='easyui-linkbutton' id="deleteAlls" data-options="iconCls:'icon-remove'" style="line-height: 25px;width: 80px;color:#a10000;" onclick="benchDelete();">批量删除</a>	                    
<!-- 	                    <button type="button" class="button3" id="sorts" onclick="sortwindow();">排序</button>
	                    <button type="button" class="button3" id="addyiti" onclick="addW2();">增加议题</button>
	                    <button type="button" class="button3" id="deleteAlls" onclick="benchDelete();">批量删除</button> -->
	                    </td>
	                </tr>
           	 		
           	 </table>
<!--           	 <input name="firstIn" id="firstIn" value="1"/>-->
           	 <table id = "treeGrid" data-options = "onDblClickCell:function (field,row){sortInput(field,row)}">
    	</table>
           	 </form>
<!--              <p>1.选择议程文件<button  class="button3" name="" type="button" style="" onclick="openWin();">上传文件</button></p>-->
<!--              <p>2.点击生成按钮，生成议程<button  class="button3" name="" type="button" style="">生成议程</button></p>-->
<!--              <p>3.查看及调整议程<button  class="button3" name="" type="button" style="">调整顺序</button><button  class="button3" name="" id="show" type="button" style="">增加议题</button></p>-->
<!--              <div class="huiyi_biaodan">-->
              	  
<!--              </div>-->
           </div>
             <form action="<%=basePath %>meet_submitMeetProcess.action" method="post" id="proForm">
            	   <input id="statename" name="statename" type="hidden"/>
            	   <s:hidden id="meetid" name="meetid" type="hidden"> </s:hidden>
             </form>          	 
          	 <div region="south" border="false" style="text-align: center; padding: 5px 0;">
    		 		<span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span id="pushtime"></span></span>          	 
<!-- 					<button type="button" class="button3"  onclick="showS();" style="margin-right:80px;margin-top:10px;">保存</button>
					<button type="button" class="button3"  onclick="saveAndP();">保存并发布</button> -->
	                <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" onclick="showS();">保存</a>
	                <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:80px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>					
			 </div>
        </div>
        
<!--此处内容更替结束-->
<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="排序" style="width:1000px;height:540px;padding:10px;">
<div style="font-size:16px;margin-bottom:5px;">议程管理</div>
<table id = "treeGridSort" data-options = "onDblClickCell:function (field,row){sortInput(field,row)}">
</table>
<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-left:800px;margin-top: 5px;" onclick="closeSort();">确定</a>		
</div>
    <!-- 弹窗div -->
<div id="add" class="pop_uph">
<div class="jiankong_head">增加议题</div>
<div class="popinner" style="margin-left:110px;">
</div>
</div>

<!-- 弹窗结束 -->
<div id="logicWindow" class="easyui-window" title="新增议题"
			iconCls="icon-save" 
			style="width: 950px; height: 500px; padding: 5px;" closed = "true"  >
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="background: #fff; border: 1px solid #ccc;">
					<form id="ff" method="post" action="">
					<input type="hidden" id="fileids" name="fileids"/> 
					<div align="right" style="margin-right:10px;" id="adddel">
                     <!--     <input type="button" onClick="insertrow();" value="增加一行"> -->
                         
                    </div>
<!--						<input type="hidden" name="subMeetingEntity.id" id="id">-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" >
						    <tbody id="ACE_HIDDEN_TABLE">
								<tr id="yichengStep">
								<td class="td_tongyong">									
									议题名称：
								</td>
							
								<td>
									<input class="easyui-validatebox" name="yitiEntity.title" id="title" validType="length[0,1000]"
										style="line-height:20px;width: 600px;line-height:20px; font-size: 14px; font-family: '微软雅黑';border: 1px solid #ccc;" required="true"></input>
										
<!--										<input name="subMeetingEntity.subtitle" id="title1" validType="length[0,1000]"-->
<!--										style="height: 30px; width: 300px; line-height: 23px;display:none;" required="true" ></input>-->
								</td>
							    </tr>
								<tr id="yichengStep">
								<td class="td_tongyong">									
									序号：							
								</td>
								
								<td >
									<input class="easyui-validatebox" name="yitiEntity.sort" id="sort" validType="length[0,1000]"
										style="width: 600px;line-height:20px;width: 600px;line-height:20px; font-size: 14px; font-family: '微软雅黑';border: 1px solid #ccc;" required="true"  onkeyup="shiyan(this)"></input>
										<tt id=tt1></tt>
								</td>
							    </tr>
							    </tr>
								<tr id="yichengStep">
								<td class="td_tongyong">									
									文件：							
								</td>
								<td style="border: 1px solid #ccc;padding: 5px;">
									<ul id="treeDemo"  class="ztree"></ul>
								</td>
							    </tr>
							</tbody>
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
</body>

</html>

