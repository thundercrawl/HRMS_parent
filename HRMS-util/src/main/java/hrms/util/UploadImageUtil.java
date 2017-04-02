package hrms.util;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HeaderElement;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class UploadImageUtil {

	//private static String targetURL = "http://localhost:8888/mvc/filter/image/"; //文件服务器上传路径
	public static Map<String, String> localUpload(HttpServletRequest request, String pathName,String fileServerPath) {
		File targetFile = null;// TODO 指定上传文件
		String uploadFunction = "upload/";//上传图片请求的方法名称
		String uploadURL = fileServerPath + uploadFunction;
		PostMethod filePost = new PostMethod(uploadURL);
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 设置编码
		multipartResolver.setDefaultEncoding("utf-8");
		MultipartHttpServletRequest multipartRequest=null;
		try {
			multipartRequest = multipartResolver
					.resolveMultipart(request);
		} catch (MultipartException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 获得第1张图片（根据前台的name名称得到上传的文件）
		MultipartFile file = multipartRequest.getFile("imgFile");
		String sourceFileName = file.getOriginalFilename();
		String extension = generateFileName(sourceFileName);
		CommonsMultipartFile cf = (CommonsMultipartFile) file;
		DiskFileItem fi = (DiskFileItem) cf.getFileItem();
		targetFile = fi.getStoreLocation();
		try {
			filePost.getParams().setCookiePolicy(CookiePolicy.IGNORE_COOKIES);
			filePost.setRequestHeader("Cookie", "pathName=" + pathName + ";"
					+ "extension=" + extension);
			Part[] parts = { new FilePart("imgFile", targetFile),
					new StringPart("sourceFileName", sourceFileName) };
			filePost.setRequestEntity(new MultipartRequestEntity(parts,
					filePost.getParams()));
			HttpClient client = new HttpClient();
			client.getHttpConnectionManager().getParams()
					.setConnectionTimeout(5000);
			int status = client.executeMethod(filePost);
			if (status == HttpStatus.SC_OK) {
				System.out.println("上传成功");
				return getResultNames(filePost,pathName,fileServerPath);
				// 上传成功
			} else {
				System.out.println("上传失败");
				// 上传失败
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			filePost.releaseConnection();
		}
		return null;
		
	}

	private static Map<String,String> getResultNames(PostMethod filePost,String pathName,String fileServerPath) {
		Map<String,String> resultMap = new HashMap<String, String>();
		Header responseHeader = filePost.getResponseHeader("Set-Cookie");
		HeaderElement[] elements = responseHeader.getElements();
		for(int i=0;i<elements.length;i++){
			if(elements[i].getName().contains("imageName_")){
				if(pathName.equals("")){
					resultMap.put(elements[i].getName(), fileServerPath+"tofindPic?imgName="+elements[i].getValue());
					continue;
				}
				resultMap.put(elements[i].getName(), fileServerPath+"tofindPic?imgName="+pathName+"/"+elements[i].getValue());
			}
			if(elements[i].getName().contains("voiceName_")){
				if(pathName.equals("")){
					resultMap.put(elements[i].getName(), fileServerPath+"tofindVoice?voiceName="+elements[i].getValue());
					continue;
				}
				resultMap.put(elements[i].getName(), fileServerPath+"tofindVoice?voiceName="+pathName+"/"+elements[i].getValue());
			}
		}
		return resultMap;
	}

	// 获取文件的后缀名
	private static String generateFileName(String originalFilename) {
		int position = originalFilename.lastIndexOf(".");
		String extension = originalFilename.substring(position);
		return extension;
	}
}
