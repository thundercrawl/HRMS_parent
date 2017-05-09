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
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="css/personal.css">
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>

</head>
			<div class="self-info-wrap">
				<div class="header-img">
					<img src="img/userinfo/iconfont-ren.png" alt="">
				</div>
			<%--	<ul class="header-title clearfix">
					<li class="user-selected" id="personMessage">个人信息</li>
				</ul>--%>
				<form class="user-form user-form1 user-info" id="userId1" method="post" action="">
					<c:if test="${userInfo.hasRole eq 1}">
						<div class="btn-userc">修改</div>
					</c:if>
					<div>
						<label for="truename">真实姓名</label> <input type="text"
							id="truename" readonly="readonly" value="${userInfo.userName}"/>
						<p>请输入与身份证相同的姓名</p>
						<span id="namespan"></span>
					</div>
					<div>
						<label for="telephone">电话号码</label> <input type="text"
							id="telephone" readonly="readonly" value="${userInfo.userPhone}"/>
						<p>请确保输入可以联系到本人的号码</p>
						<span id="phonespan"></span>
					</div>
					<div>
						<label for="idnum">身份证号</label>
						<c:if test="${ empty userInfo.userCardNumber}">
							<input type="text" id="idnum"
								   readonly="readonly" value="没有查看权限"/>
							<p>请确保输入本人有效的身份证号</p>
							<span id="idCardspan"></span>
						</c:if>
						<c:if test="${! empty userInfo.userCardNumber}">
							<input type="text" id="idnum"
								readonly="readonly" value="${userInfo.userCardNumber}"/>
							<p>请确保输入本人有效的身份证号</p>
							<span id="idCardspan"></span>
						</c:if>
					</div>
					<div>
						<label for="sexL">性别</label>
						<c:if test="${userInfo.userSex eq 1}" >
							<input type="text" id="sex" readonly="readonly" value="男">
						</c:if>
						<c:if test="${userInfo.userSex eq 2}" >
							<input type="text" id="sex" readonly="readonly" value="女">
						</c:if>
						<p>请填写“男”或“女”</p>
							<span id="sexspan" style="background-color: red">性別只能为男或女！</span>
					</div>
					<div>
						<label for="age">年龄</label> <input type="text" id="age"
							readonly="readonly" value="${userInfo.userAge}"/>
					</div>
					<div>
						<label for="dataOfBirth">出身年月</label>
						<c:if test="${empty userInfo.dataOfBirth}">
							<input type="text" id="dataOfBirth" readonly="readonly" value="没有查看权限"/>
						</c:if>
						<c:if test="${! empty userInfo.dataOfBirth}">
							<input type="text" id="dataOfBirth" readonly="readonly" value="${userInfo.dataOfBirth}"/>
						</c:if>
					</div>
					<div>
						<label for="email">邮箱</label> <input type="text" id="userEamil"
							readonly="readonly" value="${userInfo.userEamil}"/>

					</div>
					<div>
						<label for="workMessage">职业经历</label>
						<div style="overflow-x: auto;border: #ccc 1px solid;border-radius: 4px;">
							<c:forEach items="${userInfo.workMessages}" var="w">
								${w}</br>
							</c:forEach>
						</div>
						<c:if test="${userInfo.hasRole eq 1}">
							<div class="input-group col-md-5 colLee  col-md-pull-1" style="display:inline-block;text-align: right;">
								<a class="btn btn-info" id="btn-users">保存</a>
							</div>

							<div class="input-group col-md-4 colLee" style="display:inline-block;">
								<a class="btn btn-info" id="btn-userg">取消</a>
							</div>
						</c:if>
					</div>

				</form>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="js/hrms-personal/userinfo.js"></script>

