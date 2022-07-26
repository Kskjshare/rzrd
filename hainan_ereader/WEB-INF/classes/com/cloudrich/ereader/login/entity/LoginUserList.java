package com.cloudrich.ereader.login.entity;

import java.util.Enumeration;
import java.util.Vector;

public class LoginUserList {
	private static final LoginUserList userList=new LoginUserList();
	 private Vector<String> v;

	 
	   private LoginUserList()

	    {

	       v=new Vector<String>();

	   }

	

	   public static LoginUserList getInstance()

	    {

	         return userList;

	    }

	    

	   public void addUser(String name)

	    {

	         if(name!=null)

	           v.addElement(name);

	   }

	  

	   public void removeUser(String name)

	   {

	         if(name!=null)

	              v.remove(name);

	    }

	 

	   public Enumeration<String> getUserList()

	    {

	         return v.elements();

	    }

	    

	    public int getUserCount()

	    {

	        return v.size();

	    }
}
