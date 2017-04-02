package hrms.util;

import com.alibaba.fastjson.JSONObject;
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

public class ReturnJsonThird {
	private Log logger = LogFactory.getLog(ReturnJsonThird.class);
	boolean flag = true;
	public <T>T postJson(String url, Object modelObj, Class<T> clazz){
		try {
			logger.info("调用URL["+url+"]入参："+JSONObject.toJSONString(modelObj));
//			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(modelObj), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");  
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				System.out.println("入参"+JsonUtil.toJsonString(modelObj));
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
	public String postJson(String url, Object modelObj){
		try {
			logger.info("调用URL["+url+"]入参："+JSONObject.toJSONString(modelObj));
//			url = UrlUtil.merge(apiUrl, url);
			HttpPost httpPost = new HttpPost(url);
			StringEntity strEntity = new StringEntity(JsonUtil.toJsonString(modelObj));
//			StringEntity strEntity = new StringEntity(URLEncoder.encode(JsonUtil.toJsonString(modelObj), "utf8"));
			strEntity.setContentEncoding("UTF-8");  
			strEntity.setContentType("application/json");  
			httpPost.setEntity(strEntity);  
			@SuppressWarnings({ "resource" })
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
			HttpEntity entity = httpResponse.getEntity();
			if (entity != null) {
				String str = EntityUtils.toString(entity, "UTF-8");
				logger.info("调用URL["+url+"]出参："+str);
				if(flag){
					System.err.println("调用URL["+url+"]");
					System.out.println("入参"+JsonUtil.toJsonString(modelObj));
					System.out.println("出参"+str);
				}
				
				if(!StringUtils.isEmpty(str)) {
					return str;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("调用URL["+url+"]异常：", e);
		} 
		return null;
	}
}
