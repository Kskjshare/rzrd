<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "question_bank");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                    entity.remove("questionCategory");
                    entity.keyvalue("type",entity.get("questionCategory")); //类别
                    entity.keyvalue("questiontype",entity.get("questiontype")); // 题型（单多选）
                    entity.keyvalue("title",entity.get("title")); // 题目
                 if(entity.get("questiontype").equals("1")){
                    List<String> dsList = new ArrayList<>();  // 选项
                      for (int i = 0; i < 5; i++) {
                          entity.remove("d"+(i+1));
                          if(entity.get("d"+(i+1)) == null || "".equals(entity.get("d"+(i+1)))){
                              break;
                          }else{
                              dsList.add((char)(65+i) + "." + entity.get("d"+(i+1)));

                          }
                      }
                        String ds = String.join(".-f/,", dsList);
                        entity.keyvalue("options",ds);
                        int a=  Integer.parseInt(entity.get("answer"));
                    entity.keyvalue("answer",dsList.get(a)); //答案
                 }else if(entity.get("questiontype").equals("2")){
                       
                        List<String> dsList = new ArrayList<>();  // 选项 -循环处理
                        for (int i = 0; i < 20; i++) {
                            entity.remove("d"+(i+1));
                            if(entity.get("d"+(i+1)) == null || "".equals(entity.get("d"+(i+1)))){
                                continue;
                            }else{
                                dsList.add((char)(65+i) + "." + entity.get("d"+(i+1)));
                            }
                        }
                          String ds = String.join(".-f/,", dsList);
                          entity.keyvalue("options",ds);          

                          List<String> daan = new ArrayList<>();  // 答案 -循环处理
                          for (int j = 0; j < 20; j++) {
                              entity.remove("answer"+j);
                              if(entity.get("answer"+ j) == null || "".equals(entity.get("answer"+j))){
                                  continue;
                              }else{
                                   int a = Integer.parseInt(entity.get("answer"+j));
                                   daan.add( dsList.get( a ));

                              }
                          }
                        String solution = String.join(".-f/,", daan);
                        entity.keyvalue("answer",solution);   
                 }else if(entity.get("questiontype").equals("3")){
                    entity.remove("options");
                    entity.keyvalue("answer",entity.get("answer")); 
                 }
//                entity.keymyid(cookie.Get("myid"));
//                entity.timestamp();//添加当前时间到数据库
                entity.append().submit();
                break;
            case "update":
//                entity.remove("legislativeId");
//                entity.update().where("id=?", entity.get("legislativeId")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();//刷新查询页
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();

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
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%   ;}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }

        </style>
    </head>
    <body>
<!--        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>-->

        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">试卷信息</td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">试卷名称：<em class="red">*</em></td>
<!--                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>-->
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">创建人：<em class="red">*</em></td>
<!--                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>-->
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                      <tr>
                        <td class="dce w100 ">创建时间：</td>
                         <!--<td rssdate="<% out.print(entity.get("beginTime")); %>,yyyy-MM-dd hh:mm:ss"></td>-->
                        <td><input type="text" class="w200 Wdate" name="beginTime"  rssdate="<% out.print(entity.get("beginTime")); %>,yyyy-MM-dd HH:mm"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考题类别：<em class="red">*</em></td>
<!--                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>-->
                        <td><select style="width:100%;border: none;" class="w260" name="questionCategory" dict-select="questionCategory1"  def="<% entity.write("type"); %>"></select>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考题类型</td>
                        <td><select style="width:100%;border: none;" class="w260" name="questiontype" dict-select="questionType1" def="<% entity.write("questiontype"); %>"></select>
                    </tr>
                    <tr>
                        <td class="dce w100 ">题目：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
    <!-- 单选 -->
                
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项A：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="0"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d1" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项B：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="1"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d2" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项C：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="2"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d3" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项D：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="3"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d4" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    
                </table>
           </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(function(){
            //定义一个多选的选项数量变量
            var duoNum = 4;
            // $(".Duo").hide()
            // $(".ISTure").hide()
           
            $("[name='questiontype']").change(function duo () {
                var optionHtml = " ";
                var iteValue = $("[name='questiontype']").val();
                    if(iteValue==1){
                         $(".duoyu2").remove();
                        $(".ISTure").remove();
                        $(".Duo").remove();
                        $("#addtr").remove();
                        for (var i = 0; i < 4; i++) {
                            
                            optionHtml+='<tr class="duoyu2"><td class="dce w100 ">选项 '+ getLetter(i + 1)+'：<em class="red">*</em></td>'
                            optionHtml+= '<td colspan="3"><span style="width:20px;">&nbsp;<input type="radio" name="answer" value='+ i +'>&nbsp;'
                            optionHtml+= '</span><input type="text" maxlength="80" class="b95" name="d'+(i+1)+'" /></td></tr>'
                            
                        }
                        $('.cellbor').append(optionHtml);
                    }else if(iteValue==2){
                        $(".duoyu2").remove();
                        $(".ISTure").remove();
                        $(".Duo").remove();
                        $("#addtr").remove();
                        for (var i = 0; i < duoNum; i++) {
                            optionHtml+='<tr class="Duo"><td class="dce w100 ">选项 '+ getLetter(i + 1)+'：<em class="red">*</em></td>'
                            optionHtml+='<td colspan="3"><span style="width:20px;">&nbsp;<input type="checkbox" name="answer'+i+'" value='+ i +' >&nbsp;</span>'
                            optionHtml+='<input type="text" maxlength="80" class="b95" name="d'+(i+1)+'"  /></td></tr>'
                            
                        }
                        optionHtml+= `<tr id="addtr"><td colspan="2" style="text-align: center; ">
                            <span style=" padding: 10px; color:green;" id="add">添加</span><span style="padding: 10px; color:red;" id="del">删除</span></td></tr>`
                    
                        $('.cellbor').append(optionHtml);

                        
                    }else if(iteValue==3){
                         $(".duoyu2").remove();
                        $(".ISTure").remove();
                        $(".Duo").remove();
                        $("#addtr").remove();
                            optionHtml +='<tr class="ISTure">  <td class="dce w100 ">选项A：<em class="red">*</em></td>'
                            optionHtml +='<td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="A">&nbsp;</span> 正确</td>  </tr>'
                            optionHtml +='<tr class="ISTure"><td class="dce w100 ">选项B：<em class="red">*</em></td>'
                            optionHtml +='<td colspan="3"><span>&nbsp;<input type="radio" name="answer" value="B">&nbsp;</span> 错误</td></tr>'
                        $('.cellbor').append(optionHtml);
                    }
                    $('#add').click(function () {
                        if(duoNum<10){
                            duoNum++;
                        }
                        $(".duoyu2").remove();
                        $(".Duo").remove();
                        $(".ISTure").remove();
                        $("#addtr").remove();
                        duo();
                        // $("addtr").before()
                    })
                    $('#del').click(function () {
                        if(duoNum>4){
                            duoNum--;
                        }
                        $(".duoyu2").remove();
                        $(".Duo").remove();
                        $(".ISTure").remove();
                        $("#addtr").remove();
                        duo();
                    })
                    function getLetter(num) {
                        if (num == 1) {
                            return 'A';
                        }
                        if (num == 2) {
                            return 'B';
                        }
                        if (num == 3) {
                            return 'C';
                        }
                        if (num == 4) {
                            return 'D';
                        }
                        if (num == 5) {
                            return 'E';
                        }
                        if (num == 6) {
                            return 'F';
                        }
                        if (num == 7) {
                            return 'G';
                        }
                        if (num == 8) {
                            return 'H';
                        }
                        if (num == 9) {
                            return 'I';
                        }
                        if (num == 10) {
                            return 'J';
                        }
                };
                });
            });

              


        </script>
    </body>
</html>
