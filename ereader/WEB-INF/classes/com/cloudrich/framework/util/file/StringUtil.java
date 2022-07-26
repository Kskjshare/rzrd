package com.cloudrich.framework.util.file;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class StringUtil {
	
	public static String[] str2Arr(String str,String reg){
		if(ValidateUtil.isValid(str)){
			return str.split(reg);
		}
		return null;
	}

	public static boolean contains(String[] arr, String value) {
		if(ValidateUtil.isValid(arr)){
			for(String s:arr){
				if(value.equals(s)){
					return true;
				}
			}
		}
		return false;
	}

	public static String arr2Str(Object[] arr) {
		String temp="";
		if(ValidateUtil.isValid(arr)){
			for(Object s:arr){
				temp+=s+",";
			}
			return temp.substring(0, temp.length()-1);
		}
		return null;
	}
	public static String getDescString(String str,int count){
		if(ValidateUtil.isValid(str)){
			if(str.length()>count){
				str=str.substring(0, count-1);
			}
		}
		return str;
	}

	public static String str2Str(String ids, String reg) {
		String[] str=str2Arr(ids, reg);
		String temp="";
		if(ValidateUtil.isValid(str)){
			for(String s:str){
				temp+="'"+s+"',";
			}
			temp=temp.substring(0, temp.length()-1);
		}
		return temp;
	}

	public static String arr2Str(int[] menuId) {
		String temp="";
		if(menuId.length>0){
			for(int s: menuId){
				temp+=s+",";
			}
			return temp.substring(0, temp.length()-1);
		}
		return null;
	}

	public static String[] remove(String[] qx, String value) {
		List<String>list=new ArrayList<String>();
//		String temp="";
		for(String s:qx){
			if(!value.equals(s))
			list.add(s);
		}
		return list.toArray(new String[list.size()]);
//		for(String s:set){
//			temp+=s+","; 
//		}
//		if(temp.length()>0){
//			return temp.split(",");
//		}else{
//			return null;
//		}
		
	}

	public static String[] removeSeems(String[] qx) {
		Set<String>set=new HashSet<String>();
		for(String s:qx){
			set.add(s);
		}
		return set.toArray(new String[set.size()]);
	}

	public static String Null2Str(String str) {
		if(ValidateUtil.isValid(str)){
			return str;
		}
		return "";
	}

}
