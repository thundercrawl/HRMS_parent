package hrms.common;

import java.io.Serializable;

public class Constant implements Serializable{
	private static final long serialVersionUID = 1L;

	//权限
	public static final String ROLE_HR_NAME = "HR";
	public static final String ROLE_SYSTEM_MANAGER_NAME = "SYSTEM_MANAGER";
	public static final String ROLE_FINANCE_NAME = "FINANCE"; //财务
	public static final String ROLE_WORKER_NAME= "ROLE_WORKER"; //普通职员

	public static final int ROLE_HR_VALUE = 2;
	public static final int ROLE_SYSTEM_MANAGER_VALUE = 1;
	public static final int ROLE_FINANCE_VALUE = 3; //财务
	public static final int ROLE_WORKER_VALUE = 5; //普通职员

	public static final byte ROLE_ABLE = 1;
	public static final byte ROLE_DISABLE = 0;

	//sys_enum_data status 状态(1:启用 0：禁用)
	public static final byte ENUM_ABLE = 1;
	public static final byte ENUM_DISABLE = 0;

	public static final byte STATUS_DISABLE = 0;
	public static final byte STATUS_ABLE = 1;

	//picture_info rel_type
	public static final int REL_TYPE_USER_PHOTO = 1;  //用户头像


	//系统配置中用户头像paramID的前缀
	public static final String DEFAULT_USER_PHOTO_HEAD = "DEFAULT_USER_PHOTO_";

	public static final String COMPANY_NAME = "才华有限公司";

	//考勤 sign_type
	public static final byte SING_TYPE_IN = 1;//签到
	public static final byte SING_TYPE_OUT = 2;//签退

	public static final byte SIGN_STATUS_NORMAL = 1;
	public static final byte SIGN_STATUS_LATER = 2;
	public static final byte SIGN_STATUS_EARLY = 3;


	public static final byte LEAVE_TYPE_LEAVE = 1; //请假
	public static final byte LEAVE_TYPE_BUSINESS = 2;//出差
	public static final byte LEAVE_STATUS_WAIT = 1;//待审核
	public static final byte LEAVE_STATUS_PASS = 2;//审核通过
	public static final byte LEAVE_STATUS_REJECT = 3;//审核驳回


	//五险一金比例
	public static final double INS_OLD=0.22;
	public static final double INS_MEDICAL=0.12;
	public static final double INS_UNWORK=0.017;
	public static final double INS_INJURY=0.005;
	public static final double INS_MATERNITY=0.008;
	public static final double INS_HOUSE=0.07;

	public static final String BILL_START_DAY_PARAM="BILL_START_DAY";
	public static final String BILL_END_DAY_PARAM="BILL_END_DAY";

	public static final int MONEY_BUSINESS = 100;
	public static final int MONEY_LATER_EARLY= 30;

}
