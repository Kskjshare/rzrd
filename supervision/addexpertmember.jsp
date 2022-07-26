<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList member = new RssList(pageContext,"expert_member");
     RssList parttime = new RssList(pageContext,"expert_member");
    member.request();
    parttime.request();
    if(!member.get("action").isEmpty()){
        switch(member.get("action")){
            case "append":
                
                if(parttime.select().where("realname=?",member.get("realname")).get_first_rows()){
                   out.print("<script>alert('该用户名已存在...');</script>");
                   break;
                }
                if(parttime.select().where("phonenumber=?",member.get("phonenumber")).get_first_rows()){
                  out.print("<script>alert('该手机号已经注册过了！');</script>");
                  break;
                }
                
                parttime.append().submit();
                   out.print("<script>alert('添加成功');</script>");
        
        }
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" id="mainwrap">
             <!--zyx-->
            <div class="toolbar">
                <button type="button" class="res">返回上一级</button>
            </div>
            <!--zyx end-->            
            <div class="bodywrap">
                <table>
                      <div style="height: 27px;font-size: 16px;padding-top:5px;text-align: center">添加专家</div>
                    <tr>
                        <td style="height: 30px;font-size: 14px;"><p style="margin-left: 28px;line-height: 30px">姓名：<input style="height: 18px;width: 460px" type="text" name="realname" ></p></td>
                    </tr>
                     <tr>
                         <td style="height: 30px;font-size: 14px;pxmargin-left: 20px"><p style="margin-left: 28px;line-height: 30px">电话：<input  style="height: 18px;width: 460px" type="text" name="phonenumber" ></p></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </div>
    </form>
    <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
    <%@include  file="/inc/js.html" %>
    <script src="controller.js"></script>
    <script type="text/javascript">
        
            $(".footer>button").click(function () {
                if ($("[name='realname']").val() == undefined || $("[name='realname']").val() == "") {
                  alert("请填写代表姓名");
                  $("[name='realname']").focus();
                   return false;
                   }
                    if ($("[name='phonenumber']").val() == undefined || $("[name='phonenumber']").val() == "") {
                    alert("请填写电话号码");
                     $("[name='phonenumber']").focus();
                   return false;
                    } else {
                    var str = $("[name='phonenumber']").val()
                 if (!str.match(/^1[3456789]\d{9}$/)) {
                   alert("请填写正确的电话号码");
                   $("[name='phonenumber']").focus();
                     return false;
                  }
                      }
                     })
                     
// zyx                    
            $(".res").click(function () {
                history.go(-1);
            });
//            zyx end                     
    </script>
</body>
</html>