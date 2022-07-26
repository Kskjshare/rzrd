<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.JPushClient"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity2 = new RssList(pageContext, "policy_decision");
    entity2.request();

    if (!entity2.get("action").isEmpty()) {
        switch (entity2.get("action")) {
            case "append":
                entity2.timestamp();
                entity2.keyvalue("category",2 ) ;
                entity2.append().submit();          
                break;
            case "update":
                entity2.update().where("id=?", req.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity2.select().where("id=?", req.get("id")).get_first_rows();
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
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .w630{width:99%;}
            .b95{width:99%;}
          
            
            .w750 { width: 750px; }
            .w960 { width: 1198px; }

            #fileeform{position: absolute;left: -10000px;}
            #fileeform2{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept=".pdf" name="file" multiple>
        </form>  
        <form id="fileeform2" class="fileeform"  enctype="multipart/form-data" method="post">
            <input type="file" id="file2"  name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w630" name="title" value="<% entity2.write("title"); %>" /></td>
                    </tr>
                    <tr>      
                              
                       <td class="dce w100 ">附件</td>
                       <td style="color:blue ;font-size:14px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                           <span id="fjfile"><% out.print(entity2.get("enclosure").isEmpty() ? "点击选择文件" : entity2.get("enclosurename")); %>
                           </span>
                           <input type="hidden" name="enclosure" value="<% entity2.write("enclosure"); %>" >
                           <input type="hidden" name="enclosurename"  value="<% entity2.write("enclosurename"); %>" >
                       </td>   
                          
                   
                       <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">类别</td>    
                       <td colspan="2"><select  class="w630" name="classify" dict-select="trend" def="<% entity2.write("classify"); %>"></select></td>                                    
                       
                    </tr>

                     
                    <tr>
                        <td class="dce w100 ">来源</td>
                        <td><input class="w630" type="text" maxlength="80" name="source" value="<% entity2.write("source"); %>" /></td>
                        
                        
                        <td class="dce" style="width:110px;">发布时间</td>
                        <td colspan="3"><input  type="text" class="w630 Wdate" name="publishtime"  rssdate="<% out.print(entity2.get("publishtime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
             
                    </tr>
                    
                   
                            
                            
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr> 
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:480" id="matter" name="matter" class="w960" type="text/plain"><% entity2.write("matter"); %></script></td>
                    </tr>
                   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity2.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity2.get("id").isEmpty() ? "增加" : "修改");%></button>
               
            </div>
        </form>
        <!-- <div class="progress" id="progressHide">
             <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBar">
                 <span class="sr-only">40% 完成</span>
             </div>
         </div> -->
        <%@include  file="/inc/js.html" %>
        <script>

                            $(".footer button").click(function () {
                                
                                if ($("[name='publishtime']").val() != undefined && $("[name='publishtime']").val() != "") {
                                    var timestamp = new Date($("[name='publishtime']").val());
                                    $("[name='publishtime']").val(timestamp / 1000);
                                }
                                else {
                                    alert("请填写发布时间")
                                    return false;
                                }
                                
//                                if ($("[name='joinshijian']").val() != undefined && $("[name='joinshijian']").val() != "") {
//                                    var timestamp = new Date($("[name='joinshijian']").val());
//                                    $("[name='joinshijian']").val(timestamp / 1000);
//                                }
//                                var arry = [], str = "";
//                                arry.push($("[name='myid']").val());
//                                $("#selsend").find("em[myid]").each(function () {
//                                    if (arry.indexOf($(this).attr("myid")) == "-1") {
//                                        arry.push($(this).attr("myid"));
//                                    } else {
//                                    }
//                                })
//                                str = arry.join(",");
//                                $("input[name='objid']").val(str)
                            })
                            $("#fjfile").click(function () {
                                $("#filee").click();
                            })
                            $("#fjfile2").click(function () {
                                $("#file2").click();
                            })
                            $("#filee").change(function () {
                                var str = $(this).val(); //开始获取文件名
                                var filename = str.substring(str.lastIndexOf("\\") + 1);
                                $("#fileeform").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        //$("#fjfile").text(data.url)
                                        $("#fjfile").text(filename)
                                        $("input[name='enclosure']").val(data.url);
                                        $("input[name='enclosurename']").val(filename);
                                        alert("上传成功");
                                    }});
                                return false;
                            })
                            $("#file2").change(function () {
                                var xhr = $("#fileeform2").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $("#fjfile2").text(data.url)
                                        $("input[name='videosrc']").val(data.url);
                                        alert("上传成功");
                                    },
//                                    xhr: function () {
//                                        var xhr = $.ajaxSettings.xhr();
//                                        if (onprogress && xhr.upload) {
//                                            xhr.upload.addEventListener("progress", onprogress, false);
//                                            return xhr;
//                                        }
//                                    }
                                });
                                return false;
                            })
//                            $('[selectuser]').click(function () {
//                                var t = $(this).parent();
//                                RssWin.onwinreceivemsg = function (dict) {
//                                    console.log(dict);
//                                    $.each(dict, function (k, v) {
//                                        if ($("em[myid='" + v.myid + "']").length == "0") {
//                                            t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
//                                        }
//                                    })
//                                    $("#selsend i").off("click").click(function () {
//                                        $(this).parent().remove();
//                                    })
//                                }
//                                RssWin.open("/selectwin/selectall.jsp", 600, 500);
//                            });
//                            function onprogress(evt) {
//                                var loaded = evt.loaded;
//                                var tot = evt.total;
//                                var per = Math.floor(100 * loaded / tot);  //已经上传的百分比
//                                var son = document.getElementById('progressBar');
//                                son.innerHTML = per + "%";
//                                son.style.width = per + "%";
//                            }


        </script>
    </body>
</html>
