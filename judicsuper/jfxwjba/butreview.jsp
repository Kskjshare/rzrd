<%-- 
    Document   : butreview
    Created on : 2021-3-23, 19:33:48
    Author     : Administrator
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%
 StaffList.IsLogin(request, response);
        RssList entity = new RssList(pageContext, "shenchadengji");
       // RssList entity1 = new RssList(pageContext, "zhuangtai");
        CookieHelper cookies = new CookieHelper(request, response);
        HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
        entity.request();
       
      if(!entity.get("action").isEmpty()){
          
           
           if (entity.get("zhuangtai").equals("2")) {
               entity.keyvalue("zhuangtai","2");
               entity.keyvalue("xiugaiyuanyin",entity.get("xiugaiyuanyin"));
              
           }else if(entity.get("zhuangtai").equals("1")){
               entity.keyvalue("zhuangtai","1");
           }else if(entity.get("zhuangtai").equals("3")){
               entity.keyvalue("zhuangtai","3");
               entity.keyvalue("firstdata",entity.get("firstdata"));
               entity.keyvalue("data",entity.get("data"));
               entity.keyvalue("thirddata",entity.get("thirddata"));
               entity.keyvalue("fourthdata",entity.get("fourthdata"));
               entity.keyvalue("fifthdata",entity.get("fifthdata"));
               entity.keyvalue("sixthdata",entity.get("sixthdata"));
           }else if(entity.get("zhuangtai").equals("4")){
               entity.keyvalue("zhuangtai","4");
               entity.keyvalue("firstdata",entity.get("firstdata"));
               entity.keyvalue("data",entity.get("data"));
               entity.keyvalue("thirddata",entity.get("thirddata"));
               entity.keyvalue("fourthdata",entity.get("fourthdata"));
               entity.keyvalue("fifthdata",entity.get("fifthdata"));
               entity.keyvalue("sixthdata",entity.get("sixthdata"));
           };
           //zyx添加，状态为1同意，不存值，状态为2修改，存修改原因。状态为3撤销，存撤销原因；状态为4，存驳回原因。
                entity.update().where("id=?",entity.get("id")).submit();
                  
         PoPupHelper.adapter(out).iframereload();
           PoPupHelper.adapter(out).showSucceed();
            
          }
       entity.select().where("id=?", req.get("id")).get_first_rows();
           entity.select().where("id=?", entity.get("id")).get_first_rows();
          entity.select().where("id=?", cookies.Get("id")).get_first_rows();
            
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            tr>td .xzz{width: 70%;height: 99%;border: 0px;}
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 1px 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 99%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin;}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            #smalltab{width: 99%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 2px 10px;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            .disnone{display: none}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .butreturn{border: 1px yellow solid;border-radius: 28%;padding: 3px;font-size: x-small;background-color: darkgray;}
            .scyj em{margin-left: 10%}
            .scsm input{width: 98%;border: 0px;};
            .fsry .selectscr{cursor: pointer}
            .fsry .selectscra{cursor: pointer;}
            .red{
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
            <tr>   
                <tr>
                        <td colspan="10" id="tabheader">
                            <% entity.write("filename"); %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            主办单位
                        </td>
                        <td colspan="8">
                            <% entity.write("organizer"); %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            文号
                        </td>
                        <td class="w261"colspan="3">
                            <% entity.write("Titanic"); %>
                        </td>
                         <td colspan="2" class="w120 dce">
                            状态
                        </td>
                        <td class="w261"colspan="3">
                            <% entity.write("zhuangtai"); %>
                        </td>
                        
                    </tr>
                    <tr>
                        <td  colspan="2" class="w120 dce">
                            报送人电话
                        </td>
                        <td  colspan="3" class="w261" companytypeeclassify="<% entity.write("telephone"); %>">
                        </td>
                        <td  colspan="2" class="w120 dce">
                            报送人
                        </td>
                        <td  colspan="3" class="w261" lwstate="<% entity.write("name"); %>">
                        </td>
                        
                        
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            备案时间
                        </td>
                        <td colspan="3"  class="w261" circles="<% entity.write("beiandate"); %>">
                        </td>
                        <td colspan="2" class="w120 dce">
                            印发时间
                        </td>
                        <td colspan="3" class="w261" examination="<% entity.write("yfdate"); %>" registertype="<% entity.write("registertype"); %>">
                        </td>
                    </tr>
                     <tr>
                        <td colspan="2" class="w120 dce">备注</td>
                        <td colspan="8">
                            
                            <%
                                out.print(entity.get("remarks"));
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            起草说明
                        </td>
                        <td colspan="3"  class="w261" circles="<%
                                out.print(entity.get("qcexplain"));
                                %>">
                        </td>
                        <td colspan="2" class="w120 dce">
                            法律依据
                        </td>
                        <td colspan="3" class="w261" circles="<%
                                out.print(entity.get("legalbasis"));
                                %>">
                        </td>
                    </tr>
<!--                    <tr>
                        <td class="w120 dce">起草说明</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("qcexplain"));
                                %>
                        </td>
                        <td class="w120 dce">法律依据</td>
                        <td  width="4%" class="ys">  
                            <%
                                out.print(entity.get("legalbasis"));
                                %>
                        </td>
                        <td class="w120 dce">征求意见</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("opinions"));
                                %>
                        </td>
                        <td class="w120 dce">合法性审查</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("discussion"));
                                %>
                        </td>
                        <td class="w120 dce">集体讨论</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("review"));
                                %>
                        </td>
                    </tr>-->
            <tr>
		<td class="w120 dce" colspan="2">
		 附件
		</td>
	    <td style="font-weight:bold;"  colspan="8">
                            <%
//                                RssList list = new RssList(pageContext, "shenchadengji");
//                                list.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <% out.print(entity.get("enclosurename")); %><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;">&nbsp;&nbsp;&nbsp;&nbsp;点击下载</a>
                            <%
                                    }
                                }
                            %>
                    </tr> 
                 
                    <tr>
                    <td class="w120 dce" colspan="2">
                        审查意见
                    </td>
                    <input  style="display:none" id="time" style="text-align: center;" class="w200 Wdate" name="scdate" />
                    <td colspan="8" class="scyj" >
                        <input id="tongyi" name="zhuangtai" checked="checked" type="radio" value="1">同意
                        <em></em> 
                        <input name="zhuangtai" type="radio" value="2">修改
                        <em></em> 
                        <input name="zhuangtai" type="radio" value="3">撤销
                        <em></em> 
                        <input name="zhuangtai" type="radio" value="4">驳回
                    </td>
                    </tr>
                    <tr class="yjsm" style="display: none;" >
                        <td  class="w120 dce" colspan="2">
                            修改说明
                        </td>
                        <td colspan="8" class="scsm">
                            <textarea style="height:60px;width:98%;" placeholder="（如果需要修改，请这里说明理由修改的原由）" type="text" name="xiugaiyuanyin"></textarea>
                        </td>
                    </tr>
                    <tr class="cxyy" style="display: none;" >
                        <td  class="w120 dce" colspan="2 ">
                            撤销原由
                        </td>
                        <td colspan="8" class="scsm">
                            <input id="checkbox1" class="ceshi" type="checkbox" > <label>同法律法规相抵触。</label> 
                            <br>
                            <input id="checkbox2"  class="ceshi1" type="checkbox" > <label>超越法定权限，限制或者剥夺公民、法人和其他组织的合法权利，或者增加公民、法人和其他组织的义务。</label> 
                              <br>
                            <input id="checkbox3"  class="ceshi2" type="checkbox" > <label>违反法定程序指定。</label> 
                              <br>
                            <input id="checkbox4"  class="ceshi3" type="checkbox" > <label>同上级或者本级人大及其常委会的决议、决定相抵触。</label> 
                              <br>
                            <input id="checkbox5"  class="ceshi4" type="checkbox" > <label>对法律、法规进行违背其目的、精神、原则的不当解释。</label> 
                              <br>
                            <input id="checkbox6"  class="ceshi5" type="checkbox" > <label>有其他不适当问题。</label> 
                        </td>
                    </tr>
                        <tr class="bhyy" style="display: none;" >
                         <td  class="w120 dce" colspan="2">
                            驳回原由
                        </td>
                        <td colspan="8" class="scsm">
                            <input id="checkbox1" class="ceshi" type="checkbox" > <label>同法律法规相抵触。</label> 
                            <br>
                            <input id="checkbox2"  class="ceshi1" type="checkbox" > <label>超越法定权限，限制或者剥夺公民、法人和其他组织的合法权利，或者增加公民、法人和其他组织的义务。</label> 
                              <br>
                            <input id="checkbox3"  class="ceshi2" type="checkbox" > <label>违反法定程序指定。</label> 
                              <br>
                            <input id="checkbox4"  class="ceshi3" type="checkbox" > <label>同上级或者本级人大及其常委会的决议、决定相抵触。</label> 
                              <br>
                            <input id="checkbox5"  class="ceshi4" type="checkbox" > <label>对法律、法规进行违背其目的、精神、原则的不当解释。</label> 
                              <br>
                            <input id="checkbox6"  class="ceshi5" type="checkbox" > <label>有其他不适当问题。</label> 
                        </td>
                        <td style="display:none;"><input class="yi" type="text" name="firstdata" value="<% entity.write("firstdata"); %>"></td>
                         <td style="display:none;"><input class="er" type="text" name="data" value="<% entity.write("data"); %>"></td>
                         <td style="display:none;"><input class="san" type="text" name="thirddata" value="<% entity.write("thirddata"); %>"></td>
                         <td style="display:none;"><input class="si" type="text" name="fourthdata" value="<% entity.write("fourthdata"); %>"></td>
                         <td style="display:none;"><input class="wu" type="text" name="fifthdata" value="<% entity.write("fifthdata"); %>"></td>
                         <td style="display:none;"><input class="liu" type="text" name="sixthdata" value="<% entity.write("sixthdata"); %>"></td>
                    </tr>
                </table>
            </div>
           

            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit" class="sub">确定</button>
            </div>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script>
              $('input[name="zhuangtai"]').click(function () {
                if ($(this).val() == 2) {
                    $(".yjsm").show();
                    $(".cxyy").hide();
                    $(".bhyy").hide();
                } else if ($(this).val() == 3){
                    $(".yjsm").hide();
                    $(".cxyy").show();
                    $(".bhyy").hide();
                } else if ($(this).val() == 4){
                    $(".yjsm").hide();
                    $(".cxyy").hide();
                    $(".bhyy").show();
                }else{
                    $(".yjsm").hide();
                    $(".cxyy").hide();
                    $(".bhyy").hide(); 
                }
            });
            
            var value = $('input:radio[name="zhuangtai"]:checked').val();
         function datetime() {
		 var now = new Date();
		 document.getElementById("time").value = now.getFullYear() + "-"
		 + (now.getMonth() + 1) + "-" + now.getDate();
		 document.getElementById("time").value += " " + now.getHours() + ":"
		 + now.getMinutes() + ":" + now.getSeconds();
		 }
		 window.setInterval("datetime()", 1000);
                 
                 
                 
                 var one ;
            $(".yi").val(one)
          $(".ceshi").click(() => {
              if($(".ceshi").is(":checked") == true) {
                  one = "同法律法规相抵触。";
              }else{
                  one = "";
              }
              $(".yi").val(one)
          });
          var er ;
           $(".er").val(er)
           $(".ceshi1").click(() => {
              if($(".ceshi1").is(":checked") == true) {
                  er = "超越法定权限，限制或者剥夺公民、法人和其他组织的合法权利，或者增加公民、法人和其他组织的义务。";
              }else{
                  er = "";
              }
        $(".er").val(er)
             
          });
          var san ;
          $(".san").val(san)
           $(".ceshi2").click(() => {
              if($(".ceshi2").is(":checked") == true) {
                  san = "违反法定程序指定。";
              }else{
                  san = "";
              }
              $(".san").val(san)
          }); 
          var si ;
          $(".si").val(si)
          $(".ceshi3").click(() => {
              if($(".ceshi3").is(":checked") == true) {
                  si = "同上级或者本级人大及其常委会的决议、决定相抵触。";
              }else{
                  si = "";
              }
              $(".si").val(si)
          }); 
          var wu ;
          $(".wu").val(wu)
          $(".ceshi4").click(() => {
              if($(".ceshi4").is(":checked") == true) {
                  wu = "对法律、法规进行违背其目的、精神、原则的不当解释。";
              }else{
                  wu = "";
              }
              $(".wu").val(wu)
          });
            var liu ;
          $(".liu").val(liu)
          $(".ceshi5").click(() => {
              if($(".ceshi5").is(":checked") == true) {
                  liu = "有其他不适当问题。";
              }else{
                  liu = "";
              }
              $(".liu").val(liu)
          });
        </script>
        </form>
    </body>
</html>
