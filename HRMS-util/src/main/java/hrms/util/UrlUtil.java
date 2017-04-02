package hrms.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.message.BasicNameValuePair;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UrlUtil {

	public static String merge(String baseUrl, String url) {
		if(url == null) 
			return null;
		if(baseUrl == null)
			return url;
		if(url.startsWith("http://") || url.startsWith("https://") || url.startsWith("ftp://")) {
			return url;
		} else if(url.startsWith("/") && !url.startsWith("//")) {
			return baseUrl + url;
		}
		return baseUrl + "/" + url;
	}
	
	public static String format(String url, Map<String, String> params) {
		List<NameValuePair> parameters = new ArrayList<NameValuePair>();
		for(String paramName : params.keySet()) {
			parameters.add(new BasicNameValuePair(paramName, params.get(paramName)));
		}

		String paramStr = URLEncodedUtils.format(parameters, Charset.forName("UTF-8"));
		if(url.contains("?") && url.indexOf('?') != url.length()-1) {
			return url + '&' + paramStr;
		} else if(!url.contains("?")) {
			return url + '?' + paramStr;
		} else {
			return url + paramStr;
		}
	}
	
	public static String format(String url, String[] params) {
		String paramStr = StringUtils.join(params, "&");
		if(url.contains("?") && url.indexOf('?') != url.length()-1) {
			return url + '&' + paramStr;
		} else if(!url.contains("?")) {
			return url + '?' + paramStr;
		} else {
			return url + paramStr;
		}
	}
	
	public static String formatParams(Map<String, String> params) {
		StringBuffer sb = new StringBuffer();
		for(String key : params.keySet()) {
			if(!StringUtils.isEmpty(params.get(key))) {
				sb.append("&")
				.append(key)
				.append("=")
				.append(params.get(key));
			}
		}
		return sb.substring(1);
	}
}
