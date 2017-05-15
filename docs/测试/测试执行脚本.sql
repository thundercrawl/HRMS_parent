
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.17-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 hrms 的数据库结构
CREATE DATABASE IF NOT EXISTS `hrms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hrms`;

-- 导出  表 hrms.org_info 结构
CREATE TABLE IF NOT EXISTS `org_info` (
  `ORG_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '组织编号',
  `PARENT_ORG_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '上一级组织编号',
  `ORG_NAME` varchar(20) NOT NULL DEFAULT '0' COMMENT '组织名称',
  `CREATE_TIME` varchar(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `CREATE_USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '创建者用户编号',
  `ORG_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '部门状态（1：启用，0：销毁）',
  `ORG_DESC` varchar(255) DEFAULT '0' COMMENT '部门描述',
  PRIMARY KEY (`ORG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='组织信息表';

-- 正在导出表  hrms.org_info 的数据：~4 rows (大约)
DELETE FROM `org_info`;
INSERT INTO `org_info` (`ORG_ID`, `PARENT_ORG_ID`, `ORG_NAME`, `CREATE_TIME`, `CREATE_USER_ID`, `ORG_STATUS`, `ORG_DESC`) VALUES
	(1, 0, '才华有限公司', '2017-04-21 11:00:00', 1, 1, '测试公司'),
	(2, 1, '事业部', '2017-04-21 11:00:00', 1, 1, '测试公司'),
	(3, 1, 'IT Org', '2017-04-23 15:06:56', 1, 1, 'IT Org'),
	(4, 1, '财务部', '2017-04-24 22:37:54', 1, 1, '财务部'),
	(5, 1, '人事部', '2017-04-24 22:37:54', 1, 1, '人事部');

-- 导出  表 hrms.org_manager_info 结构
CREATE TABLE IF NOT EXISTS `org_manager_info` (
  `ORG_MENAGER_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '部门经理编号',
  `USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '用户编号',
  `ORG_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '部门编号',
  `STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '状态（1：启用，0：停用）',
  PRIMARY KEY (`ORG_MENAGER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门经理表';

-- 正在导出表  hrms.org_manager_info 的数据：~0 rows (大约)
DELETE FROM `org_manager_info`;
/*!40000 ALTER TABLE `org_manager_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `org_manager_info` ENABLE KEYS */;

-- 导出  表 hrms.org_member_info 结构
CREATE TABLE IF NOT EXISTS `org_member_info` (
  `ORG_MEMBER_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '部门成员关联编号',
  `USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '用户编号',
  `ORG_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '部门编号',
  `STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '状态（1：启用，0：停用）',
  `OPER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '操作者编号',
  `JOIN_TIME` varchar(20) NOT NULL DEFAULT '0' COMMENT '入职时间',
  `JOB_NAME` varchar(20) NOT NULL DEFAULT '0' COMMENT '职务',
  PRIMARY KEY (`ORG_MEMBER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='部门成员关联表';

-- 正在导出表  hrms.org_member_info 的数据：~15 rows (大约)
DELETE FROM `org_member_info`;
/*!40000 ALTER TABLE `org_member_info` DISABLE KEYS */;
INSERT INTO `org_member_info` (`ORG_MEMBER_ID`, `USER_ID`, `ORG_ID`, `STATUS`, `OPER_ID`, `JOIN_TIME`, `JOB_NAME`) VALUES
	(1, 1, 1, 1, 1, '2017-04-21 11:00:00', '系统管理员');
-- 导出  表 hrms.picture_info 结构
CREATE TABLE IF NOT EXISTS `picture_info` (
  `PIC_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '图片编号',
  `REL_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '关联编号',
  `REL_TYPE` int(4) NOT NULL DEFAULT '0' COMMENT '关联类型',
  `PIC_URL` varchar(255) NOT NULL DEFAULT '0' COMMENT '图片url',
  `PIC_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '图片状态（1：启用，0：废弃）',
  `CREATE_TIME` varchar(20) NOT NULL DEFAULT '0' COMMENT '上传时间(yyyy-MM-dd)',
  `CREATE_USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '上传用户编号',
  `PIC_DESC` varchar(255) DEFAULT '0' COMMENT '图片描述',
  PRIMARY KEY (`PIC_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='图片信息表';

-- 正在导出表  hrms.picture_info 的数据：~16 rows (大约)
DELETE FROM `picture_info`;
/*!40000 ALTER TABLE `picture_info` DISABLE KEYS */;
INSERT INTO `picture_info` (`PIC_ID`, `REL_ID`, `REL_TYPE`, `PIC_URL`, `PIC_STATUS`, `CREATE_TIME`, `CREATE_USER_ID`, `PIC_DESC`) VALUES
	(1, 1, 1, 'default_user_photo_0.jpg', 0, '2017-04-19 19:31:04', 1, '用户默认头像'),
	(3, 1, 1, 'default_user_photo_1.jpg', 1, '2017-04-21 13:53:43', 1, '1的用户头像'),
	(6, 12, 1, 'default_user_photo_0.jpg', 1, '2017-04-21 15:36:32', 1, 'wu li tou 1 默认头像'),
	(7, 13, 1, 'default_user_photo_1.jpg', 1, '2017-04-21 15:36:32', 1, 'wu li tou 2 默认头像'),
	(28, 34, 1, 'default_user_photo_4.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 1 默认头像'),
	(29, 35, 1, 'default_user_photo_6.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(30, 36, 1, 'default_user_photo_6.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(31, 37, 1, 'default_user_photo_0.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(32, 38, 1, 'default_user_photo_3.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(33, 39, 1, 'default_user_photo_5.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(34, 40, 1, 'default_user_photo_2.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(35, 41, 1, 'default_user_photo_5.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(36, 42, 1, 'default_user_photo_5.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(37, 43, 1, 'default_user_photo_2.jpg', 1, '2017-04-23 15:06:43', 1, 'wu li tou 2 默认头像'),
	(38, 44, 1, 'default_user_photo_3.jpg', 1, '2017-04-24 22:37:54', 1, '才子佳人 默认头像'),
	(39, 45, 1, 'default_user_photo_4.jpg', 1, '2017-04-25 14:49:28', 1, '张三 默认头像');
/*!40000 ALTER TABLE `picture_info` ENABLE KEYS */;

-- 导出  表 hrms.role_info 结构
CREATE TABLE IF NOT EXISTS `role_info` (
  `ROLE_ID` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `ROLE_NAME` varchar(50) DEFAULT '0' COMMENT '权限名称',
  `ROLE_DESCRIBE` varchar(255) DEFAULT '0' COMMENT '描述',
  `CREATE_USER_ID` tinyint(10) DEFAULT '0' COMMENT '操作人编号',
  `CREATE_TIME` varchar(20) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='权限定义表';

-- 正在导出表  hrms.role_info 的数据：~4 rows (大约)
DELETE FROM `role_info`;
/*!40000 ALTER TABLE `role_info` DISABLE KEYS */;
INSERT INTO `role_info` (`ROLE_ID`, `ROLE_NAME`, `ROLE_DESCRIBE`, `CREATE_USER_ID`, `CREATE_TIME`) VALUES
	(1, '系统管理员', '系统管理员 用户系统的全部权限', 1, '2017-04-19 19:31:04'),
	(2, 'HR', 'HR', 1, '2017-04-19 19:31:04'),
	(3, 'FINANCE', 'FINANCE', 1, '2017-04-19 19:31:04'),
	(5, 'WORKER', 'WORKER', 1, '2017-04-19 19:31:04');
/*!40000 ALTER TABLE `role_info` ENABLE KEYS */;

-- 导出  表 hrms.sign_info 结构
CREATE TABLE IF NOT EXISTS `sign_info` (
  `SIGN_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `USER_ID` int(10) NOT NULL COMMENT '用户编号',
  `SIGN_TYPE` int(1) NOT NULL COMMENT '考勤类型（1：签到2：签退）',
  `SIGN_STATUS` int(1) NOT NULL COMMENT '考勤状态',
  `SIGN_TIME` varchar(20) NOT NULL COMMENT '考勤时间',
  `CREATE_TIME` varchar(20) NOT NULL COMMENT '创建时间',
  `CREATE_USER_ID` int(10) NOT NULL COMMENT '操作人编号',
  PRIMARY KEY (`SIGN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='考勤记录表';

-- 正在导出表  hrms.sign_info 的数据：~2 rows (大约)
DELETE FROM `sign_info`;

-- 导出  表 hrms.sys_enum_data 结构
CREATE TABLE IF NOT EXISTS `sys_enum_data` (
  `TABLE_NAME` varchar(20) NOT NULL COMMENT '表名',
  `COLUMN_NAME` varchar(20) NOT NULL COMMENT '列名',
  `ENUM_TYPE` varchar(10) NOT NULL COMMENT '枚举类型',
  `ENUM_VALUE` varchar(255) NOT NULL COMMENT '枚举值',
  `ENUM_NAME` varchar(50) NOT NULL COMMENT '枚举名称',
  `SORT_ID` tinyint(3) NOT NULL COMMENT '序号',
  `DISP_NAME` varchar(50) NOT NULL COMMENT '展示名称',
  `STATUS` int(1) NOT NULL COMMENT '状态(1:启用 0：禁用)',
  `REMARK` varchar(50) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统常量表';

-- 正在导出表  hrms.sys_enum_data 的数据：~14 rows (大约)
DELETE FROM `sys_enum_data`;
/*!40000 ALTER TABLE `sys_enum_data` DISABLE KEYS */;
INSERT INTO `sys_enum_data` (`TABLE_NAME`, `COLUMN_NAME`, `ENUM_TYPE`, `ENUM_VALUE`, `ENUM_NAME`, `SORT_ID`, `DISP_NAME`, `STATUS`, `REMARK`) VALUES
	('user_info', 'SEX', 'varchar', '男', '1', 1, '男', 1, NULL),
	('user_info', 'SEX', 'varchar', '女', '2', 1, '女', 1, NULL),
	('user_info', 'WORK_STATUS', 'bit', '停用', '0', 1, '停用', 1, NULL),
	('user_info', 'WORK_STATUS', 'bit', '在职', '1', 1, '在职', 1, NULL),
	('user_leave_info', 'LEAVE_STATUS', 'bit', '未审批', '1', 1, '未审批', 1, NULL),
	('user_leave_info', 'LEAVE_STATUS', 'bit', '批准', '2', 2, '批准', 1, NULL),
	('user_leave_info', 'LEAVE_STATUS', 'bit', '驳回', '3', 3, '驳回', 1, NULL),
	('user_leave_info', 'LEAVE_TYPE', 'bit', '请假', '1', 1, '请假', 1, NULL),
	('user_leave_info', 'LEAVE_TYPE', 'bit', '出差', '2', 2, '出差', 1, NULL),
	('sign_info', 'SIGN_TYPE', 'bit', '签退', '2', 2, '签退', 1, NULL),
	('sign_info', 'SIGN_TYPE', 'bit', '签到', '1', 1, '签到', 1, NULL),
	('sign_info', 'SIGN_STATUS', 'bit', '正常', '1', 1, '签到', 1, NULL),
	('sign_info', 'SIGN_STATUS', 'bit', '迟到', '2', 2, '迟到', 1, NULL),
	('sign_info', 'SIGN_STATUS', 'bit', '早退', '3', 3, '早退', 1, NULL);
/*!40000 ALTER TABLE `sys_enum_data` ENABLE KEYS */;

-- 导出  表 hrms.sys_param_config 结构
CREATE TABLE IF NOT EXISTS `sys_param_config` (
  `PARAM_ID` varchar(50) NOT NULL COMMENT '配置参数编号',
  `PARAM_NAME` varchar(50) NOT NULL COMMENT '配置参数名称',
  `PARAM_VALUE` varchar(50) NOT NULL COMMENT '配置参数值',
  `PARAM_DESCRIBE` varchar(255) DEFAULT NULL COMMENT '配置参数描述',
  `CREATE_TIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `OPER_ID` tinyint(10) DEFAULT NULL COMMENT '操作人编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- 正在导出表  hrms.sys_param_config 的数据：~10 rows (大约)
DELETE FROM `sys_param_config`;
/*!40000 ALTER TABLE `sys_param_config` DISABLE KEYS */;
INSERT INTO `sys_param_config` (`PARAM_ID`, `PARAM_NAME`, `PARAM_VALUE`, `PARAM_DESCRIBE`, `CREATE_TIME`, `UPDATE_TIME`, `OPER_ID`) VALUES
	('DEFAULT_USER_PHOTO_0', '用户默认头像', 'default_user_photo_0.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_3', '用户默认头像', 'default_user_photo_3.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_2', '用户默认头像', 'default_user_photo_2.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_1', '用户默认头像', 'default_user_photo_1.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_4', '用户默认头像', 'default_user_photo_4.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_5', '用户默认头像', 'default_user_photo_5.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_6', '用户默认头像', 'default_user_photo_6.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('DEFAULT_USER_PHOTO_7', '用户默认头像', 'default_user_photo_7.jpg', '用户默认头像', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('BILL_START_DAY', '账单开始日期', '26', '账单开始日期', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1),
	('BILL_END_DAY', '账单结束日期', '25', '账单结束日期', '2017-04-19 19:31:04', '2017-04-19 19:31:04', 1);
/*!40000 ALTER TABLE `sys_param_config` ENABLE KEYS */;

-- 导出  表 hrms.user_info 结构
CREATE TABLE IF NOT EXISTS `user_info` (
  `USER_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `USER_NAME` varchar(50) NOT NULL DEFAULT '0' COMMENT '用户姓名',
  `USER_PHONE` varchar(15) NOT NULL DEFAULT '0' COMMENT '手机号码',
  `USER_SEX` varchar(1) NOT NULL DEFAULT '0' COMMENT '性别（1：男，2：女）',
  `USER_PASSWD` varchar(32) NOT NULL DEFAULT '0' COMMENT '密码',
  `USER_AGE` tinyint(3) NOT NULL DEFAULT '0' COMMENT '年龄',
  `USER_EMAIL` varchar(30) NOT NULL DEFAULT '0' COMMENT 'email',
  `CREATE_TIME` varchar(20) NOT NULL DEFAULT '0' COMMENT '新建时间',
  `CREATE_USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '操作人',
  `WORK_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '工作状态（1：正常，0：禁用）',
  `USER_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '账号状态（1：正常，0：销户）',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- 正在导出表  hrms.user_info 的数据：~15 rows (大约)
DELETE FROM `user_info`;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` (`USER_ID`, `USER_NAME`, `USER_PHONE`, `USER_SEX`, `USER_PASSWD`, `USER_AGE`, `USER_EMAIL`, `CREATE_TIME`, `CREATE_USER_ID`, `WORK_STATUS`, `USER_STATUS`) VALUES
	(1, '谢益文', '18201947094', '1', '0095c0019f809adc71c787c3e5f044fa', 22, 'wsxieyiwen@outlook.com', '2017-04-19 19:31:04', 1, 1, 1);
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;

-- 导出  表 hrms.user_leave_info 结构
CREATE TABLE IF NOT EXISTS `user_leave_info` (
  `LEAVE_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `LEAVE_CODE` varchar(16) NOT NULL COMMENT '流水号',
  `USER_ID` tinyint(10) NOT NULL COMMENT '用户编号',
  `LEAVE_TYPE` int(1) NOT NULL COMMENT '请假类型（1：请假2：出差）',
  `START_TIME` varchar(20) NOT NULL COMMENT '请假开始时间',
  `END_TIME` varchar(20) NOT NULL COMMENT '请假结束时间',
  `APPROVE_USER_ID` tinyint(10) NOT NULL COMMENT '审批人编号',
  `UP_TIME` varchar(20) NOT NULL COMMENT '提交时间',
  `APPROVE_TIME` varchar(20) DEFAULT NULL COMMENT '审批时间',
  `LEAVE_STATUS` int(1) NOT NULL COMMENT '状态（1：未审批2：通过3：驳回）',
  `LEAVE_CONTENT` varchar(256) DEFAULT NULL COMMENT '请假、外出、出差原因',
  PRIMARY KEY (`LEAVE_ID`),
  UNIQUE KEY `LEAVE_CODE` (`LEAVE_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='请假、外出、出差申请表';

-- 正在导出表  hrms.user_leave_info 的数据：~2 rows (大约)
DELETE FROM `user_leave_info`;

-- 导出  表 hrms.user_role_info 结构
CREATE TABLE IF NOT EXISTS `user_role_info` (
  `USER_ROLE_ID` tinyint(10) NOT NULL AUTO_INCREMENT COMMENT '用户权限记录表',
  `USER_ID` tinyint(10) DEFAULT '0' COMMENT '用户编号',
  `ROLE_ID` tinyint(4) DEFAULT '0' COMMENT '权限编号',
  `CREATE_USER_ID` tinyint(10) DEFAULT '0' COMMENT '操作人编号',
  `CREATE_TIME` varchar(20) DEFAULT '0' COMMENT '创建时间',
  `STATUS` int(1) DEFAULT NULL COMMENT '状态（1：正常0：禁用）',
  PRIMARY KEY (`USER_ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- 正在导出表  hrms.user_role_info 的数据：~15 rows (大约)
DELETE FROM `user_role_info`;
/*!40000 ALTER TABLE `user_role_info` DISABLE KEYS */;
INSERT INTO `user_role_info` (`USER_ROLE_ID`, `USER_ID`, `ROLE_ID`, `CREATE_USER_ID`, `CREATE_TIME`, `STATUS`) VALUES
	(1, 1, 1, 1, '2017-04-19 19:31:04', 1);
/*!40000 ALTER TABLE `user_role_info` ENABLE KEYS */;

-- 导出  表 hrms.user_sensitive_info 结构
CREATE TABLE IF NOT EXISTS `user_sensitive_info` (
  `USER_ID` tinyint(10) NOT NULL COMMENT '用户编号',
  `USER_CARD_NUMBER` varchar(20) DEFAULT NULL COMMENT '身份证号码',
  `DATA_OF_BIRTH` varchar(10) DEFAULT NULL COMMENT '出生年月日',
  `WORK_TIME` varchar(10) DEFAULT NULL COMMENT '入职时间',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户敏感信息表';

-- 正在导出表  hrms.user_sensitive_info 的数据：~13 rows (大约)
DELETE FROM `user_sensitive_info`;
/*!40000 ALTER TABLE `user_sensitive_info` DISABLE KEYS */;
INSERT INTO `user_sensitive_info` (`USER_ID`, `USER_CARD_NUMBER`, `DATA_OF_BIRTH`, `WORK_TIME`) VALUES
	(1, '432503123223322233', '1995-01-01', '2015-01-23');
/*!40000 ALTER TABLE `user_sensitive_info` ENABLE KEYS */;

-- 导出  表 hrms.user_wage_bill 结构
CREATE TABLE IF NOT EXISTS `user_wage_bill` (
  `BILL_ID` tinyint(10) NOT NULL AUTO_INCREMENT,
  `USER_ID` tinyint(10) NOT NULL DEFAULT '0',
  `BILL_DATE` varchar(7) NOT NULL DEFAULT '0' COMMENT '年月',
  `BASE_WAGE` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '基本工资',
  `SUBSIDY` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '补贴',
  `SUBSIDY_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '五险一金',
  `LEAVE_DEDUCTION` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '请假扣除款',
  `BUSINESS_SUBSIDY` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '出差补贴',
  `SIGN_DEDUCTION` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '考勤扣除款',
  `SUB_BILL` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '总计',
  PRIMARY KEY (`BILL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工资单';

-- 正在导出表  hrms.user_wage_bill 的数据：~0 rows (大约)
DELETE FROM `user_wage_bill`;
/*!40000 ALTER TABLE `user_wage_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_wage_bill` ENABLE KEYS */;

-- 导出  表 hrms.user_wage_bill_detail 结构
CREATE TABLE IF NOT EXISTS `user_wage_bill_detail` (
  `BILL_ID` tinyint(10) NOT NULL,
  `SIGN_LATER_COUNT` tinyint(3) NOT NULL DEFAULT '0' COMMENT '迟到次数',
  `SIGN_EARLY_COUNT` tinyint(3) NOT NULL DEFAULT '0' COMMENT '早退次数',
  `SIGN_NO_DAYS` tinyint(2) NOT NULL DEFAULT '0' COMMENT '缺勤天数',
  `SIGN_NORMAL_DAYS` tinyint(2) NOT NULL DEFAULT '0' COMMENT '考勤正常天数',
  `LEAVE_DAYS` tinyint(2) NOT NULL DEFAULT '0' COMMENT '请假天数',
  `BUSINESS_DAYS` tinyint(2) NOT NULL DEFAULT '0' COMMENT '出差天数',
  `SIGN_DEDUCTION` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '考勤扣除款',
  `LEAVE_DEDUCTION` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '请假扣除款',
  `BUSINESS_SUBSIDY` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '出差补贴款',
  `OLD_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '养老保险',
  `MEDICAL_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '医疗保险',
  `UNWORK_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '失业保险',
  `INJURY_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '工伤保险',
  `MATERNITY_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '生育保险',
  `HOUSE_INS` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '住房公积金',
  PRIMARY KEY (`BILL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员账单详情';

-- 正在导出表  hrms.user_wage_bill_detail 的数据：~0 rows (大约)
DELETE FROM `user_wage_bill_detail`;
/*!40000 ALTER TABLE `user_wage_bill_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_wage_bill_detail` ENABLE KEYS */;

-- 导出  表 hrms.user_wage_info 结构
CREATE TABLE IF NOT EXISTS `user_wage_info` (
  `WAGE_ID` tinyint(10) NOT NULL AUTO_INCREMENT,
  `USER_ID` tinyint(10) NOT NULL COMMENT '会员编号',
  `BASE_WAGE` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '基本工资',
  `SUBSIDY_PHONE` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '话费补贴',
  `SUBSIDY_INS` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '福利（五险一金）',
  `SUBSIDY_OTHER` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '其他福利',
  `SUBSIDY_OTHER_DESC` varchar(1024) DEFAULT '0' COMMENT '其他福利描述',
  `CREATE_TIME` varchar(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `CREATE_USER_ID` tinyint(10) NOT NULL DEFAULT '0' COMMENT '创建人编号',
  PRIMARY KEY (`WAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='基本工资表';

-- 正在导出表  hrms.user_wage_info 的数据：~2 rows (大约)
DELETE FROM `user_wage_info`;
/*!40000 ALTER TABLE `user_wage_info` DISABLE KEYS */;
INSERT INTO `user_wage_info` (`WAGE_ID`, `USER_ID`, `BASE_WAGE`, `SUBSIDY_PHONE`, `SUBSIDY_INS`, `SUBSIDY_OTHER`, `SUBSIDY_OTHER_DESC`, `CREATE_TIME`, `CREATE_USER_ID`) VALUES
	(2, 1, 12000.00, 300.00, 5280.00, 32.00, '邮费', '2017-05-07 12:35:20', 1);
/*!40000 ALTER TABLE `user_wage_info` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
