package hrms.util;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.SignatureException;
import java.util.*;

public class Md5Util {

	public static String sha1(List<String> list) {
		return sha1(StringUtils.join(list, ""));
	}

	public static String sha1(String str) {
		if (StringUtils.isEmpty(str)) {
			return StringUtils.EMPTY;
		}
		return DigestUtils.sha1Hex(str);
	}

	public static String md5Uuid(int radix) {
		UUID uuid = UUID.randomUUID();
		return new BigInteger(1, DigestUtils.md5(uuid.toString())).toString(radix);
	}
	
	public static String md5(String str) {
		return DigestUtils.md5Hex(str);
	}

	public static String sign(Map<String, String> map, String key) {
		if (map == null || map.isEmpty()) {
			return null;
		}
		Map<String, String> sortMap = new TreeMap<String, String>(new Comparator<String>() {
			@Override
			public int compare(String str1, String str2) {
				return str1.compareTo(str2);
			}

		});
		sortMap.putAll(map);
		String params = UrlUtil.formatParams(sortMap);
		if (!StringUtils.isEmpty(key)) {
			params = params + "&key=" + key;
		}
		params = params.replace("\\", "\\\\"); 
		System.out.println(params);
		String sign = DigestUtils.md5Hex(params).toUpperCase();
		return sign;
	}

	public static String signSha1(Map<String, String> map, String key) {
		if (map == null || map.isEmpty()) {
			return null;
		}
		Map<String, String> sortMap = new TreeMap<String, String>(new Comparator<String>() {
			@Override
			public int compare(String str1, String str2) {
				return str1.compareTo(str2);
			}

		});
		sortMap.putAll(map);
		String params = UrlUtil.formatParams(sortMap);
		if (!StringUtils.isEmpty(key)) {
			params = params + "&key=" + key;
		}
		System.out.println(params);
		String sign = sha1(params);
		return sign;
	}

	public static String signJson(String json, String key) {
		JSONObject jsonObject = JSONObject.parseObject(json);
		return signJson(jsonObject, key);
	}

	public static String signJson(Map<String, Object> jsonObject, String key) {
		Map<String, String> map = new TreeMap<String, String>(new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		for (String paramName : jsonObject.keySet()) {
			map.put(paramName, JSONObject.toJSONString(jsonObject.get(paramName)));
		}
		return sign(map, key);
	}

	/**
	 * 生成随机密码
	 * 
	 * @param pwd_len
	 *            生成的密码的总长度
	 * @return 密码的字符串
	 */
	public static String genRandomNum(int pwd_len) {
		// 35是因为数组是从0开始的，26个字母+10个数字
		final int maxNum = 36;
		int i; // 生成的随机数
		int count = 0; // 生成的密码的长度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
		StringBuffer pwd = new StringBuffer("");
		Random r = new Random(DateUtil.now().getTime());
		while (count < pwd_len) {
			// 生成随机数，取绝对值，防止生成负数，
			i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1
			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}
	/**
     * 签名字符串
     * @param text 需要签名的字符串
     * @param key 密钥
     * @param input_charset 编码格式
     * @return 签名结果
     */
    public static String sign(String text, String key, String input_charset) {
    	text = text + key;
        return DigestUtils.md5Hex(getContentBytes(text, input_charset));
    }
    
    /**
     * 签名字符串
     * @param text 需要签名的字符串
     * @param sign 签名结果
     * @param key 密钥
     * @param input_charset 编码格式
     * @return 签名结果
     */
    public static boolean verify(String text, String sign, String key, String input_charset) {
    	text = text + key;
    	String mysign = DigestUtils.md5Hex(getContentBytes(text, input_charset));
    	if(mysign.equals(sign)) {
    		return true;
    	}
    	else {
    		return false;
    	}
    }

    /**
     * @param content
     * @param charset
     * @return
     * @throws SignatureException
     * @throws UnsupportedEncodingException 
     */
    private static byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }

	public static void main(String[] args) {
		String s = "ssssss";
		System.out.println(Md5Util.md5(s).length());
	}
}
