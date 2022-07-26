<%-- 
    Document   : excel
    Created on : 2017-10-26, 20:57:28
    Author     : Administrator
--%>
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
    Workbook wb = new XSSFWorkbook(new FileInputStream(DirectoryExtend.Root(request) + "upfile/" + request.getParameter("n")));
    RssList list = new RssList(pageContext, "user");
    RssList list2 = new RssList(pageContext, "user");
    RssList entity6 = new RssList(pageContext, "user");
    RssList list3 = new RssList(pageContext, "user");
    RssList list4 = new RssList(pageContext, "userrole");
    RssList list5 = new RssList(pageContext, "userrole");
    RssList excel = new RssList(pageContext, "excel_process");
    RssList sessionv = new RssList(pageContext, "session_classify");
    StaffList Staff = new StaffList(pageContext);
    Sheet book = wb.getSheetAt(0);
    int rowsnum = book.getLastRowNum();
    String n[] = {"未知", "汉族", "", "壮族", "满族", "回族", "苗族", "藏族", "维吾尔族", "土家族", "彝族", "蒙古族", "布依族", "侗族", "瑶族", "朝鲜族", "白族", "哈尼族", "哈萨克族", "黎族", "傣族", "畲族", "傈僳族", "仡佬族", "东乡族", "高山族", "拉祜族", "水族", "佤族", "纳西族", "羌族", "土族", "仫佬族", "锡伯族", "柯尔克孜族", "达斡尔族", "景颇族", "瑶族", "撒拉族", "布朗族", "塔吉克族", "阿昌族", "普米族", "鄂温克族", "怒族", "京族", "基诺族", "德昂族", "保安族", "俄罗斯族", "裕固族", "乌孜别克族", "门巴族", "鄂伦春族", "独龙族", "塔塔尔族", "赫哲族", "珞巴族","毛南族"};
    String c[] = {"realname", "sex", "nationid", "birthday", "daibiaoDWjob", "pwd", "telphone", "account", "circleslist", "code", "mission", "clan", "eduid", "degree", "profession", "email", "daibiaoDWname", "daibiaoDWaddress", "daibiaoDWtel", "daibiaoDWpostcode", "sessionlist"};
    String cengci[] = {"镇级", "县级", "市级", "区级", "全国级"};
    String cengci1[] = {"乡镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String cengci2[] = {"乡人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String cengci3[] = {"乡代表", "县代表", "市代表", "区代表", "全国代表"};
    String cengci4[] = {"镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String cengci5[] = {"镇代表", "县代表", "市代表", "区代表", "全国代表"};
    String cengci6[] = {"镇人大", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
    String[] sexarry = {"保密", "女", "男"};//性别
    String[] clanarry = {"无", "中国共产党", "中国国民党革命委员会", "中国民主同盟", "中国民主建国会", "中国民主促进会", "中国农工民主党", "中国致公党", "九三学社", "台湾民主自治同盟"};//党派
    String[] circlesarry = {"乡人大", "县人大", "市人大", "区人大", "全国人大"};//层次
    String[] eduidarry = {"无", "小学", "初中", "高中", "大专", "本科", "研究生","博士生"};//学历
    String[] degreearry = {"无", "学士", "硕士", "博士"};//学位
    int num = 0;
    int nonum = 0;
    String sessionid = "";
    String errlist = "[";
    Row row = null;
    String allpage = String.valueOf(rowsnum - 1);
    excel.keyvalue("myid", UserList.MyID(request));
    excel.keyvalue("allpage", allpage);
    excel.append().submit();
    for (int i = 2; i <= rowsnum; i++) {
        String realname = "", tel = "", mission = "", passwordNO = "", account = "";
        row = book.getRow(i);
        nonum++;
        for (int j = 0; j < row.getLastCellNum(); j++) {
            Cell cell = row.getCell(j);
            cell.setCellType(cell.CELL_TYPE_STRING);
            String cellstr = row.getCell(j).toString();
            if (!cellstr.isEmpty()) {
                if (j == 0) {
                    String str2 = cellstr.replaceAll(" ", "");
                    realname = str2;
                    list.keyvalue(c[j], str2);
                } else if (j == 1) {
                    String ind = "0";
                    if (cellstr.equals("保密")) {
                        ind = "0";
                    } else if (cellstr.equals("女")) {
                        ind = "1";
                    } else if (cellstr.equals("男")) {
                        ind = "2";
                    }
                    list.keyvalue(c[j], ind);
                } else if (j == 2) {
                    for (int ind = 0; ind < n.length; ind++) {
                        if (cellstr.equals(n[ind])) {
                            list.keyvalue(c[j], ind);
                        }
                    }
                } else if (j == 3) {
                    cellstr = cellstr.replace(".", "/");
                    cellstr = cellstr.replace(",", "/");
                    try {
                        long celllong = DateTimeExtend.timestamp(cellstr, "yyyy/MM");
                        list.keyvalue(c[j], celllong);
                    } catch (Exception e) {
                    }
                } else if (j == 5) {
                    passwordNO = cellstr;
                    list.keyvalue("passwordNO", passwordNO);
                    list.keyvalue(c[j], cellstr);
                } else if (j == 6) {
                    if (cellstr.equals("")) {
                        tel = "000-" + Math.round((Math.random() * 9 + 1) * 1000);
                    } else {
                        tel = cellstr;
                    }
                    list.keyvalue(c[j], tel);
                } else if (j == 7) {
                    if (cellstr.equals("")) {
                        account = tel;
                    } else {
                        account = cellstr;
                    }
                    list.keyvalue("account", account);
                    list.keyvalue("loginNameDw", account);
                    list.keyvalue("pwd", Encrypt.Md532(account + passwordNO));
                    list.keyvalue(c[j], account);
                } else if (j == 8) {
                    String circleslist = "";
                    for (int ind = 0; ind < circlesarry.length; ind++) {
                        String[] ca = cellstr.split(",|、");
                        for (int idx = 0; idx < ca.length; idx++) {
                            if (ca[idx].equals(circlesarry[ind]) || ca[idx].equals(cengci[ind]) || ca[idx].equals(cengci1[ind]) || ca[idx].equals(cengci2[ind]) || ca[idx].equals(cengci3[ind]) || ca[idx].equals(cengci4[ind]) || ca[idx].equals(cengci5[ind]) || ca[idx].equals(cengci6[ind])) {
                                circleslist += "," + ind + ",";
                            }
                        }
                    }
                    list.keyvalue(c[j], circleslist);
                } else if (j == 10) {
                    mission = cellstr;
                    if (list2.select("myid").where("allname like '%" + cellstr + "%'").get_first_rows()) {
                        list.keyvalue("mission", list2.get("myid"));
                    } else {
                        list.keyvalue("mission", "1");
                    }
                } else if (j == 11) {
                    for (int ind = 0; ind < clanarry.length; ind++) {
                        if (cellstr.equals(clanarry[ind])) {
                            list.keyvalue(c[j], ind);
                        }
                    }
                } else if (j == 12) {
                    for (int ind = 0; ind < eduidarry.length; ind++) {
                        if (cellstr.equals(eduidarry[ind])) {
                            list.keyvalue(c[j], ind);
                        }
                    }
                } else if (j == 13) {
                    for (int ind = 0; ind < degreearry.length; ind++) {
                        if (cellstr.equals(degreearry[ind])) {
                            list.keyvalue(c[j], ind);
                        }
                    }
                } else if (j == 20) {
//                    sessionid = cellstr;
//                    String ca = cellstr.replaceAll(",|、", ",");
//                    if (sessionv.select("id").where("`name` like '%" + ca + "%'").get_first_rows()) {
//                        list.keyvalue(c[j], sessionv.get("id"));
//                    } else {
//                        list.keyvalue(c[j], "0");
//                    };
                    String sessionlist = "";
                    String ca = cellstr.replace(",", "','");
                    sessionv.select().where("`name` in ('" + ca + "')").query();
                    while (sessionv.for_in_rows()) {
                        sessionlist += "," + sessionv.get("id") + ",";
                    }
                    list.keyvalue(c[j], sessionlist);
                } else {
                    if (!c[j].isEmpty()) {
                        list.keyvalue(c[j], cell);
                    }
                }
            }
        }
        list.timestamp();
        list.keyvalue("powergroupid", 5);
        if (entity6.select().where("account='" + account + "'").get_first_rows()) {
            if (entity6.get("rolelist").indexOf(",5,") != 1) {
                list.keyvalue("rolelist", entity6.get("rolelist") + ",5,");
            }
        } else {
            list.keyvalue("rolelist", ",5,");
        }

        if (!(list4.select().where("account='" + account + "' and state=2").get_first_rows())) {
            list5.keyvalue("account", account);
            list5.keyvalue("state", 2);
            list5.append().submit();
        }
        try {
            if (list3.select().where("account='" + account + "'").get_first_rows()) {
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
            errlist += "{\"realname\":\"" + realname + "\",\"mission\":\"" + mission + "\",\"tel\":\"" + tel + "\"},";
        }
    }
    if (errlist.equals("[")) {
        errlist = "\"no\"";
    } else {
        errlist = errlist.substring(0, errlist.length() - 1);
        errlist += "]";
    }

    out.print("{\"rowsnum\":\"" + num + "\",\"nonum\":\"" + nonum + "\",\"sessionid\":\"" + sessionid + "\",\"err\":" + errlist + "}");
%>

