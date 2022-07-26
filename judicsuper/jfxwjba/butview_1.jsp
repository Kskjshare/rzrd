<%-- 
    Document   : butview_1
    Created on : 2021-3-23, 19:34:11
    Author     : Administrator
--%>


<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "shenchadengji");
    RssList entitylist = new RssList(pageContext, "suggest");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    entitylist.select().where("id=?", entity.get("id")).get_first_rows();
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
            #resumeinfo>table{width: 100%;height: 100%;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin}
            .xz{width: 70%;border: 0px;}
            .zuo{margin-left: 33%;}/*张迎新修改*/
            .zuo1{margin-left: 26%;}/*张迎新修改*/
             .zuo2{margin-left: 10%;}/*张迎新修改*/
            .span{position: absolute;left: 32em;}/*张迎新修改*/
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
            .ys{
                color: blue;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <div style="display:flex; justify-content: center">
                </div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="10" id="tabheader">
                            <% entity.write("filename"); %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            主办单位
                        </td>
                        <td colspan="8">
                            <% entity.write("organizer"); %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            文号
                        </td>
                        <td class="w261"colspan="8">
                            <% entity.write("Titanic"); %>
                        </td>
                        
                    </tr>
                    <tr>
                        <td  colspan="2" class="w120 dce">
                            报送人电话
                        </td>
                        <td  colspan="3" class="w261" companytypeeclassify="<% entity.write("telephone"); %>">
                        </td>
                        <td  colspan="2" class="w120 dce">
                            报送人
                        </td>
                        <td  colspan="3" class="w261" lwstate="<% entity.write("name"); %>">
                        </td>
                        
                        
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            备案时间
                        </td>
                        <td colspan="3"  class="w261" circles="<% entity.write("beiandate"); %>">
                        </td>
                        <td colspan="2" class="w120 dce">
                            印发时间
                        </td>
                        <td colspan="3" class="w261" examination="<% entity.write("yfdate"); %>" registertype="<% entity.write("registertype"); %>">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">
                            起草说明
                        </td>
                        <td colspan="3"  class="w261" circles="<%
                                out.print(entity.get("qcexplain"));
                                %>">
                        </td>
                        <td colspan="2" class="w120 dce">
                            法律依据
                        </td>
                        <td colspan="3" class="w261" circles="<%
                                out.print(entity.get("legalbasis"));
                                %>">
                        </td>
                    </tr>
<!--                    <tr>
                        <td class="w120 dce">起草说明</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("qcexplain"));
                                %>
                        </td>
                        <td class="w120 dce">法律依据</td>
                        <td  width="4%" class="ys">  
                            <%
                                out.print(entity.get("legalbasis"));
                                %>
                        </td>
                        <td class="w120 dce">征求意见</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("opinions"));
                                %>
                        </td>
                        <td class="w120 dce">合法性审查</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("discussion"));
                                %>
                        </td>
                        <td class="w120 dce">集体讨论</td>
                        <td  width="4%" class="ys">
                            <%
                                out.print(entity.get("review"));
                                %>
                        </td>
                    </tr>-->
                    <tr>
                        <td colspan="2" class="w120 dce">
                            附件
                        </td>
                        <td colspan="8">
                            <%
                                RssList user1 = new RssList(pageContext, "suggest");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <% out.print(entity.get("enclosurename")); %>
                            <a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;">
                               &nbsp;&nbsp;&nbsp;&nbsp; 点击下载
                            </a>
                            <%
                                    }
                                }
                            %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">内容</td>
                        <td colspan="8">
                            
                            <%
                                out.print(entity.get("remarks"));
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="w120 dce">驳回原因</td>
                        <td colspan="8">
                            
                            <%if(entity.get("firstdata").equals("")){
                            
                        }else{
                             out.print("&#9733"+entity.get("firstdata"));
                        }
                        %>    
                        <%if(entity.get("data").equals("")){
                            
                        }else{
                             out.print("<br>&#9733"+entity.get("data"));
                        }
                        %>    
                        <%if(entity.get("thirddata").equals("")){
                            
                        }else{
                             out.print("<br>&#9733"+entity.get("thirddata"));
                        }
                        %>    
                        <%if(entity.get("fourthdata").equals("")){
                            
                        }else{
                             out.print("<br>&#9733"+entity.get("fourthdata"));
                        }
                        %>    
                        <%if(entity.get("fifthdata").equals("")){
                            
                        }else{
                             out.print("<br>&#9733"+entity.get("fifthdata"));
                        }
                        %>    
                        <%if(entity.get("sixthdata").equals("")){
                            
                        }else{
                             out.print("<br>&#9733"+entity.get("sixthdata"));
                        }
                        %>    
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
            $(".uetd>ul>li").click(function () {

                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })
        </script>
    </body>
</html>