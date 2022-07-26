<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    StaffPowerList entity = new StaffPowerList(pageContext);
    entity.request().remove("id");
    String ofid = entity.get("offsetidstr");
    String ofname =URLDecoder.decode(entity.get("offsetnamestr"), "utf-8");
    entity.remove("offsetidstr","offsetnamestr");
    String[] strid = ofid.split(",");
    String[] strname = ofname.split(",");
    entity.delete().submit();
    for (int j = 0; j < strid.length; j++) {
        String a = strid[j];
        String b = strname[j];
        entity.keyvalue("offsetid",a);
        entity.keyvalue("name",b);
        entity.keyvalue("marker", entity.getmarkerbyid(a) + HttpExtend.getPinYin(b)).keyvalue("querykey", entity.createquerykey());
    out.print(entity.append().submit());
    }
    StaffList.CreateJson(pageContext);
    PoPupHelper.adapter(out).iframereload();
    PoPupHelper.adapter(out).showSucceed();
//    }
//    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>

</body>
</html>
