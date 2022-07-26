package com.cloudrich.framework.util.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import com.cloudrich.ereader.common.action.BaseAction;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

public class ToolsUtils extends BaseAction {

	public static void executePrintExcel(HttpServletRequest request,
			List<String> content, String path, String systeName, int Cols, String realPath) throws Exception {
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(path));
		HSSFSheet sheet = wb.getSheetAt(0);
		wb.setSheetName(0, systeName);
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 单元格垂直居中
		curStyle.setWrapText(true);
		int j=1;
		if(content.size()>0){
			int r = 0; // Table Row -1
			while (r * Cols < content.size()) {
				HSSFRow row = sheet.createRow(j++); // title row [row+1]
//				 System.out.println(r+":");
				for (int i = 0; i < Cols; i++) {
					HSSFCell cell = row.createCell((short) (i));
//					cell.setEncoding(HSSFCell.ENCODING_UTF_16); // 编码
					cell.setCellValue((StringUtil.Null2Str(content.get(r * Cols + i)))); 	
					cell.setCellStyle(curStyle);
					// Column Name
					// System.out.println(s);
				}
				r++;
			}
		}
		FileUtil fu = new FileUtil();
		String sFile = fu.newFile(path.substring(0, path.lastIndexOf("/")), path.substring(path.lastIndexOf("/")+1));
		System.out.println("sFile:"+sFile);
		fu.makeDir(request.getRealPath(realPath));
		String outFile = request.getRealPath(realPath)+"/"+sFile;
		System.out.println("outFile:"+outFile);
		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
//		HttpServletResponse response = ServletActionContext.getResponse();
//		downFile(response, path, request);
		HttpServletResponse response = ServletActionContext.getResponse();
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(outFile), sFile, response, true);
	}
	public static void executePrintText(HttpServletRequest request,String buffer, String path,String realPath) throws Exception {
		
		FileUtil fu = new FileUtil();
		String sFile = fu.newFile(path.substring(0, path.lastIndexOf("/")), path.substring(path.lastIndexOf("/")+1));
		System.out.println("sFile:"+sFile);
		fu.makeDir(request.getRealPath(realPath));
		String outFile = request.getRealPath(realPath)+"/"+sFile;
		System.out.println("outFile:"+outFile);
		FileOutputStream fOut = new FileOutputStream(outFile);
		byte[] data = buffer.getBytes();
		fOut.write(data);
		fOut.close();
		HttpServletResponse response = ServletActionContext.getResponse();
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(outFile), sFile, response, true);
	}
	public static void downFile(HttpServletResponse response,String path1,HttpServletRequest request) 
	throws IOException{
		File file=new File(path1);
		String fileName1=getFilePath(path1);
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName1 + "\"");
		response.setContentType("APPLICATION/OCTET-STREAM"); 
		System.out.println("over");
		
		InputStream ips=new FileInputStream(file);
		PrintWriter out=response.getWriter();
		int info=0;
		while((info=ips.read())!=-1){
			out.write(info);
		}
		ips.close();
		out.close();
	}
	
	public static String getFilePath(String path1) throws IOException {
		String fileName1=null;
		System.out.println("path1:"+path1);
		HttpServletRequest request=ServletActionContext.getRequest();
		 if(request.getRealPath(path1).lastIndexOf("/") > 0) {
			 fileName1 = new String(request.getRealPath(path1).substring(request.getRealPath(path1).lastIndexOf("/")+1, request.getRealPath(path1).length()).getBytes("GB2312"), "ISO8859_1");
    		 }else if(request.getRealPath(path1).lastIndexOf("\\") > 0) {
    			 fileName1 = new String(request.getRealPath(path1).substring(request.getRealPath(path1).lastIndexOf("\\")+1, request.getRealPath(path1).length()).getBytes("GB2312"), "ISO8859_1");
    		 }
		return fileName1;
	}
	public static String parseEncodingStr(String str, String encode) {
		String systemName=null;
		try {
			systemName=URLEncoder.encode(str, encode);
			System.out.println("systemName:"+systemName);
			systemName=URLDecoder.decode(systemName, encode);
		} catch (UnsupportedEncodingException e) {
			System.out.println("字符编码转化失败");
			e.printStackTrace();
		}
		return systemName;
	}
	public static String getWinStr(HttpServletRequest request, String returnName) {
		try {
		if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
				returnName = URLEncoder.encode(returnName, "UTF-8");
			} else {  
				returnName = new String(returnName.getBytes("UTF-8"), "ISO8859-1");  
			} 
		} catch (UnsupportedEncodingException e) {
			System.out.println("转换异常");
			e.printStackTrace();
		}
		return returnName;  
	}
	public static String getCookieStr(Cookie[] cookies, String loginUrl) {
		String loginPage="";
		for(int i=0;cookies!=null&&i<cookies.length;i++){
        	if(loginUrl.equals(cookies[i].getName())){
        		loginPage = cookies[i].getValue();
        	}
        }
		return loginPage;
	}
	public static void addToCookie(String name, String value,
			HttpServletResponse res, HttpServletRequest req) {
		String[] names=name.split(",");
		String[] values=value.split(",");
		Cookie cookie =null;
		for(int i=0;i<names.length;i++){
			cookie = new Cookie(names[i],values[i]);
			String path=req.getContextPath();
			cookie.setPath(path);
			res.addCookie(cookie);
		}
	}
	public static void delete(String name,HttpServletResponse res){
		Cookie c=new Cookie(name, "");
		c.setMaxAge(0);
		res.addCookie(c);
	}
	public static String getSuggest(List<String>username,
			String node, String word) {
		StringBuffer buffer=new StringBuffer();
		buffer.append("<words>");
		if(!username.isEmpty()){
			for(Iterator<String> i=username.iterator();i.hasNext();){
					buffer.append(node).append(i.next()).append(node.replace("<", "</"));
				}
//			}
		}
		buffer.append("</words>");
		System.out.println(username.size());
		return buffer.toString();
	}
	@SuppressWarnings("unchecked")
	public String hechengLawFile(LawEntity lawEntity) {
//		lawEntity=new LawEntity();
//		lawEntity.setId(88);
//		lawEntity.setLawTopic("标题");
//		lawEntity.setReleaseUser("石松林");
//		lawEntity.setReleaseTime("2014年");
//		lawEntity.setLawContent("石松林");
		String dir=toRealPath("upload")+"/fileLaw/";
		String path=dir+lawEntity.getId()+".html";
		System.out.println(Charset.defaultCharset());  
		System.getProperties().put("file.encoding", "UTF-8");  
		System.out.println(Charset.defaultCharset());  
		File file=new File(path);
		if(!file.exists()){
//			file.delete();
		try{
		StringBuffer buffer=new StringBuffer();
		buffer.append("<html xmlns=http://www.w3.org/1999/xhtml><meta http-equiv=Content-Type content=text/html; charset=utf-8 /><title>").append(lawEntity.getLawTopic());
		buffer.append("</title></head><body><div align=center>").append(lawEntity.getLawContent()).append("</div></body></html>");
		if(!file.exists()){
			file.createNewFile();
		}
		RandomAccessFile raf=new RandomAccessFile(file, "rw");	
		raf.seek(0);
		raf.writeUTF(buffer.toString());
		raf.close();
		}catch (Exception e) {
			System.out.println("合成失败");
			e.printStackTrace();
		}
		}
		return this.getbasePath()+"upload/fileLaw/"+lawEntity.getId()+".html";
	}
	public void setSystemOut(String path) {
		try{
	        File f = new File(path);   
	        if(!f.exists()){
	        	f.createNewFile();
	        }
	        FileOutputStream fileOutputStream = new FileOutputStream(f);  
	        PrintStream printStream = new PrintStream(fileOutputStream);  
	        System.setOut(printStream); 
		}catch (Exception e) {
			System.out.println("输入异常了");
			e.printStackTrace();
		}
	}
	public static String getSuggestUnique(Set<String> username, String node,
			String word) {
		StringBuffer buffer=new StringBuffer();
		buffer.append("<words>");
		if(!username.isEmpty()){
			for(Iterator<String> i=username.iterator();i.hasNext();){
					buffer.append(node).append(i.next()).append(node.replace("<", "</"));
				}
//			}
		}
		buffer.append("</words>");
		System.out.println(username.size());
		return buffer.toString();
	}
	/**
	 * str传过来的字符串
	 * pre字符，如小数点，"," 等
	 * i标志字符后的几位
	 */
	public String getStrAfterFix(String str, int i, String pre) {
		String result=str;
		if(str.indexOf(pre)>-1){
			int len=str.indexOf(pre);
			if(len+i<str.length()){
				result= str.substring(0, len+i);
			}else{
				result=StringUtils.rightPad(str, len+i, "0");
			}
		}
		return result;
	}
	public static void executePrintUnnormal(HttpServletRequest request, String path, String realPath, HSSFWorkbook wb
			)throws Exception {
		FileUtil fu = new FileUtil();
		String sFile = fu.newFile(path.substring(0, path.lastIndexOf("/")), path.substring(path.lastIndexOf("/")+1));
		System.out.println("sFile:"+sFile);
		fu.makeDir(request.getRealPath(realPath));
		String outFile = request.getRealPath(realPath)+"/"+sFile;
		System.out.println("outFile:"+outFile);
		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
//		HttpServletResponse response = ServletActionContext.getResponse();
//		downFile(response, path, request);
		HttpServletResponse response = ServletActionContext.getResponse();
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(outFile), sFile, response, true);
	}
	public static void setCellStyleValue(HSSFCell cell, HSSFCellStyle curStyle, String content) {
//		((Template) cell).setEncoding(HSSFCell.ENCODING_UTF_16); // 编码
		cell.setCellValue(StringUtil.Null2Str(content).replaceAll("", "").replace("&nbsp;", ""));
		cell.setCellStyle(curStyle);
	}
	public static String frmarkerHecheng(Map map, String realPath, String fileName, String newFileName) {
		String buffer="";
		try {
			String path=ServletActionContext.getServletContext().getRealPath(realPath);
			System.out.println("path:"+path);
			Configuration cfg = new Configuration(); 
			cfg.setDirectoryForTemplateLoading(new File(path));
			cfg.setObjectWrapper(new DefaultObjectWrapper());
			cfg.setDefaultEncoding("UTF-8");
			System.out.println(Charset.defaultCharset());
			Template t = cfg.getTemplate(fileName); 
			t.setEncoding("utf-8");
			String result=path+"/"+newFileName;
			File outFile=new File(result);
			System.out.println("result:"+result);
			Writer out=new OutputStreamWriter(new FileOutputStream(outFile));
			t.process(map,out);
			out.close();
			buffer=getStrFromFile(new File(result));
//			if(outFile.exists()){
//				outFile.delete();
//			}
		} catch (Exception e) {
			System.out.println("合成失败");
			e.printStackTrace();
		}
		return buffer;
	}
	public static String getStrFromFile(File file){
		StringBuffer buffer=new StringBuffer();
		BufferedReader br;
		try {
			br = new BufferedReader(new FileReader(file));
			String info=null;
			while((info=br.readLine())!=null){
				buffer.append(info);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return buffer.toString();
	}
	public static String frmarkerHechengFile(Map map, String realPath, String fileName, String newFileName) {
		String buffer="";
		try {
			String path=ServletActionContext.getServletContext().getRealPath(realPath);
			System.out.println("path:"+path);
			Configuration cfg = new Configuration(); 
			cfg.setDirectoryForTemplateLoading(new File(path));
			cfg.setObjectWrapper(new DefaultObjectWrapper());
//			cfg.setDefaultEncoding("UTF-8");
			System.out.println(Charset.defaultCharset());
			Template t = cfg.getTemplate(fileName); 
//			t.setEncoding("UTF-8");
			String result=path+"/"+newFileName;
			buffer=result;
			File outFile=new File(result);
			System.out.println("result:"+result);
			Writer out=new OutputStreamWriter(new FileOutputStream(outFile));
			t.process(map,out);
			out.close();			
		} catch (Exception e) {
			System.out.println("合成失败");
			e.printStackTrace();
		}
		return buffer;
	}
}
