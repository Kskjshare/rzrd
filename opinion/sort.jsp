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
    RssListView entity = new RssListView(pageContext, "suggest_opinion");
    RssList entity1 = new RssList(pageContext, "opinion");
    entity1.request();
    if (!entity1.get("action").isEmpty()) {

     
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity1.get("id")).get_first_rows();
  
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
                        <td colspan="20" class="tabheader">选择排序条件</td>
                        <td colspan="2">
                            <select id="type" style="width:200px;" value="<% entity.write("type"); %>" name="type">
                                <option>面商</option>
                                <option>态度</option>
                                <option>答复</option>
                                <option>结果</option>
                                <option>综合</option>
                            </select>
                                <input id="val" type="text" name="typeid" value="" style="display:none;" />
                        </td>
                         <td colspan="10" id="effect">
                            <label><input type="radio" value="1" name="ceshi">满意</label>
                            <label><input type="radio" value="2" name="ceshi">基本满意</label>
                            <label><input type="radio" value="3" name="ceshi">不满意</label>
                        </td>
                    </tr>
                   
<!--               
                    <tr>
                        <td colspan="10" class="dce">面商</td>
                        <td colspan="10" id="effect">
                            <label><input type="radio" value="1" name="ceshi">满意</label>
                            <label><input type="radio" value="2" name="ceshi">基本满意</label>
                            <label><input type="radio" value="3" name="ceshi">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">态度</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect3">满意</label>
                            <label><input type="radio" value="2" name="effect3">基本满意</label>
                            <label><input type="radio" value="3" name="effect3">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">答复</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect2">满意</label>
                            <label><input type="radio" value="2" name="effect2">基本满意</label>
                            <label><input type="radio" value="3" name="effect2">不满意</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">结果</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect4">满意</label>
                            <label><input type="radio" value="2" name="effect4">基本满意</label>
                            <label><input type="radio" value="3" name="effect4">不满意</label>
                        </td>
                    </tr>
                    
                     <tr>
                        <td colspan="10" class="dce">综合</td>
                        <td colspan="10">
                            <label><input type="radio" value="1" name="effect5">满意</label>
                            <label><input type="radio" value="2" name="effect5">基本满意</label>
                            <label><input type="radio" value="3" name="effect5">不满意</label>
                        </td>
                    </tr>                               -->
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
         
        </script>
    </body>
</html>
