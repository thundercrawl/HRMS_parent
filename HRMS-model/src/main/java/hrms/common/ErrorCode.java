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
	PARAM_TYPE_ERROR("0008","不支持的参数"),

	// 异常
	SIGN_WRONG("9995", "签名错误"),
	NOAUTH_REQ("9996", "非法请求"),
	CONNECT_TIMEOUT("9997", "连接超时"),
	POOR_URL("9998", "不合法的URL"),
	UNKNOW("9999", "Opps，貌似出了点小问题，稍后再试一下吧。"),


	//权限
	ONLY_HR("0010","只有HR或系统管理员有操作权限"),
	REGISTER_PERMISSION_DENIED("0011","权限不足,无法授予他人同级或更高的权限"),
	PERMISSION_NOT_DEFINED("0012","没有注册该权限"),

	ENTITY_COPY_ERROR("0013","实体拷贝错误"),

	REGISTER_REPEAT("0014","一个手机号码只能绑定一个账号"),
	REGISTER_ORG_MANAGER_FAIL("0015","该部门不存在或已存在部门经"),
	REGISTER_ORG_MANAGER_REPEAT("0020","一个用户只能有一个在职部门"),

	//用户
	USER_EMPTY("0016","用户不存在"),
	USER_PASSWORD_ERROR("0017","密码错误，请确认后重新输入"),
	USER_DISABLE("0018","账户已删除，请重新注册后登录"),
	USER_WORK_DISABLE("0019","账户被禁用了，请联系HR或管理员解禁"),

	//部门
	PARENT_ORG_EMPTY("0021","上级部门不存在！"),
	ORG_EMPTY("0022","部门不存在"),
	ORG_DELETE("0023","部门已删除"),

	ORG_MEMBER_EMPTY("0024","该成员没有在职部门"),

	UPDATE_PWD_NOT_MINE("0025","只能自己修改密码，其他人无操作权限"),

	PARENT_ORG_ERROR("0026","不能将自己设置为自己的上级部门"),
	PARENT_ORG_NOT_TOP("0027","顶级部门无法手动设置"),

	//考勤
	PHONE_EMPTY("0028","没有可用号码"),
	USER_PART_ERROR("0029","部分用户已删除或未注册"),
	SIGN_REPEAT("0030","一个成员一天只能签到签退各一次"),

	//请假出差
	LEAVE_TYPE_ERROR("0031","不支持的请假外出类型"),
	LEAVE_CODE_GENERATE_ERROR("0032","流水号生成失败"),
	LEAVE_APPROVE_REPEAT("0033","已完成审批，不能重复审批"),
	LEAVE_APPROVE_USER_ERROR("0034","无审批权限"),

	LEAVE_REPEAT("0035","请假或出差申请时间交叉"),
	LEAVE_NOT_BUSINESS("0036","您的账户在此时间段内通过了请假审批或存在出差审批，不能重复申请"),

	//財務
	ONLY_FINANCE("0037","只有系统管理员和财务拥有操作权限"),
	NONE("0038","没有指定操作对象"),
	WAGE_ONLY_ONE("0039","一个用户只能存在一条工资信息，不能重复注册"),
	USER_NOT_ENOUGH("0040","名单中的部分员工没注册或已删除"),

	//架构验证
	NO_AUTH("8001", "账号异常，请重新登陆"),
	TOKEN_TIMEOUT("8002", "账号被锁定,请联系所属公司管理员"),

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
