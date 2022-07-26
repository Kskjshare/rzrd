<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="<%=basePath%>third/calendar/style/jalendar.css" type="text/css" />
<script type="text/javascript" src="<%=path%>/third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>third/calendar/js/jalendar.js"></script>
<script type="text/javascript" src="<%=basePath%>third/calendar/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	function jump(locate) {
		window.location.href = locate;
	}
	$(function () {
		var date='${showdate}';
		var showdate=new Date();
		if(date!=null&&date!=''){
			date=date.replace(/-/g, "/");
			showdate=new Date(date);
		}
	    $('#myId3').jalendar({
			color: '#f57201',//主题色
			lang: 'CN',//语言
			 customDay: showdate
		});
		var time=null;
		$(".day").bind('dblclick',function(){
					//判断日历上是否有事件
			 clearTimeout(time);
			$(".panel-with-icon").html("编辑事件");		
			if($(this).children("div").length>0){
				var eventid=$(this).children("div").attr('id');
				updateinfo(eventid);
			}
		});
		$(".day").bind('click',function(){
			 clearTimeout(time);
			 $(".panel-with-icon").html("新增事件");
			 var date=$(this).attr("data-date");
			 var flag= $(this).text().trim()!=''&&$(this).text().trim()!=null;
			 time = setTimeout(function(){
			if(typeof(date)!='undefined'&&flag){
			$("#ieventname").val("");
			$("#icomment").val(""); 
			//alert($(this).attr("data-date"))
			$("#popform").attr("action","<%=basePath%>calendar/add.action");
				$("#deleteevent").css("display",'none');
				$("#valid_event").html("&nbsp;");
				$(".window").css("display",'block');
				var day=date.substring(0,date.indexOf('/'));
			if(day<10){
				day="0"+day;
			}
			var month=date.substring(date.indexOf('/')+1,date.lastIndexOf('/'));
			if(month<10){
				month="0"+month;
			}
			var year=date.substring(date.lastIndexOf('/')+1);
			date=year+"-"+month+"-"+day;
			$("#ishowdate").val(date);
			}
			 },300);
		})

	});

</script>
<script>
$(function () {
	 getSelects();
	 $(".nxt-m").click(function(){
		 getSelects();
	 });
	 $(".prv-m").click(function(){
		 getSelects();
	 });
	getPubtime()
});
function getSelects(){
	 var date=$(".this-month").last().attr('data-date'); 
	 var year=date.substring(date.lastIndexOf('/')+1);
  	 $.post("<%=basePath%>calendar/getSelectJson.action", {caldate:date}, 
  			 function(data) {
				if (data.state) {
					var array = data.list;
					for ( var i = 0; i < array.length; i++) {
						var ename = array[i].eventname;
						var date = array[i].showdate;
						var edate = new Date(date.time);
						var y = edate.getFullYear();
						var m = edate.getMonth() + 1;
						var d = edate.getDate();
						var eventid=array[i].eventid;
						var eventtype=array[i].eventtype;
						if(eventtype==1){
							$(".this-month[data-date='" + d + "/" + m + "/" + y + "']").append("<br/><div style='background:#C4000F;height:40px;color:#fff;font-size:13px;' id="+eventid+">"+ ename + "</div>");											
						}else if(eventtype==2){
							$(".this-month[data-date='" + d + "/" + m + "/" + y + "']").append("<br/><div style='background:#46B445;height:40px;color:#fff;font-size:13px;' id="+eventid+">"+ ename + "</div>");																	
						}else {
							$(".this-month[data-date='" + d + "/" + m + "/" + y + "']").append("<br/><div style='background:#2A8FFF;height:40px;color:#fff;font-size:13px;' id="+eventid+">"+ ename + "</div>");																	
						}
					}
					$.each(data.lunarmap,function(k,v){
							var fest=["元旦","春节","清明节","劳动节","端午节","中秋节","国庆节"];
							var flag=true;
 							for ( var j = 0; j < fest.length; j++) {
								if(fest[j]==v){
									$(".this-month[data-date='" + k + "']").append("<br/><span style='height:30px;color:red;font-size:13px;line-height:30px;' >"+ v + "</span>");		
									flag=false;									
								}
							}
							var duanwu=sTerm(year)+"/4/"+year;
							if(duanwu==k){
								$(".this-month[data-date='" + k + "']").append("<br/><span style='height:30px;color:red;font-size:13px;line-height:30px;' >"+ fest[2] + "</span>");		
								flag=false;	
							}							
							if(flag){ 
							$(".this-month[data-date='" + k + "']").append("<br/><span style='height:30px;font-size:13px;line-height:30px;' >"+ v + "</span>");				
							}							
					}) 
				} else {
					alert('操作失败');
			};
	});
}
//判断每年清明节
function sTerm(y) {
    var offDate = new Date(( 31556925974.7 * (y - 1900) + 128867 * 60000  ) + Date.UTC(1900, 0, 6, 2, 5));
    return (offDate.getUTCDate());
}
function validevent(){
	if($("#ieventname").val()==null||$("#ieventname").val()==''){
		$("#valid_event").html("请输入事件名称");
		$("#ieventname").focus();
		return false;
	}else{
		return true;
	}
}
function popSubmit(){
   	if(!validevent()){
   		
   	}else{
   		$("#ishowdate").attr("disabled",false);
   		$("#popform").submit();
   	}

}
function cancel(){
	$(".window").css("display",'none');
	$("#valid_event").html("&nbsp;");
}
function updateinfo (id){
	$("#deleteevent").bind('click',function(){
		window.location.href="<%=basePath%>calendar/deleteById.action?eventid="+id;
	});
	$("#deleteevent").css("display",'');
	$("#ieventname").val("");
	$("#icomment").val("");  
	var url="<%=basePath%>calendar/selectById.action?eventid="+id;
	$.ajax({
		  url: url,
          type: "POST",
          async: false,  
          cache: false,  
          contentType: false,  
          processData: false,
          dataType:"json",
          success: function (data) { 
			$("#ieventname").val(data.eventname);
			$("#ishowdate").val(data.showdate.substr(0,10));
        	$("#icomment").val(data.comment);  
        	$("#ieventtype").val(data.eventtype);  
     		$("#popwindow").attr("title","修改事件");
     		$("#popform").attr("action","<%=basePath%>calendar/update.action?eventid="+id);
			$(".window").css("display",'block');
		},
		error: function() {
			$("#alertmsg").css("display",'block');
    		$(".messager-window").css("display",'block');
    		$("#returnmsg").html("暂不能修改");
		}
	});
}
    	function showS(){
    		$("#alertmsg").css("display",'block');
    		$(".messager-window").css("display",'block');
    		$("#returnmsg").html("已保存");
    	}
    	function closealert(){
    		$("#alertmsg").css("display",'none');
    	}
    	function saveAndP(){
    		var url="<%=basePath%>calendar/insertAndPush.action?";
    		$.ajax({
  			      url: url,
                  type: "POST",
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,
		          dataType:"json",
		          success: function (data) {    	
					$("#alertmsg").css("display",'block');
    				$(".messager-window").css("display",'block');
    				$("#returnmsg").html(data.msg);
					getPubtime();
				}
			});
		}	
    	function getPubtime(){
    		var url="<%=basePath%>calendar/getPubtime.action?";
    		$.ajax({
  			      url: url,
		          success: function (data) {    	
					$("#pushtime").html(data.msg);
				}
			});
		}	
</script>
</head>

<body>
	<div>
		<div class="cwh_head">年历表</div>
		<!--此处内容更替-->

		<div class="tongzhi">
			<div style="font-size:14px;height:25px; width:1000px;margin-left: auto;margin-right: auto;"><span style="float: left;height: 25px;line-height: 25px;">请单击日期进行事件添加，双击日期进行事件编辑。</span></div>
			<div id="myId3" class="jalendar mid">
			</div>
		<div style="font-size:14px;height:30px; width:1000px;margin-left: auto;margin-right: auto;">
			<span style="font-size: 14px;margin-top:12px;float: left;">最后一次发布时间：<span id="pushtime"></span></span>
			<div style="float: left;margin-left: 160px;">
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:12px;" onclick="showS();">保存</a>
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:12px;" onclick="saveAndP();">保存并发布</a>
		</div>			
		</div>
		<!--此处内容更替结束-->
        <!-- 弹窗 -->
		<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="新增事件" style="width:630px;height:350px;padding:10px;">
			<div class="contactstable" style="height:180px;">
				<form id="popform" action="" method="post">
					<table>
						<tr>
							<td>显示日期：</td>
							<td colspan="2">
							<input class="input" id="ishowdate" style="width:175px;" type="text" name="showdate" disabled="disabled"/>
							</td>
						</tr>					
						<tr>
							<td>事件名称：</td>
							<td ><input class="input" type="text" id="ieventname" style="width:175px;"
								name="eventname" /></td>
							<td><span id="valid_event" style='color:red;float:right;font-size:14px;margin-top:14px;'>&nbsp;</td>
						</tr>
 						<tr style="display: none;">
							<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
							<td colspan="2"><input class="input" type="text" id="icomment" name="comment" style="width:175px;"/>
							</td>
						</tr> 
						<tr>
							<td>事件类型：</td>
							<td colspan="2">
								<select class="input" type="text" id="ieventtype" name="eventtype" style="height:30px;margin-left:5px;width:175px;font-size: 16px;font-family: 微软雅黑;">
									<option value="1">常委会</option>
									<option value="2">主任会</option>
									<option value="3">代表会</option>
								</select>
							
							</td>
						</tr>						
						<tr>
							<td colspan="3">
								<a class='easyui-linkbutton' id="subm" data-options="iconCls:'icon-save'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:20px;margin-left:20px;" onclick="popSubmit()" >保存</a>														
								<a class='easyui-linkbutton'  data-options="iconCls:'icon-remove'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:20px;margin-left:40px;display: none;" id="deleteevent" >删除</a>																	
								<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:20px;margin-left:40px;" onclick="cancel()" >取消</a>										
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 弹窗 -->		
		<!-- 弹出提示框-->
		<div id="alertmsg" style="display: none;">
		<div style="display: block; width: 288px; left: 464.5px; top: 237.5px; z-index: 9004;" class="panel window messager-window">
			<div style="width: 288px;" class="panel-header panel-header-noborder window-header">
				<div class="panel-title">提示</div>
				<div class="panel-tool">
					<a class="panel-tool-close" onclick="closealert();"></a>
				</div>
			</div>
		<div style="width: 266px; height: auto;" title="" class="messager-body panel-body panel-body-noborder window-body">
			<div class="messager-icon messager-info"></div>
			<div id="returnmsg">&nbsp;</div>
			<div style="clear:both;"></div>
				<div class="messager-button">
					<a id="" group="" class="l-btn l-btn-small" style="margin-left: 10px;" href="javascript:void(0)">
						<span class="l-btn-left">
							<span class="l-btn-text" onclick="closealert();">确定</span>
						</span>
					</a>
				</div>
			</div>
		</div>		
		<div style="width: 1229px; height: 649px; display: block; z-index: 9002;" class="window-mask"></div>	
		</div>
		<!-- 弹出提示框-->
	</div>
</body>
</html>
