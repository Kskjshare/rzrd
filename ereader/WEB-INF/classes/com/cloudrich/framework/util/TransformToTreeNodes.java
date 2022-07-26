package com.cloudrich.framework.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TransformToTreeNodes {

	/**
	 * 获取tree需要的数据
	 * @param list
	 * @param node
	 * @return
	 */
	
	
	
	public TransformToTreeNodes()
	{
	}
	public String fromTreeNode(List<Map<String,Object>> list,Map<String,Object> node)
	{
		StringBuilder stringbuilder = new StringBuilder();
		traOfToJson(list,node,stringbuilder);
		stringbuilder.insert(0, "[");
		stringbuilder.insert(stringbuilder.length(), "]");
		return (stringbuilder.toString().replaceAll(",]", "]")) ;
	}
	public String fromTreeNodeforSelect(List<Map<String,Object>> list,Map<String,Object> node)
	{
		StringBuilder stringbuilder = new StringBuilder();
		traOfToJsonforSelect(list,node,stringbuilder);
		stringbuilder.insert(0, "[");
		stringbuilder.insert(stringbuilder.length(), "]");
		return (stringbuilder.toString().replaceAll(",]", "]")) ;
	}
	public boolean hasChild(List<Map<String,Object>> list , Map<String,Object> node)
	{
		return getChildList(list,node).size() > 0? true : false ;
	}
	
	public List<Map<String,Object>> getChildList(List<Map<String,Object>> list , Map<String,Object> node)
	{
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		for(Map<String,Object> newMap : list)
		{
			if(newMap.get("pid").toString().equals(node.get("id").toString()))
			{
				mapList.add(newMap);
			}
		}
		return mapList;
	}
	
	public boolean isClosed(Object flag)
	{
		String a [] = {"GGMK","JTGL","QDYY","QYGL","QYYY","WLJK","XTGL"};
		for(int i = 0 ; i < a.length ; i ++)
		{
			if(a[i].equals(flag.toString()))
			{
				return true ;
			}
		}
		return false ;
	}
	
	public void traOfToJson(List<Map<String,Object>> list,Map<String,Object> node ,StringBuilder returnStr)
	{
		
		if(hasChild(list,node))
		{
			
			List<Map<String,Object>> listMap = getChildList(list,node);
			returnStr.append("{\"id\":").append("\"").append(node.get("id")).append("\"").
			append(",\"text\":").
			append("\""+node.get("text")+"\",");
			if(isClosed(node.get("id")))
			{
				returnStr.append("\"state\":").append("\"closed\",");
			}
			if(node.get("checked") != null)
			{
				returnStr.append("\"checked\":").append(""+node.get("checked")+",");
			}
			if(node.get("icon") != null&&!node.get("icon").toString().equals(""))
			{
				returnStr.append("\"iconCls\":").append(""+node.get("icon")+",");
			}
			returnStr.append("\"children\":[");
			for(Map<String,Object> map : listMap)
			{
				traOfToJson(list,map,returnStr);
			}
			returnStr.append("]},");
		} else{    
			         returnStr.append("{\"id\":");  
			         returnStr.append("\"").append(node.get("id")).append("\"")
		             .append(",\"text\":").append("\""+node.get("text")+"\"");
						if(node.get("checked") != null)
						{
							returnStr.append(",\"checked\":").append(""+node.get("checked")+"");
						}
						if(isClosed(node.get("id")))
						{
							returnStr.append(",\"state\":").append("\""+node.get("closed")+"\"");
						}
						if(node.get("icon") != null&&!node.get("icon").toString().equals(""))
						{
							returnStr.append(",\"iconCls\":").append("\""+node.get("icon")+"\"");
						}
	                 returnStr.append("},");    
			      }    

	}
	
	
	
	

	
	
	
	
	public void traOfToJsonforSelect(List<Map<String,Object>> list,Map<String,Object> node ,StringBuilder returnStr)
	{
		
		if(hasChild(list,node))
		{
			
			List<Map<String,Object>> listMap = getChildList(list,node);
			returnStr.append("{\"id\":").append("\"").append(node.get("id")).append("\"").
			append(",\"text\":").
			append("\""+node.get("text")+"\",");
			
			returnStr.append("\"children\":[");
			for(Map<String,Object> map : listMap)
			{
				traOfToJson(list,map,returnStr);
			}
			returnStr.append("]},");
		} else{    
			         returnStr.append("{\"id\":");  
			         returnStr.append("\"").append(node.get("id")).append("\"")
		             .append(",\"text\":").append("\""+node.get("text")+"\"");
		         
	                 returnStr.append("},");    
			      }    

	}

	public static void main(String[] args) {
		List<Map<String,Object>> listmap = new ArrayList<Map<String,Object>>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("id", "1");
		map1.put("pid", "0");
		map1.put("text", "1");
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("id", "2");
		map2.put("pid", "1");
		map2.put("text", "2");
		Map<String,Object> map3 = new HashMap<String,Object>();
		map3.put("id", "3");
		map3.put("pid", "1");
		map3.put("text", "3");
		Map<String,Object> map4 = new HashMap<String,Object>();
		map4.put("id", "4");
		map4.put("pid", "2");
		map4.put("text", "4");
		map4.put("checked", true);
		listmap.add(map1);
		listmap.add(map2);
		listmap.add(map3);
		listmap.add(map4);
		
		TransformToTreeNodes t = new TransformToTreeNodes();
		String s = t.fromTreeNodeforSelect(listmap, map1);
		System.out.println(s);
	}
}
