package hrms.model.common;

import org.springframework.beans.factory.annotation.Value;

import java.io.Serializable;

public class AppProperties implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Value("${fileServerPath}")
	private String fileServerPath ;
	@Value("${sessionKey}")
	private String sessionKey;
	@Value("${orgKey}")
	private String orgKey;
	@Value("${app.apiurl}")
	private String apiUrl;
	@Value("${imageUploadPath}")
	private String imageUploadPath;
	@Value("${resolutionRatio}")
	private String resolutionRatio;

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
//		return fileServerPath;
		return "http://localhost:8080/HRMS-image/filter/image/";
	}

	public void setFileServerPath(String fileServerPath) {
		this.fileServerPath = fileServerPath;
	}

	public String getResolutionRatio() {
//		return resolutionRatio;
		return "120,120;240,240;500,500";
	}

	public void setResolutionRatio(String resolutionRatio) {
		this.resolutionRatio = resolutionRatio;
	}

	public String getImageUploadPath() {
//		return imageUploadPath;
		return "E://work/HRMS/imageFile";
	}

	public void setImageUploadPath(String imageUploadPath) {
		System.out.println("set "+imageUploadPath);
		this.imageUploadPath = imageUploadPath;
	}

	public String getApiUrl() {
		return apiUrl;
	}

	public void setApiUrl(String apiUrl) {
		this.apiUrl = apiUrl;
	}

	@Override
	public String toString() {
		return "AppProperties{" +
				"fileServerPath='" + fileServerPath + '\'' +
				", sessionKey='" + sessionKey + '\'' +
				", orgKey='" + orgKey + '\'' +
				", apiUrl='" + apiUrl + '\'' +
				", imageUploadPath='" + imageUploadPath + '\'' +
				", resolutionRatio='" + resolutionRatio + '\'' +
				'}';
	}
}
