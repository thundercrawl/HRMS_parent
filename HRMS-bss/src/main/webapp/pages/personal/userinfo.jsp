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
<title>登录界面</title>
<link rel="stylesheet" type="text/css" href="css/user.css">
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/personal/main.js"></script>

</head>
			<div class="self-info-wrap">
				<div class="header-img">
					<img src="img/userinfo/iconfont-ren.png" alt="">
				</div>
				<ul class="header-title clearfix">
					<li class="user-selected">个人信息</li>
					<li>密码修改</li>
				</ul>
				<form class="user-form user-form1 user-info" id="userId1" method="post" action="">
				<div class="btn-userc">修改</div>
				<div>
						<label for="username">用户名</label> <input type="text"
							id="username" readonly="readonly" value="${administrator2.adminLname}"/>
					</div>
					<div>
						<label for="truename">真实姓名</label> <input type="text"
							id="truename" readonly="readonly" value="${administrator2.adminRname}"/>
						<p>请输入与身份证相同的姓名</p>
						<span id="namespan"></span>
					</div>
					<div>
						<label for="telephone">电话号码</label> <input type="text"
							id="telephone" readonly="readonly" value="${administrator2.adminPhone}"/>
						<p>请确保输入可以联系到本人的号码</p>
						<span id="phonespan"></span>
					</div>
					<div>
						<label for="idnum">身份证号</label> <input type="text" id="idnum"
							readonly="readonly" value="${administrator2.adminIdCard}"/>
						<p>请确保输入本人有效的身份证号</p>
						<span id="idCardspan"></span>
					</div>
					<div>
						<label for="sex">性别</label> <input type="text" id="sex"
							readonly="readonly" value="${administrator2.adminSex}"/>
					</div>
					<div>
						<label for="age">年龄</label> <input type="text" id="age"
							readonly="readonly" value="${administrator2.adminAge}"/>
					</div>
					<div>
						<label for="email">邮箱</label> <input type="text" id="email"
							readonly="readonly" value="${administrator2.adminEmail}"/>
					</div>
					
						<div class="input-group col-md-5 colLee  col-md-pull-1" style="display:inline-block;text-align: right;">
						<a class="btn btn-info" id="btn-users">保存</a>
					</div>
					
					<div class="input-group col-md-4 colLee" style="display:inline-block;">
						<a class="btn btn-info" id="btn-userg">取消</a>
					</div>
					
					<!-- <div id="user-info-btn">
						<div class="btn-user" id="btn-users">保存
							<input type="button" class="btn1-users">
						</div>
						<div class="btn-user" id="btn-userg">取消</div>
					</div> -->
				</form>
				
			
				<form class="user-form user-form2 user-password" id="userId" method="post" action="" style="padding-top: 10px;">
					<div class="space"><p class="save-succ" id="alertInfo">密码保存成功</p></div>
					<div class="user-passwd">
						<label for="password">原密码</label>
						 <input type="password"	id="password" />
						<p>用户登录原密码<img src="img/userinfo/open.png"></p>
						<span id="span1"></span>
					</div>
					<div class="user-passwd">
						<label for="password">新密码</label> <input type="password"
							id="new-password" placeholder="6-18位字母数字或特殊符号组成"/>
						<p>用户登录新密码<img src="img/userinfo/open.png"></p>
						<span id="span2"></span>
					</div>
					<div class="user-passwd">
						<label for="password">确认密码</label> <input type="password"
							id="new-password1" />
						<p>确认用户新密码<img src="img/userinfo/open.png"></p>
						<span id="span3"></span>
					</div>
						<div class="input-group col-md-7 colLee  col-md-pull-1" style="display:inline-block;text-align: right;">
						<a class="btn btn-info" id="btn-users2">保存</a>
					</div>
					
					<div class="input-group col-md-4 colLee" style="display:inline-block;">
						<a class="btn btn-info" id="btn-userg">取消</a>
					</div>
					
					
					<!-- <div id="user-info-btn">
						<div class="btn-user" id="btn-users2">保存
						<input type="button" class="btn2-users" >
						</div>
					</div> -->
				</form>
				
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="js/personal/userinfo.js"></script>

