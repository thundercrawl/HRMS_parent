package hrms.api.restful.interceptor;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.vo.MsgVo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.message.Message;
import org.apache.cxf.message.MessageContentsList;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import java.util.*;

public class SignCheckInterceptor extends AbstractPhaseInterceptor<Message> {
	
	private Log logger = LogFactory.getLog(SignCheckInterceptor.class);
	
    public SignCheckInterceptor(String phase) {
        super(phase);  
    }
    
    public SignCheckInterceptor() {  
        super(Phase.PRE_INVOKE);  
    }  

	@Override
	public void handleMessage(Message message) throws Fault {
		// 获取入参
		List<Object> requestParams = MessageContentsList.getContentsList(message);

		if (requestParams.size() != 6 || !((Class<?>)requestParams.get(4)).isAssignableFrom(CommonParams.class)) {// 参数不合法
			processFault(message, ErrorCode.PARAMERROR);
			return;
		}

		CommonParams commonParam = JSONObject.parseObject(JSONObject.toJSONString(requestParams.get(5)), CommonParams.class);
		if (commonParam == null) {// 非法请求
			processFault(message, ErrorCode.NOAUTH_REQ);
			return;
		}


		Map<String, Object> map = new HashMap<String, Object>();
		map.put((String)requestParams.get(0), requestParams.get(2));
		map.put((String)requestParams.get(3), commonParam);

		//请求成功
		List<Object> newParams = new ArrayList<Object>();
		newParams.add(JSONObject.parseObject(JSONObject.toJSONString(requestParams.get(2)), (Class<?>)requestParams.get(1)));
		newParams.add(commonParam);
		message.setContent(List.class, newParams);
	}
	
	private void processFault(Message message, ErrorCode errorCode) {
		Response response = message.getExchange().get(Response.class);
		if(response != null) {
			return;
		}
		ResponseBuilder rb = Response.status(Response.Status.OK);
		rb.language(Locale.SIMPLIFIED_CHINESE);
		if(errorCode != null) {
			 response = rb.entity(MsgVo.fail(errorCode)).build();
		} else {
			response = rb.entity(MsgVo.fail(ErrorCode.UNKNOW)).build();
		}
		message.getExchange().put(Response.class, response);
	}
}
