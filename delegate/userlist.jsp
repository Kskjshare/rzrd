<%@page import="java.util.List"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市区、市、县、乡人大代信息名册表", "utf-8") + ".xls");
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
            <caption>汝州市人大代信息名册表</caption>
            <thead>
                <tr>
                    <%
                        String strname = "姓名,性别,民族,出生年月,单位职务,详细住址,登录密码,手机号码,登录账号,代表层次";
                        strname += user.get("relationname");
                        String[] cc = strname.split(",");
                        for (int i = 0; i < cc.length; i++) {
                    %>  
                    <th><% out.print(cc[i]);%></th>
                        <%
                            }
                        %>
                </tr>
            </thead>
            <%
                String str = "realname,sex,nationid,birthday,daibiaoDWjob,homeaddress,passwordNO,telphone,account,circleslist";
                str += user.get("relation");
                String[] bb = str.split(",");
                user.pagesize = 30;
                user.select(str).where("state like '%2%' and myid in (" + user.get("relationid") + ")").get_page_desc("myid");
                int x = 1;
                String[] sexarry = {"保密", "女", "男"};//性别
//                String[] clanarry = {"无", "中国共产党", "其他"};//党派
                String[] clanarry = {"无", "中国共产党", "中国国民党革命委员会", "中国民主同盟", "中国民主建国会", "中国民主促进会", "中国农工民主党", "中国致公党", "九三学社", "台湾民主自治同盟"};
                String[] circlesarry = {"乡镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大"};//层次
                String[] eduidarry = {"无", "小学", "初中", "高中", "大专", "本科", "研究生","博士生"};//学历
                String[] degreearry = {"无", "学士", "硕士", "博士"};//学位
                String[] nationidarry = {"未知", "汉族", "", "壮族", "满族", "回族", "苗族", "藏族", "维吾尔族", "土家族", "彝族", "蒙古族", "布依族", "侗族", "瑶族", "朝鲜族", "白族", "哈尼族", "哈萨克族", "黎族", "傣族", "畲族", "傈僳族", "仡佬族", "东乡族", "高山族", "拉祜族", "水族", "佤族", "纳西族", "羌族", "土族", "仫佬族", "锡伯族", "柯尔克孜族", "达斡尔族", "景颇族", "瑶族", "撒拉族", "布朗族", "塔吉克族", "阿昌族", "普米族", "鄂温克族", "怒族", "京族", "基诺族", "德昂族", "保安族", "俄罗斯族", "裕固族", "乌孜别克族", "门巴族", "鄂伦春族", "独龙族", "塔塔尔族", "赫哲族", "珞巴族","毛南族"};
                while (user.for_in_rows()) {
            %>

            <tbody>
                <tr>
                    <%
                        for (int i = 0; i < bb.length; i++) {
                            switch (bb[i]) {
                                case "sex":
                    %>
                    <td><%
                        if (!user.get("sex").isEmpty()) {
                            int sex = Integer.valueOf(user.get("sex"));
                            out.print(sexarry[sex]);
                        }
                        %></td>
                        <%
                                break;
                            case "clan":
                        %>
                    <td><%
                        if (!user.get("clan").isEmpty()) {
                            int sex = Integer.valueOf(user.get("clan"));
                            out.print(clanarry[sex]);
                        }
                        %></td>
                        <%
                                break;
                            case "circleslist":
                        %>
                    <td><%
                        if (!user.get("circleslist").isEmpty()) {
                            String[] arry = user.get("circleslist").split(",");
                            String arrylist = "";
                            for (int ind = 0; ind < arry.length; ind++) {
                                if (!arry[ind].equals("") && !arry[ind].equals("undefined")) {
                                    int arryint = Integer.valueOf(arry[ind]);
                                    arrylist += circlesarry[arryint] + "，";
                                }
                            }
                            if (!arrylist.equals("")) {
                                arrylist = arrylist.substring(0, arrylist.length() - 1);
                            }
                            out.print(arrylist);
                        }
                        %></td>
                        <%
                                break;
                            case "eduid":
                        %>
                    <td><%
                        if (!user.get("eduid").isEmpty()) {
                            int sex = Integer.valueOf(user.get("eduid"));
                            out.print(eduidarry[sex]);
                        }
                        %></td>
                        <%
                                break;
                            case "degree":
                        %>
                    <td><%
                        if (!user.get("degree").isEmpty()) {
                            int sex = Integer.valueOf(user.get("degree"));
                            out.print(degreearry[sex]);
                        }
                        %></td>
                        <%
                                break;
                            case "nationid":
                        %>
                    <td><%
                        if (!user.get("nationid").isEmpty()) {
                            int sex = Integer.valueOf(user.get("nationid"));
                            out.print(nationidarry[sex]);
                        }
                        %></td>
                        <%
                                break;
                            case "sessionlist":
                        %>
                    <td><%
                        if (!user.get("sessionlist").isEmpty()) {
                            RssList sessionlist = new RssList(pageContext, "session_classify");
                            String[] numu = user.get("sessionlist").split(",");
                            if (user.get("sessionlist").indexOf(",") < 0) {
                                sessionlist.select().where("id=" + user.get("sessionlist")).get_first_rows();
                            } else {
//                                sessionlist.select().where("id=" + numu[1]).get_first_rows();
                            }
                            out.print(sessionlist.get("name"));
                        }
                        %></td>
                        <%
                                break;
                            case "mission":
                        %>
                    <td><%
                        if (!user.get("mission").isEmpty()) {
                            RssList missionlist = new RssList(pageContext, "user");
                            missionlist.select("allname").where("myid=" + user.get("mission")).get_first_rows();
                            out.print(missionlist.get("allname"));
                        }
                        %></td>
                        <%
                                break;
                            case "birthday":
                        %>
                    <td><%
                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        long a = Long.parseLong(user.get("birthday")) * 1000;
                        String s = simpleDateFormat.format(a);
                        out.print(s);
                        %></td>    
                        <%
                                break;
                            default:
                        %>
                    <td><% out.print(user.get(bb[i]));%></td> 
                    <%
                                    break;
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
        </table>
    </body>

    <ml>