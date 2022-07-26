<%@page import="java.text.DecimalFormat"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "suggest");
    RssList entity2 = new RssList(pageContext, "suggest");
    String a = req.get("lwstate");
    String b = req.get("session");
    String c = req.get("titlenum");
    String d = req.get("tjtitle");
    String[] bb = b.split(",");
    String[] cc = c.split(",");
    String dd = "{";
    for (int i = 0; i < cc.length; i++) {
        dd +="\"" + cc[i] + "\":{";
        for (int z = 0; z < bb.length; z++) {
            entity.select("count(*) as num").where(d + "=" + cc[i] + " and sessionid=" + bb[z] + " and lwstate=" + a).get_first_rows();
            entity2.select("count(*) as allnum").where("sessionid=" + bb[z] + " and lwstate=" + a).get_first_rows();
            Double dou = 0.00;
            int n = Integer.parseInt(entity.get("num"));
            int l = Integer.parseInt(entity2.get("allnum"));
             DecimalFormat df = new DecimalFormat("#.00");
            dou = (double)Math.round(n*100)/l ;
            String str = df.format(dou);
            dd += "\"" + bb[z] + "\":{\"num\":\"" + entity.get("num") + "\",\"allnum\":\"" + str + "\"},";
        }
        dd = dd.substring(0, dd.length() - 1);
        dd+= "},";
    }
    dd = dd.substring(0, dd.length() - 1);
    dd += "}";
    out.print(dd);
%>
