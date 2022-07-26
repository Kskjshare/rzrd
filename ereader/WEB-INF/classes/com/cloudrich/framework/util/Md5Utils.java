package com.cloudrich.framework.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.digest.DigestUtils;

public class Md5Utils {

	public static String md5_16or32(int plainText,String txt) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(txt.getBytes());
			byte b[] = md.digest();
			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			if(plainText == 16)
			{
				return buf.toString().substring(8, 24);
			}else if(plainText == 32)
			{
				return buf.toString();
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String MD5_16(String txt)
	{
		return md5_16or32(16,txt);
	}
	
	public static String MD5_32(String txt)
	{
		return md5_16or32(32, txt);
	}
	
	public static void main(String[] args){
		//String sys = MD5_32("admin@123");
		//System.out.println(sys);
		
		File file = new File("d://《Effective Java中文版 第2版》.(Joshua Bloch).[PDF]&ckook.pdf");
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
	}
}
