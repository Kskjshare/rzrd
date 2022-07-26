<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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

<%
    Workbook wb = new XSSFWorkbook(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "user");
    RssList list3 = new RssList(pageContext, "userrole");
    RssList entity6 = new RssList(pageContext, "user");
    RssList excel = new RssList(pageContext, "excel_process");
    RssListView list2 = new RssListView(pageContext, "userrole");
    RssList list4 = new RssList(pageContext, "userrole");
    RssList list5 = new RssList(pageContext, "user");
    StaffList Staff = new StaffList(pageContext);
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
    int num = 0;
    int nonum = 0;
    String errlist = "[";
    String b[];
//                String c[] = {"delegationname","code","address","name","telphone","postcode","pinyin","email"};
    String c[] = {"daibiaotuanCode", "allname", "missionAddr", "level", "pwd", "telphone", "account", "linkman", "missionpostcode", "email"};
    String cengci[] = {"镇级", "县级", "市级", "区级", "全国级"};
    String cengci1[] = {"乡镇人大", "县人大", "市人大", "区人大", "全国人大"};
    String cengci2[] = {"乡人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String cengci3[] = {"乡代表", "县代表", "市代表", "区代表", "全国代表"};
    String cengci4[] = {"镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String cengci5[] = {"镇代表", "县代表", "市代表", "区代表", "全国代表"};
    String cengci6[] = {"镇人大", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String[] circlesarry = {"乡人大", "县人大", "市人大", "区人大", "全国人大"};//层次

    Row row = null;
    String allpage = String.valueOf(rowsnum - 1);
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    for (int i = 2; i < rowsnum + 1; i++) {
        String allname = "", tel = "", passwordNO = "", account = "", linkman = "";
        row = book.getRow(i);
        nonum++;
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (j == 0) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 1) {
                allname = cellstr;
                list.keyvalue(c[j], cellstr);
            } else if (j == 4) {
                passwordNO = cellstr;
                list.keyvalue("passwordNO", passwordNO);
                list.keyvalue(c[j], Encrypt.Md532(cellstr));
            } else if (j == 5) {
                if (cellstr.equals("")) {
                    tel = "000-" + Math.round((Math.random() * 9 + 1) * 1000);
                } else {
                    tel = cellstr;
                }
                list.keyvalue(c[j], tel);
            } else if (j == 3) {
                String circleslist = "";
                for (int ind = 0; ind < circlesarry.length; ind++) {
                    String[] ca = cellstr.split(",|、");
                    for (int idx = 0; idx < ca.length; idx++) {
                        if (ca[idx].equals(circlesarry[ind]) || ca[idx].equals(cengci[ind]) || ca[idx].equals(cengci1[ind]) || ca[idx].equals(cengci2[ind]) || ca[idx].equals(cengci3[ind]) || ca[idx].equals(cengci4[ind]) || ca[idx].equals(cengci5[ind]) || ca[idx].equals(cengci6[ind])) {
                            circleslist += ind ;
                        }
                    }
                }
                list.keyvalue(c[j], circleslist);
            } else if (j == 7) {
                linkman = cellstr;
                list.keyvalue(c[j], linkman);
            } else if (j == 2) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 8) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 9) {
                list.keyvalue(c[j], cellstr);
            } else if (j == 6) {
                if (cellstr.equals("")) {
                    account = tel;
                } else {
                    account = cellstr;
                }
                list.keyvalue("account", account);
                list.keyvalue("loginNameDw", account);
                list.keyvalue("pwd", Encrypt.Md532(account + passwordNO));
                list.keyvalue(c[j], account);
            }
        }
        list.timestamp();
        list2.select("count(*) as n").where("account='" + list.get("account") + "'").get_first_rows();
        // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
        if (Integer.parseInt(list2.get("n")) >1) {
            list.keyvalue("powergroupid", 5);
        } else {
            list.keyvalue("powergroupid", 22);
        }

        if (entity6.select().where("account='" + account + "'").get_first_rows()) {
            if (entity6.get("rolelist").indexOf(",22,") != 1) {
                list.keyvalue("rolelist", entity6.get("rolelist") + ",22,");
            }
        } else {
            list.keyvalue("rolelist", ",22,");
        }

        if (!(list4.select().where("account='" + account + "' and state=4").get_first_rows())) {
            list3.keyvalue("account", account);
            list3.keyvalue("state", 4);
            list3.append().submit();
        }

        try {
            if (list5.select().where("account='" + account + "'").get_first_rows()) {
                list.update().where("account=?", account).submit();
            } else {
                list.append().submit();
            }
            if (!Staff.select().where("myid=?", String.valueOf(list.autoid)).get_first_rows()) {
                Staff.keyvalue("myid", list.autoid);
                Staff.append().submit();
            };
            num++;
            String nowpage = String.valueOf(num);
            excel.keyvalue("nowpage", nowpage);
            excel.update().where("id=" + excel.autoid).submit();
        } catch (Exception e) {
            errlist += "{\"allname\":\"" + allname + "\",\"linkman\":\"" + linkman + "\",\"tel\":\"" + tel + "\",\"account\":\"" + account + "\"},";
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

