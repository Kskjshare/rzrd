<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>

<%
    Workbook wb = new XSSFWorkbook(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "user");
    RssList list5 = new RssList(pageContext, "user");
    RssList entity6 = new RssList(pageContext, "user");
    RssList list3 = new RssList(pageContext, "userrole");
    RssListView list2 = new RssListView(pageContext, "userrole");
    RssList list4 = new RssList(pageContext, "userrole");
    RssList list1 = new RssList(pageContext, "companytype_classify");
    RssList excel = new RssList(pageContext, "excel_process");
    StaffList Staff = new StaffList(pageContext);
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
    int num = 0;
    int nonum = 0;
    String errlist = "[";
    String b[];

    //String c[] = {"code", "linkman", "telphone", "worktel", "allname", "account", "state", "email", "facsimile", "postcode", "workaddress", "note"};
    String c[] = {"danweiCode", "comtype", "company", "workaddress", "person", "dwadmin", "linkman", "pwd", "worktel", "loginNameDw", "email"};

    Row row = null;
    String allpage = String.valueOf(rowsnum - 1);
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    for (int i = 2; i < rowsnum + 1; i++) {
        String company = "", tel = "", linkman = "", loginNameDw = "", passwordNO = "";
        row = book.getRow(i);
        nonum++;
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (j == 0) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 3) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 4) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 5) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 10) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 6) {
                linkman = cellstr;
                list.keyvalue(c[j], cellstr);
            } else if (j == 7) {
                passwordNO = cellstr;
                list.keyvalue("passwordNO", passwordNO);
                list.keyvalue(c[j], Encrypt.Md532(cellstr));
            } else if (j == 8) {
                if (cellstr.equals("")) {
                    tel = "000-" + Math.round((Math.random() * 9 + 1) * 1000);
                } else {
                    tel = cellstr;
                }
                list.keyvalue(c[j], tel);
            } else if (j == 2) {
                company = cellstr;
                list.keyvalue(c[j], cellstr);
            } else if (j == 1) {
                list1.select().where("name=?", cellstr).get_first_rows();
                String ind = list1.get("id");
                list.keyvalue(c[j], ind);
            } else if (j == 9) {
                if (cellstr.equals("")) {
                    loginNameDw = tel;
                } else {
                    loginNameDw = cellstr;
                }
                list.keyvalue("account", loginNameDw);
                list.keyvalue("pwd", Encrypt.Md532(loginNameDw + passwordNO));
                list.keyvalue(c[j], loginNameDw);
            } else {
                if (!c[j].isEmpty()) {
                    list.keyvalue(c[j], cell);
                }
            }
        }
        list.timestamp();
        list2.select("count(*) as n").where("account='" + list.get("account") + "'").get_first_rows();
        // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
        if (Integer.parseInt(list2.get("n")) > 1) {
            list.keyvalue("powergroupid", 5);
        } else {
            list.keyvalue("powergroupid", 18);
        }

        if (entity6.select().where("account='" + loginNameDw + "'").get_first_rows()) {
            if (entity6.get("rolelist").indexOf(",18,") != 1) {
                list.keyvalue("rolelist", entity6.get("rolelist") + ",18,");
            }
        } else {
            list.keyvalue("rolelist", ",18,");
        }

        if (!(list4.select().where("account='" + loginNameDw + "' and state=3").get_first_rows())) {
            list3.keyvalue("account", loginNameDw);
            list3.keyvalue("state", 3);
            list3.append().submit();
        }

        list.keyvalue("parentid", UserList.MyID(request));

        try {
            if (list5.select().where("account='" + loginNameDw + "'").get_first_rows()) {
                list.update().where("account=?", loginNameDw).submit();
            } else {
                list.append().submit();
            }
            //list.append().submit();

            if (!Staff.select().where("myid=?", String.valueOf(list.autoid)).get_first_rows()) {
                Staff.keyvalue("myid", list.autoid);
                Staff.append().submit();
            };
            num++;
            String nowpage = String.valueOf(num);
            excel.keyvalue("nowpage", nowpage);
            excel.update().where("id=" + excel.autoid).submit();
        } catch (Exception e) {
            errlist += "{\"company\":\"" + company + "\",\"linkman\":\"" + linkman + "\",\"tel\":\"" + tel + "\",\"loginNameDw\":\"" + loginNameDw + "\"},";
        }
    }
    if (errlist.equals("[")) {
        errlist = "\"no\"";
    } else {
        errlist = errlist.substring(0, errlist.length() - 1);
        errlist += "]";
    }
    out.print("{\"rowsnum\":\"" + num + "\",\"nonum\":\"" + nonum + "\",\"err\":" + errlist + "}");
%>

