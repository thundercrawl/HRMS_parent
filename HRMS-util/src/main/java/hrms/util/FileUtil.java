package hrms.util;

import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.util.Arrays;
import java.util.Collection;

public class FileUtil {

	public static void writeToFile(String filePath, String fileName, Collection<String> datas) throws IOException {
		File parentFile = null;
		if(!StringUtils.isEmpty(filePath)) {
			parentFile = new File(filePath);
		}
		writeToFile(new File(parentFile, fileName), datas);
	}
	
	public static void writeToFile(String fileName, Collection<String> datas) throws IOException {
		writeToFile(new File(fileName), datas);
	}
	
	public static void writeToFile(String fileName, Collection<String> datas, boolean append) throws IOException {
		writeToFile(new File(fileName), datas, append);
	}
	
	public static void writeToFile(File parentFile, String fileName, Collection<String> datas) throws IOException {
		writeToFile(new File(parentFile, fileName), datas);
	}
	
	public static void writeToFile(File file, Collection<String> datas) throws IOException {
		writeToFile(file, datas, false);
	}
	
	public static void writeToFile(File file, Collection<String> datas, boolean append) throws IOException {
		PrintWriter pw = null;
		try {
			pw = new PrintWriter(new FileWriter(file, append));
			for(String data : datas) {
				pw.println(data);
			}
		} finally {
			if(pw != null) {
				pw.flush();
				pw.close();
			}
		}
	}
	
	public static void writeToFile(File file, String[] datas) throws IOException {
		writeToFile(file, Arrays.asList(datas));
	}

	public static void writeToFile(File file, InputStream is) throws IOException{
		byte[] buffer = new byte[8096];
		FileOutputStream fos = null;
		BufferedInputStream bis = null;
		try {
			if(!file.exists()) {
				file.createNewFile();
			}
			fos = new FileOutputStream(file);
			bis = new BufferedInputStream(is);
			int size = 0;
			while((size = bis.read(buffer)) != -1) {
				fos.write(buffer, 0, size);
			}
		} finally {
			if(fos != null) {
				try {
					fos.flush();
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(bis != null) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}
