package com.cloudrich.ereader.util;

import java.util.HashMap;
import java.util.Map;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.Cell;
import com.cloudrich.ereader.common.action.BaseAction;
import com.cloudrich.ereader.common.util.ValidateUtil;

public class DoWorkUtil extends BaseAction{
	
	public static Map<String,String> getInfoInHSSF(int beginIndex, HSSFSheet sheet, int colNum) {
		Map<String,String>map=new HashMap<String, String>();
		int rowNum=sheet.getLastRowNum()+1;
		System.out.println("rowNum:"+rowNum);
		for(int i=0;i<sheet.getLastRowNum()+1;i++){
			if(!ValidateUtil.isValid(getCellValue(sheet.getRow(i).getCell(0)))){
				rowNum--;
			}
		}
		System.out.println("rowNum:"+rowNum);
		HSSFRow row=null;
		
		for(int i=beginIndex;i<rowNum;i++){
			int j=0;
			try{
			row=sheet.getRow(i);
//			colNum=row.getLastCellNum();
			while(j<colNum){
				map.put(i+"-"+j, getCellValue(row.getCell(j)));
//				System.out.println("colNum:"+colNum);
				j++;
			}
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("i:"+i+"==j:"+j);
				System.out.println("读取文件失败");
			}
		}
		
		map.put("beginRowIndex", beginIndex+"");
		map.put("totalRowNums", rowNum+"");
		map.put("totalColNums", colNum+"");
//		System.out.println("map:"+map);
		return map;
	}
	
	@SuppressWarnings({ "static-access", "deprecation" })
	private static String getCellValue(HSSFCell hssfCell) {
		String cellValue="";
		if(hssfCell!=null){			
		switch (hssfCell.getCellType()) {
		case Cell.CELL_TYPE_BLANK:
			cellValue="";break;
		case Cell.CELL_TYPE_BOOLEAN:
			cellValue=String.valueOf(hssfCell.getBooleanCellValue());break;
		case Cell.CELL_TYPE_NUMERIC:
			cellValue=String.valueOf(hssfCell.getNumericCellValue());break;
		case Cell.CELL_TYPE_FORMULA:
			cellValue=String.valueOf(hssfCell.getCellFormula());break;
		default:
			cellValue=String.valueOf(hssfCell.getStringCellValue());break;
		}
		}
		return cellValue;
//		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) { 
//            // 返回布尔类型的值 
//            return String.valueOf(hssfCell.getBooleanCellValue()); 
//        } else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) { 
//            // 返回数值类型的值 
//        	//判断是否为日期类型
//        	if(HSSFDateUtil.isCellDateFormatted(hssfCell)){
//        		Date date=hssfCell.getDateCellValue();
//        		// 把Date转换成本地格式的字符串   
//        		return date.toLocaleString();
//        	}else{
//        		return String.valueOf(hssfCell.getNumericCellValue()); 
//        	}
//        }  else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BLANK) { 
//            // 返回空值类型的值 
//            return "";
//        } else { 
//            // 返回字符串类型的值 
//            return String.valueOf(hssfCell.getStringCellValue()); 
//        } 
	}
	
	
	
	public  static void  main(String[] args){
		
		    String daterichen="11 月1 日（星期三)";
		    String timerichen="15:20 分组审议";
		    
		    String months=daterichen.substring(0,daterichen.indexOf("月"));
		    String days=daterichen.substring(daterichen.indexOf("月")+1,daterichen.indexOf("日"));
		    String hours=timerichen.substring(0,timerichen.indexOf(":"));
		    String minutes=timerichen.substring(timerichen.indexOf(":")+1,timerichen.indexOf(":")+3);
		    System.out.println("月："+months);
		    System.out.println("日："+days);
		    System.out.println("小时："+hours);
		    System.out.println("份："+minutes);
	}
}
