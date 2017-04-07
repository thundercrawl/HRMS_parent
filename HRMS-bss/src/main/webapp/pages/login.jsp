<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<head lang="zh">
<title>登录界面</title>
<link rel="stylesheet" type="text/css" href="css/loginStyle.css">
<link rel="shortcut icon" href="plugin/img/favicon.ico">
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<!-- <script type="text/javascript" src="js/main.js"></script> -->

</head>
<body class="login-wrap">
	<div class="login-head clearfix">
		<img src="img/logo.png">
		<p>
			<span>人力资源管理系统</span>
		</p>

	</div>
	<div class="login-main clearfix">
	<img src="img/bg.jpg">
		<div class="login-pic"><img src="img/index-pc.png"></div>
		<div class="login-dialog">
			<div class="login">登录</div>
			<div class="dialog">
			<from name="from1" method="post" action="">
			<input type="hidden" name="organizeId" value="1" id="organizeId">
				<p>
					用户名<span id="loginnameError" class="warning">${msg }</span>
				</p>
				<input type="text" name="loginname" id="loginname" placeholder="请输入用户名"  class="">
				<p>
					密码<span id="loginpassError" class="warning">${msg }</span>
				</p>
				<input type="password" name="loginpass" id="loginpass" placeholder="请输入密码" class="">
				<p class="">
					验证码<span id="verifyCodeError" class="warning">${msg }</span>
				</p>
				<div class="identity-out">
					<input  name="verifyCode" id="verifyCode" value="" class="hst2" style="vertical-align:middle" type="text" placeholder="请输入验证码" class="">
					<!-- <div id="verifyCodeImg" > -->
					 <img id="kaptchaImage" style="display:none"
						src="login/getKaptchaImage" onclick="this.src='login/getKaptchaImage?e='+new Date()" id="identity" class="">
					<p id="idFresh" onclick="changeCode()">点击图片刷新验证码</p>
					<!-- </div> -->
				</div>
				<div class="btn-nor" id="submit" >登录</div>
				</from>
			</div>
		</div>
		</div>
		<div class="footer">Copyright © 谢益文. All Rights Reserved.</div>
		
<!-- <script type="text/javascript" src="js/ldjs/encrypt/sha1.js"></script> -->
<script type="text/javascript" src="js/login.js"></script>
</body>
</html>