<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=path%>/third/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>fckeditor/fckeditor.js"></script>
<style type="text/css">
.Wdate{ height:30px; margin:5px; border-style:ridge;width:250px;}
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
<%
	int meetid=Integer.parseInt(request.getParameter("meetid"));
	//int type=Integer.parseInt(request.getParameter("type"));
%>
.erjileftbar dt{ margin-top:15px;}
</style>
<style type="text/css">
/* 	ul li{
				list-style:none
			}
			#head li.current{
				background-color:#2aa9df;
				color: #ffffff;
			}
			#head li{
				list-style-type: none;
				float:left;				
				line-height: 40px;
				width: 100px;
				height: 40px;
				cursor: pointer;
				font-size: 18;
				font-family:"微软雅黑";
				margin: 0px 20px;
			}
			#head1 ul{
				padding-left:0px;
				padding-left: 0px;
				margin-left: 0px;
			}
			#head ul{
			 	text-align:center;
			 	margin-left: 300px;
			}
			.tabclass{
				background-color: #7295e4;
			} */
</style>
<script type="text/javascript">
<%-- 	 $(function(){
    	$('#begin').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'});
    	});
    	$('#end').click(function(){
    		//alert("OK");
    		WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'});
    	});
    	$('#submitData').click(function(){
    		saveW();
    	})
    	//alert("OK");
    })
    	var groupIndex=1;
    	function change(index){
    			//alert("index:"+index);
    			if(index==1){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1_1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("第一组：");
    			}else if(index==2){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2_2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("第二组：");
    			}else if(index==3){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3_3.png";
    				$("#groupinfo").html("第三组：");
    			}else if(index==4){
    				document.getElementById('img1').src="<%=path%>/themes/default/images/zu1.png";
    				document.getElementById('img2').src="<%=path%>/themes/default/images/zu2.png";
    				document.getElementById('img3').src="<%=path%>/themes/default/images/zu3.png";
    				$("#groupinfo").html("注意事项：");
    			}
    			groupIndex=index;
    			$('#groupno').val(index);
    			$.messager.progress({interval:1000,text:"正在加载。。。"});
    			var editor = FCKeditorAPI.GetInstance("groupcontent");
				editor.EditorDocument.body.innerHTML="";
				$.ajax({
				   type: "POST",
				   url: "<%=basePath%>selectFenzuList.action",
				   data: {"groupno":index,"meetid":<%=meetid%>},
				   success: function(data){
					   $.messager.progress('close');
					   //alert("state:"+data.state);
						if(data.state){
							editor.EditorDocument.body.innerHTML=data.groupcontent;
							$('#groupid').val(data.groupid);
						}else{
							$('#groupid').val("0");
						}
				   },error:function(){
					   $.messager.progress('close');
				   }
			}); 
    	}
		 $(function(){
			var oFCKeditor = new FCKeditor( 'groupcontent' ) ; // 提交表单时本字段使用的参数名-->
			oFCKeditor.BasePath	= "<%=basePath%>fckeditor/" ; // 必须要有，这是指定editor文件夹所在的路径，一定要以'/'结尾-->
			oFCKeditor.Height	= "380";
			oFCKeditor.Width	= "860";
			oFCKeditor.ToolbarSet = "Basic" ;
			oFCKeditor.ReplaceTextarea(); // 替换id或name为指定值的textarea
		});
		var timer ;
		$(function(){
		//checkload();
				checkload();
		});		
	function checkload() {
        if (document.readyState == "complete") {
            change(1);
        } else{
            timer = setTimeout("checkload()", 1000);
        }
    } --%>
	   
		
</script>
</head>

<body>
<!--此处内容更替-->
        <div class="cwh_head">
           分组
        </div>
 <%--       <div class="erjimain" style="margin-left: 90px;">             
            <div class="huiyi_main" >
              <div style="text-align: center;">
              <form action="<%=basePath %>meet_addFenzu.action" id="findForm" method="post" style="margin-left:30px; margin-top:20px;">
                  	<div style="text-align: center;">
                  	<table style="background: url('');">
                  	<tr>
                  		<td style="text-align: center;">
                  		<div>
						<a href="javascript:change(1);"><img id="img1" src="<%=path%>/themes/default/images/zu1_1.png"/></a>
						<a href="javascript:change(2);"><img id="img2" src="<%=path%>/themes/default/images/zu2.png"/></a>
						<a href="javascript:change(3);"><img id="img3" src="<%=path%>/themes/default/images/zu3.png"/></a>
						<a href="javascript:change(4);"><span style="color: #A10000;margin-left: 30px;vertical-align:center;float:right;">注意事项</span></a>
						</div>
                  		</td>
                  	</tr>
                  	<tr>
                  		<td height="10px;">
                  		    <span id="groupinfo" style="font-size:14px; color:#333; text-indent:26px;margin-left: 15px; ">第一组：</span>                  		
                  		</td>
                  	</tr>
                  	<tr>
                  		<td>
                  		<div style="text-align: center;">
							<textarea id="groupcontent" name="groupcontent"></textarea>
						</div>
                  		</td>
                  	</tr>
                  		<tr>
                  		<td height="10px;">
                  		
                  		</td>
                  	</tr>
                  	<tr>
                  		<td style="text-align: center;">
                  		</td>
                  	</tr>
                  	</table>
                  	
					</div>
					<input type="hidden" name="groupno" value="1" id="groupno"/>
					<input type="hidden" name="groupid" id="groupid" value="0"/>
              </form>
              </div>
           </div>
           
        </div> --%>
        <div class="tongzhi">
        <form  id="findForm" method="post">
            <ul>
            <s:iterator value="meetpubgrouplist" id="rodo">
            	<li style="margin-top:0px;">
            	<s:if test="%{#rodo.groupno==1}" >第一组&nbsp;&nbsp;</s:if>
            	<s:if test="%{#rodo.groupno==2}" >第二组&nbsp;&nbsp;</s:if>
            	<s:if test="%{#rodo.groupno==3}" >第三组&nbsp;&nbsp;</s:if>
            	<s:if test="%{#rodo.groupno==4}" >注意事项&nbsp;&nbsp;</s:if>
            	<a href="<%=basePath %><s:property value="filepath"/>" style="cursor: hand;" target="_blank" title="<s:property value="title" />">
            	<s:if test="%{#rodo.title.length()>50}"> 
				<s:property value="%{#rodo.title.substring(0,50)}" />...</s:if>
				<s:else> 
						<s:property value="title" />
				</s:else>            	
            	</a><a href="<%=basePath %><s:property value="filepath" />" target="_blank"  class="button2" ><img src="<%=basePath %><%=themespath%>/images/button2.png"/></a></li>
            </s:iterator>
            </ul>
            </form>
          </div>

<!--此处内容更替结束-->
</body>
</html>
