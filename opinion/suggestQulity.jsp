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

<%@page import="java.net.URLDecoder"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "overall_satisfaction");
    entity.request();
    
    String evaluatedTips ="未测评" ;
    RssList entity1 = new RssList(pageContext, "overall_satisfaction");
    entity1.request();
    entity1.select().where("id=?", entity.get("id")).get_page_desc("id");
    while ( entity1.for_in_rows() ) {
       evaluatedTips ="已测评" ;
    }
    
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid( UserList.MyID(request) );
        }
        entity.keyvalue("proposal", entity.get("id"));
        entity.keyvalue("evaluationDone", "1");
        
        //entity.update().where("id="+entity.get("id")).submit();
        entity.append().submit();

        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    
    String view = "sort";
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    String keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" +
            URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + 
            URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
            URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + 
            URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + 
            URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" + 
            URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" +
            URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + 
            URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + 
            URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" +
            URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" +
            URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and draft=2 " ;  
            keywhere += " and id="+req.get("id");


            RssListView list = new RssListView(pageContext, view); 
            list.request();
            list.select().where(keywhere).get_first_rows();

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
            label{margin: 0 15px;}
            #cbdw{cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp120 cellbor">
<!--                    <tr>                     
                        <td colspan="20" class="tabheader">建议质量</td>
                    </tr>-->
                     <tr>
                        <td colspan="10" class="dce">测评状态</td>
                        <td colspan="10"> <% out.print( evaluatedTips );%>
                        </td>
                    </tr>
                    
<!--                    <tr>
                        <td colspan="10" class="dce">标题</td>
                        <td colspan="10"> <% out.print(list.get("title"));%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">内容</td>
                        <td colspan="10"> <% out.print(list.get("matter"));%>
                        </td>

                    <tr>-->
                        <td colspan="10" class="dce">建议质量评价</td>
                        <td colspan="10" id="evaluation">
                            <label><input type="radio" value="1" name="evaluation" checked="cheched" >优秀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <label style="margin-left:30%;"><input type="radio" value="2" name="evaluation">一般</label>
                            <!--<label style="float:right;"><input type="radio" value="3" name="evaluation">不满意</label>-->
                        </td>
                    </tr>
                    
              
                  
                    <tr>
                        <td colspan="10" class="dce">您的意见</td>
                        <td colspan="10"><textarea name="opinion"><% entity.write("opinion");%></textarea></td>
                    </tr>
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
            $('#cbdw').click(function () {
//                if ($(this).text() == "请选择承办单位") {
//                    var t = $(this), n = $(this).attr("rid");
//                    if (!n) {
//                        n = "";
//                    }
//                    RssWin.onwinreceivemsg = function (dict) {
//                        console.log(dict);
//                        t.text(dict.myname)
//                        $("[name='companyidlist']").val(dict.myid);
//                    }
//                    RssWin.open("/selectwin/zhengxuncompany.jsp?relationid=0" + n, 400, 500);
//                }
//            });
//            $('.footer button').unbind().click(function () {
//                if ($("[name='companyidlist']").val() == "" || $("[name='companyidlist']").val() == undefined) {
//                    alert("请选择承办单位");
//                    return false;
//                }
//                $("[name='effect']").val($("#effect").find("input:checked").val());
//                if ($("[name='replyshijian']").val() != undefined && $("[name='replyshijian']").val() != "") {
//                    var timestamp = new Date($("[name='replyshijian']").val());
//                    $("[name='replyshijian']").val(timestamp / 1000);
//                }
//                if ($("[name='replyshijian']").val() == undefined || $("[name='replyshijian']").val() == "") {
//                    alert("请填写时间");
//                    $("[name='replyshijian']").focus();
//                    return false;
//                }
//                if ($("[name='opinion']").val() == undefined || $("[name='opinion']").val() == "") {
//                    alert("请填写意见内容");
//                    $("[name='opinion']").focus();
//                    return false;
//                }
//            })
        </script>
    </body>
</html>
