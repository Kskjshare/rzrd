package com.cloudrich.ereader.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

public class WordToRichenUtil {
	
	final static String[] dateWords={"月","日","星期"};
	final static String[] timeWords={"7:","8:","9:","07:","08:","09:","10:","11:","12:","13:","14:","15:","16:","17:","18:","19:","20:","21:","22:","23:","24:"};
    final static String[] rcytWords={"1、","2、","3、","4、","5、","6、","7、","8、","9、","10、","11、","12、","13、","14、","15、","16、","17、","18、","19、","20、","21、","22、","23、","表决有关","闭幕会","闭会"};
	final static String[] exitWords={"注："};
    /**
	 * 读取议程内容
	 * @param filename
	 * @return
	 */
	public static List<RichenConvertObject> readRichenFromFile(String filename){
		List<RichenConvertObject> list=new ArrayList<RichenConvertObject>();
		List<String> liststr=null;
		RichenConvertObject object=null;
			      
		String name=filename.trim().substring(filename.indexOf(".doc")+1);
		System.out.println(name);
		System.out.println(name.trim().equals("doc"));
		if(name.trim().equals("doc")){
			liststr=WordReadUtil.readTextFromWord2003(filename);
		}else{
			liststr=WordReadUtil.readTextFromWord2007(filename);
		}		
	      //层级标识
	      int i=0;
	      int j=0;
	      int k=0;
	      StringBuffer richenStr=null;
	      //循环文件文本内容
	      for (int m=0;m<liststr.size();m++) {  
	    	  String text=liststr.get(m);
	    	  //System.out.println(text+"j="+j+",,,i="+i);
	    	  
	    	  //退出
	    	  if(text.indexOf(exitWords[0])==0){
	    			  break;
	    		}
	    	 
	    	  //日期日程
	    	  if(text.indexOf(dateWords[0])>=0&&text.indexOf(dateWords[1])>=0&&text.indexOf(dateWords[2])>=0){
	    		  
	    		//增加最后一个议程
			      if(richenStr!=null&&richenStr.toString().trim().length()!=0){
			    	  object=new RichenConvertObject();
			    	  object.setYitiName(richenStr.toString());
					  list.add(object);
					  //System.out.println(richenStr.toString());
					  richenStr=null;
				  }
			      
	    		  System.out.println(text);
	    		  object=new RichenConvertObject();
		    	  object.setDateName(text);
				  list.add(object);
	    		  i=1;
	    		  continue;
	    	  }
	    	  //时间日程
	    	  int tag=0;
	    	  if(i==1){;
		    	  for(int t=0;t<timeWords.length;t++){
		    		  if(text.indexOf(timeWords[t])==0){
		    			  
		    			  //增加分组最后一个议题
		    			  if(richenStr!=null&&richenStr.toString().trim().length()!=0){
		    				  object=new RichenConvertObject();
					    	  object.setYitiName(richenStr.toString());
							  list.add(object);
							 // System.out.println(richenStr.toString());
							  richenStr=null;
						  }
		    			  
		    			  
		    			  //时间日程
		    			  j=2;
		    			  tag=1;
		    			  System.out.println(text+"-----"+j);
		    			  object=new RichenConvertObject();
				    	  object.setTimeName(text);
						  list.add(object);
		    			  
		    			  break;
		    		  }
		    	  }
		    	  if(tag==1){
		    		  continue;
		    	  }
		    	  
	    	  }
	    	  //日程议题
	    		    	  
	    	  if(j==2){
		    	  for(String keyword:rcytWords){
				    	  if(text.indexOf(keyword)==0){
					    		  if(richenStr!=null&&richenStr.toString().trim().length()!=0){
					    			  object=new RichenConvertObject();
							    	  object.setYitiName(richenStr.toString());
									  list.add(object);
					    			 // System.out.println(richenStr.toString());
					    		  }
					    			 
					    		  //新的一行议程
					    		  richenStr=new StringBuffer();
					    		  k=3;
					    		  break;
				    	  }
		    	  }
		    	  
		    	  if(k==3){
		    		  richenStr.append(text);
		    	  }
		    	    
	          }  
	    	  
	      }
	      //增加最后一个议题
	      if(richenStr!=null&&richenStr.toString().trim().length()!=0){
	    	  object=new RichenConvertObject();
	    	  object.setYitiName(richenStr.toString());
			  list.add(object);
			 // System.out.println(richenStr.toString());
			  richenStr=null;
		  }
	      		
	      
	      return list;

	}
	
	/**
	 * 
	 * @param args
	 */
	public  static void main(String[] args){
		String filename="g:\\海南省五届人大常委会日程.docx";
		readRichenFromFile(filename);
		
	}
   
	}
