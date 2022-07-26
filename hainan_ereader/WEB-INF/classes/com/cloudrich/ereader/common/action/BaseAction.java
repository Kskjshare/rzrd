package com.cloudrich.ereader.common.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.cloudrich.ereader.common.constant.LoginConstant;
import com.cloudrich.ereader.common.util.ValidateUtil;
import com.cloudrich.ereader.login.entity.LoginUser;
import com.cloudrich.ereader.meeting.entity.SelectEntity;
import com.cloudrich.ereader.pdf.Constant;
import com.cloudrich.ereader.pdf.SingleOpenOffice;
import com.cloudrich.ereader.pdf.SingleOpenOfficeDemo;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.regexp.internal.recompile;

public abstract class BaseAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6873530708823870074L;

	private Map<String, Object> codeMap = new HashMap<String, Object>();
	public static final String provinceName = "汝州市";
	public static final String FORMAT = "yyyy-MM-dd HH:mm";

	public Map<String, Object> getCodeMap() {
		return codeMap;
	}

	public void l(Object info) {
		System.out.println(String.valueOf(info));
	}

	public List<SelectEntity> getCiShuLists() {
		List<SelectEntity> cishuLists = new ArrayList<SelectEntity>();
		cishuLists.add(new SelectEntity("1", "1"));
		cishuLists.add(new SelectEntity("2", "2"));
		cishuLists.add(new SelectEntity("3", "3"));
		cishuLists.add(new SelectEntity("4", "4"));
		cishuLists.add(new SelectEntity("5", "5"));
		cishuLists.add(new SelectEntity("6", "6"));
		cishuLists.add(new SelectEntity("7", "7"));
		cishuLists.add(new SelectEntity("8", "8"));
		return cishuLists;
	}

	public List<SelectEntity> getJieshuLists() {
		List<SelectEntity> jieshuLists = new ArrayList<SelectEntity>();
		jieshuLists.add(new SelectEntity("1", "1"));
		jieshuLists.add(new SelectEntity("2", "2"));
		jieshuLists.add(new SelectEntity("3", "3"));
		jieshuLists.add(new SelectEntity("4", "4"));
		jieshuLists.add(new SelectEntity("5", "5"));
		jieshuLists.add(new SelectEntity("6", "6"));
		jieshuLists.add(new SelectEntity("7", "7"));
		jieshuLists.add(new SelectEntity("8", "8"));
		return jieshuLists;
	}

	public String getBaseMeetingName(String mtype, String mjieshu, String mcishu) {
		int type = Integer.parseInt(mtype);
		String jieshu = mjieshu;
		String cishu = mcishu;
		if (type == 1) {
			return provinceName + "第" + jieshu + "届人民代表大会常务委员会主任会议第" + cishu
					+ "次会议";
		} else if (type == 2) {
			return provinceName + "第" + jieshu + "届人民代表大会常务委员会第" + cishu
					+ "次会议";
		} else if (type == 3) {
			return provinceName + "第" + jieshu + "届人民代表大会法制委员会第" + cishu
					+ "次会议";
		} else if (type == 4) {
			return provinceName + "第" + jieshu + "届人民代表大会财政经济委员会第" + cishu
					+ "次会议";
		} else if (type == 5) {
			// return provinceName+cishu+"会议";
			return cishu;
		}
		return null;
	}

	public static String getJieshu(String meetingName, int type) {
		if (ValidateUtil.isValid(meetingName) && type != 5) {
			return meetingName.substring(meetingName.indexOf("市第") + 2,
					meetingName.indexOf("届"));
		}
		return null;
	}

	public static String getCishu(String meetingName, int type) {
		if (ValidateUtil.isValid(meetingName)) {
			if (type != 5) {
				return meetingName.substring(meetingName.lastIndexOf("第") + 1,
						meetingName.indexOf("次"));
			} else if (type == 5) {
				// return
				// meetingName.substring(meetingName.indexOf("海南省")+3,meetingName.lastIndexOf("会议"));
				return meetingName;
			}
		}
		return null;
	}

	/*
	 * public static void main(String[] args) {
	 * System.out.println(getCishu("海南省第五届第5次主任会议"));
	 * System.out.println(getJieshu("海南省第五届第5次主任会议")); }
	 */

	public void jsonResult(Object state, String msg) {
		codeMap.put("state", state);
		codeMap.put("msg", msg);
	}

	public void jsonResult(Object state, String msg, Object data) {
		codeMap.put("state", state);
		codeMap.put("msg", msg);
		codeMap.put("data", data);
	}

	public int getUseridInSession() {
		LoginUser user = (LoginUser) this.getSession().getAttribute(
				LoginConstant.USER);
		return user != null ? user.getId() : 0;
	}

	public void jsonSuccess(String msg) {
		jsonResult(Boolean.TRUE, msg);
	}

	public void jsonSuccess(String msg, Object data) {
		jsonResult(Boolean.TRUE, msg, data);
	}

	public void jsonError(String msg) {
		jsonResult(Boolean.FALSE, msg);
	}

	public void jsonError(String msg, Object data) {
		jsonResult(Boolean.FALSE, msg, data);
	}

	public LoginUser getCurrentUser() {
		return getSessionUser();
	}

	public LoginUser getSessionUser() {
		return (LoginUser) this.getSession().getAttribute(LoginConstant.USER);
	}

	public HttpServletRequest getRequest() {
		HttpServletRequest request = ServletActionContext.getRequest();
		return request;
	}

	public HttpServletResponse getResponse() {
		HttpServletResponse response = ServletActionContext.getResponse();
		return response;
	}

	public HttpSession getSession() {
		return getRequest().getSession();
	}

	public String getFindClasPathByFileName(String fileName) {
		return ServletActionContext.getServletContext().getRealPath(fileName);
	}

	public String getbasePath() {
		String path = this.getRequest().getContextPath();
		String basePath = this.getRequest().getScheme() + "://"
				+ this.getRequest().getServerName() + ":"
				+ this.getRequest().getServerPort() + path + "/";
		return basePath;
	}

	protected String saveUploadFileLHG(File upload, String name, boolean allPath) {
		String baseUploadPath = getUploadFileBasePath();
		// String fileName=UUID.
		// 生成文件名
		String fileName = new SimpleDateFormat("yyyyMMddHHmmssSSSS")
				.format(new Date()) + name.substring(name.lastIndexOf("."));

		File f = new File(baseUploadPath, fileName);
		try {
			// 把upload文件复制到f文件
			FileUtils.copyFile(upload, f);
			upload.delete();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (allPath) {
			return f.getAbsolutePath();
		} else {
			return fileName;
		}
	}

	/*
	 * protected static String fileName; protected String saveUploadFile(File
	 * upload, String name,boolean allPath) { String baseUploadPath =
	 * getUploadFileBasePath(); //SingleOpenOfficeDemo pdfGenerate=new
	 * SingleOpenOfficeDemo(); String load=String.valueOf(upload);
	 * 
	 * //File f=new File(baseUploadPath,fileName()); try { //把upload文件复制到f文件
	 * //FileUtils.copyFile(upload, f); SingleOpenOffice openOffice =
	 * SingleOpenOffice.getStart();
	 * 
	 * fileName=new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new
	 * Date())+name.substring(name.lastIndexOf("."));
	 * 
	 * String resultPath = openOffice.execute2Pdf(load, baseUploadPath,
	 * fileName);// 日期数随机数合并生成文档名字 System.err.println(resultPath);
	 * 
	 * // 关闭 openOffice.getStop(); } catch (Exception e) { e.printStackTrace();
	 * } if(allPath){ return load;//f.getAbsolutePath(); }else{ return fileName;
	 * } }
	 */

	/*
	 * public static String pdfGenerate(String pathFileName, String
	 * generateFile,String name) { SingleOpenOffice openOffice =
	 * SingleOpenOffice.getStart(); //fileName=fileName(); fileName=new
	 * SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new
	 * Date())+name.substring(name.lastIndexOf("."));
	 * 
	 * String resultPath = openOffice.execute2Pdf(pathFileName, generateFile,
	 * fileName);// 日期数随机数合并生成文档名字 System.err.println(resultPath);
	 * 
	 * // 关闭 openOffice.getStop(); return resultPath; }
	 */

	/*
	 * protected static String saveUploadFile(File upload, String name, boolean
	 * allPath) { SingleOpenOffice.getStart();
	 * 
	 * // 输出地址 String baseUploadPath = getUploadFileBasePath(); //
	 * fileName=UUID.
	 * randomUUID().toString()+name.substring(name.lastIndexOf(".")); // 生成文件名
	 * // String fileName=new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new
	 * // Date())+name.substring(name.lastIndexOf("."));
	 * 
	 * // 转换文件地址 String input = upload.getName();
	 * 
	 * String prefix = input.substring(input.lastIndexOf(".") + 0); String
	 * outputPath = null;
	 * 
	 * boolean isTrue = false; if (!upload.exists()) {
	 * System.out.println("文件不存在!"); return null; }
	 * 
	 * for (String name1 : Constant.FILE_SUFFIX) { if (input.endsWith(name1)) {
	 * isTrue = true; break; } }
	 * 
	 * if (!isTrue) { System.out.println("文件格式错误"); return null; }
	 * 
	 * if (baseUploadPath != null) { outputPath = name == null ? baseUploadPath
	 * + input.replace(prefix, Constant.PDF_SUFFIX) : baseUploadPath +
	 * input.replace(input, name) + Constant.PDF_SUFFIX; } else { outputPath =
	 * name == null ? upload.getPath().replace(prefix, Constant.PDF_SUFFIX) :
	 * upload.getPath() .replace(input, name) + Constant.PDF_SUFFIX; } name =
	 * fileName();
	 * 
	 * File outputFile = new File(outputPath);
	 * 
	 * if (!outputFile.exists()) { // 执行方法服务功能 execute(upload, outputFile);
	 * 
	 * } else { System.out.println("文件已存在"); } try { FileUtils.copyFile(upload,
	 * outputFile); } catch (IOException e1) { e1.printStackTrace(); } if
	 * (allPath) { return outputFile.getAbsolutePath(); } else { return name; }
	 * }
	 */

	/*
	 * private static OfficeManager officeManager;
	 * 
	 * private static void execute(File inputFile, File outputFile) { long
	 * startTime = System.currentTimeMillis();// 获取开始时间
	 * 
	 * try { System.out.println("进行文档转换转换:" + inputFile + " --> " + outputFile);
	 * OfficeDocumentConverter converter = new OfficeDocumentConverter(
	 * officeManager); converter.convert(inputFile, outputFile);
	 * System.out.println("Office转换成功"); } catch (Exception e) { getStop();
	 * e.printStackTrace(); }
	 * 
	 * long endTime = System.currentTimeMillis(); // 获取结束时间
	 * System.out.println("程序运行时间： " + (endTime - startTime) / 1000 + "s"); }
	 * 
	 * public static void getStop() { if (officeManager != null) {
	 * officeManager.stop(); } System.out.println("office关闭成功!"); }
	 */

	/**
	 * 生成文件名
	 * 
	 * @return
	 */
	public String getUploadFileBasePath(){
		//FIXME:if not tomcat,change it.
//		return System.getProperty("catalina.home")+File.separator+"upload";
		return ServletActionContext.getServletContext().getRealPath("")+File.separator+"upload";
		//return System.getProperty("catalina.home")+File.separator+"upload";
//		return ServletActionContext.getServletContext().getRealPath("/upload");
	}
	
	
	/**
	 * 生成文件名
	 * 
	 * @return
	 */
	protected static String fileName() {
		// 设置日期格式
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		// 产生日期数
		String dateTime = sdf.format(new Date());
		return dateTime+".pdf";
	}

	protected String saveUploadFile(File upload, String name, boolean allPath) {
		String baseUploadPath = getUploadFileBasePath();
		// 判断当前是否是pdf文件,不是则转换，是则直接上传
		if (name.indexOf(".pdf") == -1) {// 等于-1表示这个字符串中有“.pdf”这个字符
			SingleOpenOffice openOffice = SingleOpenOffice.getStart();
			name = fileName();
			String resultPath = openOffice.execute2Pdf(
					upload.getAbsolutePath(), baseUploadPath, name);// 日期数随机数合并生成文档名字
			System.err.println(resultPath);
			// 关闭
			openOffice.getStop();
			File f = new File(resultPath);
			File f1 = new File(baseUploadPath, name);
			try {
				// 把upload文件复制到f1文件
				
				FileUtils.copyFile(f, upload);
				FileUtils.copyFile(upload, f1);
				//upload.delete();
				f.delete();
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (allPath) {
				return f1.getAbsolutePath();
			} else {
				return name;
			}

		} else {
			String fileName=new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new Date())+name.substring(name.lastIndexOf("."));
			File f=new File(baseUploadPath,fileName);
			try {
				// 把upload文件复制到f文件
				FileUtils.copyFile(upload, f);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(allPath){
				return f.getAbsolutePath();
			}else{
				return fileName;
			}
		}
	}


	protected String saveVersionUploadFile(File upload, String name,
			boolean allPath) {
		String baseUploadPath = ServletActionContext.getServletContext()
				.getRealPath("") + File.separator + "upload/fileVersion";
		// 以上传时间为名，对apk重命名
		// String
		// fileName=UUID.randomUUID().toString()+name.substring(name.lastIndexOf("."));
		// 固定上传之后名为ereader.apk
		String fileName = "ereader" + name.substring(name.lastIndexOf("."));
		File f = new File(baseUploadPath, fileName);
		try {
			FileUtils.copyFile(upload, f);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (allPath) {
			return f.getAbsolutePath();
		} else {
			return fileName;
		}
	}

	// 保存文件名为：日期.apk
	/*
	 * protected String saveVersionUploadFile(File upload, String name,boolean
	 * allPath) { String baseUploadPath =
	 * ServletActionContext.getServletContext(
	 * ).getRealPath("")+File.separator+"upload/fileVersion"; //String
	 * fileName=UUID
	 * .randomUUID().toString()+name.substring(name.lastIndexOf(".")); String
	 * fileName=new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new
	 * Date())+name.substring(name.lastIndexOf(".")); File f=new
	 * File(baseUploadPath,fileName); try { FileUtils.copyFile(upload, f); }
	 * catch (IOException e) { e.printStackTrace(); } if(allPath){ return
	 * f.getAbsolutePath(); }else{ return fileName; } }
	 */

	public static String toRealPath(String path) {
		return ServletActionContext.getServletContext().getRealPath(path);
	}

	private JSONObject json = new JSONObject();

	// code by XK 2014.9.9
	// 自定义state返回
	public String getMyJsonSuccess(String msg) {
		json.put("state", "true");
		json.put("msg", msg);
		return json.toString();
	}

	// code by XK 2014.9.9
	// 自定义state返回
	public String getMyJsonError(String msg) {
		json.put("state", false);
		json.put("msg", msg);
		return json.toString();
	}

	public String getJsonAddSuccess() {
		json.put("state", "true");
		json.put("msg", "保存成功");
		return json.toString();
	}

	public String getJsonAddError(Object errormsg) {
		json.put("state", false);
		json.put("msg", "新增失败 错误信息:" + errormsg);
		return json.toString();
	}

	public String getJsonEditError(Object errormsg) {
		json.put("state", false);
		json.put("msg", "修改失败 错误信息:" + errormsg);
		return json.toString();
	}

	public String getJsonEditSuccess() {
		json.put("state", "true");
		json.put("msg", "修改成功");
		return json.toString();
	}

	public String getState(String state, String msg) {
		json.put("state", state);
		json.put("msg", msg);
		return json.toString();
	}

	public String getJsonDeleteSuccess() {
		json.put("state", "true");
		json.put("msg", "删除成功");
		return json.toString();
	}

	public String getJsonDeleteError(Object errormsg) {
		json.put("state", "false");
		json.put("msg", "删除失败 错误信息:" + errormsg);
		return json.toString();
	}

	public Map<String, Object> page_from_A_to_C() {
		Map<String, Object> queryMap = new HashMap<String, Object>();
		int page = 1;
		int rows = 10;
		try {
			page = Integer.parseInt(this.getRequest().getParameter("page")
					.toString());

		} catch (Exception e) {
			// 不做任何处理
		}
		try {
			rows = Integer.parseInt(this.getRequest().getParameter("rows")
					.toString());
		} catch (Exception e) {
			// 不做任何处理
		}
		if (page < 1) {
			page = 1;
		}
		int startPage = (page - 1) * rows;
		// int endPage = page * rows + 1;
		// int endPage = page * rows ;
		int endPage = page * rows;
		queryMap.put("startIndex", startPage);
		queryMap.put("endIndex", endPage);
		return queryMap;
	}

	// code by XK 2014.9.9
	// 自定义state返回
	public void printMyJsonSuccess(String msg) {
		outHtmlString(getMyJsonSuccess(msg));
	}

	// 自定义state返回
	public void printMyJsonInfoSuccess(String msg) {
		outHtmlString(msg);
	}

	// code by XK 2014.9.9
	// 自定义state返回
	public void printMyJsonError(String msg) {
		outHtmlString(getMyJsonError(msg));
	}

	public void printAddSuccess() {
		outHtmlString(getJsonAddSuccess());
	}

	public void printAddError(Object o) {
		outHtmlString(getJsonAddError(o));
	}

	public void printEditSuccess() {
		outHtmlString(getJsonEditSuccess());
	}

	public void printEditError(Object o) {
		outHtmlString(getJsonEditError(o));
	}

	public void printDeleteSuccess() {
		outHtmlString(getJsonDeleteSuccess());
	}

	public void printDeleteError(Object o) {
		outHtmlString(getJsonDeleteError(o));
	}

	public void outHtmlString(Object str) {
		try {
			this.getResponse().setCharacterEncoding("utf-8");
			this.getResponse().setContentType("text/html");
			this.getResponse().getWriter().write(str.toString());
		} catch (IOException e) {
			//
		}
	}

	public void outJsonString(Object str) {
		try {
			this.getResponse().setCharacterEncoding("utf-8");
			this.getResponse().setContentType("text/json");
			this.getResponse().getWriter().write(str.toString());
		} catch (IOException e) {
			//
		}
	}

	public void outXmlString(Object str) {
		try {
			this.getResponse().setContentType("text/xml");
			this.getResponse().getWriter().write(str.toString());
		} catch (IOException e) {
			//
		}
	}

}
