package com.cloudrich.framework.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

/**
 * 与IO相关的工具类
 *
 */
public class IOUtil {
	
	private static final int BUFFER_SIZE = 16 * 1024;

	/**
	 * 获取文件后缀名
	 *
	 * @param fileName
	 * @return
	 */
	public static String getExtention(String fileName){
		String result = "";
        int pos = fileName.lastIndexOf(".");
        if(pos > -1){
        	result = fileName.substring(pos);
        }
        return result;
	}
	
	/**
	 * 复制文件
	 *
	 * @param src 输出文件
	 * @param dst 输出地址
	 * @throws Exception
	 */
	public static void copy(File src, File dst) throws Exception {
		InputStream is = null ;
		OutputStream os = null ;
		try{                
			is = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
			os = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE);
			byte[] buffer = new byte[BUFFER_SIZE];
			while(is.read(buffer) > 0){
				os.write(buffer);
			}
		}catch(Exception e){
			throw e;
		}finally{
			if(is != null){
				is.close();
			}
			if(os != null){
				os.close();
			}
		}
	}
	public void copy1(File src, File dst) throws Exception {
		InputStream is = null ;
		OutputStream os = null ;
		try{                
			is = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
			os = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE);
			byte[] buffer = new byte[BUFFER_SIZE];
			while(is.read(buffer) > 0){
				os.write(buffer);
			}
		}catch(Exception e){
			throw e;
		}finally{
			if(is != null){
				is.close();
			}
			if(os != null){
				os.close();
			}
		}
	}
	
	/**
	 * 删除文件
	 * @param filePath 文件路径
	 * @return
	 * @throws Exception
	 */
	public static boolean delete(String filePath) throws Exception
	{
		boolean flag = false; 
		
		File file = new File(filePath);  
		if (file.isFile() && file.exists())  //路径为文件并且此文件存在
		{  
			 file.delete();  
			 flag = true;  
		} 
		return flag;
	}
	
	
	
	public static void sunvinsDown(String filePath,String fileName,HttpServletResponse response) 
	throws Exception { 
	File file = new File(filePath+fileName); 
	System.out.println(file.getName());
	System.out.println(filePath+fileName);
	if(!file.exists()){ 
	System.out.println("文件不存在"); 
	}else{ 
	FileInputStream fis = new FileInputStream(file); 
	BufferedInputStream bis = new BufferedInputStream(fis); 

	OutputStream os=response.getOutputStream(); 
	BufferedOutputStream bos=new BufferedOutputStream(os); 

	fileName=URLEncoder.encode(fileName,"UTF-8"); 
	fileName=new String(fileName.getBytes("UTF-8"),"GBK"); 
	response.reset();
	response.setContentType("UTF-8"); 
	response.setContentType("Application/x-msdownload"); 
	response.setHeader("Content-Disposition", "attachment;filename="+fileName); 
	response.setHeader("Content-Length", String.valueOf(bis.available())); 

	int bytesRead=0; 
	byte[] buffer=new byte[1024]; 
	while((bytesRead=bis.read(buffer))!=-1){ 
	bos.write(buffer,0,bytesRead); 
	} 
	bos.flush(); 
	bos.close(); 
	bis.close(); 

	os.close(); 
	fis.close(); 
	} 
	}
}
