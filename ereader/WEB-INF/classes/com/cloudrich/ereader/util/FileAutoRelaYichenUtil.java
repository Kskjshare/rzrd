package com.cloudrich.ereader.util;

import java.util.ArrayList;
import java.util.List;

public class FileAutoRelaYichenUtil {

	private static final String[] startStrs=
		new String[]{"关于提请审议",
				     "关于提请",
				     "关于促进",
				     "关于实施",
				     "关于",
				     "传达和学习",
				     "传达学习",
				     "传达",
				     "学习",
				     "听取和审议",
				     "听取",
				     };
	private static final String[] endStrs=
			new String[]{">",
					    "管理条例（草案）",
					    "修正案（草案）",
					    "办法（修订草案）",
					    "工作情况的报告",
					     "的报告",
					     "的议案",
					     "主要精神",
					     "（草案）",
					     "(草案)",
					     "的汇报"};
	
	private static final String[] containStrs=
			new String[]{"建议议程和日程",
					     "建议议程",
					     "建议日程",
					     "议程",
					     "日程"};
	
/**
 * 生成关键字数组
 * @param yichenname
 * @return
 */
public static List<String> generalKeyWords(String yichenname){	
	    List<String>  keylist=new ArrayList<String>();
		 int t=1;
		 String tempname=null;
		 String tempname1=null;
		 
		 
		 try{
			 
	       //是否包含
			 for(int m=0;m<containStrs.length;m++){
				 if(yichenname.indexOf(containStrs[0])>=0){
					 keylist.add("议程");
					 keylist.add("日程");
					 keylist.add("议题");
					 break;
				 }else if(yichenname.indexOf(containStrs[1])>=0){
					 keylist.add(containStrs[1]);
					 keylist.add("议题");
				 }else if(yichenname.indexOf(containStrs[3])>=0){
					 keylist.add(containStrs[3]);
					 keylist.add("议题");
				 }else if(yichenname.indexOf(containStrs[m])>=0){
					 keylist.add(containStrs[m]);
				 }
			 }
			 
			 //获取书名号中的关键字
			 while(true){ 
		    	 if(yichenname.indexOf("《")>=0){
		             	
		             	tempname=yichenname.substring(yichenname.indexOf("《")+1, yichenname.indexOf("》"));
		             	if(tempname!=null&&tempname.trim().length()!=0){
		             		
		             		for(int j=0;j<endStrs.length;j++){
		    				 if(tempname.indexOf(endStrs[j])>=0){
		    					 tempname=tempname.substring(0, tempname.lastIndexOf(endStrs[j]));
		    					 break;
		    				 }
		    			  }
		             		 System.out.println("------------------"+tempname);
			         		keylist.add(tempname);
			         	}
		             	t++;
		             	
		             	tempname1=yichenname.substring(yichenname.indexOf("》")+1);
		             	yichenname=tempname1;
		             }else{
		             	break;
		             }
	     	}
	 
	   //  if(t==1){
		      
	    	 //截取前面字符串
			 if(tempname!=null&&tempname.trim().length()!=0){
				 yichenname=tempname;
			 }
			
	    	 System.out.println("file util yichenname is:"+yichenname);
		    	 for(int i=0;i<startStrs.length;i++){
		    		 System.out.println("file util startStrs is:"+startStrs[i]);
			    		 if(yichenname.indexOf(startStrs[i])>=0){
				    			 boolean b=true;
				    			 int startindex=yichenname.indexOf(startStrs[i]);
				    			 startindex=startindex+startStrs[i].length();
				    			 System.out.println("-------startindexb-"+startindex);
				    			 //截取后面字符串
				    			 for(int j=0;j<endStrs.length;j++){
				    				 if(yichenname.indexOf(endStrs[j])>=0){
				    					 tempname=yichenname.substring(startindex, yichenname.lastIndexOf(endStrs[j]));
				    					
				    				     b=false;
				    					 break;
				    				 }
				    			  }
				    			 if(b){
				    				 tempname=yichenname.substring(startindex); 
				    			 }
				    			 
				    			 //增加进入关键字数组
				    			 if(tempname!=null&&tempname.trim().length()!=0){
						         		keylist.add(tempname);
						         		System.out.println("----------------"+tempname);
						         	}
				    			 break;
			    		     }
		    	  }
	    // }	
		 }catch(Exception e){
			 e.printStackTrace();
			 return keylist;
		 }
	     return keylist;
	}
/**
 * 
 * @param args
 */
public  static void main(String[] args){
	List<String> list1=generalKeyWords("十、审议昌江黎族自治县人民代表大会常务委员会关于报请批准《昌江黎族自治县农村公路条例》的报告");
	for(int i=0;i<list1.size();i++){
		System.out.println("list is:"+list1.get(i));
	}
	//System.out.println("海南省实施<中华人民共和国教师法".indexOf("<"));
}
}
