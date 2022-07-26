<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "supervision_topic_process_report_audit");
    RssList report = new RssList(pageContext, "supervision_topic_process_report");
    RssList process = new RssList(pageContext, "supervision_topic_process");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (req.get("action").equals("append")) {
        //添加audit表数据
        entity.remove("id");
        entity.timestamp();
        entity.keymyid(cookie.Get("myid"));
        entity.keyvalue("reportid", req.get("id"));
        entity.append().submit();

        //修改report表数据
        report.keyvalue("state", entity.get("state"));
        report.timestamp("auditshijian");
        report.update().where("id=" + req.get("id")).submit();

        //如果通过的是第7步的report，则将对应的第8步的report的状态设置为1（设置前state=0）
        if (entity.get("state").equals("3")) {
            RssList report2 = new RssList(pageContext, "supervision_topic_process_report");
            RssList process2 = new RssList(pageContext, "supervision_topic_process");
            report2.select("topicid,processid").where("id=" + req.get("id")).get_first_rows();
            process2.select("typeid").where("id=" + report2.get("processid")).get_first_rows();
            if (process2.get("typeid").equals("7")) {
                RssList process3 = new RssList(pageContext, "supervision_topic_process");
                process3.select("id").where("topicid=" + report2.get("topicid") + " and typeid=8").get_first_rows();
                report2.keyvalue("state", 1);
                report2.update().where("processid=" + process3.get("id")).submit();
            }
        }

        //判断条件，修改process表数据的state
        report.select("processid").where("id=?", req.get("id")).get_first_rows();
        String processid = report.get("processid");
        report.select("state").where("processid=?", processid).get_page_desc("id");

        Boolean finishstate = true;
        while (report.for_in_rows()) {
            if (!report.get("state").equals("3")) {
                finishstate = false;
            }
        }
        if (finishstate) {//判断该process下的report是否全部审核通过
            process.keyvalue("state", "2");
            process.update().where("id=" + processid).submit();
            process.select("topicid,typeid").where("id=" + processid).get_first_rows();
            if (process.get("typeid").equals("7")) {
                process.keyvalue("state", 1);
                process.remove("topicid", "typeid");
                process.update().where("topicid=" + process.get("topicid") + " and typeid=8").submit();
            }
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
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
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">调研报告审核</td></tr>
                    <tr>
                        <td class="dce">审核结论：</td>
                        <td><span>
                                <input type="radio" name="state" value="3" checked="checked" />&nbsp;通过&nbsp;&nbsp;&nbsp;
                                <input type="radio" name="state" value="4" />&nbsp;不通过&nbsp;&nbsp; &nbsp;</span> （如审核不通过则说明原因）
                        </td>

                    </tr>
                    <tr>
                        <td class="dce">审核结论：</td>
                        <td><textarea class="w250" name="matter"></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">审核附件：</td>
                        <td colspan="3">
                            <span id="fjfile">点击选择文件</span>
                            <input type="hidden" name="enclosure" value="" >
                            <input type="hidden" name="enclosurename" value="" >
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#fjfile").click(function () {
                $("#filee").click();
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
                        $("#fjfile").text(filename)
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        alert("上传成功");
                    }});
                return false;
            })
        </script>
    </body>
</html>
