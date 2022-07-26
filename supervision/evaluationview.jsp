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
    //RssListView entityView = new RssListView(pageContext, "supervision_topic");
    //RssList entity = new RssList(pageContext, "supervision_specialwork");
    
    String titleStr = "";
    RssList entity = null ;
    String keywhere = "typeid="+req.get("typeid");  
    if ( req.get("typeid").equals("9")){
         entity = new RssList(pageContext, "supervision_inspection");
         titleStr = "调研";
    }
    else if ( req.get("typeid").equals("8")){
         entity = new RssList(pageContext, "supervision_inspection");
         titleStr = "视察";
    }
    else if ( req.get("typeid").equals("7")){
         entity = new RssList(pageContext, "supervision_dismissal");
         titleStr = "撤职案的审议和决定";
    }
    else if ( req.get("typeid").equals("6")){
         entity = new RssList(pageContext, "supervision_specific_issue");
         titleStr = "特定问题调查";
    }
    else if ( req.get("typeid").equals("5")){
         entity = new RssList(pageContext, "supervision_special_inquery");
         titleStr = "专题询问";
         keywhere = "typeid="+req.get("typeid");  
    }
    else {
        entity = new RssList(pageContext, "supervision_specialwork");
        titleStr = "听取和审议专项工作报告";
    }
   
    entity.request();
    //entityView.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
    
    
   
   
    RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
    evaluationEntity.select().where( keywhere ).get_page_desc("myid");
    int satisfaction = 0 ;
    int bascisatisfaction = 0 ;
    int dissatisfaction = 0 ;
    int abstained = 0;
    
    int  send_cnt = 0;
    int  recive_cnt = 0;
     
    
    double satisfaction_rate = 0 ;
    double bascisatisfaction_rate = 0 ;
    double dissatisfaction_rate = 0 ;
    double abstained_rate = 0 ;
    
    while (evaluationEntity.for_in_rows()) {
        if ( evaluationEntity.get("evaluationResult").equals("1") ){
             satisfaction ++ ;
        }
        else if ( evaluationEntity.get("evaluationResult").equals("2") ) {
             bascisatisfaction ++ ;
        }
        else if ( evaluationEntity.get("evaluationResult").equals("3") ) {
             dissatisfaction ++ ;
        }
        else if ( evaluationEntity.get("evaluationResult").equals("4") ) {
             abstained ++ ;
        }
    }
    
    int total = satisfaction + bascisatisfaction + dissatisfaction + abstained ;
    
    
    

    double result = satisfaction;
    double fenzi = satisfaction;
    double fenmu = total;
    result = ( fenzi *100 )/ fenmu ;
    if ( fenmu == 0 ) {
        result = 0.0;
    }
    
    
    satisfaction_rate = result ;
    
    
    
    fenzi = bascisatisfaction;  
    result = ( fenzi *100 )/ fenmu ;
    if ( fenmu == 0 ) {
        result = 0.0;
    }
    bascisatisfaction_rate =  result;
    
   
    
    fenzi = dissatisfaction ;  
    result = ( fenzi *100 )/ fenmu ;
    if ( fenmu == 0 ) {
      result = 0.0;
    }
    dissatisfaction_rate =  result;
   
    fenzi = abstained ;  
    result = ( fenzi *100 )/ fenmu ;
    if ( fenmu == 0 ) {
        result = 0.0;
    }
    abstained_rate =  result;
   

    send_cnt = satisfaction + bascisatisfaction + dissatisfaction + abstained ;
    recive_cnt = 0;

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
                    <tr>
                        <td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"> <% 
//                        if ( entity.get("lwstate").equals("3") ){
//                            out.print( "听取和审议专项工作报告" );
//                           
//                        }
                        out.print( titleStr );
                        out.print( "满意度测评结果" );
                        %>
                        </td>
                    </tr>
                   
                    
                    <tr>
                        <td class="w100 dce">满意票</td>
                        <td><% out.print( satisfaction ); %></td>
                        <td class="w100 dce" >满意率</td>
                        <td>
                            <% 
   
                            
                            out.print( satisfaction_rate  );

                            out.print( "%" );
                            %>
                        </td>                                        
                    </tr>
                    
                    <tr>
                        <td class="w100 dce">基本满意票</td>
                        <td><% out.print( bascisatisfaction ); %></td>                    
                       <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;" class="w100 dce">基本满意率</td>
                       <td >
                            <% 
                            out.print( bascisatisfaction_rate );
                            out.print( "%" );
                            %>
                        </td>          
                    </tr>
                    
                    <tr>  
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;" class="w100 dce">不满意票</td>
                        <td><% out.print( dissatisfaction ); %></td>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">不满意率</td>
                        <td >
                            <% 
                            out.print( dissatisfaction_rate );
                            out.print( "%" );
                            %>
                        </td>         
                    </tr>
                          
                    <tr>  
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"  class="w100 dce">弃权票</td>
                         <td><% out.print( abstained ); %></td>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">弃权率</td>
                         <td >
                            <% 
                            out.print( abstained_rate );
                            out.print( "%" );
                            %>
                        </td>         
                    </tr>
                    
                    
                    <tr>  
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发出测评票</td>
                         <td><% out.print( send_cnt ); %></td>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">收回测评票</td>
                         <td >
                            <% 
                            out.print( recive_cnt );

                            %>
                        </td>         
                    </tr>
                    
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