<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<%
	int meetid=Integer.parseInt(request.getParameter("meetid"));
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
.erjileftbar dt{ margin-top:15px;}
</style>
<style>
.tongyong_table {
	width: 100%;
	height: 400px;
	font-family: "微软雅黑";
}

.th_tongyong {
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	color: #333;
	border-bottom: 1px solid #ccc;
	background: #ea8619;
}

.td_tongyong {
	height: 35px;
	line-height: 35px;
	font-size: 14px;
	color: #333;
	border-right: 1px solid #ccc;
	background: #faefb2;
	text-align: center;
}
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
.erjileftbar dt{ margin-top:15px;}
</style>
<script type="text/javascript">
var version;
function showVersion(dom){
   version=dom;

	var meetid=<%=meetid%>;
	clearLinkContentCss();
	$("#accordion").find("li").eq(0).find("a").addClass("shenhecontent");
	$("#add").window("open");
	treeOnClick('<%=basePath %>selectYichengListByVersion.action?meetid=<%=meetid%>&type=2&version='+dom,'主页',37);
	
}
function toPage(page){
    document.getElementById("page").value=page;
    document.getElementById("findForm").submit();
}
function backMeet(){
    		window.location.href="<%=basePath %>selectCurMeeting.action?type=2";
    	}
		function treeOnClick1(url,titleName,id,flag)
		{	
			if(!url)
			{
				return ;
			}
			if($("#tabPanel1").tabs("exists",titleName)){	 	
			alert('a');
	 		    $('#tabPanel1').tabs('select',titleName);
	 		    if(flag){
				document.getElementById("tab"+id).src = url;
			   }	
	 		}else {
	 		$('#tabPanel1').tabs('add',{
	 			closable:true,
	 			content:"<iframe scrolling='yes'  id = 'tab"+id+"' frameborder='0'  src='"+url+"' style='width:100%;height:100%;'></iframe>",
	 			title : titleName,
	 			tools:[{
	 				iconCls: "icon-mini-refresh" ,
	 				handler: function (){
	 				document.getElementById("tab"+id).src = document.getElementById("tab"+id).src;
	 				}
	 			}]
	 		});
	 		}
		}
		
		function treeOnClick(url,titleName,id,linkObj)
		{	
			if(!url)
			{
				return ;
			}
			if(linkObj){
				clearLinkContentCss();
				$(linkObj).addClass("shenhecontent");
			}
			document.getElementById("tabPanel1").innerHTML="<iframe scrolling='no'   frameborder='0'  src='"+url+"' style='width:100%;height:100%;'></iframe>";
		}
		
		function clearLinkContentCss(){
			$("#accordion a").each(function(i,data){
				$(data).removeClass("shenhecontent");
			});
		}
		
	    	    
		var collapse = true ;
		function collpasePanel(){
		if(collapse){
			$('body').layout('collapse','west');
			$('body').layout('collapse','north');
			collapse = false ;
		}else {
			$('body').layout('expand','north');
			$('body').layout('expand','west');
			collapse = true ;
		}
		
		}    	
</script>
</head>

<body>
<!--此处内容更替-->
        <div class="cwh_head">
            主页>常委会会议>审核记录 <button  class="button1" style="margin-top: 10px;"  id="backMeet" onclick="javascript:backMeet()" type="button" style="">返回</button>
        </div>
        
        <div class="erjileftbar">
            <dl>
             <dt><a href="<%=basePath %>module/main/meet/changwh/index.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon1.png"/></a></dt>
               <dd>基本信息</dd>
               <dt><a href="<%=basePath %>module/main/meet/changwh/yichengmanage.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon3.png"/></a></dt>
               <dd>议程管理</dd>
               <dt><a href="<%=basePath %>module/main/meet/changwh/richengmanage.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>日程管理</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=1&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon2.png"/></a></dt>
               <dd>文件管理</dd>              
               <dt><a href="<%=basePath %>module/main/meet/changwh/fenzu.jsp?meetid=<s:property value="meetid"/>"><img src="<%=path%>/themes/default/images/icon5.png"/></a></dt>
               <dd>分组</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=2&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>会中主任会议</dd>
               <dt><a href="<%=basePath %>meet_getMeetFile.action?meetid=<s:property value="meetid"/>&fileown=3&filetype=&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon4.png"/></a></dt>
               <dd>闭幕会</dd>
               <dt><a href="<%=basePath %>meet_selectProcessLogByMeetid.action?meetid=<s:property value="meetid"/>&pageNo=1&pageSize=8"><img src="<%=path%>/themes/default/images/icon6.png"/></a></dt>
               <dd>审核记录</dd>
            </dl>
        </div>
         <div class="erjimain">   
           <div class="huiyi_main">
            <p id="showStateName">会议变更审核记录：</p>
             <form action="<%=basePath %>meet_selectProcessLogByMeetid.action" method="post" id="findForm">
           	 <div class="tongzhi_main">
				<div class="tongyong_table">
						<div style="width:99%;margin:2px auto;">
							<s:hidden name="pageNo" id="page"></s:hidden>
							<s:hidden name="meetid" id="meetid"></s:hidden>
							<table cellpadding="0" cellspacing="0" border="0" width="100%">
								<tr>
									<th class="th_tongyong">ID</th>
<!--									<th class="th_tongyong">类型</th>-->
									<th class="th_tongyong">提交人</th>
									<th class="th_tongyong">提交时间</th>
									<th class="th_tongyong">当前状态</th>
									<th class="th_tongyong">审核人</th>
									<th class="th_tongyong">版本</th>
<!--									<th colspan="2" class="th_tongyong">操作</th>-->
								</tr>
								<s:iterator value="page.result" id="rodo" status="L">
									<tr>
										<td colspan="4" height="3"></td>
									</tr>
									<tr >
										<td class="td_tongyong">
											<s:property value="#L.index+1"/>
										</td>
<!--										<td class="td_tongyong">-->
<!--										<s:property value="submodulecode" />-->
<!--										</td>-->
										<td class="td_tongyong">
										<s:property value="tjuser" />
										</td>
										<td class="td_tongyong">
											<s:date name="tjdatetime" format="yy年MM月dd日  HH:mm"/>
										</td>
										<td class="td_tongyong">
												已发布
<!--											<s:property value="curstate" />-->
										</td>
										<td class="td_tongyong">
											<s:property value="shenheuser" />
										</td>
										<td class="td_tongyong">
											<a href="javascript:void(0)" onclick="showVersion('<s:property value="version" />')"><s:property value="version" /></a>
										</td>										
<!--										<td class="td_tongyong">-->
<!--										<a href="javascript:void(0)" onclick="deleteFile(<s:property value="fileid"/>,<s:property value="meetid"/>);">-->
<!--											<img src="<%=path%>/themes/default/images/caozuo_05.png" />-->
<!--										</a>-->
<!--										</td>-->
									</tr>
								</s:iterator>
							</table>
							
						</div>
						<s:if test="totalPage>1">
						<div id="page">
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
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:else>
									<s:iterator begin="1" end="12" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:else>
							</s:if>

							<s:if test="pageNo>7">
								<s:if test="totalPage<13">
									<s:iterator begin="1" end="totalPage" var="p">
										<s:if test="#p==pageNo">
											<a href="javascript:toPage(<s:property value="#p"/>);"
												class="current_page"><s:property value="#p" />
											</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(<s:property value="#p"/>);"><s:property
													value="#p" />
											</a>
										</s:else>
									</s:iterator>
								</s:if>
								<s:if test="totalPage>12">
									<s:if test="pageNo+4<totalPage">
										<%for(int i=6;i>-6;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
                   			  %>
										<s:if test="pageNo==pageNo+#attr.ii">
											<a href="javascript:toPage(${pageNo-ii});"
												class="current_page">${pageNo+ii }</a>
										</s:if>
										<s:else>
											<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
										</s:else>
										<%} %>
									</s:if>
									<s:else>
										<%for(int i=11;i>-1;i--){ 
                     		//System.out.println("i:"+i);
                   			  request.setAttribute("ii",i);
                   			  %>
										<s:if test="pageNo==pageNo+#attr.ii">
											<a href="javascript:toPage(${pageNo-ii});"
												class="current_page">${pageNo+ii }</a>
										</s:if>
										<s:else>
											<s:if test="pageNo-#attr.ii>0">
												<a href="javascript:toPage(${pageNo-ii});">${pageNo-ii}</a>
											</s:if>
										</s:else>
										<%} %>
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
           	 </form>
           </div>
           
        </div>
<!--此处内容更替结束-->
<!-- 弹出框 -->
 <div id="add" class="easyui-window" closed="true" data-options="iconCls:'icon-save'" title="版本" style="width:930px;height:550px;;left:50px;top:50px;padding:10px;">
    <div >
    <div class="shenhecwh_head">
           <s:property value="meettitle"/>
    </div> 
    <s:hidden name="meetid"><s:property value="meetid"/></s:hidden>
<div class="shenhemain">
    <div class="shenheleftbar flt">  
        <ul id="accordion"><!-- treeOnClick(url,titleName,id,flag) -->
         <li><a class="shenhecontent" onclick="treeOnClick('<%=basePath %>/selectYichengListByVersion.action?type=2','议程',37,this)"><img src="<%=basePath %><%=themespath %>/images/rd_icon27.png" width="20px" height="20px" style="float: left;position: absolute;left:7px;top:13px;"><font style="padding-left: 25px">议程</font></a></li>
         <li><a onclick="treeOnClick('<%=basePath %>/selectRichengListByVersion.action?type=2','日程',37,this)"><img src="<%=basePath %><%=themespath %>/images/rd_icon28.png" width="20px" height="20px" style="float: left;position: absolute;left:7px;top:13px;"><font style="padding-left: 25px">日程</font></a></li>
         <li><a onclick="treeOnClick('<%=basePath%>/selectMeetFileListByVersion.action?type=2&pageNo=1&pageSize=5','参阅文件',108,this)"><img src="<%=basePath %><%=themespath %>/images/rd_icon29.png" width="20px" height="20px" style="float: left;position: absolute;left:7px;top:13px;"><font style="padding-left: 25px">会议文件</font></a></li>
       </ul>                                 
    </div>

    <div class="shenhebox flt">
    <div class="easyui-tabs1"  id="tabPanel1" border="false" fit="true" height="350px">

    </div>
    </div>
</div> 
 </div>         
 <!-- 弹出框 -->   
</body>
</html>
