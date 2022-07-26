<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/public/common.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人大会议助理_常委会会议</title>
<script type="text/javascript">
function jump(locate) {
	window.location.href = locate;
}
function closeAll(dom){
    $(dom).parents('tr').nextUntil('tr[name=firsttr]').hide();
    $(dom).attr('onclick','').unbind('click').click(function(){showAll(dom);});
    $(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon07.png');
    $("tr[name="+dom.id+"]").each(function(){ //获取一级的id即二级的tr的name
    	 var secname=$(this).find('a').get(0);
         closeSecond(secname);
    });   
    
}
function showAll(dom){  
    $("tr[name="+dom.id+"]").show();
    $(dom).attr('onclick','').unbind('click').click(function(){closeAll(dom);});
     $(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon07_2.png');
     
    
}
function closeSecond(dom){
   	$("tr[name="+dom.id+"]").hide();
    $("#"+dom.id+"").attr('onclick','').unbind('click').click(function(){showSecond(dom);});
     $("td[name="+dom.id+"]").parent('tr').each(function(){
     	 	var id=$(this).attr('name')
 	       closeThird($("#"+id)[0]);
     })
	$(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon11.png');
}
function showSecond(dom){
   $("tr[name="+dom.id+"]").show();
   $("#"+dom.id+"").attr('onclick','').unbind('click').click(function(){closeSecond(dom);});
    $(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon10.png');
}
function showThird(dom){
   $("tr[name="+dom.id+"]").show();
   $(dom).attr('onclick','').unbind('click').click(function(){closeThird(dom);});
    $(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon08.png');
}
function closeThird(dom){
    $(dom).attr('onclick','').unbind('click').click(function(){showThird(dom);});
    $("tr[name="+dom.id+"]").hide(); 
     $(dom).find('img').attr('src','<%=path%>/themes/default/images/red_icon09.png');
}


</script>


</head>

<body>
	<div class="cwh_head">日程</div>
	<!--此处内容更替-->
	<div class="tongzhi" style="height:90%;">
		<div class="tongzhi_main" style="height:95%;">
			<div style="width:98%;margin:0px auto;height:98%;overflow-y:auto;">
 			<table cellpadding="0" cellspacing="0" border="0" width="100%" style="table-layout:fixed;">
				<s:iterator value="richenglist" var="fir">
					<s:if test="#fir.pid==0">
					<div style="display:none" id='<s:property value="#fir.id" />'></div>
						<tr name="firsttr" class="td_historyfirst" >
							<td width="94%" style="word-break:keep-all; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"><span title="<s:property value="#fir.name" />"><s:property value="#fir.name" /></span></td>
							<td width="6%">
								<a href="javascript:void(0)" onclick="showAll(this);" id="<s:property value="#fir.id" />">
								<img src="<%=path%>/themes/default/images/red_icon07.png" style="vertical-align:middle;padding-bottom:7px;width: 35px;height: 35px;"/></a>
							</td>							
						</tr>
						<s:iterator value="richenglist"  var="sec">
							<s:if test="#sec.pid==#fir.id">
								<tr name="<s:property value="#sec.pid" />" style="display: none;" class="td_historysecond">
							       <td width="94%" style="word-break:keep-all; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"><s:if test='#sec.filepath!=null'><a href="<%=basePath %>upload/<s:property value="#sec.filepath"/>" style="cursor: hand;" target="_blank" title="<s:property value="#sec.name" />"><s:property value="#sec.name" /></a></s:if>
							       	<s:if test='#sec.filepath==null'><span title="<s:property value="#sec.name" />"><s:property value="#sec.name" /></span></s:if>
							       </td>
								   <td width="6%" style="position: relative;">
									   <a href="javascript:void(0)" onclick="showSecond(this);" id="<s:property value="#sec.id" />">
									   <img src="<%=path%>/themes/default/images/red_icon11.png" style="position: absolute;right: 5px;bottom: 3px;"/></a>
								    </td>							       
						        </tr>
									<s:iterator value="richenglist"  var="thir">
										<s:if test="#thir.pid==#sec.id">
											<tr name="<s:property value="#thir.pid" />" style="display: none;" class="td_historythird">
										       <td width="94%" style="word-break:keep-all; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"><s:if test='#thir.filepath!=null'><a href="<%=basePath %>upload/<s:property value="#thir.filepath"/>" style="cursor: hand;" target="_blank" title="<s:property value="#thir.name" />"><s:property value="#thir.name" /></a></s:if>
										       	<s:if test='#thir.filepath==null'><span title="<s:property value="#thir.name" />"><s:property value="#thir.name" /></span></s:if> 
										       </td>
											   <td width="6%" style="position: relative;">
												   <a href="javascript:void(0);" onclick="showThird(this);" id="<s:property value="#thir.id" />">
												   <img src="<%=path%>/themes/default/images/red_icon09.png"  height="30" width="30"  style="position: absolute;right: 5px;bottom: 3px;"/></a>
											    </td>
									        </tr>
												<s:iterator value="richenglist"  var="four">
												   <s:if test="#four.pid==#thir.id">
													   <tr name="<s:property value="#four.pid" />" style="display: none;" class="td_historyfourth">
												          <td  colspan="2" name="<s:property value="#sec.id" />" style="word-break:keep-all; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
												          <s:if test='#four.filepath!=null'><a href="<%=basePath %>upload/<s:property value="#four.filepath"/>" style="cursor: hand;" target="_blank" title="<s:property value="#four.name" />"><s:property value="#four.name" /></a></s:if>
												           <s:if test='#four.filepath==null'><span title="<s:property value="#four.name" />"><s:property value="#four.name" /></span></s:if> 			          
												          </td>
											           </tr>
											        </s:if>
											</s:iterator>							        	
									     </s:if>								     
									</s:iterator>						        	
						     </s:if>
						</s:iterator>
					</s:if>
				</s:iterator>
			</table>
			</div>
			</div>
		</div>
	</div> 
	<!--此处内容更替结束-->
						
</body>
</html>
