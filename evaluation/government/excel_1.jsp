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
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Workbook wb = WorkbookFactory.create(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "yyl_evaluation");
    RssList excel = new RssList(pageContext, "excel_process");
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
//    String c[] = {"companyname","content","peoplenumber","grade","grade","grade","result","result","result","note","year"};
String c[] = {"companyname","content","result","result","result","note","year"};
    int num = 0;
    int nonum = 0;
    String cs1 = "";
    String cs2 = "";
    String errlist = "[";
    Row row = null;
    String allpage = String.valueOf(rowsnum - 1);
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    try {
            String[] arry = book.getRow(1).getCell(0).toString().split("年");
            list.keyvalue("year",arry[0]);
           } catch (Exception e) {
               
           }
    bgm:for (int i = 3; i <= rowsnum; i++) {
        String realname = "",content="";
        row = book.getRow(i);
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (j==0 && cellstr.isEmpty() ) {
                  continue bgm;
                }
            if (!cellstr.isEmpty()) {
                if (j == 0) {
                    String str2 = cellstr.replaceAll(" ", "");
                    realname = str2;
                    list.keyvalue(c[j], str2);
                } else if (j ==1) {
                    String str2 = cellstr.replaceAll(" ", "");
                    content = str2;
                    list.keyvalue(c[j], str2);
                } else if (j == 2||j == 3||j == 4) {
                    String str2 = cellstr.replaceAll(" ", "");
                    list.keyvalue(c[j], j-1);
                } 
//                else if (j == 6||j == 7||j == 8) {
//                    String str2 = cellstr.replaceAll(" ", "");
//                    list.keyvalue(c[j], j-5);
//                }
                else {
                    if (!c[j].isEmpty()) {
                        list.keyvalue(c[j], cell);
                    }
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
            errlist += "{\"companyname\":\"" + realname + "\",\"content\":\"" + content + "\"},";
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

