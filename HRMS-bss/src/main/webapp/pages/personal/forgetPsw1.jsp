<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
<div class="box-header well" data-original-title="" style="line-height: 0">找回密码</div>
<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
<div style="margin-top: 59px;">
	<table style="font-size: 18px; margin-left: 242px;">
    <tr>
    <td style="height:80px;">验证信息找回密码</td>
    </tr>
    <tr><input type="hidden" id="account" value="${account}">
    <td>请输入真实姓名：</td>
    <td><input type="text" id="name"></td>
    </tr>
    <tr>
    <td>请输入手机号码：</td>
    <td><input type="text" id="phone"></td>
    </tr>
    <tr>
    <td>请输入身份证号码：</td>
    <td><input type="text" id="idCard"></td>
    </tr>
    </table>
     <a href="javaScript:void(0);" class="btn btn-blue second" 
     style="margin-left: 450px;margin-top: 45px;">下一步</a>
	</div>
	</div></div></div></div>
<script src="js/personal/forgetPsw.js"></script>
