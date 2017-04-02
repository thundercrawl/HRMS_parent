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
}
