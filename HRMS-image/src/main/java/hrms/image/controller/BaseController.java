package hrms.image.controller;

import hrms.model.common.AppProperties;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

public class BaseController {
	@Autowired
	protected HttpServletRequest request;
	@Resource(name="appProperties")
	protected AppProperties appProperties;


	protected String lineSeparator = System.getProperty("line.separator", "\n");
	
	
	public String getServletContent() {
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		return basePath;
	}
	
	public String getImageUploadPath(){
		return appProperties.getImageUploadPath();
	}
	//分辨率
	public String getResolutionRatio(){
		return appProperties.getResolutionRatio();
	}

	public String getFullUri(String path) {
		return getServletContent() + (path.charAt(0)=='/'?path.substring(1):path);
	}
}
