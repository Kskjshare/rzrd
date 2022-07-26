<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<%
    StaffList.IsLogin(request, response);
    //推送接口
//    RssList entity = new RssList(pageContext, "evaluation_standard");
    RssList entity = new RssList(pageContext, "evaluation_new_standard");

    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.keymyid(UserList.MyID(request));
                entity.append().submit();
                break;
            case "update":
                entity.remove("id");
                entity.update().where("id=" + entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 3px}
/*            .center{text-align:center}*/
            .cellbor>tbody>tr>td{border: #6caddc solid thin;  line-height: 40px;}
            .cellbor{width: 100%}
/*            .cellbor td:first-child{ width: 70px; }*/
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            .w630{width:630px;}
          
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" id="tabheader">计分标准</td>
                    </tr>
                    <tr>
                        <td class="dce w120" >计分标准名称</td>
                        <td  colspan="2"><% entity.write("title"); %></td>
                    </tr>
                   <%
                   if ( entity.get("score_std6").equals("")){
                   %>
                   
                   <%
                      }else{
                   %>
                    <tr>
                        <td colspan="2" class="dce" style="width:40%;"></td>
                        <td class="dce">分值</td>
                    </tr>
<!--                    <tr>
                        <td rowspan="17"  class="dce">履职类别</td>
                        <td class="dce center w30" style="width:190px;">参加视察</td>
                         <td>
                            <% entity.write("score_std1"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std1_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std1_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>-->
                    
<!--                     <tr>
                        <td rowspan="17"  class="dce">履职类别</td> 
                        <td class="dce center">出席人代会</td>
                        <td>
                            <% entity.write("score_std7"); %>&nbsp;&nbsp;分&nbsp;&nbsp;                           
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std7_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>-->
                    
                     <tr>
                        <td rowspan="17"  class="dce">履职类别</td> 
                        <td class="dce center">出席人代会</td>
                        <td>
                            <% entity.write("score_std7"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std7_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std7_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    
                      <tr>
                        <td class="dce center">参加其他会议</td>
                        <td>
                            <% entity.write("score_std8"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std8_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std8_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                  
                    <tr>
                        <td class="dce center">参加学习培训</td>
                        <td>
                            <% entity.write("score_std5"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std5_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std5_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    
                     <tr>
                        <td class="dce center">提出议案，建议、批评和意见</td>
                        <td>
                            <% entity.write("score_std6"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std6_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            
                            &nbsp;&nbsp;附议人每一次加&nbsp;&nbsp;<% entity.write("score_std_fuyi"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;附议人最高&nbsp;&nbsp;<% entity.write("score_std_fy_most"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std6_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                   
                    <tr>
                        <td class="dce center">开展专题调研</td>
                        <td>
                            <% entity.write("score_std2"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std2_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std2_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    
<!--                    <tr>
                        <td class="dce center">参加调研</td>
                        <td>
                            <% entity.write("score_std3"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std3_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std3_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>-->
                    
                    <tr>
                        <td class="dce center">参加视察、调研及执法检查</td>
                        <td>
                            <% entity.write("score_std4"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std4_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std4_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                                    
  
                    <tr>
                        <td class="dce center">接待选民</td>
                        <td>
                           <% entity.write("score_std9"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std9_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std9_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    <tr>
                        <td class="dce center">化解矛盾纠纷</td>
                        <td>
                            <% entity.write("score_std10"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std10_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std10_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    <tr>
                        <td class="dce center">扶弱济困</td>
                        <td>
                            <% entity.write("score_std11"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std11_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std11_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    <tr>
                        <td class="dce center">办好事、实事</td>
                        <td>
                            <% entity.write("score_std12"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std12_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std12_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    <tr>
                        <td class="dce center">参加慈善公益事业</td>
                        <td>
                            <% entity.write("score_std13"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;每多参加一次加&nbsp;&nbsp;<% entity.write("score_std13_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std13_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    <tr>
                        <td class="dce center">向选民述职</td>
                        <td>
                            
                            书面述职加&nbsp;&nbsp;<% entity.write("score_std14_ext"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp; &nbsp;&nbsp;口述述职加&nbsp;&nbsp;<% entity.write("score_std14_dictate"); %>&nbsp;&nbsp;分&nbsp;&nbsp;
                            &nbsp;&nbsp;本项最高&nbsp;&nbsp;<% entity.write("score_std14_max"); %>&nbsp;&nbsp;分
                        </td>
                    </tr>
                    
                     <tr>
                        <td colspan="4" id="tabheader">其他</td>
                    </tr>
                    
                    <tr>
                        <td class="dce center">人代会上接受媒体采访</td>
                        <td><% entity.write("score_std15"); %>&nbsp;&nbsp;分</td>
                    </tr>
                    <tr>
                        <td class="dce center">人大常委会临时交办的其他工作任务</td>
                        <td><% entity.write("score_std16"); %>&nbsp;&nbsp;分</td>
                    </tr>
                    <tr>
                        <td class="dce center">列为市人大常委会重点督办的代表建议</td>
                        <td><% entity.write("score_std17"); %>&nbsp;&nbsp;分</td>
                    </tr>

                        <%
                        };
                        %>
                    <tr>
                        <td colspan="4" id="tabheader">计分标准详情</td>
                    </tr>
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td colspan="3">                    
                            <%entity.write("matter");%>
                        </td>
                    </tr>

                    
                </table>
            </div>
            <div class="footer">
                <!-- <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确定" : "修改");%></button> -->
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            $(".footer button").click(function () {
                var arry = [];
                $("#seluserlist>em[myid]").each(function () {
                    arry.push($(this).attr("myid"))
                })
                var str = arry.join(",");
                $("#rid").val(str);

                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写活动标题");
                    $("[name='title']").focus();
                    return false;
                }
            })
        </script>
    </body>
</html>
