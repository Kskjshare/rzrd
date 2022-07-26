<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市区、市、县、乡人大单位联系人信息名册表", "utf-8") + ".xls");
    response.addHeader("Content-Type", "application/ms-excel");
    response.addHeader("Pragma", "no-cache");
    response.addHeader("Expires", "0");
    RssListView user = new RssListView(pageContext, "userrole");
    user.request();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
            <caption>汝州市区、市、县、乡人大单位联系人信息名册表</caption>
            <thead>
                <tr>
                    <%
                        String strname = user.get("relationname");
                        String[] cc = strname.split(",");
                        for (int i = 1; i < cc.length; i++) {
                    %>  
                    <th><% out.print(cc[i]);%></th>
                        <%
                            }
                        %>
                    <!--
                    <th rowspan="2">序号</th>
                    <th rowspan="2">姓名</th>
                    <th rowspan="2">性别</th>
                    <th rowspan="2">民族</th>
                    <th rowspan="2">出生年月</th>
                    <th rowspan="2">身份证号</th>
                    <th rowspan="2">单位职务</th>
                    <th rowspan="2">详细住址</th>
                    <th rowspan="2">手机号码(移动)(电信)</th>
                    <th rowspan="2">代表阶层</th>
                    <th rowspan="1">电子版相片</th>
                    <th rowspan="2">备注</th>
                </tr>
                <tr>
                    <th>(注:相片要2寸蓝底照,要求穿白衬衫打领带.)注明有或否</th>
                    -->                            </tr>
            </thead>
            <%
//                RssList user = new RssList(pageContext, "user");
//                user.request();
                String str = user.get("relation");
                String arr = str.substring(1, str.length());
                String[] bb = str.split(",");
                user.select(arr).where("state=5 and myid in (" + user.get("relationid") + ")").get_page_desc("myid");
                int x = 1;
                String[] eduidarry = {"无", "小学", "初中", "高中", "大专", "本科", "研究生","博士生"};//学历
                String[] degreearry = {"无", "学士", "硕士", "博士"};//学位
                String n[] = {"未知", "汉族", "", "壮族", "满族", "回族", "苗族", "藏族", "维吾尔族", "土家族", "彝族", "蒙古族", "布依族", "侗族", "瑶族", "朝鲜族", "白族", "哈尼族", "哈萨克族", "黎族", "傣族", "畲族", "傈僳族", "仡佬族", "东乡族", "高山族", "拉祜族", "水族", "佤族", "纳西族", "羌族", "土族", "仫佬族", "锡伯族", "柯尔克孜族", "达斡尔族", "景颇族", "瑶族", "撒拉族", "布朗族", "塔吉克族", "阿昌族", "普米族", "鄂温克族", "怒族", "京族", "基诺族", "德昂族", "保安族", "俄罗斯族", "裕固族", "乌孜别克族", "门巴族", "鄂伦春族", "独龙族", "塔塔尔族", "赫哲族", "珞巴族","毛南族"};
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <%
                        for (int i = 1; i < bb.length; i++) {
                            if (bb[i].equals("sex")) {
                    %>
                    <td><%
                        if (user.get("sex").equals("0")) {
                            out.print("保密");
                        } else if (user.get("sex").equals("1")) {
                            out.print("女");
                        } else if (user.get("sex").equals("2")) {
                            out.print("男");
                        }%></td>
                        <%
                        } else if (bb[i].equals("birthday")) {
                        %>
                    <td><%
                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        long a = Long.parseLong(user.get("birthday")) * 1000;
                        String s = simpleDateFormat.format(a);
                        out.print(s);
                        %></td>    
                        <%
                        } else if (bb[i].equals("nationid")) {
                        %>
                    <td><%
                        if (!user.get("nationid").isEmpty()) {
                            int sex = Integer.valueOf(user.get("nationid"));
                            out.print(n[sex]);
                        }
                        %></td>   
                        <%
                        } else if (bb[i].equals("eduid")) {
                        %>
                    <td><%
                        if (!user.get("eduid").isEmpty()) {
                            int sex = Integer.valueOf(user.get("eduid"));
                            out.print(eduidarry[sex]);
                        }
                        %></td>    
                    <%
                    } else if (bb[i].equals("degree")) {
                    %>
                    <td><%
                        if (!user.get("degree").isEmpty()) {
                            int sex = Integer.valueOf(user.get("degree"));
                            out.print(degreearry[sex]);
                        }
                        %></td>    
                    <%
                    } else {
                    %>
                    <td><% out.print(user.get(bb[i]));%></td> 
                    <%
                            }
                        }
                    %>
                </tr>
            </tbody>
            <tfoot>
                <%
                        x++;
                    }
                %>
            </tfoot>  
            <script src="/data/suggest.js" type="text/javascript"></script>
            <%@include  file="/inc/js.html" %>
            <script src="/data/nationality.js"></script>
            <script>
                if (<% user.write("nationid"); %>) {
                    $("#nationid").text(dictdata["nationalityid"][<% user.write("nationid");%>][0])
                }
            </script>
        </table>
    </body>

    <ml>