<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#hgroupcode option[value="+${groupcode}+"]").attr("selected",true);
		$("#hmembertype option[value="+${membertype}+"]").attr("selected",true);
	});
	function toPage(page){
	   	document.getElementById("page").value=page;
	   	document.getElementById("findForm").submit();
	}
	function jump(locate){
		window.location.href=locate;
	}
	function addcontent(){
		$(".panel-with-icon").html("增加成员");
		$("#popwindow").attr("title","增加成员");
		$("#popform").attr("action","<%=basePath%>groupmember/add.action");
		$("#popwindow").window('open');
	}
	function cancel(){
		$('#popwindow').window('close');
	}
	function deleteone(id){
		$.messager.defaults = { ok: "确定", cancel: "取消" };  
        $.messager.confirm("删除提示", "确认要删除？", function (data) {  
            if (data) {  
            	window.location.href="<%=basePath%>groupmember/delete.action?memberid="+id; 
            }  
        });  
	}
	function updateinfo (id){
		$(".panel-with-icon").html("编辑成员");
		var url="<%=basePath%>groupmember/selectById.action?memberid="+id;
		$.ajax({
			  url: url,
              type: "POST",
	          async: false,  
	          cache: false,  
	          contentType: false,  
	          processData: false,
	          dataType:"json",
	          success: function (data) { 
				$("#itruename").val(data.truename);
				$("#igroupcode option[value="+data.groupcode+"]").attr("selected",true);
				$("#imembertype option[value="+data.membertype+"]").attr("selected",true);
	        	$("#iaddress").val(data.address);  
	        	$("#iphone").val(data.phone); 
	        	$("#imishuname").val(data.mishuname);  
	        	$("#imishuphone").val(data.mishuphone);  
	        	$("#inote").val(data.note);  
	     		$("#popwindow").attr("title","修改信息");
	     		$("#popform").attr("action","<%=basePath%>groupmember/update.action?memberid="+id);
				$("#popwindow").window("open");
			},
			error : function() {
				alert("暂不能修改");
			}
		});
	}
</script>
<script type="text/javascript">
$(function () {
    $('#itruename').validatebox({
    	required: true,
    	missingMessage:'请输入姓名'
    });
    $("#savegroup").click(function(){
    	if(!$("#popform").form('validate')){
    		return false;
    	}
    	$('#popform').submit();
    })
    		getPubtime();
})
    	function showS(){
    		$.messager.alert('提示',"已保存！","info");
    	}
    	function saveAndP(){
    		var url="<%=basePath%>groupmember/insertPub.action?";
    		$.ajax({
  			      url: url,
		          success: function (data) {    	
						$.messager.alert('提示',data.msg,"info");
						getPubtime();
				}
			});
		}
    	function getPubtime(){
    		var url="<%=basePath%>groupmember/selectPubtime.action?";
    		$.ajax({
  			      url: url,
		          success: function (data) {    	
						$("#pushtime").html(data.msg);
				}
			});
		}
</script>
<style>
.tongyong_table {
	width: 100%;
	height: 400px;
	font-family: "微软雅黑";
}

.th_tongyong {
	width: 11%;
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
}

.td_tongyong {
	width: 11%;
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #faefb2;
	text-align: center;
}

.popinner {
	margin-top: 20px;
}
.popinner input{
width:167px;
}
</style>
</head>

<body>
	<div class="cwh_head">组成人员</div>
	<!--此处内容更替-->
	<div class="icon_head">
	</div>
	<a class='easyui-linkbutton'  data-options="iconCls:'icon-goback'" style="line-height: 25px;width:115px;color:#a10000;right:20px;top:65px;position: absolute;" onclick="jump('<%=basePath%>groupmember/selectGroup.action');">返回组成人员</a>			
	<div class="tongzhi">
		<div class="tongzhi_head">
		<form action="<%=basePath%>groupmember/select.action" id="findForm" method="post">
		<s:hidden name="pageNo" id="page"></s:hidden>
				<p>
					姓名：
					<s:textfield class="input" name="truename"></s:textfield>
				</p>
				<p>
					类型：
					<select id="hgroupcode" name="groupcode" class="input">
							<option value="0">所有成员</option>
						<s:iterator value="groupcodeList">
							<option value="${code}">${name}</option>
						</s:iterator>
					</select>
				</p>
				<p>
					身份：
					<select id="hmembertype" name="membertype" style="width:111px;" class="input">
						<option value="0">所有</option>
						<s:iterator value="membertypeList">
						<option value="${code}">${name}</option>
						</s:iterator>
					</select>
				</p>
	  			<a class='easyui-linkbutton' data-options="iconCls:'icon-search'" style="line-height: 25px;width:80px;color:#a10000;float: left;margin: 7px;" onclick="document.getElementById('findForm').submit()">查询</a>			
	  			<a class='easyui-linkbutton' data-options="iconCls:'icon-add'" style="line-height: 25px;width:80px;color:#a10000;margin-right:20px;float:right;margin: 7px;"  onclick="addcontent();">增加成员</a>							
			</form>
		</div>
		<div class="tongzhi_main" style="height: 450px;">
			<div class="tongyong_table">
				<div style="width:90%;margin:10px auto;">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<th class="th_tongyong">姓名</th>
							<th class="th_tongyong">身份</th>
							<th class="th_tongyong">类型</th>
							<th class="th_tongyong">显示顺序</th>
							<th class="th_tongyong">联系地址</th>
							<th class="th_tongyong">联系电话</th>
							<th class="th_tongyong">秘书姓名</th>
							<th class="th_tongyong">备注</th>
							<th colspan="2" class="th_tongyong">操作</th>
						</tr>
						<s:iterator value="page.result" id="pli">
							<tr>
								<td colspan="9" height="5"></td>
							</tr>
							<tr id="${memberid}">
								<td class="td_tongyong"><s:property value="truename" />
								</td>
								<td class="td_tongyong">
								<s:if test="%{membertype==1}">主任</s:if>
								<s:if test="%{membertype==2}">副主任</s:if>
								<s:if test="%{membertype==3}">秘书长</s:if>
								<s:if test="%{membertype==4}">专职委员</s:if>
								<s:if test="%{membertype==5}">委员</s:if>
								</td>
								<td class="td_tongyong">
								<s:if test="%{groupcode==1}">主任会议成员</s:if>
								<s:if test="%{groupcode==2}">常委会委员</s:if>
								</td>
								<td class="td_tongyong"><s:property value="sort" />
								</td>
								<td class="td_tongyong"><s:if test="#pli.address==''" >&nbsp;</s:if><s:property value="address" />
								</td>
								<td class="td_tongyong"><s:if test="#pli.phone==''" >&nbsp;</s:if><s:property value="phone" />
								</td>
								<td class="td_tongyong"><s:if test="#pli.mishuname==''" >&nbsp;</s:if><s:property value="mishuname" />
								</td>
								<td class="td_tongyong"><s:if test="#pli.note==''" >&nbsp;</s:if><s:property value="note" />
								</td>
								<td style="border-right:none;" class="td_tongyong"><a
									href="javascript:void(0)" onclick="updateinfo ('${memberid}');">
										<img src="<%=path%>/themes/default/images/caozuo_03.png" style="vertical-align:middle;"/> </a>
									<a href="javascript:void(0)"
									onclick="deleteone ('${memberid}');"> <img
										src="<%=path%>/themes/default/images/caozuo_05.png" style="vertical-align:middle;"/> </a>
								</td>
							</tr>
						</s:iterator>
					</table>
				</div>
			</div>
			<s:if test="totalPage>1">
					<div id="page" style="margin-top: 5px;">
						<s:if test="totalPage==0"></s:if>
						<s:else>
							<a href="javascript:toPage(1);">首页</a>
							<s:if test="pageNo==1">
								<a href="javascript:;">上一页</a>
							</s:if>
							<s:else>
								<a href="javascript:toPage(<s:property value="pageNo-1"/>);">上一页</a>
							</s:else>

							<s:if test="pageNo<8">
								<s:if test="totalPage<12">
									<s:iterator begin="1" end="totalPage" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" /> </a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);">
											<s:property value="#p" /> </a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:else>
									<s:iterator begin="1" end="12" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page">
											<s:property value="#p" /> </a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);">
											<s:property value="#p" /> </a>
										</s:else>
									</s:iterator>
								</s:else>
							</s:if>

							<s:if test="pageNo>7">
								<s:if test="totalPage<13">
									<s:iterator begin="1" end="totalPage" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" /> </a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" /> </a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:if test="totalPage>12">
									<s:if test="pageNo+4<totalPage">
										<% for (int i = 6; i > -6; i--) {
											//System.out.println("i:"+i);
											request.setAttribute("ii", i);%>
										<s:if test="pageNo==pageNo+#attr.ii">
											<a href="javascript:toPage(${pageNo-ii});"
												class="current_page">${pageNo+ii }</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
										</s:else>
										<%}%>
									</s:if>
									<s:else>
										<%for (int i = 11; i > -1; i--) {
												//System.out.println("i:"+i);
												request.setAttribute("ii", i);%>
										<s:if test="pageNo==pageNo+#attr.ii">
											<a href="javascript:toPage(${pageNo-ii});" class="current_page">${pageNo+ii }</a>
										</s:if>
										<s:else>
											<s:if test="pageNo-#attr.ii>0">
												<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
											</s:if>
										</s:else>
										<%}%>
									</s:else>
								</s:if>
							</s:if>
							<s:if test="pageNo==totalPage">
								<a href="javascript:;">下一页</a>
							</s:if>
							<s:else>
								<a href="javascript:toPage(<s:property value="pageNo+1"/>);">下一页</a>
							</s:else>
							<a href="javascript:toPage(<s:property value="totalPage"/>);">末页</a>
						</s:else>
						<a>共<s:property value="totalPage" /> 页</a>
					</div>
					</s:if>
		</div>
		<div style="float: left;margin-left: 40px;bottom:10px;position: absolute;">
			<span style="font-size: 14px;margin-left: 10px;margin-top:10px;float: left;">最后一次发布时间：<span id="pushtime">&nbsp;</span></span>
			<div style="float: left;margin-left: 160px;">
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-save'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="showS();">保存</a>
	        <a class='easyui-linkbutton'  data-options="iconCls:'icon-push'" style="line-height: 25px;width: 115px;color:#a10000;margin-right:115px;margin-top:10px;" onclick="saveAndP();">保存并发布</a>
		</div>		
	</div>
	<!--此处内容更替结束-->

	<!-- 弹窗div -->
	<div id="popwindow" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="增加成员" style="left:230px;top:10px;width:630px;height:500px;">
		<div class="popinner" style="margin-left:160px;">
			<form action="<%=basePath%>groupmember/add.action" id="popform"
				method="post">
				<table align="left">
					<tr>
						<td>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：&nbsp;</td>
						<td><input class="input" type="text" id="itruename"
							name="entity.truename" />
						</td>
					</tr>
					<tr>
						<td>身&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份：&nbsp;</td>
						<td>
							<select id="imembertype" name="entity.membertype" class="input" style="width:167px;">
								<s:iterator value="membertypeList">
									<option value="${code}">${name}</option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td>类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：&nbsp;</td>
						<td><select class="input" id="igroupcode"
							name="entity.groupcode" style="width:167px;">
								<s:iterator value="groupcodeList">
									<option value="${code}">${name}</option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td>联&nbsp;&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;&nbsp;址：</td>
						<td><input class="input" type="text" id="iaddress"
							name="entity.address" />
						</td>
					</tr>
					<tr>
						<td>联&nbsp;&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;&nbsp;话：</td>
						<td><input class="input" type="text" id="iphone"
							name="entity.phone" />
						</td>
					</tr>
					<tr>
						<td>秘&nbsp;&nbsp;&nbsp;书&nbsp;&nbsp;&nbsp;姓&nbsp;&nbsp;&nbsp;名：</td>
						<td><input class="input" type="text" id="imishuname"
							name="entity.mishuname" />
						</td>
					</tr>
					<tr>
						<td>秘书联系方式：</td>
						<td><input class="input" id="imishuphone" type="text"
							name="entity.mishuphone" />
						</td>
					</tr>
					<tr>
						<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：&nbsp;</td>
						<td><input class="input" type="text" id="inote"
							name="entity.note" />
						</td>
					</tr>
					<tr>
					<td colspan="2" style="height:5px;";></td>
					</tr>
					<tr>
						<td>
	                		<a class='easyui-linkbutton'  data-options="iconCls:'icon-ok'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:15px;margin-left: 105px;" id="savegroup">保存</a>					
						</td>
						<td>
	                		<a class='easyui-linkbutton'  data-options="iconCls:'icon-cancel'" style="line-height: 25px;width: 80px;color:#a10000;margin-top:15px;margin-left: 30px;" onclick="cancel()">取消</a>					
						</td>
					</tr>
				</table>
		</div>
	</div>
	<!--弹窗结束-->
</body>
</html>
