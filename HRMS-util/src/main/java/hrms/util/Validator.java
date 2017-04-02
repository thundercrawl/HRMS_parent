package hrms.util;

import org.apache.commons.lang.StringUtils;

import java.math.BigDecimal;
import java.util.regex.Pattern;

/**
 * 校验器：利用正则表达式校验邮箱、手机号等
 */
public class Validator {
	// 简体中文的编码范围从B0A1（45217）一直到F7FE（63486）
    private static int BEGIN = 45217;
    private static int END = 63486;

// 按照声母表示，这个表是在GB2312中的出现的第一个汉字，也就是说“啊”是代表首字母a的第一个汉字。
    // i, u, v都不做声母, 自定规则跟随前面的字母
    private static char[] chartable = { '啊', '芭', '擦', '搭', '蛾', '发', '噶', '哈',
            '哈', '击', '喀', '垃', '妈', '拿', '哦', '啪', '期', '然', '撒', '塌', '塌',
            '塌', '挖', '昔', '压', '匝', };

// 二十六个字母区间对应二十七个端点
    // GB2312码汉字区间十进制表示
    private static int[] table = new int[27];

// 对应首字母区间表
    private static char[] initialtable = { 'a', 'b', 'c', 'd', 'e', 'f', 'g',
            'h', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
            't', 't', 'w', 'x', 'y', 'z', };

// 初始化
    static {
        for (int i = 0; i < 26; i++) {
            table[i] = gbValue(chartable[i]);// 得到GB2312码的首字母区间端点表，十进制。
        }
        table[26] = END;// 区间表结尾
    }

// ------------------------public方法区------------------------
    /**
     * 根据一个包含汉字的字符串返回一个汉字拼音首字母的字符串 最重要的一个方法，思路如下：一个个字符读入、判断、输出
     */
    public static String cn2py(String SourceStr) {
        String Result = "";
        int StrLength = SourceStr.length();
        int i;
        try {
            for (i = 0; i < StrLength; i++) {
                Result += Char2Initial(SourceStr.charAt(i));
            }
        } catch (Exception e) {
            Result = "";
        }
        return Result;
    }

// ------------------------private方法区------------------------
    /**
     * 输入字符,得到他的声母,英文字母返回对应的大写字母,其他非简体汉字返回 '0'
     *
     */
    private static char Char2Initial(char ch) {
        // 对英文字母的处理：小写字母转换为大写，大写的直接返回
        if (ch >= 'a' && ch <= 'z')
            return (char) (ch - 'a' + 'A');
        if (ch >= 'A' && ch <= 'Z')
            return ch;

// 对非英文字母的处理：转化为首字母，然后判断是否在码表范围内，
        // 若不是，则直接返回。
        // 若是，则在码表内的进行判断。
        int gb = gbValue(ch);// 汉字转换首字母

        if ((gb < BEGIN) || (gb > END))// 在码表区间之前，直接返回
            return ch;

        int i;
        for (i = 0; i < 26; i++) {// 判断匹配码表区间，匹配到就break,判断区间形如“[,)”
                if ((gb >= table[i]) && (gb < table[i+1]))
                    break;
        }
       
        if (gb==END) {//补上GB2312区间最右端
            i=25;
        }
        return initialtable[i]; // 在码表区间中，返回首字母
    }

/**
     * 取出汉字的编码 cn 汉字
     */
    private static int gbValue(char ch) {// 将一个汉字（GB2312）转换为十进制表示。
        String str = new String();
        str += ch;
        try {
            byte[] bytes = str.getBytes("GB2312");
            if (bytes.length < 2)
                return 0;
            return (bytes[0] << 8 & 0xff00) + (bytes[1] & 0xff);
        } catch (Exception e) {
            return 0;
        }
    }
	/**
	 * 正则表达式：验证用户名  //^[\u4e00-\u9fa5]{0,}$
	 */
	public static final String REGEX_USERNAME = "^[a-zA-Z]\\w{5,17}$";

	/**
	 * 正则表达式：验证密码
	 */
	public static final String REGEX_PASSWORD = "^[a-zA-Z0-9]{6,16}$";

	public static final String REGEX_FEE_1 = "^-?[0-9]{1,10}\\.[0-9]{2}$";

	public static final String REGEX_CODE_1 = "^[a-zA-Z0-9]{6,20}$";
	public static final String REGEX_CODE_3 = "^[a-zA-Z0-9]{8}$";
	public static final String REGEX_CODE_4 = "^[a-zA-Z0-9]{6}$";
	public static final String REGEX_CODE_2 = "^[a-zA-Z0-9]{1,20}$";
	public static final String REGEX_CODE_5 = "^[a-zA-Z0-9]{6,20}$";
	/*
	 * 正则表达式：验证手机验证码
	 */
	public static final String REGEX_CODE4 = "^[0-9]{4}$";
	public static final String REGEX_CODE = "^[0-9]{6}$";
	public static final String REGEX_CODE_ = "^[0-9]{0,}$";
	/**
	 * 正则表达式：验证手机号
	 */
	public static final String REGEX_MOBILE = "^[1]\\d{10}$";
	public static final String REGEX_MOBILE_ =  "^[1]\\d{0,10}$";
	public static final String REGEX_MOBILE_s = "^((13[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
	public static final String REGEX_MOBILE_S = "^[1]([3][0-9]{1}|59|58|88|89)[0-9]{8}$";
	public static final String REGEX_MOBILE_SU = "^((13[0-9])|(15[0-9])|(18[0,5-9]))\\d{8}$";
	public static final String REGEX_MOBILE_SUB = "^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
	//固话
	public static final String REGEX_GUHUA = "^((0\\d{2,3}-\\d{7,8})|(1[3584]\\d{9}))$";
	public static final String REGEX_GUHUA_S = "^((0\\d{2,3}\\d{7,8})|(1[3584]\\d{9}))$";
	/**
	 * 正则表达式：验证邮箱
	 */
	public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

	/**
	 * 正则表达式：验证汉字
	 */
	public static final String REGEX_CHINESE = "^[\u4e00-\u9fa5]{0,}$";// /^[\u4e00-\u9fa5]{0,}$/;
	public static final String REGEX_NAME = "^[\u4e00-\u9fa5-a-zA-Z]{1,15}$";// /^[\u4e00-\u9fa5]{0,}$/;

	/**
	 * 正则表达式：验证身份证
	 */
	public static final String REGEX_ID_CARD = "(^\\d{18}$)|(^\\d{17}[X]{1}$)";

	/**
	 * 正则表达式：验证IP地址
	 */
	public static final String REGEX_IP_ADDR = "^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})(\\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}$"; // "(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)";

	// /^(([01]?\d?\d|2[0-4]\d|25[0-5])\.){3}([01]?\d?\d|2[0-4]\d|25[0-5])\/(\d{1}|[0-2]{1}\d{1}|3[0-2])$/
	// \d+\.\d+\.\d+\.\d+
	// ^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$
	/*
	 * 正则表达式：验证日期时间 00-00-00 00:00:00 | 0000-00-00 00:00:00 | 09-05-22 08:16:00
	 * | 1970-00-00 00:00:00 | 20090522081600 pi
	 */
	// 
	// "({2}|\\d{4})(?:\-)?([0]{1}\\d{1}|[1]{1}[0-2]{1})(?:\-)?([0-2]{1}\\d{1}|[3]{1}[0-1]{1})(?:\\s)?([0-1]{1}\\d{1}|[2]{1}[0-3]{1})(?::)?([0-5]{1}\\d{1})(?::)?([0-5]{1}\\d{1})";
	//"(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)(?:\\s)?([0-1]{1}\\d{1}|[2]{1}[0-3]{1})(?::)?([0-5]{1}\\d{1})(?::)?([0-5]{1}\\d{1})";
	// "/^(d{4})-(d{2})-(d{2})(?:\\s)?([0-1]{1}\\d{1}|[2]{1}[0-3]{1})(?::)?([0-5]{1}\\d{1})(?::)?([0-5]{1}\\d{1})";
	public static final String REGEX_TIME = "^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29) ([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";//"/^(d{4})-(d{2})-(d{2}) (d{2}):(d{2}):(d{2})$/";
	public static final String REGEX_TIME_1 = "^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";//"/^(d{4})-(d{2})-(d{2}) (d{2}):(d{2}):(d{2})$/";
	/**^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])
	 * 校验用户名
	 * 
	 * @param username
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isUsername(String username) {
//		return Pattern.matches(REGEX_USERNAME, username);
		try {
			boolean flag = Pattern.matches(REGEX_NAME, username);
			return flag;
		} catch (Exception e) {
			return false;
		}
		
	}

	/**
	 * 校验密码
	 * 
	 * @param password
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isPassword(String password) {
		try {
			return Pattern.matches(REGEX_PASSWORD, password);
		} catch (Exception e) {
			return false;
		}
		
	}

	/**
	 * 校验手机号
	 * 
	 * @param mobile
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isMobile(String mobile) {
		try {
			mobile = mobile.replace(" ", "");
			if(Pattern.matches(REGEX_GUHUA, mobile)){
				return true;
			}
			if(Pattern.matches(REGEX_GUHUA_S, mobile)){
				return true;
			}
			return Pattern.matches(REGEX_MOBILE, mobile);
		} catch (Exception e) {
			return false;
		}
		
	}
	public static boolean isMobile_(String mobile) {
		return Pattern.matches(REGEX_MOBILE_, mobile);
	}
	
	/**
	 * 校验邮箱
	 * 
	 * @param email
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isEmail(String email) {
		return Pattern.matches(REGEX_EMAIL, email);
	}

	/**
	 * 校验汉字
	 * 
	 * @param chinese
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isChinese(String chinese) {
		if(StringUtils.isBlank(chinese)){
			return false;
		}
		return Pattern.matches(REGEX_CHINESE, chinese);
	}

	/**
	 * 校验身份证
	 * 
	 * @param idCard
	 * @return 校验通过返回true，否则返回false
	 */
	public static boolean isIDCard(String idCard) {
		try {
			if(StringUtils.isBlank(idCard)){
				return false;
			}
		} catch (Exception e) {
		}
		return Pattern.matches(REGEX_ID_CARD, idCard);
	}

	/**
	 * 校验IP地址
	 * 
	 * @param ipAddr
	 * @return
	 */
	public static boolean isIPAddr(String ipAddr) {
		return Pattern.matches(REGEX_IP_ADDR, ipAddr);
	}

	/*
	 * REGEX_CODE
	 */
	public static boolean isCode(String code) {
		if (StringUtils.isBlank(code)) {
			return false;
		}
		return Pattern.matches(REGEX_CODE, code);
	}
	public static boolean isCode(String code,int minLen,int maxLen) {
		try {
			return Pattern.matches("^[a-zA-Z0-9]{"+minLen+","+maxLen+"}$", code);
		} catch (Exception e) { 
			return false;
		}
		
	}

	public static boolean isRateCode(String code) {
		return Pattern.matches(REGEX_CODE_1, code);
	}
	/*钱可以为负数和0*/
	public static boolean isFee(BigDecimal fee) {
		if(fee==null){
			return false;
		}
		String fee1 = fee.toString();
//		System.out.println(fee1);
		if("0".equals(fee1)){
			return true;
		}
		return Pattern.matches(REGEX_FEE_1, fee1);
	}
	public static boolean isFee(String fee) {
		if(fee==null){
			return false;
		}
		if("0".equals(fee)){
			return true;
		}
		if(fee.indexOf(".")==-1){
			return Pattern.matches(REGEX_CODE_, fee);
		}
		return Pattern.matches(REGEX_FEE_1, fee);
	}
	//
	public static boolean isRateCodeSearch(String code) {
		return Pattern.matches(REGEX_CODE_2, code);
	}
	public static boolean isTime(String time) {//0000-12-12 12:12:12
		return Pattern.matches(REGEX_TIME, time);
	}
	public static boolean isTimeNoSecond(String time) {//0000-12-12
		if(StringUtils.isBlank(time)){
			return false;
		}
		return Pattern.matches(REGEX_TIME_1, time);
	}
	public static boolean isNum(Object num) {//0000-12-12 12:12:12
		try {
			String num1 = num.toString();
			if(StringUtils.isBlank(num1)){
				return false;
			}
			num1 = num1.trim();
			return Pattern.matches(REGEX_CODE_, num1);
		} catch (Exception e) {
			return false;
		}
	}
	public static boolean isSerial(String serial) {
		return Pattern.matches(REGEX_CODE_3, serial);
	}
	public static boolean isCardPass(String cardPass) {
		return Pattern.matches(REGEX_CODE_4, cardPass);
	}
	public static String companyCode(Long companyCode,int length) {
		if(companyCode!=null){
			String companyCode1 = companyCode+"";
			String showZero = "";
			if(companyCode1.length()<length){
				int count = length-companyCode1.length();
				for(int j=0;j<count;j++){
					showZero += "0";
				}
			}
			return showZero+companyCode1;
		}
		return "";
	}
	public static boolean isCustomerPhone(String customerPhone) {
		if(customerPhone==null){
			return false;
		}
		if(customerPhone.length()==4){
			if(Pattern.matches(REGEX_CODE4, customerPhone)){
				return true;
			}
		}
		return Pattern.matches(REGEX_MOBILE, customerPhone);
	}
	public static boolean isAge(String age) {
		try {
			if(StringUtils.isBlank(age)){
				return false;
			}
			int a = ParseUtil.parseInt(age);
			if(a>10&&a<200){
				return true;
			}
		} catch (Exception e) {
		}
		return false;
	}
	public static boolean isSex(String sex) {
		try {
			if(StringUtils.isBlank(sex)){
				return false;
			}
		} catch (Exception e) {
		}
		if(sex.length()>2||(!"男".equals(sex)&&!"女".equals(sex)&&!"保密".equals(sex)&&!"中性".equals(sex))){
			return false;
		}
		return true;
	}
}