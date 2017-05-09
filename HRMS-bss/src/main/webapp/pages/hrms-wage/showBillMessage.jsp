<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<head lang="zh">
<title>账单信息</title>
<link rel="stylesheet" type="text/css" href="css/bill.css">
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>

</head>
			<div class="self-info-wrap">
				<%--<div class="header-img">
					<img src="img/userinfo/iconfont-ren.png" alt="">
				</div>--%>
			<%--	<ul class="header-title clearfix">
					<li class="user-selected" id="personMessage">个人信息</li>
				</ul>--%>
				<form class="user-form user-form1 user-info" id="userId1" method="post" action="">
					<div>
						<label for="laterCount">迟到次数</label>
						<input type="text" id="laterCount" readonly="readonly" value="${billDetail.signLaterCount}"/>
						<span>罚款￥30/次</span>
					</div>
					<div>
						<label for="earlyCount">早退次数</label>
						<input type="text" id="earlyCount" readonly="readonly" value="${billDetail.signEarlyCount}" />
						<span>罚款￥30/次</span>
					</div>
					<div>
						<label for="noSignDays" >缺勤天数</label>
						<input type="text" id="noSignDays" readonly="readonly" value="${billDetail.signNoDays}" />
						<span>扣除当日实际工作日工资</span>
					</div>
					<div>
						<label for="signDeduction" >考勤扣除款</label>
						<input type="text" id="signDeduction" readonly="readonly" value="${billDetail.signDeduction}" />
						<span >迟到、早退和缺勤罚款总额</span>
					</div>
					<div>
						<label for="leaveDays" style="display: inline-table">请假天数</label>
						<input type="text" id="leaveDays" readonly="readonly" value="${billDetail.leaveDays}"/>
						<span id="leavespan">扣除当日实际工作日工资</span>
					</div>
					<div>
						<label for="leaveDeduction">请假扣除款</label>
						<input type="text" id="leaveDeduction" readonly="readonly" value="${billDetail.leaveDeduction}" />
					</div>
					<div>
						<label for="businessDays">出差天数</label>
						<input type="text" id="businessDays" readonly="readonly" value="${billDetail.businessDays}"/>
						<span id="businessspan">补贴￥100/次</span>
					</div>
					<div>
						<label for="businessSubsidy">出差补贴款</label>
						<input type="text" id="businessSubsidy" readonly="readonly" value="${billDetail.businessSubsidy}" />
					</div>
					<div>
						<label for="oldIns">养老保险</label>
						<input type="text" id="oldIns" readonly="readonly" value="${billDetail.oldIns}" />
						<span id="oldspan">公司缴纳22%</span>
					</div>
					<div>
						<label for="medicalIns">医疗保险</label>
						<input type="text" id="medicalIns" readonly="readonly" value="${billDetail.medicalIns}"/>
						<span id="modicalspan">公司缴纳12%</span>
					</div>
					<div>
						<label for="unWorkIns">失业保险</label>
						<input type="text" id="unWorkIns" readonly="readonly" value="${billDetail.unWorkIns}"/>
						<span id="unWorkspan">公司缴纳1.7%</span>
					</div>
					<div>
						<label for="injuryIns">工伤保险</label>
						<input type="text" id="injuryIns" readonly="readonly" value="${billDetail.injuryIns}"/>
						<span id="injuryspan">公司缴纳0.5%</span>
					</div>
					<div>
						<label for="maternityIns">生育保险</label>
						<input type="text" id="maternityIns" readonly="readonly" value="${billDetail.maternityIns}"/>
						<span id="maternityspan">公司缴纳0.8%</span>
					</div>
					<div>
						<label for="houseIns">住房公积金</label>
						<input type="text" id="houseIns" readonly="readonly" value="${billDetail.houseIns}"/>
						<span id="housespan">公司缴纳7%</span>
					</div>

					<div class="input-group col-md-5 colLee  col-md-pull-1" style="display:inline-block;text-align: right;">
						<a class="btn btn-info" id="prevision">返回上一级</a>
					</div>

				</form>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="js/hrms-wage/showBillMessage.js"></script>

