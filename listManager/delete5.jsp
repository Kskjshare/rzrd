<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "suggest");
    entity.request();
    
    
    RssList rank_sort_list = new RssList(pageContext, "rank_sort");
    rank_sort_list.request();
//    rank_sort_list.select().where("myid=" + req.get("myid") ).get_page_desc("id"); 
    rank_sort_list.select().where("myid=" + req.get("myid")).get_first_rows();
    
    
    
    if (req.get("action").equals("delete")) {

        //先读取记录，判断当前用户myid是否有领衔记录，用于下面的绩算
        RssList suggest = new RssList(pageContext, "suggest");
        suggest.request();
        suggest.select().where("lwstate=5 and myid=" + req.get("myid") ).get_page_desc("id");
        //领衔人
        int mysuggests = 0 ; //我有几条领衔记录
        while ( suggest.for_in_rows() ) { 
            mysuggests ++ ;
        }
        
        int baseSuggestScore = 6 ;
        int extraSuggestScore = 2 ;
        if ( mysuggests >= 1 ) {
           

            int suggestcnt = Integer.parseInt ( rank_sort_list.get("suggest") );
            suggestcnt -- ;
            int totalScore = Integer.parseInt ( rank_sort_list.get("totalScore") );
            
            
            if ( mysuggests == 1 ){ //如果只有一条建议，那么减6分
                totalScore -= baseSuggestScore ;
            }
            else {
                totalScore -= extraSuggestScore ;   //减2分
            }
            
            int num = Integer.parseInt ( rank_sort_list.get("num") );
            num -- ; 
            rank_sort_list.keyvalue("suggest", suggestcnt ); 
            rank_sort_list.keyvalue("totalScore", totalScore );
            rank_sort_list.keyvalue("num", num );
            
            rank_sort_list.update().where("myid=" + req.get("myid") ).submit();
        }
        else {
//            out.print("<script>alert('领衔记录大于 == 0！');</script>");
        }
        
        //查找附议人，对附议人的分数和建议条数进行处理
        RssListView list = new RssListView( pageContext, "second_suggest" );
        list.request();
        int a = 1;
        list.pagesize = 30;
        String keywhere ="lwstate=5 and draft=2 and id=" + req.get("id");
//        String keywhere ="title like '%" + list.get("title") + "%' and methoded like '%" + list.get("methoded") + "%' and organizer like '%" + list.get("organizer") + "%' and lwid like '%" + list.get("lwid") + "%' and realid like '%" + list.get("realid") + "%' and draft=2 and id=" + req.get("id");
        list.select().where( keywhere ).get_page_desc("id");
        while ( list.for_in_rows() ) { 
            RssList ranklist = new RssList(pageContext, "rank_sort");
            ranklist.request();
            ranklist.select().where("myid=" + list.get("userid")).get_first_rows();
                        
            int suggestcnt = Integer.parseInt ( ranklist.get("suggest") );
            suggestcnt -- ;
            suggestcnt = 1 ;
            int totalScore = Integer.parseInt ( ranklist.get("totalScore") );
            totalScore -= extraSuggestScore ;   //减2分
            
            int num = Integer.parseInt ( ranklist.get("num") );
            num -- ; 
            num = 1 ;
            ranklist.keyvalue("suggest", suggestcnt ); 
            ranklist.keyvalue("totalScore", totalScore );
            ranklist.keyvalue("num", num );
            ranklist.update().where("myid=" + list.get("userid") ).submit();   
        }
            

        
        
        
        
        
        
          
        entity.delete().where("id in(" + req.get("id") + ")").submit();
        //把notify_messages_list相关的记录也同步删除
        RssList notify_messages = new RssList(pageContext, "notify_messages");
        notify_messages.delete().where("relationid in(" + req.get("id") + ")").submit();
        
       
        
        
  
        
        
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
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                删除后不可恢复，请谨慎操作？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
