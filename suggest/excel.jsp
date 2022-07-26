<%-- 
    Document   : excel
    Created on : 2021-3-29, 10:58:50
    Author     : Administrator
--%>
<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
<%@page import="org.apache.poi.ss.usermodel.WorkbookFactory"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="java.util.Arrays"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Workbook wb = WorkbookFactory.create(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "suggest");
    RssList excel = new RssList(pageContext, "excel_process");
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
//    String c[] = {"realid","title","peoplenumber","grade","grade","grade","result","result","result","note","year"};
String c[] = {"sessionid","meetingnum","level","title","realname","permission","matter","reviewclass"};
    int num = 0;
    int nonum = 0;
    String cs1 = "";
    String cs2 = "";
    String errlist = "[";
    Row row = null;
    String allpage = String.valueOf(rowsnum -1 );
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    bgm:for (int i = 1; i <= rowsnum; i++) {
        String title = "",realname="";
        row = book.getRow(i);
        //梁小竹测试
        int a = row.getLastCellNum();
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (j==0 && cellstr.isEmpty() ) {
                  continue bgm;
                }
            if (!cellstr.isEmpty()) {
//                if (j == 0) {
//                    int ind = 0;
//                if (cellstr.equals("汝州第十三届人民代表大会")) {
//                    ind = 30;
//                } else if (cellstr.equals("汝州第十四届人民代表大会")) {
//                    ind = 0;
//                
//                }list.keyvalue(c[j], ind);
//                }
//                else if (j ==1) {
//                    int ind = 0;
//                if (cellstr.equals("第一次会议")) {
//                    ind = 1;
//                } else if (cellstr.equals("第二次会议")) {
//                    ind = 2;
//                
//                }list.keyvalue(c[j], ind);
//                } else if (j ==2) {
//                    
//                    int ind = 0;
//                if (cellstr.equals("乡镇人大代表")) {
//                    ind = 0;
//                }
//                list.keyvalue(c[j], ind);
//                }  else if (j ==7) {
//                     int ind = 0;
//                if (cellstr.equals("人事福利")) {
//                    ind =1;
//                }
//                list.keyvalue(c[j], ind);
//                
//                }  else {
                    if (!c[j].isEmpty()) {
                        list.keyvalue(c[j], cell);
//                    }
                }
            }
        }
        nonum++;
        try {
            list.append().submit();
            num++;
            String nowpage = String.valueOf(num);
            excel.keyvalue("nowpage", nowpage);
            excel.update().where("id=" + excel.autoid).submit();
        } catch (Exception e) {
            errlist += "{\"title\":\"" + title + "\",\"realname\":\"" + realname + "\"},";
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
