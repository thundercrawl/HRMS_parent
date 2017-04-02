<!DOCTYPE html>
<html lang="en">
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<head>
<base href="<%=basePath%>" />
	<meta charset="UTF-8">
	<title>优惠码</title>
	<link rel="stylesheet" href="css/style.css">
	<script src="js/createDiscount.js"></script>
	<script>
		$(function () {
			$(".btn-c").click(function () {
				$(this).next(".input-wrap").show();
			});
			$(".choose-select").change(function () {
				var classValue = $(".choose-select").find("option:selected").attr("value");
				$("." + classValue).show().siblings(".choose-select").hide();
			});
		});
	</script>
</head>


<body>
	<div class="wrap-c">
		<div class="forms">
			<div class="select-group">
				<div>
					<label for="">适应范围</label>
					<select name="" id="discountMainKind" class="choose-select">
						<option style="display:none">请选择</option>
						<option value="choose-select0">全部</option>
						<option value="choose-select1">按类型</option>
						<option value="choose-select2">按产品</option>
					</select>
				</div>
				<div class="choose-select choose-select0">
					<label for="">折扣</label>
					<input id="discountAllNO" type="text" palceholder="请输入折扣(1到100之间的整数)">
				</div>
				<div class="choose-select choose-select1">
					<div>
						<label for="">类型选择</label>
						<select name="" id="discountKind" class="choose-select">
							<option class="a0" style="display:none">按类型</option>
							<option value="1">工位</option>
							<option value="3">办公室</option>
							<option value="01">房租</option>
							<option value="02">智慧包</option>
							<option value="03">房租+智慧包</option>
						</select>
					</div>
					<div>
						<label for="">折扣</label>
						<input id="discountKindNO" type="text" palceholder="请输入折扣(1到100之间的整数)">
					</div>
				</div>
					<div class="choose-select choose-select2">
					<div>
						<label for="">项目选择</label>
						<select name="" id="discountProject" class="choose-select">
							<option class="a0" style="display:none">项目选择</option>
							<c:forEach items="${projectList}" var="project">
							<option value="${project.projectId}">${project.projectName}</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<label for="">类型选择</label>
						<select name="" id="discountKind1" class="choose-select" onchange="getProductInfo()">
							<option class="a0" style="display:none">按类型</option>
							<option value="1">工位</option>
							<option value="3">办公室</option>
						</select>
					</div>
					<div>
						<label for="">产品选择</label>
						<select name="" id="discountProduct" class="choose-select">
							<option class="a0" style="display:none">按产品</option>
							<!-- <option value="a1">按产品1</option>
							<option value="a2">按产品2</option>
							<option value="a3">按产品3</option> -->
						</select>
					</div>
					<div>
						<label for="">折扣</label>
						<input id="discountProjectNO" type="text" palceholder="请输入折扣(1到100之间的整数)">
					</div>
				</div>
			</div>
			<div>
				<a href="javaScript:void(0);" class="btn-c" onclick="createDiscountNumber()">生成</a>  
<!-- 				<button class="btn-c">生成</button>
 -->			
 			</div>
		</div>
		<div class="bottom-choose" >
			<span>折扣码</span>
			<p class="zhekou" id="discountNumbers"></p>
		</div>
	</div>
</body>

</html>