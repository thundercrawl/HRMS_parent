package hrms.model.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.Serializable;

@Component
public class QiniuProperties implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Value("${qiniu.scope}")
	private String scope;
	@Value("${qiniu.accessKey}")
	private String accessKey;
	@Value("${qiniu.secretKey}")
	private String secretKey;
	@Value("${qiniu.picPrefix}")
	private String picPrefix;
	@Value("${qiniu.tmpPath}")
	private String tmpPath;
	@Value("${qiniu.picUrl}")
	private String picUrl;
	
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getAccessKey() {
		return accessKey;
	}
	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}
	public String getSecretKey() {
		return secretKey;
	}
	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}
	public String getPicPrefix() {
		return picPrefix;
	}
	public void setPicPrefix(String picPrefix) {
		this.picPrefix = picPrefix;
	}
	public String getTmpPath() {
		return tmpPath;
	}
	public void setTmpPath(String tmpPath) {
		this.tmpPath = tmpPath;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
}
