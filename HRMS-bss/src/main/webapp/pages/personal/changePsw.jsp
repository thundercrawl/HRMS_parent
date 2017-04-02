<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
<div class="box-header well" data-original-title="">修改密码</div>
<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
<div style="min-width:1100px">
<div class="changePsw" style="background-color: rgba(23, 138, 204, 0.06);padding-top: 30px;
    width: 500px;height: 260px;position: relative;left: 250px;top: 20px;" >
	<table align="center">
       <tr>
       <td>原始密码:</td>
       <td><input type="password" id="oldPsw">
       <div style="display: inline" id="oldPswSpan"></div></td>
       </tr>
        <tr>
       <td>修改密码:</td>
       <td><input type="password" id="newPsw" placeholder="长度必须为6-18">
        <div style="display: inline;" id="newPswSpan" ></td>
       </tr>
        <tr>
       <td>再次输入新密码:</td>
       <td><input type="password" id="newPsw1" placeholder="必须和上面一致">
         <div style="display: inline;" id="newPsw1Span" ></td></td>
       </tr>
	</table>
	<br>
	<div align="center" style="position:relative;padding-top:10px;">
        <a href="javaScript:void(0);" class="btn btn-blue editPsw" onclick="sure()">确定修改</a>
       </div></div>
	</div>
	</div>
	</div></div></div>
<script src="js/personal/changePsw.js"></script>