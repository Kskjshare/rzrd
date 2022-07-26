<%@page import="RssEasy.Core.UploadFileThumbHelper"%><%@page contentType="text/html" pageEncoding="UTF-8"%><%
    UploadFileThumbHelper upfile = new UploadFileThumbHelper(pageContext);
    upfile.maxFileSize = 1024 * 1024 * 200;
    upfile.Upload();
    out.print("{\"url\":\"" + upfile.fileInfo.url.replace("upfile\\", "") + "\",\"fileid\":" + upfile.fileInfo.fileid + ",\"filesize\":" + upfile.fileInfo.filesize + ",\"error\":\"" + upfile.fileInfo.error + "\",\"succeed\":" + (upfile.fileInfo.succeed ? 1 : 0) + ",\"ext\":\"" + upfile.fileInfo.ext + "\",\"filename\":\"" + upfile.fileInfo.filename + "\",\"sourcename\":\"" + upfile.fileInfo.sourcename + "\"}");
%>
