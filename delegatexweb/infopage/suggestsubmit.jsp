<%-- 
    Document   : delegateinfo
    Created on : 2018-7-16, 17:58:04
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssList entity = new RssList(pageContext, "leaveword");
    entity.request();
    if (!entity.get("title").isEmpty()) {
        entity.remove("myid");
        entity.timestamp();
        entity.keyvalue("objid",entity.get("myid"));
        entity.append().submit();
        out.print("<script>alert('提交成功')</script>");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody {margin: 10px 23px; border: #ccc solid thin;padding-bottom: 10px;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0; }
            #webbody h1>span{display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 2px;}
            #webbody table{border: #ccc solid thin;width: 945px;margin: 39px auto;}
            #webbody table td{padding: 8px;font-size: 14px;}
            #webbody table td input[type='text']{ height: 24px;padding: 0 2px;}
            #webbody table #tabhead{text-align: center;background:#f6f6f6;font-size: 16px;font-weight: 600;letter-spacing: 1px; }
            #webbody table td>div{width: 96px;height: 122px;margin: 10px auto;overflow: hidden;}
            #webbody  table td>div>img{width: 96px;}
            #webbody  table td>p{width: 95px;height: 24px;line-height: 24px;text-align: center;color:#fff;background: #52b4bb;border:#95c2c9 solid thin;margin: 0 auto;margin-top: 65px;
            }
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1054px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            #webbody  table td textarea{ padding: 3px; margin: 0; list-style: none; font-family: Arial,Helvetica,sans-serif,宋体; text-indent: 0px; outline: none; border-radius: 3px; vertical-align: middle;resize: none; height: 110px;}
            .txtright{text-align: right;}
            .red{color: red}
            .w630{width: 630px;}
            .w150{width: 150px;}
            #webbody  table td button{width: 95px;height: 24px;line-height: 24px;text-align: center;color:#fff;background: #52b4bb;border:#95c2c9 solid thin;margin: 0 30px;}
            .popuplayer,.calendarwrap{display: none;}
            
            a{color: #039f62 ;cursor: pointer;  text-decoration: none; }
            a:hover{border-bottom:#039f62 solid 1px; }
        </style>
    </head>
    <body>
        <div>
            <form>
                <div id="header"></div>
                <div id="webbody">
                    <h1><span>当前位置：<a href="/delegatexweb/infopage/delegationinfo.jsp?myid=<% out.print(entity.get("myid"));%>">首页</a> > 选民留言</span></h1>
                    <input style="display:none" name="myid" value="<% out.print(entity.get("myid"));%>">
                    <table cellspacing="0">
                        <tr><td colspan="4" id="tabhead">向代表提建议意见</td></tr>
                        <tr><td class="txtright">您的姓名<em class="red">*</em></td><td><input type="text" name="myname" class="w150"></td><td class="txtright">电子邮件</td><td><input type="text" name="email" class="w150"></td></tr>
                        <tr><td class="txtright">联系手机<em class="red">*</em></td><td colspan="3"><input type="number" class="w150" name="telphone"></td></tr>
                        <!-- <tr><td></td><td colspan="3" class="red">非常重要！请保证号码正确,建议提交成功后会给手机发送查询反馈用的密码</td></tr> -->
                        <tr><td class="txtright">标题<em class="red">*</em></td><td colspan="3"><input class="w630" name="title" type="text"></td></tr>
                        <tr><td class="txtright">建议及意见<em class="red">*</em></td><td colspan="3"><textarea class="w630" name="matter"></textarea></td></tr>
                        <tr><td class="txtright">留言须知</td><td colspan="3">
                        <textarea class="w630" readonly="">一、留言需知：

1、本栏目仅用于政府和公众之间的交流，不用于公众互相之间的交流，公众可就政府职能范围内的相关工作进行咨询、提出意见和建议。

2、反映问题务必真实，信访人应对其所提供材料内容的真实性负责，不得捏造、歪曲事实，不得诬告、陷害他人。提出投诉请求的，还应当载明信访人的真实姓名、住址和请求、事实、理由及有效联系地址、联系电话。以便于我们同来信人保持联系，使来信事项及时得到妥善解决。

3、一封留言只能反映一个或同类问题，不同类型的问题请分别填写，请勿一次多投，重复留言不予受理。

二、本网站留言受理本县辖区内有权处理的留言事项，具体范围是：

１、受理人民群众对政府及其工作部门的批评、意见和建议；

２、受理人民群众对国家公职人员工作效率、工作质量、工作作风的意见和建议；

３、受理人民群众对经济建设、社会事业、城市管理方面的意见和建议；

４、受理对影响群众生活的有关问题及突发事件提出的处理意见和建议；

５、受理社会生活中发生的属于政府职权范围内的其他有关问题。

三、含有下列内容的留言不予发布和答复：

1、违反中华人民共和国法律、法规及违反改革开放和四项基本原则的；

2、含有造谣、诽谤、攻击他人内容的；

3、根据未经证实的消息提出相关问题的；

4、无真实姓名（名称）和有效联系方式的投诉将被视为无效投诉，不予受理。

5、含有商业广告内容的。

四、凡在本栏目留言，即表明已阅读并接受了上述各项条款。</textarea>
                        </td></tr>
                        <tr><td></td><td colspan="3"><label><input type="checkbox">我已阅读上面的留言须知</label></td></tr>
                        <tr><td></td><td colspan="3"><button type="submit">提交</button>
                        <button style="display:none;">查询反馈</button>
                        <button type="button" id="history">返回</button><input type="hidden" name="objid" value="<% entity.write("objid");%>"></td></tr>
                    </table>
                </div>
                <div id="footer">
                    <!--<p>汝州市人大常委会主办</p>-->
                    <p style="margin-top:-10px;">&nbsp;&nbsp;&nbsp;</p>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主办：汝州市人大常委会办公室&nbsp;&nbsp;<a class="ml80" href="https://beian.miit.gov.cn/" target="_blank">豫ICP备17035523号</a></p>
                    <p>电话：0375-6862978<span class="ml144">邮编：467500</span></p>
                    <p>地址：平顶山市汝州市丹阳中路268号</p>
                </div>
                    
      
                    
            </form>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
          
             
            $("#history").click(function () {
                history.go(-1);
            })
            $("button[type='submit']").click(function () {
                
                 if ($("[name='myname']").val() == undefined || $("[name='myname']").val() == "") {
                    //let text = "请填写姓名";
                    //popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='myname']").focus();
                     alert("请填写姓名")
                    return false;
                }
                
                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
                //let text = "请填写电话号码";
                //popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                $("[name='telphone']").focus();
                 alert("请填写电话号码")
                return false;
                }
                
                
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                //let text = "请填写电话号码";
                //popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                $("[name='title']").focus();
                 alert("请填写标题")
                return false;
                }
                
                
                 if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
                //let text = "请填写电话号码";
                //popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                $("[name='matter']").focus();
                 alert("请填写内容")
                return false;
                }
                
                if ($("input[type='checkbox']").is(":checked")) {
                } else {
                    alert("请先阅读留言须知")
                return false;
                }
            })
        </script>
    </body>
</html>
