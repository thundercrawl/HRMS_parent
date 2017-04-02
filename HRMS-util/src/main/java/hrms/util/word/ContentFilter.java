package hrms.util.word;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ContentFilter {
	/**
	 * @author CGH 修改
	 * @param content
	 * @param list
	 * @return
	 */
	public static String getClearContent(String content,List<String> list){
		if(content == null || "".equals(content)){
			return "";
		}
		if(list==null){
			return content;
		}
		for (String des : list) {
			// 自定义正则
			Pattern pattern = Pattern.compile(des);// 正则匹配对象 资源库中每一个词汇 做成一个匹配正则
			// 和目标用户提交 数据进行比对
			Matcher m = pattern.matcher(content);
			// 判断是否 符合条件
			if (m.find()) {
				content = content.replaceAll(des, "**");
			}
		}
		return content;
	}
	/**
	 * 正则判断
	 * 替换为非敏感词
	 * @author CGH
	 * @param content
	 * @param map
	 * @return
	 */
	public static String replaceCheck(String content,Map<String, ?> map) {
		
		if(content == null){
			return "";
		}
		
		Set<String> keys = map.keySet();

		Iterator<String> iter = keys.iterator();
		try {
			while (iter.hasNext()) {
				String key = iter.next();
				
				if(key==null){
					continue;
				}
				
				String value = map.get(key)+"";
				// 自定义正则
				Pattern pattern = Pattern.compile(key);// 正则匹配对象 资源库中每一个词汇 做成一个匹配正则
				// 和目标用户提交 数据进行比对
				Matcher m = pattern.matcher(content);

				// 判断是否 符合条件
				if (m.find()) {
					content = content.replaceAll(key, value);
				}

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			// TODO: handle exception
		}
		

		return content;

	}
	
	/**contains 判断
	 * @author CGH
	 * @param content
	 * @param map
	 * @return
	 */
	public static String replaceSensiveWords( String content , Map<String, ?> map ) {
		
		if(content == null){
			return "";
		}
		
		Set<String> keys = map.keySet();

		Iterator<String> iter = keys.iterator();
		
		while (iter.hasNext()) {

			String key = iter.next();
			if(key==null){
				continue;
			}
			String value = map.get(key)+"";
			
			if (content.contains(key)) {

				content = content.replaceAll(key, value);// 对于符合map中的key值实现替换功能

			}

		}
		return content;

	}
	
}
