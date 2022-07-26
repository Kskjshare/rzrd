package com.cloudrich.framework.util.file;

import java.util.Collection;

public class ValidateUtil {

	/**
	 * 检验字符串
	 */
	public static boolean isValid(String str){
		if(str == null || "".equals(str.trim())||"null".equals(str)){
			return false ;
		}
		return true ;
	}
	
	/**
	 * 检验集合
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isValid(Collection col){
		if(col == null || col.isEmpty()){
			return false ;
		}
		return true ;
	}

	/**
	 * 检验数组
	 */
	public static boolean isValid(Object[] arr) {
		if(arr == null || arr.length == 0){
			return false;
		}
		return true ;
	}

}
