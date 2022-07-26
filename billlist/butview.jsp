<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "sort");
//    RssList sessionid = new RssList(pageContext, "session");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();

//    sessionid.select().where("id=?", entity.get("sessionid")).get_first_rows();

 //取建议表
     RssList suggestTable = new RssList(pageContext, "suggest");
    suggestTable.request();
    suggestTable.select().where("id=?", suggestTable.get("id")).get_first_rows();
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
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{height: 100%;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 100%;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            .popupwrap>div:first-child{height: 100%;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 100%;}
            .xz{width: 70%;border: 0px;}
             .zuo{margin-left: 33%;}/*张迎新修改*/
            .zuo1{margin-left: 26%;}/*张迎新修改*/
             .zuo2{margin-left: 10%;}/*张迎新修改*/
            .span{position: absolute;left: 32em;}/*张迎新修改*/
            .popupwrap div>tr:last-of-type{height: 297px;}
            .iframe{height: 90%;height: 245px;}
            .bg{font-size:14px;height:100%;background:#FFF;margin:0 .9%;padding:3px;border:#6caddc solid thin;}
            .nav{
                display:flex;
                /*margin-left:130px;*/
                /*margin: 0px auto;*/
                margin-top: 3px;
                margin-bottom: 5px;
            }
            .nav .nav-item{
                width:120px;
                height:30px;
                margin-left: 1px;
                text-align: center;
                line-height: 30px;
                color: #FFF
            }
            .nav-yuanshi{
                width:120px;
                height:30px;
                margin-left: 1px;
                text-align: center;
                line-height: 30px;
                color: #FFF;
                background-color: #778899;
            }
            .img1{
                z-index: 10;
            }

            .blue{background-color: #20c1ff;}
            .yel{background-color: #FFD700 ;}
            .pink{background-color: pink;}
            .nn{background-color: #dce6f5;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <div style="display:flex; justify-content: center">
                    <div class="nav">
                        <!--流程的进度-->
                    </div>
                </div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">标题</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <!--
                    <tr>
                        <td class="w120 dce">届次</td><td class="w261"  sessionclassify="<% entity.write("sessionid"); %>"></td>
                        <td class="w120 dce">会议次数</td><td class="w261"  companytypeeeclassify="<% entity.write("meetingnum"); %>"></td>
                    </tr>
                    -->
                    <tr>
                        <td class="w120 dce">分类</td><td class="w261" companytypeeclassify="<% entity.write("reviewclass"); %>">
                        </td><td class="w120 dce">审查状态</td><td class="w261" examination="<% 
                            entity.write("examination"); 
                        %>" registertype="<% entity.write("registertype"); %>">
                        </td>
                    </tr>
                    <tr>
                        <!--
                        <td class="w120 dce" >层次：</td>
                        <td colspan="3" class="w261" circles="<% entity.write("level"); %>"></td>
                        <td class="w120 dce"  style="display: none;">可否联名提出</td>
                        <td style="display: none;" class="w261" seconded="<% entity.write("seconded"); %>"></td>
                        -->
                          <td class="w120 dce">主办单位</td>
                        <td colspan="3" class="w261" circles="<% suggestTable.write("realcompanyname"); %>"></td>
                    </tr>
                    
                     <tr>
                        <td class="w120 dce">协办单位</td>
                     
                        <td colspan="3" class="w261" circles="<% suggestTable.write("coorganisername"); %>"></td>     
                    </tr>
                    
                    <tr style="display: none;"><td class="w120 dce">是否会上</td><td class="w261" judgment="<% entity.write("meet"); %>"></td><td class="w120 dce">可否网上公开</td><td class="w261" judgment="<% entity.write("permission"); %>"></td></tr>
                    <tr><td class="w120 dce">附件</td><td colspan="3">
                            <%
                                RssList user1 = new RssList(pageContext, "suggest");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <input style="font-size:14px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  user1.write("enclosurename"); %>"/>
                            <a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击下载</a>
                            <!--zyx添加，查看页面显示附件文件名称。-->
                            <%
                                    }
                                }
                            %></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">内容</li><li>提出者信息</li><li>议案办复信息</li><li>代表评价</li><li>操作日志记录</li></ul>
                            <div class="iframe"><p><iframe src="butview_1.jsp?id=<% out.print(entity.get("id"));%>"></iframe></p></div>
                            <div id="tczxx">
                                <%
                                    RssListView user = new RssListView(pageContext, "user_delegation");
                                    if (entity.get("myid").isEmpty()) {
                                        entity.keymyid(UserList.MyID(request));
                                    }
                                    user.select().where("myid=?", entity.get("myid")).get_first_rows();
                                %>   
                                <table>
                                    <tbody>
                                        <tr><td>编号</td><td><% user.write("code"); %></td><td>姓名</td><td><% user.write("realname"); %></td></tr>
                                        <tr><td>性别</td><td sex="<% user.write("sex"); %>"></td><td>民族</td><td nationid="<% out.print(user.get("nationid")); %>"></td></tr>
                                        <tr><td>党派</td><td clan="<% user.write("clan"); %>"></td><td>出生年月</td><td rssdate="<% out.print(user.get("birthday")); %>,yyyy-MM"></td></tr>
                                        <tr><td>单位名称</td><td colspan="3"><% user.write("company"); %></td></tr>
                                        <tr><td>代表团</td><td><% user.write("delegationname"); %></td><td>联系电话</td><td colspan="3"><% user.write("dbtdh"); %></td></tr>
                                        <tr><td>附议代表</td><td colspan="3"><ul id="blfyr">
                                                    <b class="zuo2">姓名</b><b class="zuo">电话</b><b class="zuo1">职务</b> <!--张迎新修改-->
                                                    <%
                                                        if (!entity.get("id").isEmpty()) {
                                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                                            while (secondlist.for_in_rows()) {
                                                    %>
                                                    <li style="margin-left:10%;" myid='<% out.print(secondlist.get("userid"));%>'><!--张迎新修改-->
                                                        <% out.print(secondlist.get("realname"));%><span class="span"><% out.print(secondlist.get("telphone"));%></span><span style="position: absolute;left: 47em;"><% out.print(secondlist.get("job"));%></span></li>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                </ul></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="resumeinfo">
                                <%
                                    if (entity.get("resume").equals("1")) {
                                %>
<!--                                <p class="yjsm">-->
<!-- removed by ding   
                                    <%
                                        RssListView company = new RssListView(pageContext, "suggest_company");
                                        company.select().where("suggestid=" + entity.get("id")).get_first_rows();
                                        if (entity.get("BanFuName").isEmpty() && entity.get("BanFutel").isEmpty()) {
                                            if (company.get("dworxz").equals("1")) {
                                    %>
                                    <em>办复人：</em><b><% company.write("linkman"); %></b><br>
                                    <em>办复人电话：</em><b><% company.write("worktel"); %></b>
                                    <a>a</a>
                                    <%
                                    } else {
                                    %>
                                    <em>办复人：</em><b><% company.write("realname"); %></b><br>
                                    <em>办复人电话：</em><b><% company.write("worktel"); %></b>
                                    <%
                                        }
                                    %>
                                    <%
                                    } else {
                                    %>
                                    <em>办复人：</em><b><% entity.write("BanFuName"); %></b><br>
                                    <em>办复人电话：</em><b><% entity.write("BanFutel"); %></b>
                                    <%
                                        }
                                    %>
 --------------------->
 
                                    
                                                                      
<!--                                    <em>分管负责人：</em><b><% suggestTable.write("firstperson"); %></b>
                                    <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>
                                    <em>职位：</em><b><% suggestTable.write("firstpost");  %></b>
                                    <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>
                                    <em>电话：</em><b><% suggestTable.write("firstphone"); %></b><br>
                                    
                                    <em>具体承办人：</em><b><% suggestTable.write("secondperson"); %></b>
                                    <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>
                                    <em>职位：</em><b><% suggestTable.write("secondpost"); %></b>
                                    <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</em>
                                    <em>电话：</em><b><% suggestTable.write("secondphone"); %></b><br>-->
                                    <table style="background-color:white;width:98%;margin:0 auto;" class="yjsm">
                                    <tr>
                                        <!--zyx-->
                                      <%
                                    if ( suggestTable.get("firstperson").equals("")){
                                    %>
                                    <%
                                    }else{
                                    %>  
                                        <td style="border:#ffffff solid 1px;">分管负责人：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("firstperson"); %></td>
                                        <td style="border:#ffffff solid 1px;">职位：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("firstpost");  %></td>
                                        <td style="border:#ffffff solid 1px;">电话：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("firstphone"); %></td>    
                                         <%
                                    };
                                    %>
                                    <%
                                    if ( suggestTable.get("secondperson").equals("")){
                                    %>
                                    <%
                                    }else{
                                    %>
                                    </tr>
                                    <tr>
                                        <td style="border:#ffffff solid 1px;">具体承办人：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("secondperson"); %></td>
                                        <td style="border:#ffffff solid 1px;">职位：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("secondpost");  %></td>
                                        <td style="border:#ffffff solid 1px;">电话：</td>
                                        <td style="border:#ffffff solid 1px;"><% suggestTable.write("secondphone"); %></td>
                                    </tr>
                                     <%
                                    };
                                    %>
                                    <!--zyx end-->
<!--                                    张迎新修改对齐样式-->
                                </table>
                                    
                                <!--</p>-->
                                <%
                                    }
                                %>
                                <h6>办复附件</h6>
                                <%
                                    RssList user11 = new RssList(pageContext, "suggest");
                                    user11.select().where("id=?", entity.get("id")).get_first_rows();
                                    String[] arry11 = {"", "", ""};
                                    if (!user11.get("dfenclosure").isEmpty()) {
                                        String[] str = user11.get("dfenclosure").split(",");
                                        for (int idx = 0; idx < str.length; idx++) {
                                            arry11[idx] = str[idx];
                                %>
                                <p>
                                    <!--zyx--> 
                                    <input style="font-size:14px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  user11.write("dfenclosurename"); %>"/>
                                    <a href="/upfile/<% out.print(arry11[idx]); %>" style="cursor: pointer;color: red;font-weight: bold;">点击下载</a>
                                    <!--zyx end-->
                                </p>
                                    <%
                                            }
                                        }
                                    %>
<!--                                <h6>意见说明</h6>
                                <p class="yjsm"><% entity.write("comments"); %></p>-->
                                <h6>办理报告</h6>
                                <div class="bg"><% entity.write("resumeinfo");%>  </div>
                            </div>
                            <div id="resumeinfo">
                                <h6>领衔代表意见说明</h6>
                                <table class="wp100 cellbor">
                                    <tbody>
                                        <tr><td  class="w120 dce">面商</td><td style="background-color:white;" effect="<% out.print(entity.get("effect")); %>"></td></tr>
                                        <tr><td  class="w120 dce">态度</td><td style="background-color:white;" effect="<% out.print(entity.get("effect3")); %>"></td></tr>
                                        <tr><td  class="w120 dce">答复</td><td style="background-color:white;" effect="<% out.print(entity.get("effect2")); %>"></td></tr>
                                        <tr><td  class="w120 dce">结果</td><td style="background-color:white;" effect="<% out.print(entity.get("effect4")); %>"></td></tr>
                                        <tr style="height:100px;" ><td class="w120 dce">代表意见</td><td style="background-color:white;" class="dbyj"><span><% entity.write("opinion");%></span></td></tr>
                                    </tbody>
                                </table>
                                    <!--zyx修改，办理报告页面显示问题-->
<!--                                <p class="yjsm"><b><% entity.write("realname"); %>：</b><b effect="<% out.print(entity.get("effect")); %>"></b>：&nbsp;&nbsp;&nbsp;<% entity.write("opinion");%>
                                </b>：&nbsp;&nbsp;&nbsp;<% entity.write("comments");%></p>-->
                                <h6>附议代表意见说明</h6>
                                <%
                                    RssListView comments = new RssListView(pageContext, "suggestcomments");
//                                    comments.query("select * from suggestcomments_list_view where suggestid="+entity.get("id"));
                                    comments.select().where("suggestid=" + entity.get("id")).query();
                                    while (comments.for_in_rows()) {
                                %>
                                <p class="yjsm"><b><% comments.write("realname"); %>：</b><b effect="<% out.print(comments.get("effect")); %>"></b>：&nbsp;&nbsp;&nbsp;<% comments.write("comments"); %></p>
                                <%
                                    }
                                %>
                            </div>
                            <div id="resumeinfo">

                                <p class="yjsm">
                                    <%
                                        if (!(entity.get("ProposedBill").isEmpty())) {
                                    %>
                                    提交时间：<input  id="tijiao" type="text" class="xz" rssdate="<% entity.write("ProposedBill");%>"><br>
                                    <%
                                        }
                                        if (!(entity.get("InitialReviewTime").isEmpty())) {
                                    %>
                                    初审时间：<input id="chushen" type="text" class="xz" rssdate="<% entity.write("InitialReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(entity.get("ReviewTime").isEmpty())) {
                                    %>
                                    复审时间：<input id="fushen" type="text" class="xz" rssdate="<% entity.write("ReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(entity.get("xzReviewTime").isEmpty())) {
                                    %>
                                    乡镇人大主席团审查时间：<input id="shencha" type="text" class="xz" rssdate="<% entity.write("xzReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(entity.get("AssignedByTime").isEmpty())) {
                                    %>
                                    交办时间：<input id="jiaoban" type="text" class="xz" rssdate="<% entity.write("AssignedByTime");%>"><br>
                                    <%
                                        }
                                        if (!(entity.get("ResponseTime").isEmpty())) {
                                    %>
                                    答复时间：<input id="dafu" type="text" class="xz" rssdate="<% entity.write("ResponseTime");%>"><br>
                                    <%
                                        }
                                    %>
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script>
//            http://219.159.165.98:81/upfile/1811/0514/6593c1fc95dd53f0.xlsx
//    function xz() {
//        var xz = $(".xz").val();
//        var zz = xz.substring(0, xz.indexOf(","));
//        var xx = "";
//        for (var idx = 0; idx < zz.length; idx++) {
//            xx = zz;
//        }
//        var $form = $('<form method="GET"></form>');
//        $form.attr('action', "http://219.159.165.98:81/upfile/" + xz);
//        $form.appendTo($('body'));
//        $form.submit();
//    }
//            $("tr #xz").click(function (){
//              window.open("",'_blank');
//            });
            $(".uetd>ul>li").click(function () {

                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })
            
            
            
            <%
                RssList entitylist = new RssList(pageContext, "suggest");
                entitylist.select().where("id=?", entity.get("id")).get_first_rows();
                if(entitylist.get("ismeet") != null && !"".equals(entitylist.get("ismeet")) && "0".equals(entitylist.get("ismeet"))){
                    //说明是闭会期间提的建议
                    //判断是县代表还是乡镇代表
                    if(entitylist.get("isysw") != null && !"".equals(entitylist.get("isysw")) && "21".equals(entitylist.get("isysw"))){
                        //说明是县代表流程
                        %>
                            let str = '<div id="one" class="nav-yuanshi" style="width:80px;">提交</div>' + 
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />' + 

                                '<div id="two" class="nav-yuanshi" style="width:80px; margin-left: -12px">审查</div>' + 
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+

                                '<div id="four" class="nav-yuanshi" style="width:80px; margin-left: -12px">交办</div>'+
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+

                                '<div id="five" class="nav-yuanshi" style="width:80px; margin-left: -12px">答复</div> '+
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                                '<div id="six" class="nav-yuanshi"  style="width:80px; margin-left: -12px">已办结</div>';
                            $(".nav").append(str);
                        <%
                    }else{
                        //说明是乡镇的
                        %>
                            let str = '<div id="one" class="nav-yuanshi" style="width:80px;">提交</div>' + 
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />' + 

                                '<div id="four" class="nav-yuanshi" style="width:80px; margin-left: -12px">审查</div>'+
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+

                                '<div id="five" class="nav-yuanshi" style="width:80px; margin-left: -12px">答复</div> '+
                                '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                                '<div id="six" class="nav-yuanshi"  style="width:80px; margin-left: -12px">已办结</div>';
                            $(".nav").append(str);
                        <%
                    }
                    
                }else{
                    //说明是开会期间提的建议
                    %>
                        let str = '<div id="one" class="nav-yuanshi" style="width:80px;">提交</div>' + 
                            '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />' + 
                            
                            '<div id="two" class="nav-yuanshi" style="width:80px; margin-left: -12px">初审</div>' + 
                            '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                            
                            '<div id="three" class="nav-yuanshi" style="width:80px; margin-left: -12px">复审</div> '+
                            '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                            
                            '<div id="four" class="nav-yuanshi" style="width:80px; margin-left: -12px">交办</div>'+
                            '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                            
                            '<div id="five" class="nav-yuanshi" style="width:80px; margin-left: -12px">答复</div> '+
                            '<img src="./img/导航箭头.png" class="img1" style="width:25px; height:32px; margin-left: -12px" />'+
                            '<div id="six" class="nav-yuanshi"  style="width:80px; margin-left: -12px">已办结</div>';
                        $(".nav").append(str);
                    <%
                }
            %>

                $('#one').attr('class','nav-item blue')
                $('#two').attr('class','nav-item yel')
                if($('#chushen').val() !== undefined) {
                    $('#two').attr('class','nav-item blue')
                    $('#three').attr('class','nav-item yel')
                }
                if($('#fushen').val() !== undefined) {
                    $('#three').attr('class','nav-item blue')
                    $('#four').attr('class','nav-item yel')
                }
                if($('#jiaoban').val() !== undefined) {
                    $('#four').attr('class','nav-item blue')
                    $('#five').attr('class','nav-item yel')
                }
                if($('#dafu').val() !== undefined) {
                    $('#five').attr('class','nav-item blue')
                    $('#six').attr('class','nav-item blue')
                }

        </script>
    </body>
</html>
