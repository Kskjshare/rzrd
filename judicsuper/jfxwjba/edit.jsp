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
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    String meetingTime = "0";
    try {
        String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
        Properties properties = new Properties();
        InputStream is = new FileInputStream(propertiesFileName);
        properties.load(is);
        is.close();
        meetingTime = properties.get("meetingtime").toString();
    } catch (Exception e) {
        e.printStackTrace();
    }

    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "shenchadengji");
    RssList contacts = new RssList(pageContext, "suggestlxr");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    RssList scr = new RssList(pageContext, "suggestscr");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("scyj", "realid", "perm", "type1", "type2", "type3", "type4", "blfs", "secound", "contacts", "usercomp", "scr");
        entity.remove("id");
        entity.remove("secound");
        if (entity.get("summary").isEmpty()) {
            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
        }

        if (entity.get("myid").isEmpty()) {
            entity.keymyid( UserList.MyID(request) );
        }
        if (meetingTime.equals("1")) {
            entity.keyvalue("isysw", "0");//不经过选工委或代表联络科
            //预留空位，此处应为大会期间的其他处理
        } else {
            if ((entity.get("level").equals("0"))) {//0为乡镇，examination设为5；   1为市级，examination设为1（默认为1，不动即可）    注：因乡镇路线无初审流程，故设为5
                entity.keyvalue("examination", 5);
                entity.keyvalue("iscs", 1);
                entity.keyvalue("isdbtshenhe", 1);  //设为1：即不经过代表团或选工委代表联络科，
            }
            entity.keyvalue("isysw", "21");//闭会市镇，经过选工委或代表联络科

        }
        entity.timestamp();
        entity.append().submit();
       
        
        out.print("<script>alert('操作成功！');</script>");
//        PoPupHelper.adapter(out).iframereload();
//        PoPupHelper.adapter(out).showSucceed();
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
            #suggesttype{text-align: right;margin-top: 5px;}
            #suggesttype>select{margin: -5px 5px 0;}
            .popupwrap{overflow: auto}
            .popupwrap table td>b{cursor: pointer;}
            .popupwrap>div>h1{text-align: center; margin: 10px 0 20px 0;}
            .popupwrap table td>.lxrlist>input{width: 100px;margin: 0 10px;}
            .popupwrap table td>label{margin: 0 3px;}
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer}
            /*.popupwrap .footer>button{ font-size: 99px;}*/
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .popupwrap>.footer{top: auto;bottom: 0;right: 24px;border-top: solid 1px #e6e6e6; padding-top: 5px;position: fixed;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .w498{width: 99%;}
            #suggesttype{
                font-size: 14px;
            }
            .w98{width: 98%;}
            .meetingtime{color: red}
            /*撑下边按钮*/
            .chengyemian{

                height: 50px;
            }
            .yanse{
                color: blue;
                font-weight: 600;
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
                <h1>规范性文件备案审查登记表</h1>
                <table class="wp100 cellbor">
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <tr>
                        <td colspan="1" class="dce">文件名<em class="red">*</em></td>
                        <td colspan="4"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="filename" value="<% entity.write("filename"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr>
                        <td class="dce">报备单位<em class="red">*</em></td>
                      
                        <td colspan="2"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="organizer" value="<% entity.write("organizer"); %>" /><label class="labtitle"></label></td>
                           
                        
                        
                        <td class="dce">文号<em class="red">*</em></td>
                        <td colspan="2"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="Titanic" value="<% entity.write("Titanic"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr>
                        <td class="w150 dce">报送人<em class="red">*</em></td>
                        <td colspan="2"><input type="text" required="required" class="w98 null" onblur="shijian(event)" name="name" value="<% entity.write("name"); %>" /><label class="labtitle"></label></td>
                        <td class="dce">报送人电话<em class="red">*</em></td>
                        <td ><input class="w98 dianhua" onblur="checkPhone()" required="required" type="text" name="telephone" value="<% entity.write("telephone"); %>"> </td>
                    </tr>
                    <tr>
                        <td class="dce">印发时间<em class="red">*</em></td>
                        <td colspan="2"  >
                            <input class="w98" required="required" type="date" name="yfdate" value="<% entity.write("yfdate"); %>"></td>
                        <td class="dce">备案时间<em class="red">*</em></td>
                        <td colspan="2"><input class="w98" required="required" type="date" name="beiandate" value="<% entity.write("beiandate"); %>"></td>
                    </tr>
                    <tr>
                        <td colspan="5" class="dce">
                            <input id="checkbox1" class="ceshi" type="checkbox" > <label for="checkbox1">起草说明</label> 
                       
                                <input id="checkbox2"  class="ceshi1" type="checkbox" > <label for="checkbox2">法律依据</label> 
<!--                                <input id="checkbox3"  class="ceshi2" type="checkbox" > <label for="checkbox3">征求意见</label> 
                                <input id="checkbox4"  class="ceshi3" type="checkbox" > <label for="checkbox2">合法性审查</label> 
                                <input id="checkbox5"  class="ceshi4" type="checkbox" > <label for="checkbox3">集体讨论</label> -->
<!--zyx注销，原因是不需要这三个东西-->
                        </td>
                         <td style="display:none;"><input class="yi" type="text" name="qcexplain" value="<% entity.write("qcexplain"); %>"></td>
                         <td style="display:none;"><input class="er" type="text" name="legalbasis" value="<% entity.write("legalbasis"); %>"></td>
<!--                         <td style="display:none;"><input class="san" type="text" name="opinions" value="<% entity.write("opinions"); %>"></td>
                         <td style="display:none;"><input class="si" type="text" name="review" value="<% entity.write("review"); %>"></td>
                         <td style="display:none;"><input class="wu" type="text" name="discussion" value="<% entity.write("discussion"); %>"></td>-->
                    </tr>

                    
                   
                   
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel">备注</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="remarks" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce">附件</td>
                        <td colspan="5">
                            <div><span id="fjfile1" rid="1" class="yanse">点击选择文件</span>
                                <input type="hidden"  id="enclosure1" >
                                <input type="hidden"  name="enclosurename" >
                                
                            </div>
                            <div style="display: none;"><span id="fjfile2" rid="2" class="yanse">点击选择文件</span><input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" class="yanse">点击选择文件</span><input type="hidden" id="enclosure3" ></div>
                        </td>
                    </tr>
                    
                    <!-- below added by jackie  //-->
                    <%
                        if (!(cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))//不为政府办和乡镇政府办且
                                && meetingTime.equals("0")//议审委流程且不在大会期间//added by jackie
                                //                                && flowtype_ysw.equals("22")//议审委流程且不在大会期间//added by jackie
                                ) {
                    %>

                    <%
                        }//22议审委流程且不在大会期间//added by jackie
                    %>
                    <!-- up added by jackie  //-->
                    <tr style="display: none;"><td rowspan="6">相关情况</td><td colspan="5" selradio>代表对公开此建议有关情况的意见<label><input type="radio" name="perm">同意全文公开</label><label><input type="radio" name="perm">仅同意公开标题</label><input type="hidden" name="permission"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>此建议由代表通过调查研究形成<label><input type="radio" name="type1">专题调研</label><label><input type="radio" name="type1">座谈</label><label><input type="radio" name="type1">走访等其他形式</label><input type="hidden" name="sugformation"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>属于多年多次提出,尚未解决的事项<label><input type="radio" name="type2">两年</label><label><input type="radio" name="type2">三年</label><label><input type="radio" name="type2">三年以上</label><input type="hidden" name="sugyears"></td></tr>
                    <tr style="display: none;"><td colspan="5" >希望承办单位在办理过程中加强与代表的联系沟通<input selbox type="checkbox" name="type3"><input type="hidden" name="communicate"></td></tr>
                    <tr style="display: none;"><td colspan="5" selbox>此建议请承办单位在工作中研究参考,不需要书面答复<input selbox type="checkbox" name="type4"><input type="hidden" name="written"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>可否联名提出<label><input type="radio" name="type1">可以</label><label><input type="radio" name="type1">不可以</label><input type="hidden" name="seconded"></td></tr> <!--<tr><td>办理方式</td><td colspan="5" selradio><label><input type="radio" name="blfs">主办/协办</label><label><input type="radio" name="blfs">分办</label><input type="hidden" name="handle"></td></tr>-->
                    <!--                    <td>有效届次：</td>
                                        <td colspan="5"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>-->
                    <tr style="display: none;"><td>办理单位</td><td colspan="4"><ul id="bldw"></ul></td><td><b class="selectcompany">选择主/分办单位</b></td></tr>
                    <tr style="display: none;"><td>建议联系人</td><td colspan="4"><ul id="jylxr"></ul></td><td><b class="selectuser">添加建议联系人</b></td></tr>
                    <tr style="display: none;"><td>审查人</td>
                        <% RssListView user1 = new RssListView(pageContext, "user_delegation");
                            user1.request();
                            if (entity.get("id").isEmpty()) {
                                user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                            } else {
                                user1.select().where("myid=" + entity.get("myid")).get_first_rows();
                            }
                        %>
                        <td colspan="5">
                            <input class="yincang" id="scrid" type="text" myid="<% user1.write("mission"); %>" value="<% user1.write("delegationname"); %>" >
                        </td>
                    </tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="5"><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label><input name="secound"><input name="contacts"><input name="scr"><input name="usercomp"><input name="numpeople"><input name="enclosure"></td>
                    </tr>   

                </table>

                <div class="chengyemian ">


                </div>
            </div>

            <div class="footer" >
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <!--<button type="submit">保存</button>-->
                <button type="submit" ><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <%
                    if (!(cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16"))) {
                %>
                <input type="hidden" name="level">
                <%
                    }
                %>
                <input name="year" type="hidden">
                <input name="ProposedBill" type="hidden">
                <input name="draft" type="hidden">
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
//                    console.log(v + "+" + ind)
                    $("input[name='" + k + "']").parent().find("label").eq(ind).click();
                }
            })
            //办理单位,联系人,联名人赋值



            $(".footer>button").click(function () {
                
                //梁小竹修改
                if($(".shencha").length > 0){
                    if($("#jyscr>li").length <= 0){
//                        alert("请选择审查人员");
                    let text = "请选择审查人员";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                    popuplayer.display( window.location.href='/showalert.jsp?text ='+encodeURI(encodeURI(text)), '提示', {width: 300, height: 100});
                        return false;
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
//                        flog = 1;
//                        lii.remove();
//                        return false;
                    }else{
//                        说明联名人没有重复
//                        alert("没有");
//let text = "没有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                        mid.set(val,1);
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
//                console.log(mydate);
                $('[name=year]').val(mydate);

                var timestamp = Date.parse(new Date());
//                console.log(timestamp / 1000);
                $('[name=ProposedBill]').val(timestamp / 1000);
                $('[name=draft]').val("2");
//                alert($('[name=draft]').val());
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
//                        alert("请填写完整数据")
                        let text = "请填写完整数据";
                        popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        return false;
                    }
                })
//                console.log($("#suggesttype select").val());

                if ($("#level option:selected").attr("circles") == 2) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 1)
                } else if ($("#level option:selected").attr("circles") == 3) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 2)
                } else if ($("#level option:selected").attr("circles") == 4) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 3)
                } else {
                    $("input[name='level']").val($("#level option:selected").attr("circles"))
                }
                if ($("#suggesttype select").val() == 2) {//如果选的类型为议案
                    if ($("#blfyr>li").length < 11) {//因为列名也占了一行
//                        alert("议案的联名人数得大于等于10人");
                        let text = "议案的附议人数得大于等于10人";
                        popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        return false;
                    }
                }

//                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
////                    alert("请填写交流标题");
//                    let text = "请填写交流标题";
//                    popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
//                    $("[name='title']").focus();
//                    return false;
//                }
//                if ($("[name='qwshdate']").val() == undefined || $("[name='qwshdate']").val() == "") {
////                    alert("请填写交流标题");
//                    let text = "请填写期望办理时间";
//                    popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
//                    $("[name='qwshdate']").focus();
//                    return false;
//                }
//                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
////                    alert("请填写内容");
//                    let text = "请填写内容";
//                    popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
//                    $("[name='matter']").focus();
//                    return false;
//                }
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
            $("span[rid]").click(function () {
                var rid = $(this).attr("rid")
                $("#file" + rid).click();
            })
            $(".fileeform>input").change(function () {
                var ridform = $(this).attr("ridform");
                 var str = $(this).val(); //开始获取文件名
                var filename = str.substring(str.lastIndexOf("\\") + 1);
                $(this).parent().ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.url !== null && "" !== data.url) {
                            $("#fjfile" + ridform).text(filename);
                            $("#enclosure"+ ridform).val(data.url);
                            $("input[name='enclosurename']").val(filename);
//                            alert("上传成功");
                            let text = "上传成功";
                            popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        } else {
                            $("#fjfile" + ridform).text("点击选择文件");
//                            $("#" + ridform).val(data.url);
//                            alert("未上传");
                            let text = "未上传";
                            popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        }
                    }});
                return false;
            })
            $("#suggesttype select").change(function () {//选择了类别//added by jackie
                var v_type = '';
                if ($("#suggesttype select").val() == 2) {//如果选择了议案类别
                    v_type = 'editya';
                } else {
                    v_type = 'edit';
                }
                // alert(v_type);
                self.location = "/bill/" + v_type + ".jsp";
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
//                console.log(t)
                RssWin.onwinreceivemsg = function (dict) {
//                    console.log(dict);
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 16.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em><em style='inline block;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em><em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.daibiaoDWaddress + "</em><em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em><em class='blue'>删除</em></li>")
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
//                        console.log(dict);
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
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
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
            var one ;
            $(".yi").val(one)
          $(".ceshi").click(() => {
              if($(".ceshi").is(":checked") == true) {
                  one = "√";
              }else{
                  one = "";
              }
              $(".yi").val(one)
          });
          var er ;
           $(".er").val(er)
           $(".ceshi1").click(() => {
              if($(".ceshi1").is(":checked") == true) {
                  er = "√";
              }else{
                  er = "";
              }
        $(".er").val(er)
             
          });
          var san ;
          $(".san").val(san)
           $(".ceshi2").click(() => {
              if($(".ceshi2").is(":checked") == true) {
                  san = "√";
              }else{
                  san = "";
              }
              $(".san").val(san)
          }); 
          var si ;
          $(".si").val(si)
          $(".ceshi3").click(() => {
              if($(".ceshi3").is(":checked") == true) {
                  si = "√";
              }else{
                  si = "";
              }
              $(".si").val(si)
          }); 
          var wu ;
          $(".wu").val(wu)
          $(".ceshi4").click(() => {
              if($(".ceshi4").is(":checked") == true) {
                  wu = "√";
              }else{
                  wu = "";
              }
              $(".wu").val(wu)
          });
          
          
        </script>
        <!--正则-->
        <script>
            function checkPhone(){ 
                var phone = $(".dianhua").val()
                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if(!phone){ 
//                        alert("手机号码有误，请重填");  
                         popuplayer.display("/showalert.jsp?text=" + "输入为空", '提示', {width: 300, height: 100});
                         return false; 
                 } else if(!(myreg.test(phone))  ) {
                         popuplayer.display("/showalert.jsp?text=" + "输入手机号或座机号有误", '提示', {width: 300, height: 100});
                         return false; 
                 }
            }
        </script>
        
    </body>
</html>

