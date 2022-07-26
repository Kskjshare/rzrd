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
    RssList entity = new RssList(pageContext, "deputyActivity");
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

//        if (entity.get("myid").isEmpty()) {
//            entity.keymyid(UserList.MyID(request));
//        }
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
        <title>添加记录</title>
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
        <form id="abc" enctype="multipart/form-data" method="post" style="display:none;">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form> 
        <form class="abc" enctype="multipart/form-data" method="post" style="display:none;">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" class="file" name="file" multiple>
            <input class="submit" type="submit"/>  
        </form> 
        <form method="post" class="popupwrap"> 
            

            <div>
                <h1>履职活动</h1>
                <table class="wp100 cellbor">
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <tr>
                        <td colspan="1">主题<em class="red">*</em></td>
                        <td colspan="4"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="topic" value="<% entity.write("topic"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr>
                        <td>地点<em class="red">*</em></td>                     
                        <td colspan="2"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="place" value="<% entity.write("place"); %>" /><label class="labtitle"></label></td>   
                        <td>参与人<em class="red">*</em></td>                     
                        <td colspan="2"><input type="text" class="w98 null" required="required" onblur="shijian(event)" name="people" value="<% entity.write("people"); %>" /><label class="labtitle"></label></td>   
                    </tr>
                    <tr>
                        <td>开始时间</td>
                        <td colspan="2"  >
                            <input class="w98" required="required" type="date" name="starttime" value="<% entity.write("starttime"); %>"></td>
                        <td>结束时间</td>
                        <td colspan="2"><input class="w98" required="required" type="date" name="endtime" value="<% entity.write("endtime"); %>"></td>
                    </tr>


<tr>
    <td colspan="5" align="center" ><h3>内容</h3></td>
                        
</tr>
                   
                   
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel">内容区域</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="content" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                    <tr>
                        <td>上传图片</td>
                        <td colspan="2">
     
                            <div style="display:flex"> 
                                <div id="divPreview" style="display:none;">
                                        <img id="imgHeadPhoto" src="/upfile/<% entity.write("picture"); %>">
                            </div>
                            <p id="selbut" style="color:blue; cursor: pointer;font-weight:bold;">选择图片</p>&nbsp;&nbsp;
                            <p id="pbut" style="color:blue;cursor: pointer;;font-weight:bold;">上传图片</p>
                            <span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="picture" id="ico" value="<% entity.write("picture"); %>">
                            </div>
                  </td>
                            
                           
                        <td>组织单位</td>
                        <td colspan="2">
                            <select style="width:200px;" value="<% entity.write("organization"); %>" name="organization">
                                <option>市人大常委会</option>
                                <option>办公室</option>
                                <option>财政经济工作委员会</option>
                                <option>法制工作委员会</option>
                                <option>内务司法工作委员会</option>
                                <option>预算工作委员会</option>
                                <option>农村工作委员会</option>
                                <option>教育科学文化卫生工作委员会</option>
                                <option>环境与资源保护工作委员会</option>
                                <option>民族侨务外事工作委员会</option>
                                <option>选举任免代表联络工作委员会</option>
                                <option>上级人大</option>
                                <option>代表团</option>
                                <option>代表小组</option>
                                <option>其他</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>上传封面</td>
                        <td colspan="2">
                            <div style="display:flex"> 
                                <div class="divPreview" style="display:none;">
                                        <img id="imgHeadPhoto" src="/upfile/<% entity.write("cover"); %>">
                            </div>
                            <p class="selbut" style="color:blue; cursor: pointer;;font-weight:bold;">选择图片</p>&nbsp;&nbsp;
                            <p class="pbut" style="color:blue;cursor: pointer;;font-weight:bold;">上传图片</p>
                            <span class="upfiletype">(未上传)</span>
                            <input type="hidden" name="cover" class="ico" value="<% entity.write("cover"); %>">
                            </div>
                        </td>
                        <td>类型</td>
                        <td colspan="2">
                            <select id="type" style="width:200px;" value="<% entity.write("type"); %>" name="type">
                                <option>参加人大代会</option>
                                <option>参加常委会</option>
                                <option>参加主任会议</option>
                                <option>参加代表团会议/活动</option>
                                <option>其他会议/活动</option>
                                <option>参加视察调研</option>
                                <option>参加执法检查</option>
                                <option>参加专题座谈</option>
                                <option>参加学习培训</option>
                                <option>联系、接待基层代表和人民群众</option>
                                <option>报告履职情况</option>
                                <option>获省级及以上表彰奖励</option>
                                <option>获市级表彰奖励</option>
                                <option>列席市人大常委会会议</option>
                                <option>列席县（市、区）人民代表大会</option>
                                <option>列席县（市、区）人大常委会会议</option>
                                <option>个人持证视察或调研</option>
                                <option>为民办实事</option>
                            </select>
                                <input id="val" type="text" name="typeid" value="" style="display:none;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            &nbsp;
                        </td>
                    </tr>


                </table>

                <div class="chengyemian ">


                </div>
            </div>

                    <div class="footer" >
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <!--<button type="submit">保存</button>-->
                <button type="submit" ><% out.print(entity.get("topic").isEmpty() ? "提交" : "修改");%></button>
                
<!--                <input type="hidden" name="level">
              
                <input name="year" type="hidden">
                <input name="ProposedBill" type="hidden">
                <input name="draft" type="hidden">-->
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
                 } else if(!(myreg.test(phone))) {
                         popuplayer.display("/showalert.jsp?text=" + "输入有误", '提示', {width: 300, height: 100});
                         return false; 
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
                                        $("#ico").val(data.url);
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
                            
                            
                             $(".submit").click(function () {
                                $(".abc").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        console.log(data)
                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $(".ico").val(data.url);
                                        alert("上传成功");
                                        $(".upfiletype").text("(成功上传)")
                                    }});
                                return false;
                            })
                            $('.pbut').click(function () {
                                $(".submit").click();
                            })
                            
                            $(".selbut").click(function () {
                                $(".file").click();
                            })
        </script>
        <script>
            $(function() {
                 var number = 1;
                 $("#val").val(number)
                $("#type").click(function() {
                    if($("#type").val() == "参加人大代会") {
                    number = 1;
                    $("#val").val(number)
                }else if($("#type").val() == "参加常委会") {
                    number = 2;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加主任会议") {
                    number = 3;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加代表团会议/活动") {
                    number = 4;
                    $("#val").val(number)
                }
                else if($("#type").val() == "其他会议/活动") {
                    number = 5;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加视察调研") {
                    number = 6;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加执法检查") {
                    number = 7;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加专题座谈") {
                    number = 8;
                    $("#val").val(number)
                }
                else if($("#type").val() == "参加学习培训") {
                    number = 9;
                    $("#val").val(number)
                }
                else if($("#type").val() == "联系、接待基层代表和人民群众") {
                    number = 10;
                    $("#val").val(number)
                }
                else if($("#type").val() == "报告履职情况") {
                    number = 11;
                    $("#val").val(number)
                }
                else if($("#type").val() == "获省级及以上表彰奖励") {
                    number = 12;
                    $("#val").val(number)
                }
                else if($("#type").val() == "获市级表彰奖励") {
                    number = 13;
                    $("#val").val(number)
                }
                else if($("#type").val() == "列席市人大常委会会议") {
                    number = 14;
                    $("#val").val(number)
                }
                else if($("#type").val() == "列席县（市、区）人民代表大会") {
                    number = 15;
                    $("#val").val(number)
                }
                else if($("#type").val() == "列席县（市、区）人大常委会会议") {
                    number = 16;
                    $("#val").val(number)
                }
                else if($("#type").val() == "个人持证视察或调研") {
                    number = 17;
                    $("#val").val(number)
                }
                else if($("#type").val() == "为民办实事") {
                    number = 18;
                    $("#val").val(number)
                }
               
                })
            })
        </script>
    </body>
</html>