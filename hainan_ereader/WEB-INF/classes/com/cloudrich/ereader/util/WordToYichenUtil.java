package com.cloudrich.ereader.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WordToYichenUtil {

	final static String[] keywords = { "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五",
			"十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
			"11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "（1）",
			"（2）", "（3）", "（4）", "（5）", "（6）", "（7）", "（8）", "（9）", "（10）", "（11）", "（12）", "（13）", "（14）", "（15）",
			"（16）", "（17）", "（18）", "（19）", "（20）", "（21）", "（22）", "（23）", "（24）", "（25）", "（26）", "（27）" };
	final static String onetitles = "一,二,三,四,五,六,七,八,九,十,十一,十二,十三,十四,十五,十六,十七,十八,十九,二十,二十一,二十二,二十三,二十四";
	final static String twotitles = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
	final static String threetitles = "（1）,（2）,（3）,（4）,（5）,（6）,（7）,（8）,（9）,（10）,（11）,（12）,（13）,（14）,（15）,（16）,（17）,（18）,（19）,（20）,（21）,（22）,（23）,（24）,（25）,（26）,（27）";

	/**
	 * 读取议程文件
	 * 
	 * @param filename
	 * @return
	 */
	public static List<Map<String, Object>> readYichenFromFile(String filename) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<String> liststr = null;
		// System.out.println("filename就是" + filename);
		String name = filename.trim().substring(filename.indexOf(".doc") + 1);
		// System.out.println("readYichenFromFile :"+name);
		// System.out.println(name.trim().equals("doc"));
		if (name.trim().equals("doc")) {
			liststr = WordReadUtil.readTextFromWord2003(filename);
		} else {
			liststr = WordReadUtil.readTextFromWord2007(filename);
			// System.out.println(liststr.size());
		}

		int i = 1;
		StringBuffer yichenStr = null;
		Map<String, Object> map = null;
		// 循环文件文本内容
		for (int t = 0; t < liststr.size(); t++) {
			String text = liststr.get(t).trim();
			System.out.println(text);
			if (text != null && text.trim().length() != 0) {
				for (String keyword : keywords) {
					if (text.indexOf(keyword) == 0) {
						if (yichenStr != null && yichenStr.toString().trim().length() != 0) {

							 //System.out.println(yichenStr.toString());
							map.put("content", yichenStr.toString().trim());
							list.add(map);
							// if()
						}

						i = 0;
						yichenStr = new StringBuffer();
						map = new HashMap<String, Object>();
						// 定义级别
						map.put("keyword", keyword);
						if (onetitles.indexOf(keyword) >= 0) {
							map.put("level", 1);
							//System.out.println("keyword is:"+keyword);
							System.out.println("level is: 1");
						} else if (twotitles.indexOf(keyword) >= 0) {
							map.put("level", 2);
							//System.out.println("keyword is:"+keyword);
							System.out.println("level is: 2");
						}
						// 第三级
						else if (threetitles.indexOf(keyword) >= 0) {
							map.put("level", 3);
							//System.out.println("keyword is:"+keyword);
							System.out.println("level is: 3");
						}
						break;
					}
				}
			}

			// 换行增加
			if (i == 0) {
				yichenStr.append(text);

			}
		}
		// 增加最后一个议程
		if (yichenStr != null && yichenStr.toString().trim().length() != 0) {

			map.put("content", yichenStr.toString().trim());
			System.out.println(yichenStr.toString());
			list.add(map);
		}
		
		return list;
	}

	/**
	 * 
	 */
	public static void main(String[] args) {
		String filename = "C:\\Users\\jack\\Desktop\\项目资料\\新建文件夹\\34次主任会议议程.doc";
		readYichenFromFile(filename);
	}

}
