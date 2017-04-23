package hrms.util;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.model.common.AppProperties;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.URLEncoder;

@SuppressWarnings("deprecation")
public abstract class ReturnJson {
	private Log logger = LogFactory.getLog(ReturnJson.class);
	
	private static String DEFAULT_API_URL = "http://localhost:8888/HRMS-api/";
	
	private AppProperties appProperties;
	private String apiUrl;
	
	public ReturnJson() {
		super();
		this.apiUrl = DEFAULT_API_URL;
	}
	
	public ReturnJson(AppProperties appProperties) {
		this();
		this.appProperties= appProperties;
		if(appProperties != null) {
			this.apiUrl = appProperties.getApiUrl();
		}
	}
	

	public <T>T postJson(String url, Object modelObj, CommonParams cp, Class<T> clazz){
		try {
			logger.info("调用URL["+url+"]入参："+JSONObject.toJSONString(modelObj));
			System.out.println("调用URL["+url+"]入参："+JSONObject.toJSONString(modelObj));
			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(new String[]{"object", "commonParam"}, modelObj, cp), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				System.out.println("入参"+ JsonUtil.toJsonString(new String[]{"object", "commonParam"}, modelObj, cp));
				System.out.println("调用URL["+url+"]"+"出参"+str);
				if(!StringUtils.isEmpty(str)) {
					return JSONObject.parseObject(str, clazz);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("调用URL["+url+"]异常：", e);
		} 
		return null;
	}
	
	public <T>T postJson(String url, String strJson,CommonParams cp, Class<T> clazz){
		try {
			logger.info("调用URL["+url+"]入参："+strJson);
			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			JSONObject json = JSONObject.parseObject(strJson);
			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(new String[]{"object", "commonParam"}, json, cp), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");  
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				if(!StringUtils.isEmpty(str)) {
					return JSONObject.parseObject(str, clazz);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("调用URL["+url+"]异常：", e);
		} 
		return null;
	}
	
	public <T>T postJson(String url, Object modelObj, Class<T> clazz){
		try {
			CommonParams cp = new CommonParams();
			logger.info("调用URL["+url+"]入参："+JSONObject.toJSONString(modelObj));
			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(new String[]{"object", "commonParam"}, modelObj, cp), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");  
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				System.out.println("入参"+ JsonUtil.toJsonString(new String[]{"object", "commonParam"}, modelObj, cp));
				System.out.println("出参"+str);
				if(!StringUtils.isEmpty(str)) {
					return JSONObject.parseObject(str, clazz);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("调用URL["+url+"]异常：", e);
		} 
		return null;
	}
	
	public <T>T postJson(String url, String strJson, Class<T> clazz){
		try {
			logger.info("调用URL["+url+"]入参："+strJson);
			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			JSONObject json = JSONObject.parseObject(strJson);
			CommonParams cp = new CommonParams();
			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(new String[]{"object", "commonParam"}, json, cp), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");  
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				if(!StringUtils.isEmpty(str)) {
					return JSONObject.parseObject(str, clazz);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("调用URL["+url+"]异常：", e);
		} 
		return null;
	}

}
