package hrms.util;

import org.apache.commons.beanutils.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Map转Object 工具类
 */
public class BeanUtil {

	public static Object populateBean(Map<String, ? extends Object> map, Class<? extends Object> clazz) throws Exception{
		Object obj = clazz.newInstance();
		BeanUtils.populate(obj, map);
		return obj;
	}
	
	public static List<Object> popListToList(Object object, List<Map<String, Object>> list) throws Exception{
		
		List<Object> listRetun = new ArrayList<Object>();
		for (Map<String, Object> map : list) {
			listRetun.add(BeanUtil.populateBean(map, object.getClass()));
		}
		return listRetun;
	}
}
