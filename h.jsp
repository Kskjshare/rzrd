
<%@page import="RssEasy.CreditCard.MailBill.MailBillExtend"%>
<%@page import="java.util.Map"%>
<%@page import="RssEasy.Core.RedisExtend"%>
<%@page import="java.util.HashMap"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.PowerHelper"%>
<%@page import="RssEasy.Core.Validated"%>
<%@page import="RssEasy.MySql.AreaList"%>
<%@page import="RssEasy.MySql.RssCodeList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Font"%>
<%@page import="java.awt.Graphics"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="RssEasy.Core.GraphicsExtend"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//   MailBillExtend mail=new MailBillExtend("15810208908@qq.com", "");
  DirectoryExtend.MakeUpfile(request,120);
%>