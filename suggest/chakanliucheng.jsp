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
            /*#resumeinfo{display: none;}*/
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 100%;}
            #resumeinfo>table{width: 100%;height: 100%;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin}
            .xz{width: 70%;border: 0px;}
            .zuo{margin-left: 24%;}
            .span{position: absolute;left: 28em;}
            .popupwrap div>tr:last-of-type{height: 297px;}
            .iframe{height: 90%;height: 245px;}
            .dbyj{height: 130px;}
            /*.iframe p{height: 100%;background-color: white;}*/
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
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">操作日志记录</li></ul>

                            <div id="resumeinfo">

                                <p class="yjsm">
                                    <%
                                        if (!(entity.get("ProposedBill").isEmpty())) {
                                    %>
                                    提交时间：<input id="tijiao" type="text" class="xz" rssdate="<% entity.write("ProposedBill");%>"><br>
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
                                    议审委审查时间：<input id="shencha" type="text" class="xz" rssdate="<% entity.write("xzReviewTime");%>"><br>
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
<!--<script>
            $(function () {

                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })

            // alert("contextPath::"+pageContext.request.contextPath);//jackie debug
        </script>-->
<script>

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
                    $('#two').attr('class','nav-item blue') //added by ding
                    
                    $('#three').attr('class','nav-item blue')
                    $('#four').attr('class','nav-item yel')
                }
                if($('#jiaoban').val() !== undefined) {
                    $('#two').attr('class','nav-item blue') //added by ding
                    $('#three').attr('class','nav-item blue')//added by ding
                    
                    $('#four').attr('class','nav-item blue')
                    $('#five').attr('class','nav-item yel')
                }
                if($('#dafu').val() !== undefined) {
                    $('#two').attr('class','nav-item blue') //added by ding
                    $('#three').attr('class','nav-item blue')//added by ding
                    $('#four').attr('class','nav-item blue')//added by ding
                    
                    $('#five').attr('class','nav-item blue')
                    $('#six').attr('class','nav-item blue')
                }

</script>
    </body>
</html>
