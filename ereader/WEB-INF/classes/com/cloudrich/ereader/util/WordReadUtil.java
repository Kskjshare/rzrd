package com.cloudrich.ereader.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

public class WordReadUtil {
	
	/**
	 * 内部调用
	 * @param is
	 * @return
	 */
	 public static  List<String> readTextFromWord2007(String filename){
		List<String> list=new ArrayList<String>();
		XWPFDocument doc = null;
		InputStream is = null;
		try {
			is = new FileInputStream(filename);
			doc = new XWPFDocument(is);
		} catch (IOException e) {
			e.printStackTrace();
		}  
	      List<XWPFParagraph> paras = doc.getParagraphs();
	      for (XWPFParagraph para : paras) {  
	    	  String text=para.getText().trim();
	    	  System.out.println("wordreadUtil text is:"+text);
	    	  list.add(text);
	      }
	      //关闭close
  		if (doc != null) {  
		         try {  
		             doc.close();
		         } catch (IOException e) {  
		            e.printStackTrace(); 
		         }  
		      } 
  		if (is != null) {  
		         try {  
		             is.close();
		         } catch (IOException e) {  
		            e.printStackTrace(); 
		         }  
		      } 
	      
	      return list;  
	}
	 
	 /**
		 * 内部调用
		 * @param is
		 * @return
		 */
		public static List<String> readTextFromWord2003(String filename){
			List<String> list=new ArrayList<String>();
			WordExtractor doc = null;
			
			InputStream is = null;
			try {
				is = new FileInputStream(filename);
				doc = new WordExtractor(is);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			String [] strArray = doc.getParagraphText();
		      for (int i=0;i<strArray.length;i++) {  
		    	  String text=strArray[i].trim();
		    	  list.add(text);
		      }
		    //关闭close
	    		if (doc != null) {  
			         try {  
			             doc.close();
			         } catch (IOException e) {  
			            e.printStackTrace(); 
			         }
			      } 
	    		if (is != null) {  
			         try {  
			             is.close();
			         } catch (IOException e) {  
			            e.printStackTrace(); 
			         }  
			      } 
		      return list;  
		}

}
