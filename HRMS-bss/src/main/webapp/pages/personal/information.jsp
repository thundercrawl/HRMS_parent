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
<div class="box-header well" data-original-title="">个人资料</div>
<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
<div style="min-width:1100px;margin-top: 33px;">
<div class="changePsw" style="background-color: rgba(23, 138, 204, 0.06);padding-top: 23px;
    width: 800px;height: 276px;position: relative;left: 135px;top: -12px;" >
	<table style="font-size: 18px; margin-left: 110px;">
    <tr>
    <td>真实姓名:</td>
    <td style="width: 281px;">${administrator2.adminRname}</td>
     <td>性别:</td>
    <td>${administrator2.adminSex}</td>
    </tr>
    <tr>
    <td>手机号码:</td>
    <td>${administrator2.adminPhone}</td>
      <td>年龄:</td>
    <td>${administrator2.adminAge}</td>
    </tr>
    <tr>
    <td>身份证号:</td>
    <td>${administrator2.adminIdCard}</td>
    <td>邮箱:</td>
    <td>${administrator2.adminEmail}</td>
    </tr>
    </table>
     <a href="javaScript:void(0);" class="btn btn-blue edit" style="margin-left: 335px;margin-top: 45px;"
     data-name="${administrator2.adminRname}" data-phone="${administrator2.adminPhone}"
	data-idCard="${administrator2.adminIdCard}" data-sex="${administrator2.adminSex}"
	data-age="${administrator2.adminAge}" data-mail="${administrator2.adminEmail}">完善信息</a>
	</div>
	</div></div></div></div></div>
	
	<div id="addMdialog" style="display:none;width:400px;">
     <form action="">
     <table>
      <tr>
         <td><span style="color: red;">*</span>真实姓名:</td>
         <td><input type="text" id="name"/>&nbsp;<span id="namespan"></span></td>
      </tr>
      <tr>
         <td><span style="color: red;">*</span>手机号码:</td>
         <td><input type="text" id="phone"/>&nbsp;<span id="phonespan"></span></td>
      </tr>
      <tr>
         <td><span style="color: red;">*</span>身份证号:</td>
         <td><input type="text" id="idCard"/>&nbsp;<span id="idCardspan"></span></td>
      </tr>
      <tr>
         <td> &nbsp;&nbsp;性别:</td>
         <td><input type="text" id="sex"/>&nbsp;<span id="sexspan"></span></td>
      </tr>
      <tr>
         <td> &nbsp;&nbsp;年龄:</td>
         <td><input type="text" id="age"/>&nbsp;<span id="agespan"></span></td>
      </tr>
       <tr>
         <td>&nbsp;&nbsp;邮箱:</td>
         <td><input type="text" id="email"/>&nbsp;<span id="emailspan"></span></td>
      </tr>
    </table>
   </form>
   <center>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
  </center>
  </div>
<script src="js/personal/information.js"></script>
