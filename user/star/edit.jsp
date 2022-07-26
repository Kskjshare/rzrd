<%@page import="RssEasy.MySql.Store.StoreList"%>
<%@page import="RssEasy.MySql.Service.ServiceList"%>
<%@page import="RssEasy.Core.Validated"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="Model.Trans.UserTransList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    UserList entity = new UserList(pageContext);
    UserTransList stat = new UserTransList(pageContext);
    if (!req.get("action").isEmpty()) {
        Validated validated = new Validated(req);
        int age = 20;
        if (!req.get("birthday").isEmpty()) {
            age = DateTimeExtend.getAge(req.get("birthday"));
            entity.keyvalue("birthday", DateTimeExtend.timestamp(req.get("birthday") + " 00:00:00")).keyvalue("age", age);
        }

        entity.keyvalue("account", req.get("account")).keyvalue("realname", req.get("realname")).keyvalue("sex", req.get("sex")).keyvalue("account", req.get("account")).keyvalue("classifyid", req.get("classifyid")).keyvalue("avatar", req.get("avatar")).keyvalue("videourl", req.get("videourl")).keyvalue("schoolid", req.get("schoolid")).keyvalue("zhuyaojinli", req.get("zhuyaojinli")).keyvalue("zhuyaochengjiu", req.get("zhuyaochengjiu")).keyvalue("shiyongshuoming", req.get("shiyongshuoming")).keyvalue("videoposter", req.get("videoposter")).keyvalue("nationalityid", req.get("nationalityid")).keyvalue("nationid", req.get("nationid"));

        stat.keyvalue("liutongshijian", req.get("liutongshijian"));
        switch (req.get("action")) {
            case "append":
                entity.keyvalue("pwd", Encrypt.Md532(req.get("account") + "123456789")).timestamp();
                entity.append().submit();

                stat.keyvalue("myid", entity.autoid).keyvalue("code", req.get("code")).keyvalue("shengyushijian", req.get("liutongshijian")).keyvalue("faxingjia", req.get("faxingjia")).keyvalue("zuigaojia", req.get("faxingjia")).keyvalue("zuidijia", req.get("faxingjia")).keyvalue("zuixinjia", req.get("faxingjia")).keyvalue("junjia", req.get("faxingjia")).keyvalue("kaipanjia", req.get("faxingjia")).keyvalue("shoupanjia", req.get("faxingjia")).keyvalue("dieting", Double.parseDouble(req.get("faxingjia")) * 1.1).keyvalue("zhangting", Double.parseDouble(req.get("faxingjia")) * 0.9);
                stat.append().submit();

                UserTransList.shenjia(this.getServletContext(), stat.get("myid"), Double.parseDouble(req.get("faxingjia")));

                StoreList store = new StoreList(pageContext);
                store.keyvalue("myid", entity.autoid);
                store.append().submit();

                ServiceList sl = new ServiceList(pageContext);
                sl.keyvalue("storeid", store.autoid);
                sl.append().submit();
                break;
            case "update":
                entity.update().where("myid=?", req.get("myid")).submit();
                stat.update().where("myid=?", req.get("myid")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.keyvalue("sex", "1");
    entity.select().where("myid=?", req.get("myid")).get_first_rows();
    stat.select().where("myid=?", req.get("myid")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w80">类别：</td>
                        <td dict-radio="userclassify" dict-name="classifyid" def="<% out.print(entity.get("classifyid")); %>" colspan="3"></td>
                    </tr>
                    <tr>
                        <td class="tr">头像：</td>
                        <td>
                            <div class="imgupload">
                                <ul id="icourlwrap" class="swfuploadwrap square w120">
                                    <li><div class="swfuploadimg"><div><img src="/upfile/<% out.print(entity.get("avatar")); %>"></div></div></li>
                                </ul>
                                <div>
                                    <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                    <br/>
                                </div>
                            </div>
                            <input type="hidden" name="avatar" id="avatar" value="<% out.print(entity.get("avatar")); %>">
                            <label>建议尺寸：120px*120px</label>
                        </td>
                        <td class="tr w80">视频：</td>
                        <td>
                            <div class="imgupload">
                                <ul id="videourlwrap" class="swfuploadwrap square w120">
                                    <li><div class="swfuploadimg"><div><img src="/img/soft/mp4.png"></div></div></li>
                                </ul>
                                <div>
                                    <span swfupload="videourlswf" config="{multimode:0,fileType: [['视频(*.mp4)','*.mp4']]}"></span>
                                    <br/>
                                </div>
                            </div>
                            <input type="hidden" name="videourl" id="videourl" value="<% out.print(entity.get("videourl")); %>">
                            <label>宽度：320px*240px</label>
                        </td>
                    </tr>                    
                    <tr>
                        <td class="tr">国籍名族：</td>
                        <td selectcascade="nationalityid" dict-val="<% out.print(entity.get("nationalityid") + "," + entity.get("nationid")); %>" dict-name="nationalityid,nationid"></td>
                        <td class="tr">视频封面：</td>
                        <td>
                            <div class="imgupload">
                                <ul id="posterwrap" class="swfuploadwrap">
                                    <li><div class="swfuploadimg"><div><img src="/upfile/<% out.print(entity.get("videoposter")); %>"></div></div></li>
                                </ul>
                                <div>
                                    <span swfupload="posterswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                    <br/>
                                </div>
                            </div>
                            <input type="hidden" name="videoposter" id="videoposter" value="<% out.print(entity.get("videoposter")); %>">
                            <label>宽度：320px*240px</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">说明 ：</td>
                        <td colspan="3">
                            明星基本资料必填，以下资料增加后不可修改（代码、姓名、出生日期、发行价、流通秒数）
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">代码：</td>
                        <td><input type="text" name="code" maxlength="6" disedit class="w80" value="<% out.print(stat.get("code")); %>"/></td>
                        <td class="tr">手机号：</td>
                        <td><input type="text" name="account" maxlength="11" value="<% out.print(entity.get("account")); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr">姓名：</td>
                        <td><input type="text" name="realname" disedit class="w80" value="<% out.print(entity.get("realname")); %>"/></td>
                        <td class="tr">性别：</td>
                        <td dict-radio="sex" def="<% out.print(entity.get("sex")); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">出生日期：</td>
                        <td><input type="text" name="birthday" disedit class="w80" calendar="" rssdate="<% out.print(entity.get("birthday")); %>,yyyy-MM-dd"/></td>
                        <td class="tr">流通秒数：</td>
                        <td><input type="text" name="liutongshijian" disedit class="w80" value="<% out.print(stat.get("liutongshijian")); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr">发行价：</td>
                        <td><input type="text" name="faxingjia" disedit class="w80" value="<% out.print(stat.get("faxingjia")); %>"/></td>
                        <td class="tr">毕业院校：</td>
                        <td><input type="text" name="schoolid" disedit class="w80" value="<% out.print(entity.get("schoolid")); %>"/></td>
                    </tr>
                    <tr>
                        <td class="tr">主要经历：</td>
                        <td colspan="3"><script ueditor="toolbars: [],initialFrameHeight:100" id="zhuyaojinli" name="zhuyaojinli" class="w500" type="text/plain"><% entity.write("zhuyaojinli"); %></script></td>
                    </tr>
                    <tr>
                        <td class="tr">主要成就：</td>
                        <td colspan="3"><script ueditor="toolbars: [],initialFrameHeight:100" id="zhuyaochengjiu" name="zhuyaochengjiu" class="w500" type="text/plain"><% entity.write("zhuyaochengjiu"); %></script></td>
                    </tr>
                    <tr>
                        <td class="tr">使用说明：</td>
                        <td colspan="3"><script ueditor="toolbars: [],initialFrameHeight:100" id="shiyongshuoming" name="shiyongshuoming" class="w500" type="text/plain"><% entity.write("shiyongshuoming"); %></script></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(req.get("myid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(req.get("myid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/user.js" type="text/javascript"></script>
        <script src="/data/nationality.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="upload.js" type="text/javascript"></script>
    </body>
</html>
