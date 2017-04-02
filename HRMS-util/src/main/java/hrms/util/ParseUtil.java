package hrms.util;

import java.math.BigDecimal;

public class ParseUtil {

	public static Byte parseByte(Object obj) {
		if(obj == null) {
			return null;
		}
		return Byte.parseByte(obj.toString());
	}

	public static Short parseShort(Object obj) {
		if(obj == null) {
			return null;
		}
		return Short.parseShort(obj.toString());
	}

	public static Integer parseInt(Object obj) {
		if(obj == null) {
			return null;
		}
		return Integer.parseInt(obj.toString());
	}

	public static Long parseLong(Object obj) {
		if(obj == null) {
			return null;
		}
		return Long.parseLong(obj.toString());
	}
	public static Long parseNullZeroLong(Object obj) {
		if(obj == null) {
			return 0l;
		}
		return Long.parseLong(obj.toString());
	}
	public static String parseString(Object obj) {
		if(obj == null) {
			return null;
		}
		return obj.toString();
	}
	
	public static String parseStringStr(Object obj) {
		if(obj == null) {
			return "";
		}
		return obj.toString();
	}

	public static Float parseFloat(Object obj) {
		if(obj == null) {
			return null;
		}
		return Float.parseFloat(obj.toString());
	}

	public static Double parseDouble(Object obj) {
		if(obj == null) {
			return null;
		}
		return Double.parseDouble(obj.toString());
	}
	

	public static BigDecimal parseBigDecimal(Object obj) {
		if(obj == null) {
			return null;
		}
		return BigDecimal.valueOf(parseDouble(obj));
	}
}
