package hrms.model.common;

import org.springframework.beans.factory.annotation.Value;

import java.io.Serializable;

public class AppProperties implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Value("${fileServerPath}")
	private String fileServerPath;
	@Value("${sessionKey}")
	private String sessionKey;
	@Value("${orgKey}")
	private String orgKey;
	@Value("${app.apiurl}")
	private String apiUrl;
	@Value("${resolutionRatio}")
	private String resolutionRatio;
	@Value("${imageUploadPath}")
	private String imageUploadPath;

	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}

	public String getOrgKey() {
		return orgKey;
	}

	public void setOrgKey(String orgKey) {
		this.orgKey = orgKey;
	}

	public String getFileServerPath() {
		return fileServerPath;
	}
	public String getResolutionRatio() {
		return resolutionRatio;
	}
	public String getImageUploadPath() {
		return imageUploadPath;
	}

	public void setFileServerPath(String fileServerPath) {
		this.fileServerPath = fileServerPath;
	}


	public String getApiUrl() {
		return apiUrl;
	}

	public void setApiUrl(String apiUrl) {
		this.apiUrl = apiUrl;
	}


}
