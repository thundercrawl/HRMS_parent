package hrms.vo;

import com.alibaba.fastjson.JSONObject;
import hrms.common.ErrorCode;

import java.io.Serializable;
import java.util.Map;

public class MsgVo implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String status;
	private String message;
	private Map<String, ? extends Object> data;
	
	public MsgVo() {
		super();
	}

	public MsgVo(String status, Map<String, ? extends Object> data) {
		super();
		this.status = status;
		this.data = data;
	}
	
	public MsgVo(String status, String message) {
		super();
		this.status = status;
		this.message = message;
	}
	
	public MsgVo(String status, String message, Map<String, ? extends Object> data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}
	
	public MsgVo(ErrorCode errorCode, Map<String, ? extends Object> data) {
		super();
		this.status = errorCode.getStatus();
		this.message = errorCode.getMessage();
		this.data = data;
	}
	
	public MsgVo(ErrorCode errorCode, Map<String, ? extends Object> data, String...parms) {
		super();
		this.status = errorCode.getStatus();
		this.message = errorCode.getMessage(parms);
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Object getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public static MsgVo success(Map<String, ? extends Object> data) {
		return new MsgVo(ErrorCode.SUCCESS, data);
	}
	
	public static MsgVo fail(ErrorCode errorCode) {
		return new MsgVo(errorCode, null);
	}
	
	public static MsgVo fail(ErrorCode errorCode, String... parms) {
		return new MsgVo(errorCode, null, parms);
	}
	
	public static MsgVo fail(ErrorCode errorCode, Map<String, ? extends Object> data) {
		return new MsgVo(errorCode, data);
	}
	
	public static MsgVo error(ErrorCode errorCode) {
		return new MsgVo(errorCode, null);
	}
	
	public static MsgVo error(ErrorCode errorCode, Map<String, ? extends Object> data) {
		return new MsgVo(errorCode, data);
	}
	
	public static String successJson(Map<String, ? extends Object> data) {
		return JSONObject.toJSONString(success(data));
	}
	
	public static String failJson(ErrorCode errorCode, Map<String, ? extends Object> data) {
		return JSONObject.toJSONString(fail(errorCode, data));
	}
	
	public static String errorJson(ErrorCode errorCode, Map<String, ? extends Object> data) {
		return JSONObject.toJSONString(error(errorCode, data));
	}
	
	public static String failJson(ErrorCode errorCode) {
		return JSONObject.toJSONString(fail(errorCode));
	}
	
	public static String errorJson(ErrorCode errorCode) {
		return JSONObject.toJSONString(error(errorCode));
	}
}
