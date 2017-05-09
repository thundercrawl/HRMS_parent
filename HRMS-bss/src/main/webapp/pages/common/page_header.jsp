<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<meta charset="UTF-8" />
    <title>才华有限公司 人力资源管理后台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
    <meta name="author" content="Muhammad Usman">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
	<%--<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=EsNhdTOg2zB7wAa39W2ffGw9"></script>--%>

    <!-- The styles -->

    <link href="plugin/css/charisma-app.css" rel="stylesheet">
    <link href='plugin/bower_components/responsive-tables/responsive-tables.css' rel='stylesheet'>
    <link href='css/jquery/jquery-ui.min.css' rel='stylesheet'>
    <link href="css/style.css" rel="stylesheet">
    <link href="css/styleForCard.css" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery/jquery.datetimepicker.css">
    <link href="css/zyUpload.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/peizhi.css">
    <!-- jQuery -->

    <!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js" ></script>
    <![endif]-->

    <!-- The fav icon -->
    <link rel="shortcut icon" href="plugin/img/favicon.ico">

</head>
<body>