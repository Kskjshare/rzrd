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
    RssList entity = new RssList(pageContext, "user");
    RssList entity6 = new RssList(pageContext, "user");
    RssList entity2 = new RssList(pageContext, "user");
    RssList entity3 = new RssList(pageContext, "user");
    RssList user = new RssList(pageContext, "userrole");
    RssList user3 = new RssList(pageContext, "userrole");
    RssList user4 = new RssList(pageContext, "userrole");
    RssListView userrole = new RssListView(pageContext, "userrole");
    StaffList Staff = new StaffList(pageContext);
    entity.request();
   
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("passworderrornum", 0);//设置密码输入错误次数为零
                if (userrole.select().where("account='" + entity.get("loginNameDw") + "' and state like '%3%'").get_first_rows()) {
                    out.print("<script>console.log(('该单位登录账号已经注册过了！'));</script>");
                    out.print("<script>alert('该单位登录账号已经注册过了！');</script>");
                } else {
                    if (entity3.select().where("danweiCode=" + entity.get("danweiCode") + "").get_first_rows()) {
                        out.print("<script>alert('该单位编号已存在！');</script>");
                        break;
                    } else {
                        if (entity3.select().where("company='" + entity.get("company") + "'").get_first_rows()) {
                            out.print("<script>alert('该单位名称已存在！');</script>");
                            break;
                        } else {
                            if (entity.get("loginNameDw").isEmpty() && !entity.get("worktel").isEmpty()) {
                                out.print("<script>console.log('登录名为空，电话不为空！');</script>");
                                if (entity3.select().where("account='" + entity.get("worktel") + "'").get_first_rows()) {
                                    out.print("<script>alert('该单位电话已经注册过了！');</script>");
                                    break;
                                } else {
                                    entity.remove("account");
                                    entity.remove("myid");
                                    entity.remove("parentid");
                                    entity.remove("login");
                                    if (entity3.select().where("account='" + entity.get("worktel") + "'").get_first_rows()) {
                                        user.keyvalue("account", entity.get("worktel"));
                                    } else {
                                        entity.keyvalue("loginNameDw", entity.get("worktel"));
                                        entity.keyvalue("account", entity.get("worktel"));
                                        user.keyvalue("account", entity.get("worktel"));
                                        entity.keyvalue("pwd", Encrypt.Md532(entity.get("worktel") + entity.get("passwordNO")));
                                    }
                                }
                            } else {
                                entity.remove("account");
                                entity.remove("myid");
                                entity.remove("parentid");
                                entity.remove("login");
                                out.print("<script>console.log('登录名123！');</script>");
                                if (entity3.select().where("account='" + entity.get("loginNameDw") + "'").get_first_rows()) {
                                    user.keyvalue("account", entity.get("loginNameDw"));
                                } else {
                                    entity.keyvalue("loginNameDw", entity.get("loginNameDw"));
                                    entity.keyvalue("account", entity.get("loginNameDw"));
                                    user.keyvalue("account", entity.get("loginNameDw"));
                                    entity.keyvalue("pwd", Encrypt.Md532(entity.get("loginNameDw") + entity.get("passwordNO")));
                                }
                            }
                            entity.timestamp();
//                            entity.keyvalue("state", 3);
                            user.keyvalue("state", 3);

                            if (entity6.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                                if (entity6.get("rolelist").indexOf(",18,") != 1) {
                                    entity.keyvalue("rolelist", entity6.get("rolelist") + ",18,");
                                }
                            } else {
                                entity.keyvalue("rolelist", ",18,");
                            }

                            if (entity.get("loginNameDw").isEmpty() && !entity.get("worktel").isEmpty()) {
                                // 查找相同登录账号的行数
                                user4.select("count(*) as n").where("account='" + user.get("worktel") + "'").get_first_rows();
                                // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
                                if (Integer.parseInt(user4.get("n")) != 1) {
//                                    entity.keyvalue("powergroupid", 5);
                                    entity.keyvalue("powergroupid", 18);//  20/12/07修改：此处原本为设置值=5,现强行改为18（主办单位）
                                } else {
                                    entity.keyvalue("powergroupid", 18);
                                }

                                if (entity3.select().where("account='" + entity.get("worktel") + "'").get_first_rows()) {
                                    entity.update().where("account=?", entity.get("worktel")).submit();
                                } else {
                                    entity.append().submit();
                                }
                                user.append().submit();
                            } else {
                                user4.select("count(*) as n").where("account='" + user.get("account") + "'").get_first_rows();
                                // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
                                if (Integer.parseInt(user4.get("n")) != 1) {
//                                    entity.keyvalue("powergroupid", 5);
                                    entity.keyvalue("powergroupid", 18);//  20/12/07修改：此处原本为设置值=5,现强行改为18（主办单位）
                                } else {
                                    entity.keyvalue("powergroupid", 18);
                                }

                                if (entity3.select().where("account='" + entity.get("loginNameDw") + "'").get_first_rows()) {
                                    entity.update().where("account=?", entity.get("loginNameDw")).submit();
                                } else {
                                    entity.append().submit();
                                }
                                user.append().submit();
                            }
                            if (!Staff.select().where("myid=?", String.valueOf(entity.autoid)).get_first_rows()) {
                                Staff.keyvalue("myid", entity.autoid);
                                Staff.append().submit();
                            }
                            if (!(entity.get("relationid").isEmpty())) {
                                entity2.keyvalue("parentid", entity.get("relationid"));
                                entity2.update().where("myid in (" + entity.get("parentid") + ")").submit();
                            }
                            PoPupHelper.adapter(out).iframereload();
                            PoPupHelper.adapter(out).showSucceed();
                        }
                    }
                }
                break;
            case "update":
                if("1".equals(entity.get("enabled"))){
                    entity.keyvalue("passworderrornum", 0);
                }
                entity.remove("myid");
                if (entity3.select().where("danweiCode=" + entity.get("danweiCode") + " and myid<>" + entity.get("relationid") + "").get_first_rows()) {
                    out.print("<script>alert('该单位编号已存在！');</script>");
                    break;
                } else {
                    if (entity3.select().where("account='" + entity.get("loginNameDw") + "' and myid <> " + entity.get("relationid") + "").get_first_rows()) {
                        out.print("<script>alert('该登录账号已存在！');</script>");
                        break;
                    } else {
                        if (entity3.select().where("company='" + entity.get("company") + "' and myid <> " + entity.get("relationid") + "").get_first_rows()) {
                            out.print("<script>alert('该单位名称已存在！');</script>");
                            break;
                        } else {
                            entity.remove("account");
                            user4.remove("n");
                            entity.remove("parentid");
                            entity.keyvalue("loginNameDw", entity.get("loginNameDw"));
                            entity.keyvalue("account", entity.get("loginNameDw"));
                            entity.keyvalue("pwd", Encrypt.Md532(entity.get("loginNameDw") + entity.get("passwordNO")));

                            user4.keyvalue("account", entity.get("loginNameDw"));
                            user4.update().where("account ='" + entity.get("login") + "'").submit();

                            entity.remove("login");
                            entity.update().where("myid=?", entity.get("relationid")).submit();

                            entity2.keyvalue("parentid", 0);
                            entity2.update().where("parentid=" + entity.get("relationid")).submit();
                            entity2.keyvalue("parentid", entity.get("relationid"));
                            if (!(entity.get("parentid").isEmpty())) {
                                entity2.update().where("myid in (" + entity.get("parentid") + ")").submit();
                            }
                            PoPupHelper.adapter(out).iframereload();
                            PoPupHelper.adapter(out).showSucceed();
                        }
                    }
                }
                break;
        }
    }
    entity.select().where("myid=?", entity.get("relationid")).get_first_rows();
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
            #section{width:90%;margin: 10px auto;border: #ccc solid thin;text-align: center; }
            #section tr>th{padding: 5px 0; }
            #middletitle{font-weight: 600; padding-left: 40px;margin-top: 20px;font-size: 14px;}
            #middletitle>span{margin-left: 16px;font-size: 12px;cursor: pointer;}
            .red{font-size: 12px;color: red;margin-left: 2px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr>
                        <td class="tr w100 ">单位编号<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="danweiCode" value="<% entity.write("danweiCode"); %>" /></td>
                        <td class="tr wp100 ">单位类别</td>
                        <td><select class="w206" name="comtype" dict-select="companytypeclassify" def="<% entity.write("comtype"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位名称<em class="red">*</em></td>
                        <td colspan="3">
                        <input type="text"  placeholder="请输入单位名称" maxlength="80" class="w640" name="company" value="<% entity.write("company"); %>" />
                        <!--zyx增加 onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'')" placeholder="请输入单位名称"   用于只可输入汉字，解决增加单位后由于是英文或拼音没有显示的问题-->
                        </td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位地址</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w640" name="workaddress" value="<% entity.write("workaddress"); %>" /></td>
                    </tr>

	    <tr>
                        <td class="tr w100 ">单位邮编</td>
                         <td><input type="text" maxlength="80" class="w200" name="postcode" value="<% entity.write("postcode"); %>" /></td>
                        <td class="tr w100 ">电子邮箱</td>
                        <td><input type="text" maxlength="80" class="w200" name="email" value="<% entity.write("email"); %>" /></td>
                    </tr>

                    <tr>
                        <td class="tr w100 ">联系人</td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="linkman" value="<% entity.write("linkman"); %>" /></td>
                        <td class="tr w100 ">单位电话<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="worktel" value="<% entity.write("worktel"); %>" /></td>
                    </tr>

                    <tr>
                        <td class="tr w120 ">分管负责人<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w200" name="firstperson" value="<% entity.write("firstperson"); %>" /></td>
                        
                        <td class="tr w120 ">分管人职务<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w200" name="firstpost" value="<% entity.write("firstpost"); %>" /></td>
        
	<!--
	       <td class="tr w120 ">分管人电话：<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w100" name="firstphone" value="<% entity.write("firstphone"); %>" /></td>
        
	        
	        <td class="tr w100 ">单位邮编：</td>
                        <td><input type="text" maxlength="80" class="w80" name="postcode" value="<% entity.write("postcode"); %>" /></td>
	        -->
                    </tr>
 	<tr>
	       <td class="tr w120 ">分管人电话<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w200" name="firstphone" value="<% entity.write("firstphone"); %>" /></td>
   
                    </tr>


 	  <tr>
                        <td class="tr w120 ">承办人<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w200" name="secondperson" value="<% entity.write("secondphone"); %>" /></td>
                        
                        <td class="tr w100 ">承办人职务<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="60" class="w200" name="secondpost" value="<% entity.write("secondpost"); %>" /></td>
                    </tr>

            <tr>    
	       <td class="tr w100 ">承办人电话<em class="red">*</em></td>
                       <td class="backdce"><input type="text" maxlength="60" class="w200" name="secondphone" value="<% entity.write("secondphone"); %>" /></td>
                    </tr>




                    <tr>
                        <td class="tr w100 ">登录名<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="w200" name="loginNameDw" value="<% entity.write("loginNameDw"); %>" />
                            <input type="hidden" maxlength="80" class="w200" name="login" value="<% entity.write("loginNameDw"); %>" style="display: none;" />
                        </td>
                        <td class="tr w100 ">登录密码<em class="red">*</em></td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="passwordNO" value="<% entity.write("passwordNO"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位管理员</td>
                        <td><input type="text" maxlength="80" class="w200" name="dwadmin" value="<% entity.write("dwadmin"); %>" /></td>
                       <!-- 
	       <td class="tr w100 ">电子邮箱：</td>
                        <td><input type="text" maxlength="80" class="w200" name="email" value="<% entity.write("email"); %>" /></td>
	        -->
                        <td class="tr w100 ">状态</td>
                        <td><select class="w200" name="enabled" dict-select="enabled" def="<% entity.write("enabled"); %>"></select></td>
                    </tr>
                </table>
                <div id="middletitle" powerid="191">单位联系人员<span>添加</span><span>移出</span></div>
                <table id="section" powerid="191">
                    <tr><th class="w30"><input type="checkbox"></th><th>编号</th><th>姓名</th><th>性别</th><th>职务</th><th>电话</th><th>出生年月</th></tr>
                            <%
                                if (!entity.get("relationid").isEmpty()) {
                                    entity2.select().where("parentid=" + entity.get("relationid")).get_page_desc("myid");
                                    while (entity2.for_in_rows()) {
                            %>
                    <tr><td><input type="checkbox"  rid="<% out.print(entity2.get("myid"));%>"></td><td><% out.print(entity2.get("lianxirenCode"));%></td><td><% out.print(entity2.get("realname"));%></td><td sex="<% out.print(entity2.get("sex"));%>"></td><td><% out.print(entity2.get("job"));%></td><td><% out.print(entity2.get("telphone"));%></td><td rssdate="<% out.print(entity2.get("birthday")); %>,yyyy-MM"></td></tr>

                    <%
                            };
                        }
                    %>

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("relationid").isEmpty() ? "增加" : "修改");%></button>
                <input type="hidden" name="account" value="<% out.print(entity.get("account"));%>">
                <input type="hidden" name="parentid" value="<% out.print(entity.get("parentid"));%>">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script>

            $(".footer>button").click(function () {
                if ($("[name='danweiCode']").val() == undefined || $("[name='danweiCode']").val() == "") {
                    alert("请填写单位编号");
                    $("[name='danweiCode']").focus();
                    return false;
                }


                if ($("[name='worktel']").val() == undefined || $("[name='worktel']").val() == "") {
                    alert("请填写单位电话");
                    $("[name='worktel']").focus();
                    return false;
                } else {
                    var str = $("[name='worktel']").val()
//                    if (!str.match(/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/)) {
                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
                        alert("请填写正确的手机号");
                        return false;
                    }
                }
                if ($("[name='worktel']").val().length > 11) {
                    alert("手机号格式不正确");
                    $("[name='worktel']").focus();
                    return false;
                }


            if ($("[name='danweiCode']").val() == undefined || $("[name='loginNameDw']").val() == "") {
                    alert("请填写登录名");
                    $("[name='loginNameDw']").focus();
                    return false;
                }

                if ($("[name='action']").val() == "append" && $("[name='passwordNO']").val() == "") {
                    alert("请填写密码");
                    $("[name='passwordNO']").focus();
                    return false;
                }

	  if ($("[name='action']").val() == "append" && $("[name='firstperson']").val() == "") {
                    alert("请填写分管负责人姓名");
                    $("[name='firstperson']").focus();
                    return false;
                }
               if ($("[name='action']").val() == "append" && $("[name='firstpost']").val() == "") {
                    alert("请填写分管负责人职位");
                    $("[name='firstpost']").focus();
                    return false;
                }
              if ($("[name='action']").val() == "append" && $("[name='firstphone']").val() == "") {
                    alert("请填写分管负责人电话");
                    $("[name='firstphone']").focus();
                    return false;
                }
	else {
                    var str = $("[name='firstphone']").val()
                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
                        alert("请填写分管负责人正确的电话号码");
                        return false;
                    }
                }
                if ($("[name='firstphone']").val().length > 11) {
                    alert("分管负责人手机号格式不正确");
                    $("[name='firstphone']").focus();
                    return false;
                }


          if ($("[name='action']").val() == "append" && $("[name='secondperson']").val() == "") {
                    alert("请填写承办人姓名");
                    $("[name='secondperson']").focus();
                    return false;
                }
               if ($("[name='action']").val() == "append" && $("[name='secondpost']").val() == "") {
                    alert("请填写承办人的职位");
                    $("[name='secondpost']").focus();
                    return false;
                }
              if ($("[name='action']").val() == "append" && $("[name='secondphone']").val() == "") {
                    alert("请填写承办人的电话");
                    $("[name='secondphone']").focus();
                    return false;
                }
	else {
                    var str = $("[name='secondphone']").val()
                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
                        alert("请填写承办人正确的电话号码");
                        return false;
                    }
                }
                if ($("[name='secondphone']").val().length > 11) {
                    alert("承办人手机号格式不正确");
                    $("[name='secondphone']").focus();
                    return false;
                }



                var ridarry = [], parentid = "";
                $("#section td>input").each(function () {
                    ridarry.push($(this).attr("rid"));
                })
                parentid = ridarry.join(",");
                $("input[name='parentid']").val(parentid);
            })
            $('#middletitle>span').eq(0).off("click").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("input[rid='" + v.myid + "']").length == "0") {
                            var shijian = "";
                            if (v.birthday) {
                                shijian = new Date(v.birthday * 1000).toString("yyyy-MM")
                            }
                            $("#section").append('<tr><td><input type="checkbox" rid=' + v.myid + '></td><td>' + v.lianxirenCode + '</td><td>' + v.realname + '</td><td>' + dictdata["sex"][v.sex] + '</td><td>' + v.job + '</td><td>' + v.telphone + '</td><td>' + shijian + '</td></tr>')
                        }
                    })
                }
                RssWin.open("/selectwin/selcompanyuser.jsp", 700, 650);
            });
            $('#middletitle>span').eq(1).off("click").click(function () {
                $("#section td input:checked").parent().parent().remove();
            })
            $("#section th>input").change(function () {
                if ($(this).is(":checked")) {
                    $("#section td>input").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $("#section td>input").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })

        </script>
    </body>
</html>