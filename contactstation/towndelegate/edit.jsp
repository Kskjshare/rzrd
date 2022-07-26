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
    RssListView entity2 = new RssListView(pageContext, "user_vitae");
    RssList matter = new RssList(pageContext, "vitae");
    RssList entity = new RssList(pageContext, "user");
    RssList entity6 = new RssList(pageContext, "user");
    RssList entity3 = new RssList(pageContext, "user");
    RssList user1 = new RssList(pageContext, "userrole");
    RssList user4 = new RssList(pageContext, "userrole");
    RssListView userrole = new RssListView(pageContext, "userrole");
    StaffList Staff = new StaffList(pageContext);
    entity.request();
    entity2.request();
    System.out.println("entity.action::"+entity.get("action"));
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                int myid = Integer.valueOf( UserList.MyID(request) );
                if ( myid < 1024 && myid > 1050 ) {
                   out.print("<script>alert('你没有权限！');</script>");
                   PoPupHelper.adapter(out).iframereload();
                   PoPupHelper.adapter(out).showSucceed();
                   return;
                }
                
            
                entity.keyvalue("passworderrornum", 0);//设置密码输入错误次数为零
                entity.keyvalue("isdelegate",1 );
                //强制默认为乡镇代表
                entity.keyvalue("circleslist", 4 );

                entity.remove("account");
                if (userrole.select().where("account='" + entity.get("account") + "' and state=2").get_first_rows()) {
                    out.print("<script>console.log(('该代表登录账号已经注册过了！'));</script>");
                    out.print("<script>alert('该代表登录账号已经注册过了！');</script>");
                } else {
//                    if (entity3.select().where("code=" + entity.get("code") + "").get_first_rows()) {
//                        out.print("<script>alert('该代表编号已存在！');</script>");
//                        break;
//                    } else {
                    if (entity.get("account").isEmpty() && !entity.get("telphone").isEmpty()) {
                        out.print("<script>console.log('登录名为空，电话不为空！');</script>");
                        if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                            out.print("<script>alert('该手机号码已经注册过了！');</script>");
                            break;
                        } else {
                            matter.keyvalue("matter", entity2.get("matter"));
                            matter.append().submit();
                            entity.remove("matter");
                            entity.keyvalue("matterid", matter.autoid);
                            entity.timestamp();
                            entity.remove("account");
                            entity.remove("myid");
                            entity.remove("login");
                            if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                                user1.keyvalue("account", entity.get("telphone"));
                            } else {
                                entity.keyvalue("loginNameDw", entity.get("telphone"));
                                entity.keyvalue("account", entity.get("telphone"));
                                user1.keyvalue("account", entity.get("telphone"));
                                entity.keyvalue("pwd", Encrypt.Md532(entity.get("telphone") + entity.get("passwordNO")));
                            }
                        }
                    } else {
                        matter.keyvalue("matter", entity2.get("matter"));
                        matter.append().submit();
                        entity.remove("matter");
                        entity.keyvalue("matterid", matter.autoid);
                        entity.remove("account");
                        entity.remove("myid");
                        entity.remove("login");
                        if (entity3.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                            user1.keyvalue("account", entity.get("account"));
                        } else {
                            entity.keyvalue("loginNameDw", entity.get("account"));
                            entity.keyvalue("account", entity.get("account"));
                            user1.keyvalue("account", entity.get("account"));
                            entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
                        }
                    }

                    entity.timestamp();
                    user1.keyvalue("state", 2);
                    entity.keyvalue("powergroupid", 5);
                   
                    
                    
                    if (entity6.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                        if (entity6.get("rolelist").indexOf(",5,") != 1) {
                            entity.keyvalue("rolelist", entity6.get("rolelist") + ",5,");
                            if ( entity.get("rolelist").isEmpty() ) {
                            entity.keyvalue("rolelist", entity6.get("rolelist") );
                            }
                            else {
                            entity.keyvalue("rolelist", entity6.get("rolelist") + ",5");
                            }
                        }
                    } else {
                        //entity.keyvalue("rolelist", ",5,");
                        if ( entity.get("rolelist").isEmpty() ) {
                            entity.keyvalue("rolelist", "5");
                        }
                        else {
                            entity.keyvalue("rolelist", ",5");
                        }
                        
                    }
                    if (entity.get("account").isEmpty() && !entity.get("telphone").isEmpty()) {
                        if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                            entity.update().where("account=?", entity.get("telphone")).submit();
                        } else {
                            entity.append().submit();
                        }
                        user1.append().submit();
                    } else {
                        if (entity3.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                            entity.update().where("account=?", entity.get("account")).submit();
                        } else {
                            entity.append().submit();
                        }
                        user1.append().submit();
                    }
                    if (!Staff.select().where("myid=?", String.valueOf(entity.autoid)).get_first_rows()) {
                        Staff.keyvalue("myid", entity.autoid);
                        Staff.append().submit();
                    }
                    PoPupHelper.adapter(out).iframereload();
                    PoPupHelper.adapter(out).showSucceed();
//                    }
                }

//                if (!entity.get("telphone").isEmpty()) {
//                    if (userrole.select().where("role like '%3%' and state=2 and (account=" + entity.get("telphone") + " or account=" + entity.get("account") + ")").get_first_rows()) {
//                        if (entity.get("state").indexOf("2") != -1) {
//                            out.print("<script>alert('该账号已经注册过了！');</script>");
//                        } else {
//                            matter.keyvalue("matter", entity2.get("matter"));
//                            matter.append().submit();
//                            entity.remove("matter");
//                            entity.keyvalue("matterid", matter.autoid);
//                            entity.keyvalue("powergroupid", 3);
//                            entity.keyvalue("state", entity.get("state") + ",2");
//                            entity.update().where("myid=" + entity.get("myid")).submit();
//                        }
//                    } else {
//                        matter.keyvalue("matter", entity2.get("matter"));
//                        matter.append().submit();
//                        entity.timestamp();
//                        entity.remove("myid");
//                        entity.keyvalue("account", entity.get("account"));
//                        entity.keyvalue("powergroupid", 3);
//                        entity.keyvalue("rolelist", ",3,");
//                        user.keyvalue("account", entity.get("account"));
//                        user.keyvalue("role", 3);
//                        user.append().submit();
//                        entity.keyvalue("matterid", matter.autoid);
////                        entity.keyvalue("passwordNO", entity.get("pwd"));
//                        entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
//                        entity.remove("matter");
//                        entity.append().submit();
//                        Staff.keyvalue("myid", entity.autoid);
//                        Staff.append().submit();
//                        PoPupHelper.adapter(out).iframereload();
//                        PoPupHelper.adapter(out).showSucceed();
//                    }
//                } else {
//                    out.print("<script>alert('请填写手机号！');</script>");
//                }
                break;
            case "update":

//                if (!entity.get("pwd").isEmpty()) {
//                    entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
//                } else {
//                    entity.remove("pwd");
//                }
//                entity.remove("account");
//                matter.keyvalue("matter", entity2.get("matter"));
//                matter.append().submit();
//                entity.keyvalue("matterid", matter.autoid);
//                entity.remove("matter");
////                entity.keyvalue("passwordNO", entity.get("passwordNO"));
//                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
//                entity.update().where("myid=?", entity.get("relationid")).submit();
//                PoPupHelper.adapter(out).iframereload();
//                PoPupHelper.adapter(out).showSucceed();
//                if (entity3.select().where("code=" + entity.get("code") + " and myid <> " + entity.get("relationid") + "").get_first_rows()) {
//                    out.print("<script>alert('该代表证号已存在！');</script>");
//                    break;
//                } else {
                if("1".equals(entity.get("enabled"))){
                    entity.keyvalue("passworderrornum", 0);
                }
                if (entity3.select().where("account='" + entity.get("account") + "' and myid <> " + entity.get("relationid") + "").get_first_rows()) {
                    out.print("<script>alert('该登录账号已存在！');</script>");
                    break;
                } else {
                    entity.remove("myid");
                    user4.remove("n");

                    matter.keyvalue("matter", entity2.get("matter"));
                    matter.append().submit();

                    entity.keyvalue("matterid", matter.autoid);
                    entity.keyvalue("loginNameDw", entity.get("account"));
                    entity.keyvalue("passwordNO", entity.get("passwordNO"));
                    entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));

                    user4.keyvalue("account", entity.get("account"));
                    user4.update().where("account ='" + entity.get("login") + "'").submit();

                    entity.remove("login");
                    entity.update().where("myid=?", entity.get("relationid")).submit();

                    PoPupHelper.adapter(out).iframereload();
                    PoPupHelper.adapter(out).showSucceed();
                }
//                }
                break;
        }
    }
    entity2.select().where("myid=?", entity2.get("relationid")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>汝州市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="../css/swfupload.css" rel="stylesheet" type="text/css"/>
        <style>
            #headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            em{font-size: 12px;color: red;margin-left: 2px;}
            .w656{width: 649px;}
            /*.w656{width: 100%;}*/
            .borderred{border-color:red; }
            #abc{position: absolute;left: -10000px;}
            td>h1{text-align: center;margin: 20px;}
            .w254{width: 254px;}
            .w260{width: 260px;}
            .w258{width: 258px;}
            .checksel{height: 32px;}
            .checksel>p{min-height: 26px; border: solid 1px #cbcbcb;padding: 0 2px;border-radius: 3px;line-height: 26px;background: #fff;background:url("/css/limg/mnselect.png") no-repeat 245px 10px; }
            /*#sessionlist>p>span{display: block;}*/
            .checksel ul{position: relative;z-index: 9999;display: none;background: #fff;border: #cbcbcb solid 1px;}
            .checksel li{line-height: 32px;font-size: 12px;padding: 0 3px;}
            .popupwrap>div:first-child {
                height: 90%;
            }
        </style>
    </head>
    <body>
        <form id="abc" enctype="multipart/form-data" method="post">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form>  
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr><td>头像</td>
                        <td colspan="3" id="headimg">
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity2.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity2.get("avatar")); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity2.write("avatar");%>">
                        </td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">姓名<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w254" name="realname" value="<% entity2.write("realname"); %>" /></td>
<!--                        <td class="tr w100 ">代表证号</td>
                        <td><input type="text" maxlength="80" class="w254" name="code" value="<% entity2.write("code"); %>" /></td>-->
                        
                        <td class="tr w100 ">用户类别</td>
                         <td><select class="w260" name="isdelegate" dict-select="isdelegate" def="<% entity2.write("isdelegate"); %>"></select></td>
                        
                    </tr>
                    <tr>
                        <td class="tr w100 ">出生年月</td>
                        <!--<td><input type="text" class="w254 Wdate" name="birthday"  rssdate="<% out.print(entity2.get("birthday")); %>,yyyy-MM"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM'})" readonly="readonly"></td>-->
                        <td><input type="text" class="w254 Wdate" name="birthday"  rssdate="<% out.print(entity2.get("birthday")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>

                        <td class="tr w100 ">代表团<em class="red">*</em></td>
                        
                        <td><select name="mission" class="w260">
                                <%
                                    RssListView company = new RssListView(pageContext, "userrole");
                                    company.select().where("state like '%4%' order by daibiaotuanCode").query();
                                    out.print(company.sql);
                                    while (company.for_in_rows()) {
                                        if (entity2.get("mission").equals(company.get("myid"))) {
                                %>
                                <option selected="select" value="<% company.write("myid"); %>"><% company.write("allname"); %></option>
                                <%
                                } else {
                                %>
                                <option value="<% company.write("myid"); %>"><% company.write("allname"); %></option>
                                <%
                                        }
                                    }
                                %>
                            </select></td>                                       
                    </tr>
                    <tr>
                        <td class="tr w100 ">性别</td>
                        <td><select class="w260" name="sex" dict-select="sex" def="<% entity2.write("sex"); %>"></select></td>
                        <td class="tr w100 ">民族</td>
                        <td><select class="w260" name="nationid" dict-select="nationid" def="<% entity2.write("nationid"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">党派</td>
                        <!--  partytypeclassify改为partytype-->
                        <td><select class="w260" name="clan" dict-select="partytype" def="<% entity2.write("clan"); %>"></select></td>
                        
                        <td class="tr w100 ">职业</td>
                        <td><input type="text" maxlength="80" class="w254" name="profession" value="<% entity2.write("profession"); %>" /></td>
                        
                        <!--<td class="tr w100 ">层次<em class="red">*</em></td>-->
                        <!--<td><select type="text" maxlength="80" class="w200" name="level" dict-select="circles" def="<% entity2.write("level"); %>" ></select></td>-->
                        <!--<td><div class="checksel" id="circleslist"><p class="w254"></p><ul class="w258"></ul></div></td>-->
                    </tr>
                    <tr>
                        <td class="tr w100 ">学历</td>
                        <td><select class="w260" name="eduid" dict-select="eduid" def="<% entity2.write("eduid"); %>"></select></td>
                        <td class="tr w100 ">学位</td>
                        <td><select class="w260" name="degree" dict-select="degree" def="<% entity2.write("degree"); %>"></select></td>
                    </tr>
<!--                    <tr>
                        <td class="tr w100 ">职业</td>
                        <td><input type="text" maxlength="80" class="w254" name="profession" value="<% entity2.write("profession"); %>" /></td>
                        <td class="liucheng tr w100 ">人大主席团<em class="red">*</em></td>
                        <td class="liucheng"><select name="presidium" class="w260">
                                <%
                                    RssListView company1 = new RssListView(pageContext, "userrole");
                                    company.select().where("state like '%25%' order by daibiaotuanCode").query();
                                    out.print(company.sql);
                                    while (company.for_in_rows()) {
                                        if (entity2.get("presidium").equals(company.get("myid"))) {
                                %>
                                <option selected="select" value="<% company.write("myid"); %>"><% company.write("realname"); %></option>
                                <%
                                } else {
                                %>
                                <option value="<% company.write("myid"); %>"><% company.write("realname"); %></option>
                                <%
                                        }
                                    }
                                %>
                            </select></td>
                    </tr>-->
<!--                    <tr>
                        <td class="tr w100 ">职业：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w656" name="profession" value="<% entity2.write("profession"); %>" /></td>
                    </tr>-->
                    <tr>
                        <td class="tr w100 ">电子邮箱</td>
                        <td><input type="text" maxlength="80" class="w254" name="email" value="<% entity2.write("email"); %>" /></td>
                        <td class="tr w100 ">电话号码<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w254" name="telphone" value="<% entity2.write("telphone"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">登陆账号<em class="red">*</em></td>
                        <td><input class="w254" type="text" name="account" value="<% out.print(entity2.get("account")); %>" ><input type="hidden" maxlength="80" class="w200" name="login" value="<% entity2.write("account"); %>" /></td>
                        <td class="tr w100 ">登录密码<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w254" name="passwordNO" value="<% out.print(entity2.get("passwordNO")); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位名称</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w656" name="daibiaoDWname" value="<% entity2.write("daibiaoDWname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">职务</td>
                        <td colspan="3"><textarea maxlength="88" class="w656 h60" name="daibiaoDWjob"><% entity2.write("daibiaoDWjob"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">通讯地址</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w656" name="daibiaoDWaddress" value="<% entity2.write("daibiaoDWaddress"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位电话</td>
                        <td><input class="jynum w254" maxlength="80" name="daibiaoDWtel" value="<% entity2.write("daibiaoDWtel"); %>" /></td>
                        <td class="tr w100 ">邮编：</td>
                        <td><input class="w254" maxlength="80" name="daibiaoDWpostcode" value="<% entity2.write("daibiaoDWpostcode"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">状态</td>
                        <td><select class="w260" name="enabled" dict-select="enabled" def="<% entity2.write("enabled"); %>"></select></td>
                        <!--<td class="tr w100 ">有效届次<em class="red">*</em></td>-->
<!--                        <td><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity2.write("sessionid"); %>"></select></td>-->
                        <!--<td><div class="checksel" id="sessionlist"><p class="w254"></p><ul class="w258"></ul></div></td>-->
                    </tr>
                    <tr class="">
                        <td colspan="4" class="marginauto uetd">
                            <h1>代表简历</h1>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity2.write("matter"); %></script>
                        </td>
                    </tr>
                </table>
                <!--梁小竹注释，增加的一句增加代表的powergroupid = 5 ,说明是一个代表-->
                <input type="hidden" name="powergroupid" value="5" />
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity2.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity2.get("relationid").isEmpty() ? "增加" : "修改");%></button>
                <!--<input type="hidden" name="account" value="<% out.print(entity2.get("account"));%>">-->
                <input type="hidden" name="sessionlist" value="<% out.print(entity2.get("sessionlist"));%>">
                <input type="hidden" name="circleslist" value="<% out.print(entity2.get("circleslist"));%>">
            </div>
        </form>
        <script src="../data/partytype.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/staff.js"></script>
        <script src="/data/nationality.js"></script>
        <%@include  file="/inc/js.html" %>
        
        <!--
            添加开始
            修改人:梁小竹
            时间:2021.02.24
            说明:用于控制添加代表时的人大主席团选项的显示与不显示
        -->
        <script src="../liuChengSwitch.js"></script>
        <script>
            $(function(){
                if(liuchengflog === 2){
                    //如果是2，则议案建议流程不分开会闭会期间
//                    alert(liuchengflog);
                    $(".liucheng").remove();
                    
                }else{
                    //                    alert(liuchengflog);
                    //如果是1，则议案建议流程分开会闭会期间
                }
            });
        </script>
        
        <!--梁小竹修改结束-->
        
        
        <script>
//            var tel = '0551-5555555';
//            var r=/^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
//            alert(r.test(tel));

                            var imgresult = $("#divPreview>img").attr("src");
                            if (imgresult !== "/upfile/avatar.png") {
                                $("#upfiletype").text("已上传");
                            }
                            $(".footer>button").click(function () {
                                if ($("[name='birthday']").val() != undefined && $("[name='birthday']").val() != "") {
                                    var timestamp = new Date($("[name='birthday']").val());
                                    $("[name='birthday']").val(timestamp / 1000);
                                    console.log($("[name='birthday']").val());
                                }
//                                if ($("[name='code']").val() == undefined || $("[name='code']").val() == "") {
//                                    alert("请填写代表证号");
//                                    $("[name='code']").focus();
//                                    return false;
//                                }

                                if ($("[name='realname']").val() == undefined || $("[name='realname']").val() == "") {
                                    alert("请填写代表姓名");
                                    $("[name='realname']").focus();
                                    return false;
                                }
                                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
                                    alert("请填写电话号码");
                                    $("[name='telphone']").focus();
                                    return false;
                                } else {
                                    var str = $("[name='telphone']").val()
                                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
                                        alert("请填写正确的电话号码");
                                        $("[name='telphone']").focus();
                                        return false;
                                    }
                                }
                                if ($("[name='account']").val() == undefined || $("[name='account']").val() == "") {
                                    alert("登录账号未填写,默认电话号码为登录号");
                                    $("[name='account']").val($("[name='telphone']").val())
                                }
//                                if ($("[name='telphone']").val().length > 11) {
//                                    alert("手机号格式不正确");
//                                    $("[name='telphone']").focus();
//                                    return false;
//                                }
                                if ($("[name='action']").val() == "append" && $("[name='passwordNO']").val() == "") {
                                    alert("请填写密码");
                                    return false;
                                }
                                var tf = "0";
//                                var editdata = {"telphone": "手机号码", "worktel": "单位电话", "codepost": "单位邮编", "hometel": "家庭号码", "homecode": "家庭邮编"};
//                                var editdata = {"telphone": "手机号码", "codepost": "单位邮编", "hometel": "家庭号码", "homecode": "家庭邮编"};
//                                $(".jynum").each(function () {
//                                    var val = $(this).val();
//                                    var e = $(this).attr("name");
//                                    if (val) {
//                                        var patrn = /^[0-9]*$/;
//                                        if (!patrn.test(val)) {
//                                            alert('邮编应是纯数字');
//                                            $("[name='" + e + "']").focus();
//                                            tf = "1"
//                                        }
//                                    }
//                                })
                                if (tf == "1") {
                                    return false;
                                }
                                var circleslistval = ",", sessionlistval = ",";
                                var index = 0 ;
                                $("#circleslist p").find("span").each(function () {
                                    var sesid = $(this).attr("sesid");
                                    if ( index > 0 ) {
                                       circleslistval += ",";    
                                    }
                                    circleslistval += sesid;
                                    index ++ ;
                                    
                                    //circleslistval += sesid + ","
                                   // circleslistval = sesid ;
                                })
 
                                $("#sessionlist p").find("span").each(function () {
                                    var sesid = $(this).attr("sesid");
                                    //sessionlistval += sesid + ",";
                                    sessionlistval = sesid ;
                                })

//                                $("input[name='circleslist']").val($(".circles option:selected").val() + ",")
                                $("input[name='circleslist']").val(circleslistval)
                                $("input[name='sessionlist']").val(sessionlistval)
                            })

                            function PreviewImage(fileObj, imgPreviewId, divPreviewId) {
                                var allowExtention = ".jpg,.bmp,.gif,.png"; //�����ϴ��ļ��ĺ�׺��document.getElementById("hfAllowPicSuffix").value;
                                var extention = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();
                                var browserVersion = window.navigator.userAgent.toUpperCase();
                                if (allowExtention.indexOf(extention) > -1) {
                                    if (fileObj.files) {//HTML5ʵ��Ԥ��������chrome�����7+��
                                        if (window.FileReader) {
                                            var reader = new FileReader();
                                            reader.onload = function (e) {
                                                document.getElementById(imgPreviewId).setAttribute("src", e.target.result);
                                            }
                                            reader.readAsDataURL(fileObj.files[0]);
                                        } else if (browserVersion.indexOf("SAFARI") > -1) {
                                            alert("��֧��Safari6.0�����������ͼƬԤ��!");
                                        }
                                    } else if (browserVersion.indexOf("MSIE") > -1) {
                                        if (browserVersion.indexOf("MSIE 6") > -1) {//ie6
                                            document.getElementById(imgPreviewId).setAttribute("src", fileObj.value);
                                        } else {//ie[7-9]
                                            fileObj.select();
                                            if (browserVersion.indexOf("MSIE 9") > -1)
//                                                fileObj.blur(); //������document.selection.createRange().text��ie9��
                                                document.getElementById(divPreviewId).focus();
                                            fileObj.blur();
                                            var newPreview = document.getElementById(divPreviewId + "New");
                                            if (newPreview == null) {

                                                newPreview = document.createElement("div");
                                                newPreview.setAttribute("id", divPreviewId + "New");
                                                newPreview.style.border = "solid 1px #d2e2e2";
                                            }
                                            newPreview.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";
                                            var tempDivPreview = document.getElementById(divPreviewId);
                                            tempDivPreview.parentNode.insertBefore(newPreview, tempDivPreview);
                                            tempDivPreview.style.display = "none";
                                        }
                                    } else if (browserVersion.indexOf("FIREFOX") > -1) {//firefox
                                        var firefoxVersion = parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);
                                        if (firefoxVersion < 7) {//firefox7���°汾
                                            document.getElementById(imgPreviewId).setAttribute("src", fileObj.files[0].getAsDataURL());
                                        } else {//firefox7.0+                    
                                            document.getElementById(imgPreviewId).setAttribute("src", window.URL.createObjectURL(fileObj.files[0]));
                                        }
                                    } else {
                                        document.getElementById(imgPreviewId).setAttribute("src", fileObj.value);
                                    }
                                } else {
                                    alert("��֧��" + allowExtention + "Ϊ��׺�����ļ�!");
                                    fileObj.value = ""; //���ѡ���ļ�
                                    if (browserVersion.indexOf("MSIE") > -1) {
                                        fileObj.select();
                                        document.selection.clear();
                                    }
                                    fileObj.outerHTML = fileObj.outerHTML;
                                }
                            }
                            $("#submit").click(function () {
                                $("#abc").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        console.log(data)
                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $("#avatar").val(data.url);
                                        alert("上传成功");
                                        $("#upfiletype").text("(成功上传)")
                                    }});
                                return false;
                            })
                            $('#pbut').click(function () {
                                $("#submit").click();
                            })
                            $("#selbut").click(function () {
                                $("#file").click();
                            })
                            var sessionlist = $("input[name='sessionlist']").val().split(",");
                            $.each(dictdata["sessionclassify"], function (k, v) {
                                if (sessionlist.indexOf(k) != "-1") {
                                    $("#sessionlist p").append("<span sesid=" + k + ">" + v[0] + "<span>")
                                    $("#sessionlist ul").append('<li class="w254"><label><input checked="checked" sesid=' + k + ' type="checkbox" ><span>' + v[0] + '</span></label></li>')
                                } else {
                                    $("#sessionlist ul").append('<li class="w254"><label><input sesid=' + k + ' type="checkbox" ><span>' + v[0] + '</span></label></li>')
                                }
                            })
                            
                            var circleslist = $("input[name='circleslist']").val().split(",");
                            $.each(dictdata["circles"], function (k, v) {
                                if (circleslist.indexOf(k) != "-1") {
                                    $("#circleslist p").append("<span sesid=" + k + ">" + v + "</span>,")
                                    $("#circleslist ul").append('<li class="w254"><label><input checked="checked" sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
                                } else {
                                    $("#circleslist ul").append('<li class="w254"><label><input sesid=' + k + ' type="checkbox" ><span>' + v + '</span></label></li>')
                                }
                            })
                            checksel();
                            $(".popupwrap").click(function () {
                                $(".checksel").find("ul").hide();
                            })


        </script>
    </body>
</html>
