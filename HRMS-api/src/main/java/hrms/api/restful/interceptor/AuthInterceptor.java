package hrms.api.restful.interceptor;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.common.ErrorCode;
import hrms.vo.MsgVo;
import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.message.Message;
import org.apache.cxf.message.MessageContentsList;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;

import javax.ws.rs.core.Response;
import java.util.*;

public class AuthInterceptor extends AbstractPhaseInterceptor<Message> {
	
	/*
	 * 需要token检查的路径
	 */
	private Set<String> authPaths;
	
    public AuthInterceptor(String phase) {  
        super(phase);  
    }
    
    public AuthInterceptor() {  
        super(Phase.PRE_INVOKE);
    }  

	@Override
	public void handleMessage(Message message) throws Fault {
		// 获取入参
		List<Object> requestParams = MessageContentsList.getContentsList(message);

		if (requestParams.size() != 2
				|| !(requestParams.get(1) instanceof CommonParams)) {// 参数不合法
			processFault(message, ErrorCode.PARAMERROR);
			return;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Object", requestParams.get(0));
		map.put("CommonParam", requestParams.get(1));
		System.out.println(JSONObject.toJSONString(map));
		CommonParams commonParam = (CommonParams) requestParams.get(1);

		//请求成功
		processContinue(message, requestParams, commonParam);
	}
	
	private void processContinue(Message message, List<Object> requestParams, CommonParams commonParam) {
		List<Object> newParams = new ArrayList<Object>();
		newParams.add(requestParams.get(0));
		newParams.add(commonParam);
		message.setContent(List.class, newParams);
	}

	private void processFault(Message message, ErrorCode errorCode) {
		Response response = message.getExchange().get(Response.class);
		if(response != null) {
			return;
		}
		
		Response.ResponseBuilder rb = Response.status(Response.Status.OK);
		rb.language(Locale.SIMPLIFIED_CHINESE);
		if(errorCode != null) {
			 response = rb.entity(MsgVo.fail(errorCode)).build();
		} else {
			response = rb.entity(MsgVo.fail(ErrorCode.UNKNOW)).build();
		}
		message.getExchange().put(Response.class, response);
	}

	public Set<String> getAuthPaths() {
		return authPaths;
	}

	public void setAuthPaths(Set<String> authPaths) {
		this.authPaths = authPaths;
	}
	
}
