package hrms.api.restful.interceptor;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.message.Message;
import org.apache.cxf.message.MessageContentsList;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;

import java.util.List;

public class OutLoggerInterceptor extends AbstractPhaseInterceptor<Message> {
	
	private Log logger = LogFactory.getLog(OutLoggerInterceptor.class);
	
    public OutLoggerInterceptor(String phase) {  
        super(phase);  
    }
    
    public OutLoggerInterceptor() {  
        super(Phase.PREPARE_SEND);
    }  

	@Override
	public void handleMessage(Message message) throws Fault {
		// 获取出参
		List<Object> requestParams = MessageContentsList.getContentsList(message);
		System.err.println("请求接口出参："+JSONObject.toJSONString(requestParams)+':'+System.currentTimeMillis());
		logger.info("请求接口出参："+JSONObject.toJSONString(requestParams));
	}
	
	
}
