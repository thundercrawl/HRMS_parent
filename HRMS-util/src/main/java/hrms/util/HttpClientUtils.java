package hrms.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.ssl.SSLContexts;

import javax.net.ssl.SSLContext;
import javax.servlet.ServletOutputStream;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.KeyStore;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class HttpClientUtils {

	public HttpClient buildClient() throws IOException {
		HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
		return httpClientBuilder.build();
	}
	
	@SuppressWarnings("deprecation")
	public HttpClient buildSSLClient(String certType, File certFile, String certPwd) throws Exception {
		 KeyStore keyStore  = KeyStore.getInstance(certType);
	        FileInputStream instream = new FileInputStream(certFile);
	        if(!StringUtils.isEmpty(certPwd)) {
	        	try {
	        		keyStore.load(instream, certPwd.toCharArray());
	        	} finally {
	        		instream.close();
	        	}
	        }

	        SSLContext sslcontext = SSLContexts.custom()
	                .loadKeyMaterial(keyStore, certPwd.toCharArray())
	                .build();
	        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
	                sslcontext,
	                new String[] { "TLSv1" },
	                null,
	                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
	        CloseableHttpClient httpclient = HttpClients.custom()
	                .setSSLSocketFactory(sslsf)
	                .build();
	        return httpclient;
	}
	
	public HttpResponse executeGet(HttpClient client, String urlStr) throws ClientProtocolException, IOException {
		HttpGet get = new HttpGet(urlStr);
		return client.execute(get);
	}
	
	public HttpResponse executePost(HttpClient client, String urlStr, List<BasicNameValuePair> params) throws ClientProtocolException, IOException {
		HttpPost post = new HttpPost(urlStr);
		if(params != null && !params.isEmpty()) {
			//创建表单参数列表  
			List<BasicNameValuePair> qparams = new ArrayList<BasicNameValuePair>(); 
			// 添加参数
			qparams.addAll(params);
			//填充表单  
			post.setEntity(new UrlEncodedFormEntity(qparams,"UTF-8"));
		}
		
		return client.execute(post);
	}
	
	public HttpResponse executePost(HttpClient client, String urlStr, Map<String, String> params) throws ClientProtocolException, IOException {
		List<BasicNameValuePair> nameValuePairs = new ArrayList<BasicNameValuePair>();
		for(String key : params.keySet()) {
			nameValuePairs.add(new BasicNameValuePair(key, params.get(key)));
		}
		return executePost(client, urlStr, nameValuePairs);
	}
	
	public String response(HttpResponse response) throws IOException {
		if(response == null) 
			return null;
		HttpEntity entity = response.getEntity();
		if(entity == null) 
			return null;
		entity = new BufferedHttpEntity(entity); 
		InputStream is = entity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		String str = null;
		StringBuffer responseStr = new StringBuffer();
		while((str=br.readLine())!= null) {
			responseStr.append(str);
		}
		return responseStr.toString();
	}
	
	public String postEntity(String url, HttpEntity entity) {
		if (url == null || entity == null) {
			System.out.println("URL或者文件为NULL");
			return null;
		}
		HttpResponse response = null;
		try {
			HttpClient client = buildClient();
			HttpPost httpPost = new HttpPost(url);
			httpPost.setEntity(entity);
			response = client.execute(httpPost);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}

		// 判断上传的状态和打印调试信息
		String returnData = null;
		if (response != null && response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
			try {
				returnData = response(response);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 打印调试信息,上传的url和参数
			System.out.println(MessageFormat.format("post success! url = [{0}], returnData = [{1}]", url, returnData));
		} else if(response != null){
			System.out.println(response.getStatusLine().getStatusCode());
		}
		return returnData;
	}
	
	public String sslPostEntity(String url, String certType, File certFile, String certPwd,  HttpEntity entity) {
		if (url == null || entity == null) {
			System.out.println("URL或者文件为NULL");
			return null;
		}
		HttpResponse response = null;
		try {
			HttpClient client = buildSSLClient(certType, certFile, certPwd);
			HttpPost httpPost = new HttpPost(url);
			httpPost.setEntity(entity);
			response = client.execute(httpPost);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
		
		// 判断上传的状态和打印调试信息
		String returnData = null;
		if (response != null && response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
			try {
				returnData = response(response);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 打印调试信息,上传的url和参数
			System.out.println(MessageFormat.format("post success! url = [{0}], returnData = [{1}]", url, returnData));
		} else if(response != null){
			System.out.println(response.getStatusLine().getStatusCode());
		}
		return returnData;
	}
	
	public static HttpEntity fileEntity(File f) {
		return MultipartEntityBuilder.create()
				.addPart("file", new FileBody(f))
				.build();
	}
	
	public static InputStreamEntity streamEntity(String url) throws MalformedURLException, IOException {
		return new InputStreamEntity(new URL(url).openStream());
	}
	
	public static HttpEntity multipartEntity(String url) throws MalformedURLException, IOException {
		InputStream inputStream = null;
		File tmpFile = null;
		try {
		inputStream = new URL(url).openStream();
		tmpFile = new File("/upload-newproduct.tmp");
		if(!tmpFile.exists()) {
			tmpFile.createNewFile();
		}
		FileUtil.writeToFile(tmpFile, inputStream);
		return  MultipartEntityBuilder.create()
                .addPart("file", new FileBody(tmpFile))
                .build();
		} finally {
			if(inputStream != null) {
				inputStream.close();
			}
		}
	}

	public static HttpEntity stringEntity(String params) {
		return new StringEntity(params, "UTF-8");
	}

	public HttpEntity getEntity(String url) {
		if (url == null ) {
			System.out.println("URL为NULL");
			return null;
		}
		HttpResponse response = null;
		try {
			HttpClient client = buildClient();
			HttpGet httpGet = new HttpGet(url);
			response = client.execute(httpGet);
			return response.getEntity();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void response(ServletOutputStream outputStream, String data) {
		PrintWriter pw = null;
		try {
			pw = new PrintWriter(outputStream);
			pw.append(data);
			pw.flush();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pw != null) {
				pw.close();
			}
		}
		
	}
}
