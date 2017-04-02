package hrms.util;

import java.util.HashMap;
import java.util.Map;
public class EnumerateUtil {

	private static Map<String, String> map=new HashMap<String, String>();

	public static String translator(String key){
		if(map.get(key)!=null){
			return map.get(key);
		}
		else
		{
			String keys[]=key.split("-");
			return keys[2];
		}
	}
	
	public static Map<String, String> getMap() {
		return map;
	}

	public static void setMap(Map<String, String> map) {
		EnumerateUtil.map = map;
	}
	
}
