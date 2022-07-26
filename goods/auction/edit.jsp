<%@page import="api.saas.TimeConvert"%>
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
    RssList entity = new RssList(pageContext, "goods");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");

//        if (entity.get("summary").isEmpty()) {
//            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
//        }
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        long firstdeliverytime = DateTimeExtend.timestamp(entity.get("firstdeliverytime"), "yyyy-MM-dd HH:mm");
        long seconddeliverytime = DateTimeExtend.timestamp(entity.get("seconddeliverytime"), "yyyy-MM-dd HH:mm");
        entity.keyvalue("firstdeliverytime", firstdeliverytime).keyvalue("seconddeliverytime", seconddeliverytime);
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.keyvalue("firstdeliverytime", firstdeliverytime).keyvalue("seconddeliverytime", seconddeliverytime);
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    String firstdeliverytime = "";
    String seconddeliverytime = "";
    if (!entity.get("firstdeliverytime").equals("") && !entity.get("firstdeliverytime").equals(null) && !entity.get("firstdeliverytime").isEmpty()) {
        firstdeliverytime = TimeConvert.timeStamp2Date(entity.get("firstdeliverytime"), "");
    }
    if (!entity.get("seconddeliverytime").equals("") && !entity.get("seconddeliverytime").equals(null) && !entity.get("seconddeliverytime").isEmpty()) {
        seconddeliverytime = TimeConvert.timeStamp2Date(entity.get("seconddeliverytime"), "");
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
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w120">商品名称：</td>
                        <td><input type="text" class="w500" name="title" value="<% entity.write("title"); %>" /><input type="hidden" name="type" value="2"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">类型：</td>
                        <td><select name="classify" dict-select="coaltype" def="<% entity.write("classify"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w120">产地：</td>
                        <td><div selectcascade="area" data-val="5" dict-name="shengid,shiid,xianid"></div></td>
                    </tr>
                    <tr>
                        <td class="tr w120">交货方式：</td>
                        <td><select name="deliveryterms" dict-select="deliverytype" def="<% entity.write("deliveryterms"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w120">押金：</td>
                        <td><input class="sum" type="text" name="deposit" placeholder="请填写价格" value="<% entity.write("deposit"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">每次上涨金额：</td>
                        <td><input class="sum" type="text" name="risesum" placeholder="请填写价格" value="<% entity.write("risesum"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">煤炭价格：</td>
                        <td><input class="sum" type="text" name="price" placeholder="请填写价格" value="<% entity.write("price"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">库存：</td>
                        <td><input type="number" name="inventory" placeholder="请填写库存" value="<% entity.write("inventory"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">交货时间：</td>
                        <td><input type="text" class="Wdate" name="firstdeliverytime" value="<% out.print(firstdeliverytime); %>">--<input type="text" class="Wdate" name="seconddeliverytime" value="<% out.print(seconddeliverytime); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">全水份：</td>
                        <td><input type="text" name="allmoisture" value="<% entity.write("allmoisture"); %>" placeholder="请填写全水分"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">水份：</td>
                        <td><input type="text" name="moisture" value="<% entity.write("moisture"); %>" placeholder="请填写水分"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">灰份：</td>
                        <td><input type="text" name="ashconten" value="<% entity.write("ashconten"); %>" placeholder="请填写灰分"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">挥发份：</td>
                        <td><input type="text" name="volatile" value="<% entity.write("volatile"); %>" placeholder="请填写挥发份"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">焦渣特性：</td>
                        <td><input type="text" name="cokedustfeatures" value="<% entity.write("cokedustfeatures"); %>" placeholder="请填写焦渣特性"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">固定碳：</td>
                        <td><input type="text" name="FCad" value="<% entity.write("FCad"); %>" placeholder="请填写固定碳"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">全硫：</td>
                        <td><input type="text" name="totalsulfur" value="<% entity.write("totalsulfur"); %>" placeholder="请填写全硫"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">氪：</td>
                        <td><input type="text" name="krypton" value="<% entity.write("krypton"); %>" placeholder="请填写氪"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">发热量：</td>
                        <td><input type="text" name="calorific" value="<% entity.write("calorific"); %>" placeholder="请填写发热量"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">灰熔融性：</td>
                        <td><input type="text" name="ashfusibility" value="<% entity.write("ashfusibility"); %>" placeholder="请填写灰熔融性"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">黏结指数：</td>
                        <td><input type="text" name="cakingexponent" value="<% entity.write("cakingexponent"); %>" placeholder="请填写黏结指数"></td>
                    </tr>
                    <tr>
                        <td class="tr w120">减灰（回收率）：</td>
                        <td><input type="text" name="firstdeliverytime" value="<% entity.write("recoveryratio"); %>" placeholder="请填写减灰（回收率）"></td>
                    </tr>
                    <tr>
                        <td class="tr">作者ID：</td>
                        <td><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label></td>
                    </tr>   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/goods.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script type="text/javascript">
            //data-val:默认值
            //dict-name:对应表单的name值
            dictdata["area"] = AreaListData;
        </script>
        <script>
            $('.Wdate').click(function () {
                WdatePicker({el: this, dateFmt: 'yyyy-MM-dd HH:mm'});
            });
            $(document).ready(function () {
                if ($(".footer input").val() == "append") {
                    $("td input").val("");
                    $(".type").val(1)
                }
            })
            $('.Wdate').click(function () {
                WdatePicker({el: this, dateFmt: 'yyyy-MM-dd HH:mm'});
            });
            if (!isNaN($(".Wdate").val())) {
                $(".Wdate").val("")
            }
            $(document).ready(function () {
                $(".goodskey").val($(".goodstype option:selected").text());
            })
            $(".goodstype").change(function () {
                var thisval = $(this).val();
                $.each(dictdata["coaltype"], function (k, v) {
                    if (thisval == k) {
                        $(".goodskey").val(v);
                    }
                })
            })
            $(".sum").bind("input propertychange", function () {
                if (isNaN($(this).val())) {
                    $(this).val($(this).val().substring(0, $(this).val().length - 1));
                }
            })

            $(".popupwrap").submit(function () {

                var i = 0;
                $(".popupwrap td>input").each(function () {
                    if ($(this).val() == "") {
                        i++;
                    }
                })
                if (i != 0) {
                    alert("请完善商品信息！")
                    return false;
                }
                if(isNaN($(".sum").val())){
                    alert("金额不能为数字！");
                    return false;
                }
            })
        </script>
        <script src="/js/upload.js" type="text/javascript"></script>
        <script src="ico.js" type="text/javascript"></script>
    </body>
</html>