<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>

<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
   StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "supervision_topic");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    RssList user1 = new RssList(pageContext, "user");
    user1.select().where("myid = " + cookie.Get("myid")).get_first_rows();
    String presidium = user1.get("presidium");
    entity.keyvalue("xzscID", presidium);

    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid","objid");
                entity.update().where("id=?", entity.get("relationid")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
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
            .cellbor td{padding: 0 6px;font-size: 12px;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 770px}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            #edui2{width: 100%;line-height: 14px}
            .popupwrap>div:first-child{width: 800px;margin: 0 auto; margin-bottom: 50px; height: auto;}
            .fileeform{position: absolute;left: -10000px;}
            .cellbor td>span{cursor: pointer;}
            #suggesttype{text-align: left;margin-top: 5px;}
            #suggesttype>select{margin: -5px 5px 0;}
            .popupwrap{overflow: auto}
            .popupwrap table td>b{cursor: pointer;}
            .popupwrap>div>h1{text-align: center; margin: 10px 0 20px 0;}
            .popupwrap table td>.lxrlist>input{width: 100px;margin: 0 10px;}
            .popupwrap table td>label{margin: 0 3px;}
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}/*虎鹏明*/
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer}
            /*.popupwrap .footer>button{ font-size: 99px;}*/
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .popupwrap>.footer{top: auto;bottom: 0;right: 24px;border-top: solid 1px #e6e6e6; padding-top: 5px;position: fixed;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .w498{width: 99%;}
            #suggesttype{
                font-size: 16px;
                font-family: 微软雅黑;
            }
            .w98{width: 97%;}
            .meetingtime{color: red}
 /*撑下边按钮*/
            .chengyemian{
               
                height: 50px;
            }
            .selectscr22{
                color: blue;
            }
        </style>
    </head>
    <body>
        <form id="fileeform1" class="fileeform"enctype="multipart/form-data" method="post">
            <input type="file" id="file1" ridform="1" accept=".pdf"  name="file1" multiple>
        </form>
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap"> 

            <div>
                <!--div id="suggesttype">类&nbsp;&nbsp;别：<select style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                        <option value="1" style="font-size:16px;font-family: 微软雅黑">视察调研</option>
                        <option value="2" style="font-size:16px;font-family: 微软雅黑">执法检查</option>
                        <option value="3" style="font-size:16px;font-family: 微软雅黑">听取和审议专项工作报告</option>
                        <option value="4" style="font-size:16px;font-family: 微软雅黑">质询和询问</option>
                        <option value="5" style="font-size:16px;font-family: 微软雅黑">质询和特定问题调查</option>
                        <option value="6" style="font-size:16px;font-family: 微软雅黑">工作评议</option>
                        <option value="7" style="font-size:16px;font-family: 微软雅黑">规范性文件备案审查</option>
                         <option value="8" style="font-size:16px;font-family: 微软雅黑">工作评议</option>
                    </select>
                </div-->
              
                <h1 style="font-size:22px;font-family: 微软雅黑">定制视察调研方案</h1>
                <table class="wp100 cellbor">
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <!--
                    <tr>
                        <td style="font-size:16px;font-family: 微软雅黑" >届次<em class="red">*</em>
                        </td>
                        <td colspan="2" style="font-size:16px">
                            <select style="font-size:16px;font-family: 微软雅黑" class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>">
                            </select>
                        </td>
                        <td style="width:100%;font-size:16px;font-family: 微软雅黑">会议次数<em class="red">*</em></td>
                        <td colspan="2" style="font-size:16px;font-family: 微软雅黑">
                            <select style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80" 
                                    class="w260" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" >
                            </select>
                        </td>
                    </tr>
                    
                    -->
                    
                    
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">方案类别<em class="red">*</em></td>
                        
                        <td colspan="2">
                            <div id="suggesttype">
                        <select style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                        <option value="1" style="font-size:16px;font-family: 微软雅黑">视察调研</option>
                        <option value="2" style="font-size:16px;font-family: 微软雅黑">执法检查</option>
                        <option value="3" style="font-size:16px;font-family: 微软雅黑">听取和审议专项工作报告</option>
                        <option value="4" style="font-size:16px;font-family: 微软雅黑">质询和询问</option>
                        <option value="5" style="font-size:16px;font-family: 微软雅黑">质询和特定问题调查</option>
                        <option value="6" style="font-size:16px;font-family: 微软雅黑">工作评议</option>
                        <option value="7" style="font-size:16px;font-family: 微软雅黑">规范性文件备案审查</option>
                    </select>
                </div>
                        </td>
                        
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">视察调研类别<em class="red">*</em></td>           
                        <td colspan="5" selradio>
                             <select style="width:200px;font-size:16px" value="<% entity.write("name"); %>" name="reviewclass"> 
                                <%
                                    
                                      HttpRequestHelper req1 = new HttpRequestHelper(pageContext).request();
                                     entity1.select().where("name like '%" + 
                                            URLDecoder.decode(req1.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                   // int a=1;
                                         while (entity1.for_in_rows()) {
                                %>
                                <option><% entity1.write("name"); %></option>
                                <%
                                  ;
                                }
                                %>
                            </select>
                            
                            
                        </td>
                        
  
                    </tr>
                    
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">方案定制单位<em class="red">*</em></td>
                        <td  colspan="5" style="font-size:16px;font-family: 微软雅黑"> <% user.write("realname"); %></td>        
                    </tr>                             
                  <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">方案文件</td>
                        <td colspan="5">
                            <div><span id="fjfile1" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span><input type="hidden" id="enclosure1" ></div>
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑">点击选择文件</span><input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑">点击选择文件</span><input type="hidden" id="enclosure3" ></div>
                        </td>
                    </tr>
                     <tr>
                     <td class="dce" style="font-size:16px;font-family: 微软雅黑" >视察调研时间<em class="red">*</em>
                        </td>
                        <td colspan="2" style="font-size:16px">
                            <input type="text" class="w200 Wdate" name="inspectTime"  rssdate="<% out.print(entity.get("inspectTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                        
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑" >审定时间<em class="red">*</em>
                        </td>
                        <td colspan="2" style="font-size:16px">
                           <input type="text" class="w200 Wdate" name="auditTime"  rssdate="<% out.print(entity.get("auditTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    
                    
                    
                    
                    <tr>
                        <td class="dce"><b class="selectuser" style="color:blue;font-size:16px;font-family: 微软雅黑">添参加视察调研人<em class="red">*</em></b></td>
                        <td colspan="5"><ul style="font-size:16px;font-family: 微软雅黑" id="blfyr" class="lianmingren">
                                <li>
                                    <em  style='display: inline;font-size:16px;width: 65.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;font-family: 微软雅黑'>
                                         参加视察调研人姓名                                    </em>
<!--                                    <em style='display: inline;width: 33%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;联系电话
                                    </em>-->
                                    
                                    <!--
                                    <em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;通讯地址
                                    </em>
                                    <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;代表证号码</em>
                                     <em >操作</em>
                                    -->
                                   
                                    <em style='display: inline;font-size:16px;font-family: 微软雅黑;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;操作
                                    </em>
                                </li>
                                <!--    <%/*
                                        if (!entity.get("id").isEmpty()) {
                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                            while (secondlist.for_in_rows()) {
                                    */%>
                                <li  myid='<%// out.print(secondlist.get("userid"));%>'>
                                    <%// out.print(secondlist.get("realname"));%><em class='red'>删除</em></li>
                                    <%
//                                            }
  //                                      }
                                    %>
                                -->
                            </ul></td>

                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr class="">
                        <td class="dce" colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                    

                </table>

<div class="chengyemian ">
                        
                    </div>

            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <%
                    if (!(cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16"))) {
                %>
                <input type="hidden" name="level">
                <%
                    }
                %>
                <input name="year" type="hidden">
                <input name="ProposedBill" type="hidden">
                <!--input name="draft" type="hidden"-->
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            //单选多选赋值
            var json = {};
            json.reviewopinion =<% out.print(entity.get("reviewopinion"));%>
            json.permission =<% out.print(entity.get("permission"));%>
            json.sugformation =<% out.print(entity.get("sugformation"));%>
            json.sugyears =<% out.print(entity.get("sugyears"));%>
            json.communicate =<% out.print(entity.get("communicate"));%>
            json.written =<% out.print(entity.get("written"));%>
            json.handle =<% out.print(entity.get("handle"));%>
            $.each(json, function (k, v) {
                $("input[name='" + k + "']").val(v);
                if (k == "written" || k == "communicate") {
                    if (v == "1") {
                        $("input[name='" + k + "']").parent().find("input").eq(0).click();
                    }
                } else {
                    var ind = parseInt(v) - 1
                    console.log(v + "+" + ind)
                    $("input[name='" + k + "']").parent().find("label").eq(ind).click();
                }
            })
            //办理单位,联系人,联名人赋值


//<!--  removed by ding for ruzhou's project  ----> 
            $(".footer>button").click(function () {
               

                //梁小竹修改
                if($(".shencha").length > 0){
                    if($("#jyscr>li").length <= 0){
//                        alert("请选择审查人员");
  //////                  let text = "请选择审查人员";
 //////                   popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                    popuplayer.display( window.location.href='/showalert.jsp?text ='+encodeURI(encodeURI(text)), '提示', {width: 300, height: 100});
                  //////      return false;
                    }
                }
       
                /*
                 * 梁小竹修改
                 * 修复联名人可以多次添加同一个人并提交的bug
                 * @type Date
                 */
                var mid = new Map();
                //做一个标志位，循环里面return false没有用，要在外面return false才不会提交
                var flog = 0;
                //选中所有的多选框
                $("#blfyr>li").each(function () {
//                    alert("1");
                    let lii = $(this);
                    let val = lii.attr("myid");
                    if(mid.get(val)){  
//                        说明联名人有重复
//                        alert("有");
//let text = "有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        flog = 1;
                        lii.remove();
//                        return false;
                    }else{
//                        说明联名人没有重复
//                        alert("没有");
//let text = "没有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        mid.set(val,1);
                    }
                });
                if(flog === 1){
//                    alert("建议联名人有重复，已为您自动删除重复人员，请查看无误后再次提交");
                    let text = "建议附议人有重复，已为您自动删除重复人员，请查看无误后再次提交";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    return false;
                }
                /*
                 * 梁小竹修改结束
                 */
                
                
                var date = new Date;
                var year = date.getFullYear();
                var mydate = year.toString();
                console.log(mydate);
                $('[name=year]').val(mydate);

                var timestamp = Date.parse(new Date());
                console.log(timestamp / 1000);
                $('[name=ProposedBill]').val(timestamp / 1000);
                
                  $('[name=inspectTime]').val(timestamp / 1000);
                  $('[name=auditTime]').val(timestamp / 1000);
                
                
//                $('[name=draft]').val("2");
//                alert($('[name=draft]').val());
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
                    let text = "请填写完整数据";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        return false;
                    }
                })
                console.log($("#suggesttype select").val());

                if ($("#level option:selected").attr("circles") == 2) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 1)
                } else if ($("#level option:selected").attr("circles") == 3) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 2)
                } else if ($("#level option:selected").attr("circles") == 4) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 3)
                } else 
                {
                    $("input[name='level']").val($("#level option:selected").attr("circles"))
                }
                if ($("#suggesttype select").val() == 2) {//如果选的类型为议案
                    if ($("#blfyr>li").length < 11) {//因为列名也占了一行
//                        alert("议案的联名人数得大于等于10人");
                    let text = "议案的附议人数得大于等于10人";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        return false;
                    }
                }

                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
//                    alert("请填写建议标题");
                    let text = "请填写标题";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='title']").focus();
                    return false;
                }
                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
//                    alert("请填写内容");
                    let text = "请填写内容";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='matter']").focus();
                    return false;
                }
                var secound = [], secoundsp = "", contacts = [], contactsp = "", usercomp = [], usercompsp = "", scr = [], scrsp = "";
                $("#blfyr>li").each(function () {
                    secound.push($(this).attr("myid"));
                })
                $("#jylxr>li").each(function () {
                    contacts.push($(this).attr("myid"));
                })
                $("#bldw>li").each(function () {
                    usercomp.push($(this).attr("myid"));
                })
                scr.push($("#scrid").attr("myid"));
                secoundsp = secound.join(",");
                contactsp = contacts.join(",");
                usercompsp = usercomp.join(",");
                scrsp = scr.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='contacts']").val(contactsp);
                $("input[name='usercomp']").val(usercompsp);
                $("input[name='scr']").val(scrsp);
                $("input[name='numpeople']").val($("#blfyr>li").length);
                var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val()
                var enc1 = $("#enclosure11").val() + "," + $("#enclosure22").val() + "," + $("#enclosure33").val()
                $("input[name='enclosure']").val(enc);
                $("input[name='fileName']").val(enc1);
                $("[selradio]").each(function () {
                    var num = $(this).find("input:checked").parent().index() + 1;
                    $(this).find("input[type='hidden']").val(num);
                })
                $("[selbox]").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).parent().find("input[type='hidden']").val("1")
                    } else {
                        $(this).parent().find("input[type='hidden']").val("2")
                    }
                })
//                var matter = UE.getEditor('matter').getContent();
//                for (var i = 0; i < MGC.length; i++) {
//                    if (matter.indexOf(MGC[i]) > 1) {
//                        alert("发表内容包含敏感词");
//                        return false;
//                    }
//                }
            })//$(".footer>button").click(function () {
            $(".cellbor").click(function () {
                $("#dblist").hide();
            })
            //上传附件
//            $("span[rid]").click(function () {
//                var rid = $(this).attr("rid")
//                $("#file" + rid).click();
//            })
//            $(".fileeform>input").change(function () {
//                var ridform = $(this).attr("ridform");
//                $(this).parent().ajaxSubmit({
//                    url: "/widget/upload.jsp?",
//                    type: "post",
//                    dataType: "json",
//                    async: false,
//                    success: function (data) {
//                        $("#fjfile" + ridform).text(data.url)
//                        $("#enclosure" + ridform).val(data.url);
//                        alert("上传成功");
//                    }});
//                return false;
//            })
            /*
             * 梁小竹修改
             * 修改原因为修复二次点击上传附件按钮但取消上传后上传附件按钮消失
             * @type type
             */
            //上传附件
            $("span[rid]").click(function () {
                var rid = $(this).attr("rid")
                $("#file" + rid).click();
            })
            $(".fileeform>input").change(function () {
                var ridform = $(this).attr("ridform");
                $(this).parent().ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if(data.url !== null && "" !== data.url){
                            $("#fjfile" + ridform).text(data.url);
                            $("#enclosure" + ridform).val(data.url);
                            alert("上传成功");
	     
                        }
                        else{
                            $("#fjfile" + ridform).text("点击选择文件");
                            $("#enclosure" + ridform).val(data.url);
                            alert("未上传");
                        }
                    }});
                return false;
            })
            /*
             * 梁小竹修改结束
             */
            
//            梁小竹修改 覆盖默认alert，
//            window.alert = function (txt) {
//                navigator.notification.alert(txt, null, "Alert", "Close");
//            }
            //梁小竹修改结束
            $("#suggesttype select").change(function () {//选择了类别//added by jackie
                var v_type = '';
                
               if ($("#suggesttype select").val() == 1) {// 视察调研
                    v_type = 'editInspection';
                }
                else if ($("#suggesttype select").val() == 2){ //执法检查
                    v_type = 'editEnforcement';
                }
                 else if ($("#suggesttype select").val() == 3){ //听取和审议专项工作报告
                    v_type = 'specialReport';
                }
                else if ($("#suggesttype select").val() == 4){ //质询和询问
                    v_type = 'editInquery';
                }
                else if ($("#suggesttype select").val() == 5){ //质询和特定问题调查
                    v_type = 'editInvestigation';
                }
                 else if ($("#suggesttype select").val() == 6 ){ //工作评议
                    v_type = 'editWorkReview';
                }
                 else if ($("#suggesttype select").val() == 7 ){ //规范性文件备案
                    v_type = 'editNormativeDocument';
                }
                
             
                
                // alert(v_type);
                self.location = "/supervision/" + v_type + ".jsp";
                return false;
            })
            $('.selectscr').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.linkman + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser.jsp", 700, 650);
            });
            $('.selectuser').click(function () {
                var t = $(this).parents("tr").find("ul");
                console.log(t)
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                     $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
//                            t.append("<li myid='" + v.myid + "'>\n\
//                            <em  style='display: inline;width: 16.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em>\n\
//                            <em style='inline block;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em>\n\
//                            <em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.daibiaoDWaddress + "</em>\n\
//                            <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em>\n\
//                            <em class='blue'>删除</em></li>")
            
             t.append("<li myid='" + v.myid + "'>\n\
                            <em  style='display: inline;width: 65.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em>\n\
                            \n\
                            <em class='blue'style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;color:blue;cursor:pointer;'>删除</em></li>"
                    )
                            //t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>" + v.realname +"</em><em style='inline block;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.code+"</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.homeaddress+ "</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.telphone+ "</em><em class='red'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em style='margin-left: 10px;'>&nbsp;" + v.realname + "</em><em style='margin-left: 85px;'>&nbsp;"+v.code+"</em><em style='margin-left: 200px;'>&nbsp;"+v.homeaddress+"</em><em style='margin-left: 85px;'>&nbsp;"+v.telphone+"</em><em class='red'>删除</em></li>")
                            // t.append("<li style='border: 1px #dce6f5 solid;margin-top: 2px;' myid='" + v.myid + "'>" +v.realname +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.code + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.homeaddress +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.telphone +"<em class='red'>删除</em></li>")
                        }
                    })
                    // t.find("em").off("click").click(function () {
                    $('.blue').click(function () {
                        $(this).parent().remove();
                    })
                }
                if (Cookie.Get("powergroupid") == "22") {
                    RssWin.open("/selectwin/selectuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>", 700, 650);
                } else {
                    RssWin.open("/selectwin/selectuser.jsp?mission=<% out.print(user1.get("mission"));%>", 700, 650);
                }
            });
            $('.selectcompany').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 700, 650);
            });
            $("li").find(".red").off("click").click(function () {
                $(this).parent().remove();
            })
            if (Cookie.Get("powergroupid") == "16" || Cookie.Get("powergroupid") == "22" || Cookie.Get("powergroupid") == "8" || Cookie.Get("powergroupid") == "15" || Cookie.Get("powergroupid") == "0") {
                $("#adminsel>input").click(function () {
                    RssWin.onwinreceivemsg = function (dict) {
                        console.log(dict);
                        $("#adminsel>input").val(dict.myname)
                        $("#parentname").text(dict.delegationname)
                        $("#scrid").attr("myid", dict.mission)
                        $("#codenum").text(dict.code)
                        $("#postcode").text(dict.postcode)
                        $("#telphone").text(dict.telphone)
                        $("#homeaddress").text(dict.daibiaoDWaddress)
                        $("[name='myid']").val(dict.myid)
                    }
                    RssWin.open("/selectwin/selectoneuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>&mission=<% out.print(user1.get("mission"));%>", 700, 650);
                })
//            }else if(Cookie.Get("powergroupid") == "22"){
//                $("#adminsel>input").click(function () {
//                    RssWin.onwinreceivemsg = function (dict) {
//                        console.log(dict);
//                        $("#adminsel>input").val(dict.myname)
//                        $("#parentname").text(dict.realname)
//                        $("#codenum").text(dict.code)
//                        $("#postcode").text(dict.postcode)
//                        $("#telphone").text(dict.telphone)
//                        $("#homeaddress").text(dict.homeaddress)
//                        $("[name='myid']").val(dict.myid)
//                    }
//                    RssWin.open("/selectwin/selectuser_1.jsp?myidd=<% out.print(cookie.Get("myid"));%>", 700, 650);
//                })
            }

            $('.selectscr22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li class='abc' myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_p7.jsp", 700, 650);
            });
            $('.selectscra22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='xzscID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_1_1.jsp", 700, 650);
            });

        </script>
    </body>
</html>
