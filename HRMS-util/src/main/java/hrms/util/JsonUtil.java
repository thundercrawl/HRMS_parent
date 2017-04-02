package hrms.util;

import com.alibaba.fastjson.JSONObject;
import hrms.common.ErrorCode;
import hrms.exception.InvalidException;

import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

public class JsonUtil {

	public static String toJsonString(Object obj){
		return JSONObject.toJSONString(obj);
	}
	
	public static String toJsonString(Map<String, Object> map){
		return JSONObject.toJSONString(map);
	}
	
	public static String toJsonString(JSONObject jsonObject, Comparator<String> comparator){
		Map<String,Object> map = new TreeMap<String,Object>(comparator); 
		return JSONObject.toJSONString(map);
	}
	
	public static String toJsonString(String[] jsonNameArray, Object... obj){
		if(jsonNameArray.length != obj.length) {
			throw new InvalidException('['+ ErrorCode.PARAMERROR.getStatus()+']'+ErrorCode.PARAMERROR.getMessage());
		}
		if(jsonNameArray.length == 0) {
			return "{}";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		for(int i = 0; i < jsonNameArray.length; i ++) {
			sb.append("\"").append(jsonNameArray[i]).append("\"")
				.append(':').append(JSONObject.toJSONString(obj[i]))
				.append(",");
		}
		sb.delete(sb.length()-1, sb.length());
		sb.append("}");
		return sb.toString();
	}
}
