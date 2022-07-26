package com.cloudrich.ereader.pdf;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.OfficeManager;

/**
 * 
 * @author lhg
 * @date 2018年8月31日
 */
public class SingleOpenOfficeDemo {
	public static void main(String[] args) {
		//pdfGenerate("G:/aaa.pptx", "F:/");
		 diff_pathAndAbsolutePath();
		/*
		 * File inputFile = new
		 * File("F:/repository/com/jcraft/jsch/三亚市人大常委会电子阅文系统测试报告_王会儒v7.xlsx");
		 * String fileName = String.valueOf(inputFile);//inputFile.getName();
		 * System.out.println(fileName);
		 */
	}

	public static String fileName;

	public static String fileName() {
		// 设置日期格式
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		// 产生随机数
		Random random = new Random();
		// 产生日期数
		String dateTime = sdf.format(new Date());

		return dateTime + (random.nextInt(1000) + 1) * 19;

	}

	public static void diff_pathAndAbsolutePath() {
		File file1 = new File("./三亚市人大常委会电子阅文系统测试报告_王会儒v7.xlsx");
		File file2 = new File(
				"F:/repository/com/jcraft/jsch/三亚市人大常委会电子阅文系统测试报告_王会儒v7.xlsx");
		System.err.println("—–默认相对路径：取得路径不同——");
		System.out.println(file1.getPath());
		System.out.println(file1.getAbsolutePath());
		System.err.println("—–默认绝对路径:取得路径相同——");
		System.out.println(file2.getPath());
		System.out.println(file2.getAbsolutePath());
	}

	public static String getUploadFileBasePath() {
		// FIXME:if not tomcat,change it.
		// return System.getProperty("catalina.home")+File.separator+"upload";
		return ServletActionContext.getServletContext().getRealPath("")
				+ File.separator + "upload";
		// return System.getProperty("catalina.home")+File.separator+"upload";
		// return
		// ServletActionContext.getServletContext().getRealPath("/upload");
	}

	/*protected static String saveUploadFile(File upload, String name,
			boolean allPath) {
		// 输出地址
		String baseUploadPath = getUploadFileBasePath();
		SingleOpenOffice openOffice = SingleOpenOffice.getStart();
		// fileName=UUID.randomUUID().toString()+name.substring(name.lastIndexOf("."));
		// 生成文件名
		// String fileName=new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new
		// Date())+name.substring(name.lastIndexOf("."));

		// 转换文件地址
		String input = upload.getAbsolutePath();

		String prefix = input.substring(input.lastIndexOf(".") + 0);
		String outputPath = null;

		boolean isTrue = false;
		if (!upload.exists()) {
			System.out.println("文件不存在!");
			return null;
		}

		for (String name1 : Constant.FILE_SUFFIX) {
			if (input.endsWith(name1)) {
				isTrue = true;
				break;
			}
		}

		if (!isTrue) {
			System.out.println("文件格式错误");
			return null;
		}

		if (baseUploadPath != null) {
			outputPath = name == null ? baseUploadPath
					+ input.replace(prefix, Constant.PDF_SUFFIX)
					: baseUploadPath + input.replace(input, name)
							+ Constant.PDF_SUFFIX;
		} else {
			outputPath = name == null ? upload.getPath().replace(prefix,
					Constant.PDF_SUFFIX) : upload.getPath()
					.replace(input, name) + Constant.PDF_SUFFIX;
		}
		name = fileName();

		File outputFile = new File(outputPath);

		if (!outputFile.exists()) {
			// 执行方法服务功能
			execute(upload, outputFile);

		} else {
			System.out.println("文件已存在");
		}
		try {
			FileUtils.copyFile(upload, outputFile);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		if (allPath) {
			return outputFile.getAbsolutePath();
		} else {
			return name;
		}
	}*/

/*	private static OfficeManager officeManager;

	private static void execute(File inputFile, File outputFile) {
		long startTime = System.currentTimeMillis();// 获取开始时间

		try {
			System.out.println("进行文档转换转换:" + inputFile + " --> " + outputFile);
			OfficeDocumentConverter converter = new OfficeDocumentConverter(
					officeManager);
			converter.convert(inputFile, outputFile);
			System.out.println("Office转换成功");
		} catch (Exception e) {
			getStop();
			e.printStackTrace();
		}

		long endTime = System.currentTimeMillis(); // 获取结束时间
		System.out.println("程序运行时间： " + (endTime - startTime) / 1000 + "s");
	}

	public static void getStop() {
		if (officeManager != null) {
			officeManager.stop();
		}
		System.out.println("office关闭成功!");
	}*/

	/**
	 * 
	 * 转换生成pdf文件
	 * 
	 * @param pathFileName
	 *            文件路径名称
	 * @param produceFile
	 *            转换生成后的文件路径
	 */
	public static String pdfGenerate(String pathFileName, String generateFile) {
		SingleOpenOffice openOffice = SingleOpenOffice.getStart();
		fileName = fileName();
		String resultPath = openOffice.execute2Pdf(pathFileName, generateFile,
				fileName);// 日期数随机数合并生成文档名字
		System.err.println(resultPath);

		// 关闭
		openOffice.getStop();
		return resultPath;
	}

}
