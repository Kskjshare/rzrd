<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerGroupList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Workbook wb = new XSSFWorkbook(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "user");
    RssList list6 = new RssList(pageContext, "user");
    RssList entity6 = new RssList(pageContext, "user");
//    RssList list1 = new RssList(pageContext, "staff_power_group");
    RssListView list2 = new RssListView(pageContext, "userrole");
    RssListView list5 = new RssListView(pageContext, "userrole");
    RssList list3 = new RssList(pageContext, "userrole");
    RssList excel = new RssList(pageContext, "excel_process");
//    RssListView entity = new RssListView(pageContext, "company_user");
    StaffList Staff = new StaffList(pageContext);
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
    String b[];
//    String c[] = {"code", "realname", "sex", "nationid", "eduid", "degree", "profession", "worktitle","powergroupid","email", "birthday", "telphone","pwd","job","homeaddress","hometel","homecode"};
    String c[] = {"lianxirenCode", "realname", "sex", "nationid", "eduid", "degree", "profession", "company", "email", "birthday", "pwd", "telphone", "account", "job", "homeaddress", "hometel", "homecode"};
//    String d[] = {"0", "女", "男"};
    String[] eduidarry = {"无", "小学", "初中", "高中", "大专", "本科", "研究生","博士生"};//学历 小学、初中、高中、大专、大学本科、研究生
    String[] degreearry = {"无", "学士", "硕士", "博士"};//学位
    String n[] = {"未知", "汉族", "", "壮族", "满族", "回族", "苗族", "藏族", "维吾尔族", "土家族", "彝族", "蒙古族", "布依族", "侗族", "瑶族", "朝鲜族", "白族", "哈尼族", "哈萨克族", "黎族", "傣族", "畲族", "傈僳族", "仡佬族", "东乡族", "高山族", "拉祜族", "水族", "佤族", "纳西族", "羌族", "土族", "仫佬族", "锡伯族", "柯尔克孜族", "达斡尔族", "景颇族", "瑶族", "撒拉族", "布朗族", "塔吉克族", "阿昌族", "普米族", "鄂温克族", "怒族", "京族", "基诺族", "德昂族", "保安族", "俄罗斯族", "裕固族", "乌孜别克族", "门巴族", "鄂伦春族", "独龙族", "塔塔尔族", "赫哲族", "珞巴族","毛南族"};

    int num = 0;
    int nonum = 0;
    String errlist = "[";
    Row row = null;
    String allpage = String.valueOf(rowsnum - 1);
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    for (int i = 2; i < rowsnum + 1; i++) {
        String realname = "", tel = "", passwordNO = "", account = "", company = "";
        row = book.getRow(i);
        nonum++;
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (j == 1) {
                realname = cellstr;
                list.keyvalue(c[j], cellstr);
            } else if (j == 2) {
                String ind = "0";
                if (cellstr.equals("保密")) {
                    ind = "0";
                } else if (cellstr.equals("女")) {
                    ind = "1";
                } else if (cellstr.equals("男")) {
                    ind = "2";
                }
                list.keyvalue(c[j], ind);
            } else if (j == 3) {
                for (int ind = 0; ind < n.length; ind++) {
                    if (cellstr.equals(n[ind])) {
                        list.keyvalue(c[j], ind);
                    }
                }
            } else if (j == 10) {
                passwordNO = cellstr;
                list.keyvalue("passwordNO", passwordNO);
                list.keyvalue(c[j], Encrypt.Md532(cellstr));
            } else if (j == 11) {
                if (cellstr.equals("")) {
                    tel = "000-" + Math.round((Math.random() * 9 + 1) * 1000);
                } else {
                    tel = cellstr;
                }
//                list.keyvalue("account", cellstr);
//                list.keyvalue("pwd", Encrypt.Md532(cellstr + passwordNO));
                list.keyvalue(c[j], tel);
            } else if (j == 9) {
                cellstr = cellstr.replace(".", "/");
                cellstr = cellstr.replace(",", "/");
                try {
                    long celllong = DateTimeExtend.timestamp(cellstr, "yyyy/MM");
                    list.keyvalue(c[j], celllong);
                } catch (Exception e) {
                }
            } else if (j == 12) {
                if (cellstr.equals("")) {
                    account = tel;
                } else {
                    account = cellstr;
                }
                list.keyvalue("account", account);
                list.keyvalue("pwd", Encrypt.Md532(account + passwordNO));
                list.keyvalue(c[j], account);
            } //            else if (j == 9) {
            //                    list1.select().where("name=?" ,cellstr).get_first_rows();
            //                    powergroupid=list1.get("id");
            //                    list.keyvalue(c[j], powergroupid);
            //            } 
            else if (j == 7) {
                company = cellstr;
                list2.select().where("state=3 and company=?", cellstr).get_first_rows();
                String companyallname = list2.get("company");
                String parentid = list2.get("myid");
                list.keyvalue("parentid", parentid);
//                entity.keyvalue("parentid",parentid);
//                entity.keyvalue("companyallname",companyallname);
                list.keyvalue(c[j], companyallname);
            } else if (j == 4) {
                for (int ind = 0; ind < eduidarry.length; ind++) {
                    if (cellstr.equals(eduidarry[ind])) {
                        list.keyvalue(c[j], ind);
                    }
                }
            } else if (j == 5) {
                for (int ind = 0; ind < degreearry.length; ind++) {
                    if (cellstr.equals(degreearry[ind])) {
                        list.keyvalue(c[j], ind);
                    }
                }
            } else {
                list.keyvalue(c[j], cellstr);
            }
        }
        list.timestamp();
        list2.select("count(*) as n").where("account='" + list.get("account") + "'").get_first_rows();
        // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
        if (Integer.parseInt(list2.get("n")) > 1) {
            list.keyvalue("powergroupid", 5);
        } else {
            list.keyvalue("powergroupid", 24);
        }
        if (entity6.select().where("account='" + account + "'").get_first_rows()) {
            if (entity6.get("rolelist").indexOf(",24,") != 1) {
                list.keyvalue("rolelist", entity6.get("rolelist") + ",24,");
            }
        } else {
            list.keyvalue("rolelist", ",24,");
        }

        if (!(list5.select().where("account='" + account + "' and state=5").get_first_rows())) {
            list3.keyvalue("account", account);
            list3.keyvalue("state", 5);
            list3.append().submit();
        }

        try {
            if (list6.select().where("account='" + account + "'").get_first_rows()) {
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
            errlist += "{\"realname\":\"" + realname + "\",\"tel\":\"" + tel + "\",\"allnam\":\"" + company + "\"},";
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

