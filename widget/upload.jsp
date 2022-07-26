<%@page import="RssEasy.Core.UploadFileThumbHelper"%><%@page contentType="text/html" pageEncoding="UTF-8"%><%
    response.setHeader("Access-Control-Allow-Origin", "*");
    UploadFileThumbHelper upfile = new UploadFileThumbHelper(pageContext);
    upfile.maxFileSize = 4096 * 4096 * 20;
//    upfile.maxFileSize = 1024 * 1024 * 200;

    upfile.allowUploadFileType = "(?:mp4|png|gif|xls|zip|txt|xlsx|png|jpg|avi|mp3|rm|kux|mpeg-1|apk|doc|docx|pdf)$";
    //ArrayList str_url=upfile.fieldlist;
    // System.out.println("str_url::"+str_url);
//        out.print("123");

    boolean b_result = upfile.Upload();//在列表里，则生成URL，单结果返回false
//        System.out.println(upfile.fieldlist);
//    out.print(upfile.fileInfo);

    out.print(upfile.toJson());
    // String str_root=upfile.get("root");//jackie debug
    // System.out.println("b_result=#@@@"+b_result);//jackie debug
    //System.out.println("upfile.toJson()=#@@@"+upfile.toJson());//jackie debug
%>