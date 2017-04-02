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
<div class="box-header well" data-original-title="">找回密码</div>
<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
<div style="min-width:1100px;margin-top: 59px;">
	<table style="font-size: 18px; margin-left: 242px;">
    <tr>
    <td>找回密码验证失败</td>
    </tr>
    </table>
     <a href="javaScript:void(0);" class="btn btn-blue fail" 
     style="margin-left: 450px;margin-top: 45px;">返回</a>
	</div>
	</div></div></div></div>
<script src="js/personal/forgetPsw.js"></script>
