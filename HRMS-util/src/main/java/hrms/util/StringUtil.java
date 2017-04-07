package hrms.util;

public class StringUtil {

	public static boolean isEmpty(Object obj){
		
		if(obj == null || "".equals(obj.toString().trim())){
			return true;
		}
		
		return false;
	}
}
