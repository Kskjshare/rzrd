<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>


<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookie = new CookieHelper(request, response);
    
    RssList entity = new RssList(pageContext, "finance_public");
    //RssListView entityView = new RssListView(pageContext, "supervision_topic");
    entity.request();
    //entityView.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
    
    
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "财政监督";
    
    int state = 0 ;
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
    

    RssListView user = new RssListView(pageContext, "user_delegation");
    //RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + entity.get("myid")).get_first_rows();
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
            .cellbor td img{width: 100%}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{min-height: 100px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .popupwrap>div:first-child{height: 100%;}
            td>h1{text-align: center;margin:0;}
            .xz{width: 70%;border: 0px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"><%out.print(title);%></td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>-->
                  
                 
                    <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 

                          out.print(user.get("realname"));
                        
                        %></td>                
                    </tr>
                   
    
                   <tr>                   
                       <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                       <td class="w250"  rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                      
                    </tr>
             
            <%
                int items = 1 ;
                String titlestr[] = new String[10];
                String prefpath[] = new String[10];
                String prefname[] = new String[10];
                titlestr[ 0] = "预算文件";
               
           
            int i = 1 ;
            for ( int ii = 0 ; ii< items ; ii ++ ) {
//                 prefpath[ ii ] = "enclosure" + i ;
//                 prefname[ ii ] = "enclosurename" + i ;
                 
                 prefpath[ ii ] = "enclosure"  ;
                 prefname[ ii ] = "enclosurename" ;

                 i ++ ;
            %>
             <tr>
                <td class="dce" style="width:160px;font-size:15px;font-family: 微软雅黑"><%out.print(titlestr[ ii ]);%></td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry0 = {"", "", ""};
                     if (!entity.get( prefpath[ii]  ).isEmpty()) {
                         String[] str1 = entity.get( prefpath[ii]  ).split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry0[idx] = str1[idx];
                 %>
                 <%  entity.write( prefname[ii] ); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr>
            <%
            }
            %>  

                    
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/nationality.js"></script>
        <script src="/data/session.js"></script>
        <script src="/data/dictdata.js"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
            if (<% entity.write("nationid"); %>) {
                $("#nationid").text(dictdata["nationid"][<% entity.write("nationid");%>][0])
            }

        </script>
    </body>
</html>