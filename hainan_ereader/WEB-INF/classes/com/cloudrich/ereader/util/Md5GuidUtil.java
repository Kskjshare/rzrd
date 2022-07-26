package com.cloudrich.ereader.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.commons.codec.digest.DigestUtils;

public class Md5GuidUtil {
	public static String getMd5Guid(File file){
		String md5=null;
		try {
			md5 = DigestUtils.md5Hex(new FileInputStream(file));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(md5);
		return md5;
	}
	
}
