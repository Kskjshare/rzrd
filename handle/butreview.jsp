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
    String shencha="建议审查";
    StaffList.IsLogin(request, response);
    RssList list = new RssList(pageContext, "suggest");
    RssListView entity = new RssListView(pageContext, "sort");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    RssList usercompxieban = new RssList(pageContext, "suggest_xieban_company");
   //zyx
    RssList entity2 = new RssList(pageContext, "companytypee_classify");
    HttpRequestHelper req1 = new HttpRequestHelper(pageContext).request();
//    zyx end
    list.request();
    entity.request();
    if (!list.get("action").isEmpty()) {
        list.remove("id");
        list.keyvalue("examination", 2);
       // list.keyvalue("handlestate",3);
        usercomp.delete().where("suggestid=" + list.get("id")).submit();
        usercompxieban.delete().where("suggestid=" + list.get("id")).submit();
        if (!list.get("realcompanyid").equals(",")) {
            String[] bb = list.get("realcompanyid").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    usercomp.keyvalue("suggestid", list.get("id"));
                    usercomp.keyvalue("companyid", bb[i]);
                    usercomp.keyvalue("type", 2);
                    usercomp.append().submit();
                }
            }
            list.keyvalue("handlestate",3);
        }else{
             list.keyvalue("handlestate",2);
        }
        
            //协办单位
        if (!list.get("coorganiserid").equals(",")) {
            String[] cc = list.get("coorganiserid").split(",");
            for (int i = 0; i < cc.length; i++) {
                if (!cc[i].isEmpty()) {
                    usercompxieban.keyvalue("suggestid", list.get("id"));
                    usercompxieban.keyvalue("companyid", cc[i]);
                    usercompxieban.keyvalue("type", 2);
                    usercompxieban.append().submit();
                }
            }
        }
        
        list.remove("realcompanyid");
        list.remove("coorganiserid");//从sql语句中移除协办单位
        list.keyvalue("handlestate",3);
        list.update().where("id=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
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
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;font-weight: bold;}
            #co-smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #co-smalltab .tdleft{text-align: left;}
            #co-smalltab span{color: #186aa3;margin: 0 10px;font-weight: bold;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #selalert{margin: 100px auto;;width: 400px;background: #dce6f5;line-height: 34px;display: none}
            #selalert #alerthead{color: #fff}
            #selalert>table{margin: 0 auto 5px;background:#fff;line-height: 34px;width: 97%;color: #666; }
            #selalert>table td{position: relative;}
            #selalert>table td input{height: 28px;}
            #selalert>table span{padding: 5px 10px;margin: 0 20px;background: #a79012;color: #fff;border-radius: 5px;cursor: pointer}
            #selalert>table span:first-child{background: #186aa3;margin-left: 100px}
            #selalert .w100{text-align:right;}
            #selalert .alerthead{text-align: center;background: #82bee9;color: black;}
            #selalert ul{position: absolute;left:3px ;top: 30px;background: #fff;z-index: 99;border: #666 solid 1px;border-radius: 5px;color: #000;overflow-x:hidden;overflow-y:auto; display: none;max-height: 110px;}
            #selalert ul li{text-indent: 5px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #selalert ul li:hover{background:#dce6f5; }
            .disnone{display: none}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
 	   <!--
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">届次</td><td class="w261" name="sessionid" sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">会议次数</td><td colspan="3" lass="w261" companytypeeeclassify="<% entity.write("meetingnum"); %>"></td></tr>
	    -->

                    <tr><td class="w120 dce">编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">类型</td><td class="w261" lwstate="<%
                        if (entity.get("lwstate").equals("1") ) {
                            out.print("建议");
                        }
                        else if (entity.get("lwstate").equals("2") ) {
                            out.print("议案");
                            shencha = "议案审查";
                        }
                        else  if (entity.get("lwstate").equals("3") ) {
                            out.print("批评");
                            shencha = "批评审查";
                        }
                        else   if (entity.get("lwstate").equals("4") ) {
                            out.print("意见");
                            shencha = "意见审查";
                        }
                         else   if (entity.get("lwstate").equals("5") ) {
                            out.print("质询");
                            shencha = "质询审查";
                        }
                        
                    %>"></td></tr>
                    <tr><td class="w120 dce">标题</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">内容</td><td colspan="3"><% entity.write("matter"); %></td></tr>
                 
<!---added by ding -->
                    <tr><td class="w200 dce">领衔代表</td><td colspan="3"><% entity.write("realname"); %></td></tr>


	<tr><td class="w120 dce">附议代表</td><td colspan="3">
                                                  <%
                                                        if (!entity.get("id").isEmpty()) {
                                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                                            while (secondlist.for_in_rows()) {
                                                    %>
                                                        <% entity.write(secondlist.get("realname"));%>
                                                        <% out.print(secondlist.get("realname"));%>
                                                        <% out.print("    ");%>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                	</td>
			</tr>
<!---added end -->


 	
                    <tr><td colspan="4" id="tabheader" >
                            <%
                            out.print(shencha);
                            %>
                        </td></tr>
                   
                    <tr><td class="w120 dce">审查分类</td>
                        <td colspan="3">
                        <select style="width:200px;font-size:16px" value="<% entity2.write("name"); %>" name="reviewclass" companytypeeclassify="<% entity.write("reviewclass"); %>">
                                 
                                <%
                                    entity2.select().where("name like '%" + 
                                    URLDecoder.decode(req1.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                    int a=1;
                                         while (entity2.for_in_rows()) {
                                %>
                                <option><% entity2.write("name"); %></option>
                                <%
                                   a++;
                                }
                                %>
                            </select>
<!--                            zyx修改，解决议案建议审查分类默认为空的bug -->
                        </td>
                    </tr>
<!--                    <tr><td class="w120 dce">办理方式</td><td><select class="w206" name="handle" dict-select="handle" def="<% entity.write("handle"); %>"></select></td><td class="w120 dce">审查分类</td><td><select class="w206" name="reviewclass" dict-select="reviewclass" def="<% entity.write("reviewclass"); %>"></select></td></tr>-->
                    <tr class="h210">
                        <td class="w120 dce">主办单位</td>
                        <td colspan="3" class="vertop">
                            <table id="smalltab">
                                <tr>
                                    <td colspan="6" class="tdleft">
                                        <span tradd>增加</span><span trdel>删除</span>
                                        <input class="disnone" name="realcompanyid">
                                        <input class="disnone" name="realcompanyname">
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" id="checkboxall"></td>
                                    <td style="display: none;">单位编号</td>
                                    <td>单位名称</td>
                                    <td style="display: none;">单位类别</td>
                                    <td style="display: none;">办理类型</td>
                                    <td></td>
                                </tr>
                                <%
                                            RssListView companylist = new RssListView(pageContext, "suggest_company");
                                            companylist.select().where("suggestid in (" + entity.get("id") + ") and type =2").get_page_desc("suggestid");
                                            int nuu = 1;
                                            while (companylist.for_in_rows()) {
                                        %>
                                <tr class="sellist" allname="<% out.print(companylist.get("allname"));%>" realid="<% out.print(companylist.get("companyid"));%>">
                                    <td><input type="checkbox" class="checksel"></td>
<!--                                 //    <td><% out.print(companylist.get("code"));%></td>-->
                                    <td class="tdleft" style="text-align:center;"><% out.print(companylist.get("allname"));%></td>
                                    <td class="tdleft" companytypeclassify="<% out.print(companylist.get("comtype"));%>"></td>
<!--                                    <td></td>-->
                                </tr>
                                        <%
                                            }
                                        %>
                            </table>
                        </td></tr>




                        <tr class="h210"><td class="w120 dce">协办单位</td><td colspan="3" class="vertop">
                            <table id="co-smalltab">
                                <tr>
                                    <td colspan="6" class="tdleft">
                                        <span coAdd>增加</span>
                                        <span coDel>删除</span>
                                        <input class="disnone" name="coorganiserid">
                                        <input class="disnone" name="coorganisername">
                                    </td>
                                </tr>
                                <tr>
                                    <tr>
                                    <td><input type="checkbox" id="checkboxall"></td>
                                    <td style="display: none;">单位编号</td>
                                    <td>单位名称</td>
                                    <td style="display: none;">单位类别</td>
                                    <td style="display: none;">办理类型</td>
                                    <td></td>
                                </tr>
                                </tr>
                                <%
                                            RssListView companylist1 = new RssListView(pageContext, "suggest_xieban_company");
                                            companylist1.select().where("suggestid in (" + entity.get("id") + ") and type =2").get_page_desc("suggestid");
                                           
                                            while (companylist1.for_in_rows()) {
                                        %>
                                <tr class="sellist1" allname="<% out.print(companylist1.get("allname"));%>" realid="<% out.print(companylist1.get("companyid"));%>">
                                    <td>
                                        <input type="checkbox" class="checksel">
                                    </td>
                                   <!-- <td><% out.print(companylist1.get("code"));%></td> -->
                                    <td class="tdleft" ><% out.print(companylist1.get("allname"));%></td>
                                    <td class="tdleft" companytypeclassify="<% out.print(companylist1.get("comtype"));%>"></td>
                                    <td></td>
                                <tr>
                                        <%
                                            }
                                        %>
                            </table>
                        </td></tr>


                    <tr><td class="w120 dce">审查单位</td><td colspan="4"><% out.print(UserList.RealName(request));%></td>
                        <!--<td class="w120 dce">审查时间</td><td rssdata="<% entity.write("shijian");%>,yyyy-MM-dd"></td>-->
                    </tr>
                </table>
            </div>
            <div id="selalert">
                <table>
                    <tr><td class="alerthead" colspan="2">增加承办单位</td></tr>
                    <tr><td class="w100">单位编号：</td><td><input autocomplete="off" class="w200" id="comcode"><ul class="w200" id="com1"></ul></td></tr>
                    <tr><td class="w100">单位名称：</td><td><input autocomplete="off" class="w200" id="comname"><ul class="w200" id="com2"></ul></td></tr>
                    <tr><td class="w100">办理类型：</td><td id="handle"></td></tr>
                    <tr><td class="w100">单位类别：</td><td id="comtype"></td></tr>
                    <tr><td></td><td><span>确定</span><span>取消</span></td></tr>
                </table>
            </div>

       

            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script>
         //增加
            $('[tradd]').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("tr[realid='" + v.myid + "']").length == "0") {
//                           $("#smalltab tbody").append('<tr class="sellist" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td>' + v.code + '</td><td class="tdleft">' + v.realname + '</td><td class="tdleft">' + v.comtype + '</td><td></td></tr>') 
                            $("#smalltab tbody").append('<tr class="sellist" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td class="tdleft" style="text-align:center;">' + v.realname + '</td><td></td></tr>')
                        }
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 500, 600);
            });

<!---added by ding-->
  <!--//协办单位增加-->
            $('[coAdd]').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("tr[realid='" + v.myid + "']").length == "0") {
//                            $("#co-smalltab tbody").append('<tr class="sellist1" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td>' + v.code + '</td><td class="tdleft">' + v.realname + '</td><td class="tdleft">' + v.comtype + '</td><td></td></tr>')
                            $("#co-smalltab tbody").append('<tr class="sellist1" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td style="text-align:center;" class="tdleft">' + v.realname + '</td><td></td></tr>')
                        }
                       
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 500, 600);
            });
   <!--//协办单位删除-->
            $("[coDel]").click(function () {
                $("#co-smalltab .sellist1").find("input:checked").parent().parent().remove();
            })
<!--added end-->

            //删除
            $("[trdel]").click(function () {
                $("#smalltab .sellist").find("input:checked").parent().parent().remove();
            })
            //全选
            $("#checkboxall").change(function () {
                if ($(this).is(":checked")) {
                    $(".checksel").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $(".checksel").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })

            $(".footer>button").click(function () {
                if($(".sellist").length==0){
                    alert("请选择承办单位！");
                    return false;
                }
                var realcompanyid = [], realcompanyname = [];
                $(".sellist").each(function () {
                    realcompanyid.push($(this).attr("realid"));
                    realcompanyname.push($(this).attr("allname"))
                })
                realcompanyid = jQuery.unique(realcompanyid)
                realcompanyname = jQuery.unique(realcompanyname)
                var realcompany = realcompanyid.join(",")
                var realcompanyname = realcompanyname.join(",")
                $("input[name='realcompanyid']").val("," + realcompany)
                $("input[name='realcompanyname']").val(realcompanyname)
                if (realcompanyname.length != 0) {
                    $("input[name='handlestate']").val("3")
                }
                //协办单位
                var coorganiserid = [], coorganisername = [];
                $(".sellist1").each(function () {
                    coorganiserid.push($(this).attr("realid"));
                    coorganisername.push($(this).attr("allname"))
                })
                coorganiserid = jQuery.unique(coorganiserid)
                coorganisername = jQuery.unique(coorganisername)
                var realcompany1 = coorganiserid.join(",")
                var coorganisername = coorganisername.join(",")
                $("input[name='coorganiserid']").val("," + realcompany1)
                $("input[name='coorganisername']").val(coorganisername)
                if (coorganisername.length != 0) {
                    $("input[name='handlestate']").val("3")
                }
            });
            
//            $(".footer>button").click(function () {
//                var realcompanyid = [],realcompanyname=[];
//                $(".sellist").each(function () {
//                    realcompanyid.push($(this).attr("realid"));
//                    realcompanyname.push($(this).attr("allname"))
//                })
//                realcompanyid = jQuery.unique(realcompanyid)
//                realcompanyname = jQuery.unique(realcompanyname)
//                var realcompany = realcompanyid.join(",")
//                 var realcompanyname = realcompanyname.join(",")
//                $("input[name='realcompanyid']").val("," + realcompany)
//                $("input[name='realcompanyname']").val(realcompanyname)
//            })
//            function tabsel() {
//                $(".sellist").off("click").click(function () {
//                    $(this).addClass("sel").siblings().removeClass("sel");
//                })
//            }
//            function alclear() {
//                $("#selalert").hide();
//                $("#comcode").removeAttr("code")
//                $("#selalert input").val("");
//                $("#selalert").hide();
//                $("#handle").text("");
//                $("#comtype").text("");
//            }
        </script>
    </body>
</html>