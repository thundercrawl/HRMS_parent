package hrms.common;


public enum ErrorCode {

	SUCCESS("0000", "请求成功"),
	// 结果
	EMPTY("0001", "没有查询到数据"), NO_RESULT("40001", "当前条件下无搜索结果，返回推荐结果"),
	PARAMERROR("0002","参数错误"),
	PARAM_EMPTY("0003","参数有为空的"),
	RESULT_EMPTY("0004","结果集为空"),
	NAME_REPEAT("0005","名称重复，请确认！"),
	ROLE_ERROR("0006","权限不足"),
	DATE_ERROR("0007","时间错误"),


	//权限
	ONLY_HR("0010","只有HR或系统管理员有操作权限"),
	REGISTER_PERMISSION_DENIED("0011","权限不足,无法授予他人同级或更高的权限"),
	PERMISSION_NOT_DEFINED("0012","没有注册该权限"),

	ENTITY_COPY_ERROR("0013","实体拷贝错误"),

	REGISTER_REPEAT("0014","一个手机号码只能注册一个账号"),
	REGISTER_ORG_MANAGER_FAIL("0015","该部门不存在或已存在部门经理，无法重复设置"),
	REGISTER_ORG_MANAGER_REPEAT("0020","您有在职部门"),

	//用户
	USER_EMPTY("0016","用户未注册"),
	USER_PASSWORD_ERROR("0017","密码错误，请确认后重新输入"),
	USER_DISABLE("0018","账户已删除，请重新注册后登录"),
	USER_WORK_DISABLE("0019","账户被禁用了，请联系HR或管理员解禁"),

	//部门
	PARENT_ORG_EMPTY("0021","上级部门不存在！"),


	//架构验证
	NO_AUTH("8001", "账号异常，请重新登陆"),
	TOKEN_TIMEOUT("8002", "账号被锁定,请联系所属公司管理员"),

	// 异常
	SIGN_WRONG("9995", "签名错误"),
	NOAUTH_REQ("9996", "非法请求"),
	CONNECT_TIMEOUT("9997", "连接超时"),
	POOR_URL("9998", "不合法的URL"),
	UNKNOW("9999", "Opps，貌似出了点小问题，稍后再试一下吧。"),

	;
	
	
	
	
	private String status;
	private String message;

	private ErrorCode(String status, String message) {
		this.status = status;
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public String getMessage() {
		return message;
	}

	public String getMessage(String[] args) {
		int index = 0;
		String tempMsg = message;
		for(String arg : args) {
			tempMsg=tempMsg.replace("{"+index+++"}", arg);
		}
		return tempMsg;
	}

}
