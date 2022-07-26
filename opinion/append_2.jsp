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
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssListView entity = new RssListView(pageContext, "suggest_opinion");
    RssList entity1 = new RssList(pageContext, "second_opinion"); 
   
    RssList suggest = new RssList(pageContext, "suggest");
   
    RssListView company = new RssListView(pageContext, "suggest_company");
   
    entity1.request();
    if (!entity1.get("action").isEmpty()) {
        entity1.remove("id");
        entity1.remove("summary");
        entity1.remove("ceshi");
        entity1.remove("companyidlist");
        if (entity1.get("myid").isEmpty()) {
            entity1.keymyid(UserList.MyID(request));
        }
        entity1.timestamp();
        entity1.keyvalue("proposal", req.get("id"));
        entity1.keyvalue("evaluationDone", "1");
        entity1.append().submit();
        
        
        
       // suggest.keyvalue("consultation", 1);
      //  suggest.update().where("id=?", entity1.get("id")).submit();

       
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity1.get("id")).get_first_rows();
    company.select().where("type=2 and suggestid=?", entity1.get("id")).get_page_desc("suggestid");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="mui.min.css" rel="stylesheet" type="text/css"/>
        <style>
            /*.popupwrap{width: 100%}*/
            .left_op{width: 30px}
            .mui-input-row span{display: none}
            .mui-input-range input[type=range]{background-color: #dce6f5;height: 6px;border: 1px solid #cbcbcb;width: 90%;margin: 0}
            .mui-input-row.mui-input-range{float: left;width: 90%;padding: 0;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 36px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #baidubjq td{line-height: 17px;background: #dce6f5}
            #baidubjq td ul{width: 798px;margin-top: 5px;border-top: 1px solid #6caddc;border-left: 1px solid #6caddc;border-right: 1px solid #6caddc}
            #baidubjq td div{border-left: 1px solid #6caddc;border-right: 1px solid #6caddc;border-bottom: 1px solid #6caddc;margin-bottom: 5px;width: 778px;padding: 10px;background: #fff}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
            #titlecode{float: right;margin-right: 30px;}
            .startlist em{display: inline-block; ;right:30px; color: #777777;}
            .startlist a { background: url(../css/limg/star1.png) no-repeat; background-size: 25px 25px; display: inline-block; width: 25px; height: 25px; margin: 0 6px;vertical-align: middle;}
            .startlist .sel{background: url(../css/limg/star1s.png) no-repeat; background-size: 25px 25px;}  
            .startlist input{border: 0;width: 15px;}
            label{margin: 0 5px;}
            #cbdw{cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp120 cellbor">
                    <tr>                    
                        <td colspan="20" class="tabheader">办理满意度评价</td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">标题</td>
                        <td colspan="10"> <% out.print(entity.get("title"));%>
                            <!--span id="titlecode">编号： <% out.print(entity.get("realid"));%></span-->
                        </td>
                    </tr>
                    <tr><td colspan="10" class="dce">主办单位</td><td colspan="10"><span id="cbdw" rid="<%
                        String str = "", companyname = "";
                        int companynum = 0;
                        while (company.for_in_rows()) {
                            str += company.get("companyid") + ",";
                            
                            //added by ding 
                             if ( companynum > 0 ){
                                 companyname += ",";
                            }
//                            companyname += company.get("account"); 
                            companyname += company.get("realname"); 
                            //end
                            
                            
                            //companyname += company.get("account") + ",";
                            companynum++;
                        }
                        if (!str.equals("")) {
                            str.substring(0, str.length() - 1);
                        }
                        if (!companyname.equals("")) {
                            companyname.substring(0, companyname.length() - 1);
                        }
                    %>"><% out.print(companynum == 0 ? "请选择承办单位" : companyname);%></span><input type="hidden" name="companyidlist" value="<%out.print(str);%>">
                   </td>
                    </tr>
                    
                    <!--
                    <tr><td colspan="10" class="dce">您是否收到办理函</td><td colspan="10"><select class="w206" name="reply" dict-select="state"></select></td></tr>
                    <tr><td colspan="10" class="dce">收到时间</td><td colspan="10"><input type="text" class="w200 Wdate" name="replyshijian"  rssdate="<% out.print(entity.get("replyshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td></tr>
                    <tr><td colspan="20" class="tabheader">收到办理函后您认为</td></tr>
                    -->
                    <tr>
                        <td colspan="10" style="width:22%;" class="dce">面商</td>
                        <td colspan="10" id="effect">
                            <label><input type="radio" value="1" name="ceshi" checked="cheched" >满意</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="ceshi">基本满意</label>
                            <label style="float:right;"><input type="radio" value="3" name="ceshi">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">态度</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect2" checked="cheched" >满意</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="effect2">基本满意</label>
                            <label style="float:right;"><input type="radio" value="3" name="effect2">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">答复</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect3" checked="cheched" >满意</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="effect3">基本满意</label>
                            <label style="float:right;"><input type="radio" value="3" name="effect3">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">结果</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect4" checked="cheched" >满意</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="effect4">基本满意</label>
                            <label style="float:right;"><input type="radio" value="3" name="effect4">不满意</label>
                        </td>
                    </tr>
                    
                     <tr>
                        <td colspan="10" class="dce">综合</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect5" checked="cheched" >满意</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="effect5">基本满意</label>
                            <label style="float:right;"><input type="radio" value="3" name="effect5">不满意</label>
                        </td>
                        <!--zyx 对单选按钮样式调整-->
                    </tr>
                    
<!--                    <tr>
                        <td colspan="10" class="dce">您对办理情况意见：</td>
                        <td colspan="10"><textarea name="opinion"><% entity.write("opinion");%></textarea></td>
                    </tr>-->
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="effect" value="<% entity.write("effect");%>">
                <input type="hidden" name="action" value="1" />
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>          
            $('.footer button').unbind().click(function () {               
                $("[name='effect']").val($("#effect").find("input:checked").val());
                if ($("[name='shijian']").val() != undefined && $("[name='shijian']").val() != "") {
                    var timestamp = new Date($("[name='shijian']").val());
                    $("[name='shijian']").val(timestamp / 1000);
                }

//                if ($("[name='opinion']").val() == undefined || $("[name='opinion']").val() == "") {
//                    alert("请填写意见内容");
//                    $("[name='opinion']").focus();
//                    return false;
//                }
            })
        </script>
    </body>
</html>
