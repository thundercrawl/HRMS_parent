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
	<table style="font-size: 18px; width:100%;">
    <tr>
    <td style="text-align: right;padding-right: 20px;">请输入登录账号:</td>
    <td style="text-align: left;"><input type="text" id="account"></td>
    </tr>
    </table>
    <div class="input-group col-md-12 colLee text-center" style="display:inline-block;margin-top: 65px;">
		<a href="javaScript:void(0);" class="btn btn-primary next" id="queryBtn">下一步</a>
	</div>
    
	</div>
	</div></div></div></div>
<script src="js/personal/forgetPsw.js"></script>
