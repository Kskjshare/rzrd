<%-- 
    Document   : list
    Created on : 2021-3-2, 10:34:37
    Author     : EDZ
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html style="width: 100%; height: 100%;">
<head>
    <meta name="viewport" content="width=device-width" />
    <title>短信群发</title>
    <style type="text/css">
        #submit
        {
            display: block;
            height: 40px;
            width: 200px;
            background-color: #1E90FF;
            text-align: center;
            line-height: 40px;
            font-size: 16px;
            color: White;
            text-decoration: none;
            position: relative;
            top: 50%;
            left: 50%;
            margin-left: -100px;
            margin-top: -20px;
        }
        #submit:hover
        {
            background-color: #00BFFF;
        }
        .colo_r:hover{
            background-color: buttonface;
        }
        table{
            border-collapse: collapse;
        }
        .colo_r{
            text-align: center;
            border-style:solid;
            border-width:1px;
            border-color:#555;
        }
        td{
            border-right: 1px #555 solid;
            font-size: 8px;
        }
         li:hover{
            background-color:buttonhighlight;
        }
    </style>
</head>
<body style="height: 100%; width: 100%; overflow: hidden;">
    <div style="height: 100%; width: 40%; float: left;">
        <div style="float: left; width: 100%; margin-top: 10px; line-height: 30px; margin-bottom: 3px; height: 6%;">
            <div  class="chazhao" style="width: 100%;float:left;">
                <img style="cursor:pointer; width:18px;height:18px;float:left;position:fixed;margin-left:0.7%;margin-top:8px;" src="images/2.jpeg"/>
                <select  style="cursor:pointer; float:left;width:18%; height:34px;text-align-last: center;"><option style="text-aline:right;" >姓名</option></select>
                <input  id="tb_select_realTime"  placeholder="请输入搜索条件"  style="float:left; width:80% ; height: 30px;padding:0;"/>
                <img onclick="checkboxed(this)" style="cursor:pointer; float:right;width:30px;height:30px;margin-top:-32px;margin-right:1.6%;" src="images/chazhao.png"  no-repeat/>
            </div>
        </div>
        <div style="height: 90%; margin-top: 60px;">
            <div style="height: 100%; width: 28%; float: left;  border: 1px solid #95B8E7;">
                <ul  style="height: 100%; list-style-type:none;">
                    <li>
                        <img style="width:15px;height:15px;margin-top: 6px;" src="images/1.jpeg"  no-repeat/>
                        <a href="/judicsuper/thrques/list.jsp" style="text-decoration:none;">全部人员</a>
                    </li>
                    <li>
                        <img style="width:15px;height:15px;margin-top: 6px;" src="images/1.jpeg"  no-repeat/>
                        <a href="/judicsuper/thrques/list.jsp?my_state=5" style="text-decoration:none;">全部代表</a>
                    </li>
<!--                    <li >
                        <img style="width:15px;height:15px;margin-top: 6px;" src="images/1.jpeg"  no-repeat/>
                        <a href="" style="text-decoration:none;margin-left:1px;">接收人</a>
                    </li>-->
                </ul>
            </div>
            <div  class="allorder" style= " width: 70%; float: left; height: calc(100% + 3px);overflow:scroll; margin-left: 1px;">
                    <table style="width:100%;">
                    <thead>
                        <tr>
                            <!--<th class="bianse" onclick="checkboxed('checkbox')" style="font-weight:lighter;width:12%;heigth:30px;background-color:#3076BD;border-style:solid;border-width:1px;border-color:#E0ECFF" ></th>-->
                            <th class="bianse" style="font-weight:lighter;width:12%;heigth:30px;background-color:#3076BD;border-style:solid;border-width:1px;border-color:#E0ECFF" ></th>
                            <th style="font-weight:lighter;width:12%;heigth:30px;background-color:#3076BD;border-style:solid;border-width:1px;border-color:#E0ECFF"><input type="checkbox" onclick="allselect(this)"></th>
                            <th style="font-weight:lighter;width:38%;heigth:30px;color:#FFF;font-size:16px;background-color:#3076BD;border-style:solid;border-width:1px;border-color:#E0ECFF">姓名</th>
                            <th style="font-weight:lighter;width:38%;heigth:30px; color:#FFF;font-size:16px; background-color:#3076BD;border-style:solid;border-width:1px;border-color:#E0ECFF">手机号</th>
                        </tr>
                    </thead>
                         <%
                            RssList list = new RssList(pageContext, "user");//连接
                            list.request();
                            int a = 1;
                            list.pagesize = 30000;
                            String sql = "1=1 ";
                            if(list.get("my_state") != null && !"".equals(list.get("my_state"))){
                                sql = sql + " and powergroupid = " + list.get("my_state");
//                                System.out.println("11111111111111111111111"+sql);
                            }
                            if(list.get("name") != null && !"".equals(list.get("name"))){
                                sql = sql + " and realname like '%" + list.get("name") + "%'";
//                                System.out.println("11111111111111111111111"+sql);
                            }
                            list.select().where(sql).get_page_desc("myid");
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr class = "colo_r">
                            <td><% out.print(a); %></td>
                            <td><input class="qx" type="checkbox" name="id" onclick="change(this)" value="<% out.print(list.get("myid")); %>"/></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <!--<th style="width:38%;heigth:36px;font-size: 8px; color:#636363;border-style:solid;border-width:1px;border-color:#E0ECFF"><% out.print(list.get("telphone")); %></th>-->
                        </tr>
                        <%
                                a++;
                            }
                        %>
                        
                    
          
                </table>
            </div>
           <div class="selectorder hidden"> </div>
        </div>
    </div>
    <div style="height: 100%; width: 60%; float: right; margin-top: 12px;">
        <div style="height: 35%; width: 99%; border: 1px solid #95B8E7;">
            <div style="height: 25px; width: 100%; background-color: #E0ECFF;">
                <span  style="line-height: 25px; font-size: 13px; font-weight: bold;">短信接收人</span>
            </div>
            <div id="as" name="as" class="mingdan"  style="margin: 3px 3px 3px 3px; height: calc(100% - 26px); width: auto; overflow:auto;"></div>
        </div>
        <div style="height: 45%; width: 99%; border: 1px solid #95B8E7; margin-top: 2px;">
            <div style="height: 25px; width: 100%; background-color: #E0ECFF;">
                <span style="line-height: 25px; font-size: 13px; font-weight: bold;">短信内容</span></div>
            <div  style="height: calc(100% - 28px); width: 100%; padding: 5px 5px 5px 5px;">
                <!--<input  data-options="multiline:true" type="" id="message" style="width: 98%;height: 98%;" />-->
                <textarea id="asd1" name="asd1"  cols="" rows="" style="width:98%; height:95%;"></textarea>
            </div>
        </div>
        <div style="height: 15%; width: 99%; margin-top: 2px; text-align: center;">
            <a id="submit" onclick="ConfirmDel()">发送短信</a>
        </div>
    </div>
    <div style="clear: both;">
    </div>
<!--    <script src="/dhsrdys/Scripts/system/MassSendNote.js" type="text/javascript"></script>-->
</body>
<script src='../../js/jquery.min.js'></script>
<script language="javascript" type="text/javascript">
    
    function checkboxed(obj){
        let name = $("#tb_select_realTime").val();
        window.location.href = "/judicsuper/thrques/list.jsp?name=" + name;
    }
    
    
    var a="";  
    function change(obj){
        
        
    var tr = obj.parentElement.parentElement;
       
    if(obj.checked){
        let td = obj.parentElement;
        let id = $(td).prev().text();
        let name = $(td).next().text();
        let tel = $(td).next().next().text();
        $(".mingdan").append("<span class='" + id + "'> " + name + "  " + tel + "， </span>");
        tr.style.backgroundColor='#D1EEEE';
        a=a+tel+",";
    }else{
        
        let td = obj.parentElement;
        let id = $(td).prev().text();
         let tel = $(td).next().next().text();
         a=a.replace(tel+",","");
        $("."+id).remove();
        tr.style.backgroundColor='white';
        
    }
//    alert(a);
}

function allselect(obj){
        var xz = $(obj).prop("checked");//判断全选按钮的选中状态
        $(".qx").prop("checked",xz);  //让class名为qx的选项的选中状态和全选按钮的选中状态一致。  
        var a="";
        $(".qx").each(function(){
            let tr1=this.parentElement.parentElement;
                if(obj.checked){
                    //全选
                    let td = this.parentElement;
                    let id = $(td).prev().text();
                    let name = $(td).next().text();
                    let tel = $(td).next().next().text();
                    $(".mingdan").append("<span class='" + id + "'> " + name + "  " + tel + "， </span>");
                    tr1.style.backgroundColor='#D1EEEE';
                    a=a+tel+",";
                }else{
                    //全部选
                    let td = this.parentElement;
                    let id = $(td).prev().text();
                    $("."+id).remove();
                    tr1.style.backgroundColor='white';
                    a="";
                }
               
        });
}
 function ConfirmDel()
{  x=document.getElementById("as").innerHTML;//获取内容
//    var y=document.getElementById("asd1").innerHTML;
    var y = $("#asd1").val();//返回或设置选中元素的值
      confirm("确定向代表发送信息吗？");
   if(x===''){
       confirm("请选择短信接收人");  
     }
    else if(y===''){     
       confirm("请选择短信内容");
     }
   else if(x!==''&&y!==''){
       alert("短信发送成功");
     }
      
}   
</script>
</html>
