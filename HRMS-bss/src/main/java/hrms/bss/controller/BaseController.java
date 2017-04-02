package hrms.bss.controller;

import hrms.model.common.AppProperties;
import hrms.util.UploadImageUtil;
import hrms.vo.LoginInfo;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public class BaseController {

	@Autowired
	protected HttpServletRequest request;
	@Resource(name="appProperties")
	protected AppProperties appProperties;

	public HttpSession getHttpSession() {
		return request.getSession();
	}

	public LoginInfo getCurrentUser() {
		return (LoginInfo) request.getSession().getAttribute(appProperties.getSessionKey());
	}

	public LoginInfo getDebugCurrentUser() {
		return new LoginInfo();
	}

	public String getServletContent() {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		return basePath;
	}

	public Long getCurrentUserOrgId() {
		Object orgid = getCurrentUser().getOrgId();
		if (orgid != null)
			return Long.parseLong(orgid.toString());
		return Long.parseLong(""+0);
	}
	
	public Map<String, String> uploadImage(HttpServletRequest request,String imagePath){
		Map<String, String> localUpload = UploadImageUtil.localUpload(request, imagePath,appProperties.getFileServerPath());
		
		
		return localUpload;
	}

	public String inputStream2String(InputStream in) throws IOException {
		StringBuffer out = new StringBuffer();
		byte[] b = new byte[4096];
		for (int n; (n = in.read(b)) != -1;) {
			out.append(new String(b, 0, n));
		}
		return out.toString();
	}
}
