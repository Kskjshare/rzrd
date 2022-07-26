<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
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
    Workbook wb = new XSSFWorkbook(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "user");
    RssList list1 = new RssList(pageContext, "userrole");
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
//                out.print(rowsnum);
    String b[];
    String c[] = {"code", "realname", "job", "telphone", "worktel", "hometel", "company", "account", "state", "stratumid", "email","","","","","","","","",""};
    String d[] = {"0", "女", "男"};
    Row row = null;
    for (int i = 4; i < rowsnum-2; i++) {
        row = book.getRow(i);String account="";
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            if (j == 0) {
               String cellstr = row.getCell(j).toString(); 
               String celint =  cellstr.substring(0, cellstr.length()-2);
               list.keyvalue(c[j], celint);
            } else if (j == 2) {
               String ind = "0";
               String cellstr = row.getCell(j).toString();
                if(cellstr.equals("保密")){
                        ind = "0";
                        }else if(cellstr.equals("女")){
                         ind = "1";
                        }else if(cellstr.equals("男")){
                         ind = "2";
                        }
                list.keyvalue(c[j], ind);
            } else if (j == 4) {
                String cellstr = row.getCell(j).toString();
                cellstr = cellstr.replace(".", "/");
                long celllong = DateTimeExtend.timestamp(cellstr, "yyyy/MM");
                list.keyvalue(c[j], celllong);
            } else if(j==7){
               String cellstr = row.getCell(j).toString();
               account=cellstr;
               list1.keyvalue("account",account);
            }else{
                list.keyvalue(c[j], cell);
            }
        }
        list1.keyvalue("state", 2);
        list1.append().submit();
        list.append().submit();
        b = null;
    }
    out.print("{\"rowsnum\":\"" + rowsnum + "\"}");
%>

