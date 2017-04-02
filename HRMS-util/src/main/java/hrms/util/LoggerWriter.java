package hrms.util;

import org.apache.commons.logging.Log;

import com.alibaba.fastjson.JSONObject;


/** 
 * @version 1.0
 * @parameter  
 * @since  
 * @return  
 */
public class LoggerWriter {
	
	public static void addWrite(Log log,String content,Object ... object){
		if(log.isDebugEnabled()){
			log.debug("新增"+content+":"+JSONObject.toJSON(object));
		}
	}
	public static void deleteWrite(Log log,String content,Object ... object){
		if(log.isDebugEnabled()){
			log.debug("删除"+content+":"+JSONObject.toJSON(object));
		}
	}
	public static void updateWrite(Log log,String content,Object ... object){
		if(log.isDebugEnabled()){
			log.debug("修改"+content+":"+JSONObject.toJSON(object));
		}
	}
}
