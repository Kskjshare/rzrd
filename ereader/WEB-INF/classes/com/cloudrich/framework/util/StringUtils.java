package com.cloudrich.framework.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtils {

	public static boolean isNotNull(String params)
	{
		return params != null && !params.equals("");
	}
	
	public static boolean isNotNull(Object params)
	{
		return params != null && !params.toString().equals("");
	}
	
	/** 
     * 根据byte数组，生成文件 
     */  
    public static void byteToFile(byte[] bfile, String filePath,String fileName) {  
        BufferedOutputStream bos = null;  
        FileOutputStream fos = null;  
        File file = null;  
        try {  
            File dir = new File(filePath);  
            if(!dir.exists()&&dir.isDirectory()){//判断文件目录是否存在  
                dir.mkdirs();  
            }  
            file = new File(filePath+"\\"+fileName);  
            fos = new FileOutputStream(file);  
            bos = new BufferedOutputStream(fos);  
            bos.write(bfile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (bos != null) {  
                try {  
                    bos.close();  
                } catch (IOException e1) {  
                    e1.printStackTrace();  
                }  
            }  
            if (fos != null) {  
                try {  
                    fos.close();  
                } catch (IOException e1) {  
                    e1.printStackTrace();  
                }  
            }  
        }  
    }  
    
    public static String getRamName(){
    	SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
        Date date=new Date();    
        String time=sdf.format(date);
	    Date dt = null;
		try {
			dt = sdf.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    String fname=dt.getTime()+"";
	    return fname;
    }
}
